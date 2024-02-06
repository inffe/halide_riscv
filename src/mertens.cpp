#include <opencv2/opencv.hpp>

#include <vector>
#include "Halide.h"
#include <iostream>
#include <cmath>

using namespace cv;
using namespace Halide;

void LaplacianFilter(Mat src, Mat dst, int height, int width) { 

    float filter[3][3] = {{0, -1, 0}, {-1, 4, -1}, {0, -1, 0}};
    Buffer<float> input(src.ptr<float>(), {width, height});
    Buffer<float> output(dst.ptr<float>(), {width, height});
    Buffer<float> weights(filter);

#ifdef __riscv
    contrast(input, output);
#else
    Func f("contrast");
try {
        Var x("x"), y("y"), c("c");

        RDom r(-1, 3, -1, 3);

        Func input1 = BoundaryConditions::constant_exterior(input, 0);

        f(x, y) = sum(input1(x + r.x, y + r.y) * weights(r.x + 1, r.y + 1));

        f.realize(output);

} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
#endif
}

void standartDeviation(Mat src, Mat dst, int height, int width) {

    Buffer<float> input = Buffer<float>::make_interleaved(src.ptr<float>(), width, height, 3);
    Buffer<float> output(dst.ptr<float>(), {width, height}); 

    Func f("deviation");
    Func mean;

try {

    Var x("x"), y("y"), c("c");

    mean(x, y) = cast<float>(input(x, y, 0) + input(x, y, 1) + input(x, y, 2))/3;

    Expr r = mean(x, y) - input(x, y, 0);
    Expr g = mean(x, y) - input(x, y, 1);
    Expr b = mean(x, y) - input(x, y, 2);

    f(x, y) = sqrt(r*r + g*g + b*b);

    f.realize(output);

} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
}

void wellExp(Mat src, Mat dst, int height, int width) {

    Buffer<float> input = Buffer<float>::make_interleaved(src.ptr<float>(), width, height, 3);
    Buffer<float> output(dst.ptr<float>(), {width, height}); 
    
    Func f("well-exposedness");

try {

    Var x("x"), y("y"), c("c");

    Expr r = pow(input(x, y, 0) - 0.5f, 2.0f);
    Expr g = pow(input(x, y, 1) - 0.5f, 2.0f);
    Expr b = pow(input(x, y, 2) - 0.5f, 2.0f);

    r = -r / 0.08f;
    g = -g / 0.08f;
    b = -b / 0.08f;

    r = exp(r);
    g = exp(g);
    b = exp(b);

    f(x, y) = r * g * b;

    f.realize(output);

} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
}

void weightsImage(Mat contrast, Mat saturation, Mat wellexp, Mat dst, int height, int width) {
    Buffer<float> input1(contrast.ptr<float>(), {width, height});
    Buffer<float> input2(saturation.ptr<float>(), {width, height});
    Buffer<float> output(dst.ptr<float>(), {width, height});

    Func f("weights");

try {

    Var x("x"), y("y"), c("c");

    f(x, y) = input1(x, y) * input2(x, y) + 1e-12f;

    f.realize(output);

} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
}

void weight_sum(Mat src1, Mat src2, Mat src3, Mat src4, Mat dst, int height, int width) {
    Buffer<float> input1(src1.ptr<float>(), {width, height});
    Buffer<float> input2(src2.ptr<float>(), {width, height});
    Buffer<float> input3(src3.ptr<float>(), {width, height});
    Buffer<float> input4(src4.ptr<float>(), {width, height});
    Buffer<float> output(dst.ptr<float>(), {width, height});

    Func f("summary");

try {

    Var x("x"), y("y"), c("c");

    f(x, y) = input1(x, y) + input2(x, y) + input3(x, y) + input4(x, y);

    f.realize(output);

} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
}
