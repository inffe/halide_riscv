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

#include "algos.hpp"

using namespace cv;

CV_PERF_TEST_MAIN("")

Mat src(1080, 1920, CV_8UC3);

static const int julia_width = 200;
static const int julia_height = 200;

PERF_TEST(julia, halide) {
    Mat dst(julia_height, julia_width, CV_8UC1, Scalar(0));

    PERF_SAMPLE_BEGIN()
        halide_julia(dst.ptr<uint8_t>(), dst.rows, dst.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(julia, reference) {
    Mat dst(julia_height, julia_width, CV_8UC1, Scalar(0));

    PERF_SAMPLE_BEGIN()
        julia_ref(dst.ptr<uint8_t>(), dst.rows, dst.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(histogram, reference) {
    Mat dst(3, 256, CV_32S);
    randu(src, 0, 256);

    PERF_SAMPLE_BEGIN()
        histogram_ref(src.ptr<uint8_t>(), dst.ptr<int32_t>(), src.rows, src.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(histogram, opencv) {
    Mat dst(3, 256, CV_32F);
    randu(src, 0, 256);

    PERF_SAMPLE_BEGIN()
        histogram_opencv(src, dst);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(histogram, halide) {
    Mat dst(3, 256, CV_32S);
    randu(src, 0, 256);

    PERF_SAMPLE_BEGIN()
        histogram_halide(src.ptr<uint8_t>(), dst.ptr<int32_t>(), src.rows, src.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(bgr2gray, reference) {
    Mat dst(src.size(), CV_8U);
    randu(src, 0, 256);

    PERF_SAMPLE_BEGIN()
        bgr2gray_ref(src.ptr<uint8_t>(), dst.ptr<uint8_t>(), src.rows, src.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(bgr2gray, opencv) {
    Mat dst(src.size(), CV_8U);
    randu(src, 0, 256);

    PERF_SAMPLE_BEGIN()
        bgr2gray_opencv(src, dst);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(bgr2gray_interleaved, halide) {
    randu(src, 0, 256);
    Mat dst(src.size(), CV_8U);

    PERF_SAMPLE_BEGIN()
        bgr2gray_interleaved_halide(src.ptr<uint8_t>(), dst.ptr<uint8_t>(), src.rows, src.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(bgr2gray_planar, halide) {
    randu(src, 0, 256);
    Mat dst(src.size(), CV_8U);

    PERF_SAMPLE_BEGIN()
        bgr2gray_planar_halide(src.ptr<uint8_t>(), dst.ptr<uint8_t>(), src.rows, src.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(boxFilter, halide) {
    Mat src16(src.size(), CV_16U);
    Mat dst(src.rows - 2, src.cols - 2, CV_16U);
    randu(src16, 0, 256);

    PERF_SAMPLE_BEGIN()
        boxFilter_halide(src16.ptr<uint16_t>(), dst.ptr<uint16_t>(), src.rows, src.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(boxFilter, opencv) {
    Mat srcCh(src.size(), CV_8U);
    Mat dst(src.size(), CV_8U);
    randu(src, 0, 256);

    PERF_SAMPLE_BEGIN()
        boxFilter_opencv(srcCh, dst);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

#ifdef HAVE_OPENCV_DNN

PERF_TEST(convolution, opencv) {
    static const int ic = 16;
    static const int oc = 32;
    static const int height = 128;
    static const int width = 128;
    Mat src({1, ic, height, width}, CV_32F);
    Mat kernel({oc, ic, 3, 3}, CV_32F);
    Mat dst({1, oc, height - 1, width - 1}, CV_32F);
    randn(src, 0, 1);
    randn(kernel, 0, 1);

    PERF_SAMPLE_BEGIN()
        convolution_opencv(src, kernel, dst, ic, oc);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

PERF_TEST(convolution_nchw, halide) {
    static const int ic = 16;
    static const int oc = 32;
    static const int height = 128;
    static const int width = 128;
    Mat src({1, ic, height, width}, CV_32F);
    Mat kernel({oc, ic, 3, 3}, CV_32F);
    Mat dst({1, oc, height - 2, width - 2}, CV_32F);
    randn(src, 0, 1);
    randn(kernel, 0, 1);

    PERF_SAMPLE_BEGIN()
        convolution_nchw_halide(src.ptr<float>(), kernel.ptr<float>(), dst.ptr<float>(),
                                ic, oc, height, width);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}


PERF_TEST(convolution_nhwc, halide) {
    static const int ic = 16;
    static const int oc = 32;
    static const int height = 128;
    static const int width = 128;
    Mat src({1, height, width, ic}, CV_32F);
    Mat kernel({oc, ic, 3, 3}, CV_32F);
    Mat dst({1, height - 2, width - 2, oc}, CV_32F);
    randn(src, 0, 1);
    randn(kernel, 0, 1);

    PERF_SAMPLE_BEGIN()
        convolution_nhwc_halide(src.ptr<float>(), kernel.ptr<float>(), dst.ptr<float>(),
                                ic, oc, height, width);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}

#endif  // HAVE_OPENCV_DNN


// 300 elems (100 points)
static int idwPoints[] = {0, 0, 72, 0, 213, 79, 0, 426, 60, 0, 640, 76, 0, 853, 128, 0, 1066, 67, 0, 1280, 65, 0, 1493, 64, 0, 1706, 60, 0, 1920, 61, 120, 0, 81, 120, 213, 79, 120, 426, 58, 120, 640, 132, 120, 853, 149, 120, 1066, 142, 120, 1280, 64, 120, 1493, 69, 120, 1706, 65, 120, 1920, 64, 240, 0, 75, 240, 213, 68, 240, 426, 140, 240, 640, 153, 240, 853, 145, 240, 1066, 132, 240, 1280, 152, 240, 1493, 125, 240, 1706, 66, 240, 1920, 58, 360, 0, 78, 360, 213, 60, 360, 426, 139, 360, 640, 168, 360, 853, 154, 360, 1066, 138, 360, 1280, 145, 360, 1493, 160, 360, 1706, 68, 360, 1920, 60, 480, 0, 77, 480, 213, 59, 480, 426, 165, 480, 640, 183, 480, 853, 166, 480, 1066, 142, 480, 1280, 123, 480, 1493, 155, 480, 1706, 144, 480, 1920, 60, 600, 0, 83, 600, 213, 65, 600, 426, 178, 600, 640, 184, 600, 853, 138, 600, 1066, 124, 600, 1280, 132, 600, 1493, 175, 600, 1706, 175, 600, 1920, 60, 720, 0, 86, 720, 213, 60, 720, 426, 182, 720, 640, 179, 720, 853, 152, 720, 1066, 140, 720, 1280, 115, 720, 1493, 156, 720, 1706, 172, 720, 1920, 65, 840, 0, 90, 840, 213, 69, 840, 426, 164, 840, 640, 186, 840, 853, 146, 840, 1066, 147, 840, 1280, 122, 840, 1493, 152, 840, 1706, 166, 840, 1920, 69, 960, 0, 85, 960, 213, 67, 960, 426, 186, 960, 640, 169, 960, 853, 162, 960, 1066, 147, 960, 1280, 124, 960, 1493, 149, 960, 1706, 157, 960, 1920, 69, 1080, 0, 85, 1080, 213, 70, 1080, 426, 193, 1080, 640, 192, 1080, 853, 155, 1080, 1066, 135, 1080, 1280, 120, 1080, 1493, 138, 1080, 1706, 128, 1080, 1920, 70};
// 100 elems
float idwWeights[] = {0.04053167, -0.07571915, 0.0025228, 0.1974248, -0.14461569, 0.30541419, -0.06167972, -0.04958807, 0.00050641, -0.02023852, -0.05910183, -0.05512609, 0.37617088, -0.15904428, -0.10229038, -0.34355378, 0.39128499, 0.16502984, -0.00916588, -0.05264022, 0.01936275, 0.07156495, -0.35144818, -0.01955447, 0.07818357, 0.10850975, -0.34972095, -0.12186563, 0.04116577, 0.00378971, -0.05382689, 0.12480152, 0.0629668, 0.01070963, 0.03499341, 0.03218783, -0.00559502, -0.21214646, 0.34402987, -0.0246006, -0.01532894, 0.14944613, -0.12848858, -0.04539923, -0.1401344, -0.08143395, 0.18241941, 0.08353522, -0.20102434, 0.05168503, -0.05897654, 0.09669851, -0.13024191, -0.02125988, 0.19499928, 0.12311092, -0.05857943, -0.14954968, -0.19763496, 0.1172914, -0.04584096, 0.20130274, -0.198312, 0.04763513, -0.05524272, -0.07034198, 0.15155036, 0.0718368, -0.09612551, 0.09076872, -0.0863682, 0.08457486, 0.05520895, -0.10551672, 0.12577908, -0.05857014, 0.03529613, 0.01300365, -0.09736055, 0.06580921, -0.03074898, 0.1528181, -0.18295799, 0.18713497, -0.07368328, -0.06431868, 0.02485816, -0.02782657, -0.15182979, 0.06845911, -0.01974711, 0.23508139, -0.23124445, -0.1202987, 0.05380124, 0.04331648, 0.06285662, -0.01171756, 0.01128749, 0.06012665};

PERF_TEST(idw, reference) {
    const int width = 1920;
    const int height = 1080;

    Mat dst(height, width, CV_8U);

    TEST_CYCLE_N(10)
    {
        idw_ref(NULL, dst.ptr<uint8_t>(), height, width, idwPoints, idwWeights);
    }
    SANITY_CHECK_NOTHING();
}

PERF_TEST(idw, halide) {
    const int width = 1920;
    const int height = 1080;

    Mat dst(height, width, CV_8U);

    TEST_CYCLE_N(10)
    {
        idw_halide(NULL, dst.ptr<uint8_t>(), height, width, idwPoints, idwWeights);
    }
    SANITY_CHECK_NOTHING();
}

PERF_TEST(voxel_up, halide) {
    static const int ic = 4;
    static const int height = 100;
    static const int width = 100;
    static const int batch = 72;
    Mat src({width, height,ic, batch}, CV_32F);
    Mat kernel({4, 4, 4, ic}, CV_32F);
    Mat dst({width*2, height*2,ic, batch*2}, CV_32F);
    randn(src, 0, 1);
    randn(kernel, 0, 1);

    TEST_CYCLE_N(10)
    {
        voxel_up(src.ptr<float>(), kernel.ptr<float>(), dst.ptr<float>(),
                                ic, width, height, batch);
    }

    SANITY_CHECK_NOTHING();
}
