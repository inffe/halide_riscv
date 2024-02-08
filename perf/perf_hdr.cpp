#include <opencv2/ts.hpp>

#include "algos.hpp"

using namespace cv;

CV_PERF_TEST_MAIN("")    

PERF_TEST(hdr, halide) {   

    Mat image1 = imread("1.jpg");
    Mat image2 = imread("2.jpg");
    Mat image3 = imread("3.jpg");
    Mat image4 = imread("4.jpg");

    image1.convertTo(image1, CV_32F, 1.0f/255.0f);
    image2.convertTo(image2, CV_32F, 1.0f/255.0f);
    image3.convertTo(image3, CV_32F, 1.0f/255.0f);
    image4.convertTo(image4, CV_32F, 1.0f/255.0f);

    Mat image1Gray;
    Mat image2Gray;
    Mat image3Gray;
    Mat image4Gray;

    cvtColor(image1, image1Gray, cv::COLOR_BGR2GRAY);
    cvtColor(image2, image2Gray, cv::COLOR_BGR2GRAY);
    cvtColor(image3, image3Gray, cv::COLOR_BGR2GRAY);
    cvtColor(image4, image4Gray, cv::COLOR_BGR2GRAY);

    int imageWidth = image1Gray.cols;
    int imageHeigth = image1Gray.rows;

    int size = imageHeigth * imageHeigth;

    Mat laplaced1(imageHeigth, imageWidth, CV_32F);
    Mat laplaced2(imageHeigth, imageWidth, CV_32F);
    Mat laplaced3(imageHeigth, imageWidth, CV_32F);
    Mat laplaced4(imageHeigth, imageWidth, CV_32F);

    Mat stDev1(imageHeigth, imageWidth, CV_32F);
    Mat stDev2(imageHeigth, imageWidth, CV_32F);
    Mat stDev3(imageHeigth, imageWidth, CV_32F);
    Mat stDev4(imageHeigth, imageWidth, CV_32F);

    Mat we1(imageHeigth, imageWidth, CV_32F);
    Mat we2(imageHeigth, imageWidth, CV_32F);
    Mat we3(imageHeigth, imageWidth, CV_32F);
    Mat we4(imageHeigth, imageWidth, CV_32F);

    Mat weights1(imageHeigth, imageWidth, CV_32F);
    Mat weights2(imageHeigth, imageWidth, CV_32F);
    Mat weights3(imageHeigth, imageWidth, CV_32F);
    Mat weights4(imageHeigth, imageWidth, CV_32F);

    Mat weights_sum(imageHeigth, imageWidth, CV_32F);

    PERF_SAMPLE_BEGIN()

    LaplacianFilter(image1Gray, laplaced1, imageHeigth, imageWidth); // LaplacianFilter - 1920x1080x1 as result
    LaplacianFilter(image2Gray, laplaced2, imageHeigth, imageWidth);
    LaplacianFilter(image3Gray, laplaced3, imageHeigth, imageWidth);
    LaplacianFilter(image4Gray, laplaced4, imageHeigth, imageWidth);

    laplaced1 = abs(laplaced1); //absolute value
    laplaced2 = abs(laplaced2);
    laplaced3 = abs(laplaced3);
    laplaced4 = abs(laplaced4);

    standartDeviation(image1, stDev1, imageHeigth, imageWidth); // Calculation of standrat deviation - 1920x1080x1 as result
    standartDeviation(image2, stDev2, imageHeigth, imageWidth);
    standartDeviation(image3, stDev3, imageHeigth, imageWidth);
    standartDeviation(image4, stDev4, imageHeigth, imageWidth);

    wellExp(image1, we1, imageHeigth, imageWidth); // Calculation of well-exposedness - 1920x1080x1 as result
    wellExp(image2, we2, imageHeigth, imageWidth);
    wellExp(image3, we3, imageHeigth, imageWidth);
    wellExp(image4, we4, imageHeigth, imageWidth);

    weightsImage(laplaced1, stDev1, we1, weights1, imageHeigth, imageWidth); // Calculation of weight map - 1920x1080x1 as result
    weightsImage(laplaced2, stDev2, we2, weights2, imageHeigth, imageWidth);
    weightsImage(laplaced3, stDev3, we3, weights3, imageHeigth, imageWidth);
    weightsImage(laplaced4, stDev4, we4, weights4, imageHeigth, imageWidth);

    weight_sum(weights1, weights2, weights3, weights4, weights_sum, imageHeigth, imageWidth);

    PERF_SAMPLE_END()

    imwrite("laplaced1.jpg", laplaced1 * 255); //write laplaced images
    imwrite("laplaced2.jpg", laplaced2 * 255);
    imwrite("laplaced3.jpg", laplaced3 * 255);
    imwrite("laplaced4.jpg", laplaced4 * 255);

    std::cout << "check weights sum" << std::endl;

    std::vector<Mat> weightsVec = {weights1, weights2, weights3, weights4};

    std::vector<Mat> imagesVec = {image1, image2, image3, image4};

    //opencv code

    int maxlevel = static_cast<int>(logf(static_cast<float>(min(imageWidth, imageHeigth))) / logf(2.0f));
        std::vector<Mat> res_pyr(maxlevel + 1);
        std::vector<Mutex> res_pyr_mutexes(maxlevel + 1);

        parallel_for_(Range(0, static_cast<int>(imagesVec.size())), [&](const Range& range) {
            for(int i = range.start; i < range.end; i++) {
                weightsVec[i] /= weights_sum;

                std::vector<Mat> img_pyr, weight_pyr;
                buildPyramid(imagesVec[i], img_pyr, maxlevel);
                buildPyramid(weightsVec[i], weight_pyr, maxlevel);

                for(int lvl = 0; lvl < maxlevel; lvl++) {
                    Mat up;
                    pyrUp(img_pyr[lvl + 1], up, img_pyr[lvl].size());
                    img_pyr[lvl] -= up;
                }
                for(int lvl = 0; lvl <= maxlevel; lvl++) {
                    std::vector<Mat> splitted(3);
                    split(img_pyr[lvl], splitted);
                    for(int c = 0; c < 3; c++) {
                        splitted[c] = splitted[c].mul(weight_pyr[lvl]);
                    }
                    merge(splitted, img_pyr[lvl]);

                    AutoLock lock(res_pyr_mutexes[lvl]);
                    if(res_pyr[lvl].empty()) {
                        res_pyr[lvl] = img_pyr[lvl];
                    } else {
                        res_pyr[lvl] += img_pyr[lvl];
                    }
                }
            }
        });
        for(int lvl = maxlevel; lvl > 0; lvl--) {
            Mat up;
            pyrUp(res_pyr[lvl], up, res_pyr[lvl - 1].size());
            res_pyr[lvl - 1] += up;
        }

        Mat dst = res_pyr[0];

        imwrite("FinalImage.jpg", dst * 255);
}
