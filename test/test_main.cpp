// Copyright (C), 2023, KNS Group LLC (YADRO)

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <opencv2/ts.hpp>
#include <iostream>

#include "algos.hpp"

using namespace cv;

const int width = 1920;
const int height = 1080;

static const int julia_width = 200;
static const int julia_height = 200;

CV_TEST_MAIN("")

TEST(julia, ref) {
    Mat dst(julia_height, julia_width, CV_8UC1, Scalar(0));

    julia_ref(dst.ptr<uint8_t>(), dst.rows, dst.cols);

    imwrite("julia_ref.png", dst);
}

TEST(julia, halide) {
    Mat dst(julia_height, julia_width, CV_8UC1, Scalar(0));

    halide_julia(dst.ptr<uint8_t>(), dst.rows, dst.cols);

    imwrite("julia_halide.png", dst);
}

TEST(histogram, opencv) {
    Mat src(height, width, CV_8UC3), dst(3, 256, CV_32F), ref(3, 256, CV_32S);
    randu(src, 0, 256);

    histogram_opencv(src, dst);
    histogram_ref(src.ptr<uint8_t>(), ref.ptr<int32_t>(), src.rows, src.cols);

    ref.convertTo(ref, CV_32F);
    ASSERT_EQ(countNonZero(dst != ref), 0);
}

TEST(histogram, halide)
{
    Mat src(height, width, CV_8UC3), dst(3, 256, CV_32S), ref(3, 256, CV_32S);
    randu(src, 0, 256);

    histogram_halide(src.ptr<uint8_t>(), dst.ptr<int32_t>(), src.rows, src.cols);
    histogram_ref(src.ptr<uint8_t>(), ref.ptr<int32_t>(), src.rows, src.cols);

    ASSERT_EQ(countNonZero(dst != ref), 0);
}

TEST(bgr2gray, opencv) {
    Mat src(height, width, CV_8UC3), dst(height, width, CV_8U), ref(height, width, CV_8U);
    randu(src, 0, 256);

    bgr2gray_opencv(src, dst);
    bgr2gray_ref(src.ptr<uint8_t>(), ref.ptr<uint8_t>(), src.rows, src.cols);

    ASSERT_LE(norm(ref, dst, NORM_INF), 1);
}

TEST(bgr2gray_interleaved, halide) {
    Mat src(height, width, CV_8UC3), dst(height, width, CV_8U), ref(height, width, CV_8U);
    randu(src, 0, 256);

    bgr2gray_interleaved_halide(src.ptr<uint8_t>(), dst.ptr<uint8_t>(), src.rows, src.cols);
    bgr2gray_ref(src.ptr<uint8_t>(), ref.ptr<uint8_t>(), src.rows, src.cols);

    ASSERT_LE(norm(ref, dst, NORM_INF), 0);
}

TEST(bgr2gray_planar, halide) {
    Mat src(height, width, CV_8UC3), dst(height, width, CV_8U), ref(height, width, CV_8U);
    randu(src, 0, 256);
    Mat planar(height * 3, width, CV_8U);

    std::vector<cv::Mat> channels(3);
    channels[0] = planar.rowRange(0, height);
    channels[1] = planar.rowRange(height, height * 2);
    channels[2] = planar.rowRange(height * 2, height * 3);
    cv::split(src, channels);

    bgr2gray_ref(src.ptr<uint8_t>(), ref.ptr<uint8_t>(), src.rows, src.cols);
    bgr2gray_planar_halide(planar.ptr<uint8_t>(), dst.ptr<uint8_t>(), src.rows, src.cols);

    ASSERT_LE(norm(ref, dst, NORM_INF), 0);
}

TEST(boxFilter, halide) {
    Mat src(height, width, CV_8U), dst(height - 2, width - 2, CV_16U), ref(height, width, CV_8U);
    randu(src, 0, 256);
    Mat src16;
    src.convertTo(src16, CV_16U);

    boxFilter_halide(src16.ptr<uint16_t>(), dst.ptr<uint16_t>(), src.rows, src.cols);
    boxFilter_opencv(src, ref);

    ref = ref.rowRange(1, height - 1).colRange(1, width - 1);
    ref.convertTo(ref, CV_16U);
    ASSERT_LE(norm(ref, dst, NORM_INF), 1);
}

TEST(contrast, halide) {

    Mat image1 = imread("../halide_riscv/src/1.jpg");
    Mat image2 = imread("../halide_riscv/src/2.jpg");
    Mat image3 = imread("../halide_riscv/src/3.jpg");
    Mat image4 = imread("../halide_riscv/src/4.jpg");

    Mat image1Gray = imread("../halide_riscv/src/1.jpg", IMREAD_GRAYSCALE);
    Mat image2Gray = imread("../halide_riscv/src/2.jpg", IMREAD_GRAYSCALE);
    Mat image3Gray = imread("../halide_riscv/src/3.jpg", IMREAD_GRAYSCALE);
    Mat image4Gray = imread("../halide_riscv/src/4.jpg", IMREAD_GRAYSCALE);

    int imageWidth = image1Gray.cols;
    int imageHeigth = image1Gray.rows;

    Mat laplaced1(imageHeigth, imageWidth, CV_8U);
    Mat laplaced2(imageHeigth, imageWidth, CV_8U);
    Mat laplaced3(imageHeigth, imageWidth, CV_8U);
    Mat laplaced4(imageHeigth, imageWidth, CV_8U);

    //LaplacianFilter(image1Gray, laplaced1, imageHeigth, imageWidth);

    std::cout << "123" << std::endl;

    LaplacianFilter(image2Gray, laplaced2, imageHeigth, imageWidth);
    LaplacianFilter(image3Gray, laplaced3, imageHeigth, imageWidth);
    LaplacianFilter(image4Gray, laplaced4, imageHeigth, imageWidth);

    std::cout << "1234" << std::endl;

    //laplaced1 = abs(laplaced1); //absolute value
    laplaced2 = abs(laplaced2);
    laplaced3 = abs(laplaced3);
    laplaced4 = abs(laplaced4);

    //std::cout << laplaced1 << std::endl;

    //imwrite("laplaced1.jpg", laplaced1);
    imwrite("laplaced2.jpg", laplaced2);
    imwrite("laplaced3.jpg", laplaced3);
    imwrite("laplaced4.jpg", laplaced4);

    std::cout << "2222" << std::endl;

    Mat stDev1(imageHeigth, imageWidth, CV_8U);
    Mat stDev2(imageHeigth, imageWidth, CV_8U);
    Mat stDev3(imageHeigth, imageWidth, CV_8U);
    Mat stDev4(imageHeigth, imageWidth, CV_8U);

    //standartDeviation(image1, stDev1, imageHeigth, imageWidth);
}

#ifdef HAVE_OPENCV_DNN

TEST(convolution_nchw, halide) {
    static const int ic = 16;
    static const int oc = 32;
    static const int height = 128;
    static const int width = 128;
    Mat src({1, ic, height, width}, CV_32F);
    Mat kernel({oc, ic, 3, 3}, CV_32F);
    Mat ref({1, oc, height - 2, width - 2}, CV_32F);
    Mat dst({1, oc, height - 2, width - 2}, CV_32F);
    randn(src, 0, 1);
    randn(kernel, 0, 1);

    convolution_opencv(src, kernel, ref, ic, oc);
    convolution_nchw_halide(src.ptr<float>(), kernel.ptr<float>(), dst.ptr<float>(),
                            ic, oc, height, width);

    ASSERT_LE(norm(ref, dst, NORM_INF), 4e-5f);
}

TEST(convolution_nhwc, halide) {
    static const int ic = 16;
    static const int oc = 32;
    static const int height = 128;
    static const int width = 128;
    Mat src_nchw({1, ic, height, width}, CV_32F);
    Mat kernel_oihw({oc, ic, 3, 3}, CV_32F);
    Mat ref({1, oc, height - 2, width - 2}, CV_32F);
    Mat dst_nhwc({1, height - 2, width - 2, oc}, CV_32F);
    randn(src_nchw, 0, 1);
    randn(kernel_oihw, 0, 1);

    convolution_opencv(src_nchw, kernel_oihw, ref, ic, oc);

    Mat kernel_ihwo, src_nhwc;
    cv::transpose(kernel_oihw.reshape(1, oc), kernel_ihwo);
    cv::transpose(src_nchw.reshape(1, ic), src_nhwc);

    convolution_nhwc_halide(src_nhwc.ptr<float>(), kernel_ihwo.ptr<float>(), dst_nhwc.ptr<float>(),
                            ic, oc, height, width);

    Mat dst;
    cv::transpose(dst_nhwc.reshape(1, dst_nhwc.size[1] * dst_nhwc.size[2]), dst);

    ASSERT_LE(norm(ref.reshape(1, 1), dst.reshape(1, 1), NORM_INF), 4e-5f);
}

#endif  // HAVE_OPENCV_DNN


TEST(idw, halide) {
    Mat src(height, width, CV_8U);
    Mat dst(height, width, CV_8U), cl_dst(height, width, CV_8UC3), dst_h(height, width, CV_8U), cl_dst_h(height, width, CV_8UC3);
    // randu(src, 0, 256);

    // 300 elems (100 points)
    int points[] = {0, 0, 72, 0, 213, 79, 0, 426, 60, 0, 640, 76, 0, 853, 128, 0, 1066, 67, 0, 1280, 65, 0, 1493, 64, 0, 1706, 60, 0, 1920, 61, 120, 0, 81, 120, 213, 79, 120, 426, 58, 120, 640, 132, 120, 853, 149, 120, 1066, 142, 120, 1280, 64, 120, 1493, 69, 120, 1706, 65, 120, 1920, 64, 240, 0, 75, 240, 213, 68, 240, 426, 140, 240, 640, 153, 240, 853, 145, 240, 1066, 132, 240, 1280, 152, 240, 1493, 125, 240, 1706, 66, 240, 1920, 58, 360, 0, 78, 360, 213, 60, 360, 426, 139, 360, 640, 168, 360, 853, 154, 360, 1066, 138, 360, 1280, 145, 360, 1493, 160, 360, 1706, 68, 360, 1920, 60, 480, 0, 77, 480, 213, 59, 480, 426, 165, 480, 640, 183, 480, 853, 166, 480, 1066, 142, 480, 1280, 123, 480, 1493, 155, 480, 1706, 144, 480, 1920, 60, 600, 0, 83, 600, 213, 65, 600, 426, 178, 600, 640, 184, 600, 853, 138, 600, 1066, 124, 600, 1280, 132, 600, 1493, 175, 600, 1706, 175, 600, 1920, 60, 720, 0, 86, 720, 213, 60, 720, 426, 182, 720, 640, 179, 720, 853, 152, 720, 1066, 140, 720, 1280, 115, 720, 1493, 156, 720, 1706, 172, 720, 1920, 65, 840, 0, 90, 840, 213, 69, 840, 426, 164, 840, 640, 186, 840, 853, 146, 840, 1066, 147, 840, 1280, 122, 840, 1493, 152, 840, 1706, 166, 840, 1920, 69, 960, 0, 85, 960, 213, 67, 960, 426, 186, 960, 640, 169, 960, 853, 162, 960, 1066, 147, 960, 1280, 124, 960, 1493, 149, 960, 1706, 157, 960, 1920, 69, 1080, 0, 85, 1080, 213, 70, 1080, 426, 193, 1080, 640, 192, 1080, 853, 155, 1080, 1066, 135, 1080, 1280, 120, 1080, 1493, 138, 1080, 1706, 128, 1080, 1920, 70};
    // 100 elems
    float weights[] = {0.04053167, -0.07571915, 0.0025228, 0.1974248, -0.14461569, 0.30541419, -0.06167972, -0.04958807, 0.00050641, -0.02023852, -0.05910183, -0.05512609, 0.37617088, -0.15904428, -0.10229038, -0.34355378, 0.39128499, 0.16502984, -0.00916588, -0.05264022, 0.01936275, 0.07156495, -0.35144818, -0.01955447, 0.07818357, 0.10850975, -0.34972095, -0.12186563, 0.04116577, 0.00378971, -0.05382689, 0.12480152, 0.0629668, 0.01070963, 0.03499341, 0.03218783, -0.00559502, -0.21214646, 0.34402987, -0.0246006, -0.01532894, 0.14944613, -0.12848858, -0.04539923, -0.1401344, -0.08143395, 0.18241941, 0.08353522, -0.20102434, 0.05168503, -0.05897654, 0.09669851, -0.13024191, -0.02125988, 0.19499928, 0.12311092, -0.05857943, -0.14954968, -0.19763496, 0.1172914, -0.04584096, 0.20130274, -0.198312, 0.04763513, -0.05524272, -0.07034198, 0.15155036, 0.0718368, -0.09612551, 0.09076872, -0.0863682, 0.08457486, 0.05520895, -0.10551672, 0.12577908, -0.05857014, 0.03529613, 0.01300365, -0.09736055, 0.06580921, -0.03074898, 0.1528181, -0.18295799, 0.18713497, -0.07368328, -0.06431868, 0.02485816, -0.02782657, -0.15182979, 0.06845911, -0.01974711, 0.23508139, -0.23124445, -0.1202987, 0.05380124, 0.04331648, 0.06285662, -0.01171756, 0.01128749, 0.06012665};

    idw_ref(NULL, dst.ptr<uint8_t>(), height, width, points, weights);
    idw_halide(NULL, dst_h.ptr<uint8_t>(), height, width, points, weights);

    applyColorMap(dst, cl_dst, COLORMAP_JET);
    applyColorMap(dst_h, cl_dst_h, COLORMAP_JET);

    // imwrite("src.png", src);
    imwrite("res.png", dst);
    imwrite("cres.png", cl_dst);
    imwrite("res_halide.png", dst_h);
    imwrite("cres_halide.png", cl_dst_h);
}
