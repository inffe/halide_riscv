#include <opencv2/ts.hpp>

#include "algos.hpp"

using namespace cv;

PERF_TEST(ascii_art, reference) {
    static const int rx = 15;
    static const int ry = 19;
    const int width = 1920;
    const int height = 1080;
    const std::string grey_scale = "$@B%8&WM#*OAHKDPQWMRZO0QLCJUYXVJFT/|()1{}[]?-_+~<>i!lI;:,^`'.  ";

    Mat src(height, width, CV_8UC1), dst(height/ry, width/rx, CV_8U);
    randu(src, 0, 256);
    PERF_SAMPLE_BEGIN()
        ascii_art_ref(src.ptr<uint8_t>(), dst.ptr<uint8_t>(), src.rows, src.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}


PERF_TEST(ascii_art, halide) {
    static const int rx = 15;
    static const int ry = 19;
    const int width = 1920;
    const int height = 1080;
    const std::string grey_scale = "$@B%8&WM#*OAHKDPQWMRZO0QLCJUYXVJFT/|()1{}[]?-_+~<>i!lI;:,^`'.  ";

    Mat src(height, width, CV_8UC1), dst(height/ry, width/rx, CV_8U);
    randu(src, 0, 256);
    PERF_SAMPLE_BEGIN()
        ascii_art_halide(src.ptr<uint8_t>(), dst.ptr<uint8_t>(), src.rows, src.cols);
    PERF_SAMPLE_END()

    SANITY_CHECK_NOTHING();
}
