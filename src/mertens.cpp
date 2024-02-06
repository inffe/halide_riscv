#include <opencv2/opencv.hpp>

#include <vector>
#include "Halide.h"
#include <iostream>

using namespace cv;
using namespace Halide;

void LaplacianFilter(Mat src, Mat dst, int height, int width) { // переназвать фильтр grayscale + laplacian

    int8_t filter[3][3] = {{0, -1, 0}, {-1, 4, -1}, {0, -1, 0}}; //фильтр
    Buffer<uint8_t> input(src.ptr<uint8_t>(), {width, height});
    Buffer<uint8_t> output(dst.ptr<uint8_t>(), {width, height}); // обработка границ???
    Buffer<int8_t> weights(filter);

#ifdef __riscv
    contrast(input, output);
#else
    static Func f("contrast");
    if (!f.defined()) {
try {
        Var x("x"), y("y"), c("c");

        RDom r(-1, 3, -1, 3); // сеткой 3 на 3

        std::cout << "check1" << std::endl;

        Func input1 = BoundaryConditions::constant_exterior(input, 0);

        Expr s = sum(cast<int16_t>(input1(x + r.x, y + r.y)) * weights(r.x + 1, r.y + 1)); // каждый элемент подсетки умножается на вес фильтра, все результаты суммируются

        Expr sum = clamp(s, 0, 255); 

        f(x, y) = cast<uint8_t>(sum); 

        std::cout << "check2" << s.type() << f.type() << std::endl;

        std::cout << "check3" << std::endl;

        f.realize(output);
} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
    }
#endif
}

void standartDeviation(Mat src, Mat dst, int height, int width) {

    Buffer<uint8_t> input(src.ptr<uint8_t>(), {width, height, 3});
    Buffer<uint8_t> output(dst.ptr<uint8_t>(), {width, height, 3});

    const int numOfElements = height*width;

    static Func f("deviation");

    Var x("x"), y("y"), c("c");
    
    // step 1 - find mean / sum all bits of r / (1920x1080) / 3x1

    int chR = 0;
    int chG = 0;
    int chB = 0;

    for (int j = 0; j < height; ++j) { //height
        for (int i = 0; i < width; ++i) { //widtht
            chR += src.at<int>(j, i, 0);
            chG += src.at<int>(j, i, 1); 
            chB += src.at<int>(j, i, 2);
        }
    }

    // step 2 - find score’s deviation from the mean / r - step 1 result, g - step 1 result, b - step 1 result / 1920x1080x3

    f(x, y, 0) = f(x, y, 0) - chR;
    f(x, y, 1) = f(x, y, 1) - chG;
    f(x, y, 2) = f(x, y, 2) - chB;

    // step 3 - find square each deviation from the mean / pow(step 2 result, 2) / 1920x1080x3

    f(x, y, 0) = f(x, y, 0) * f(x, y, 0);
    f(x, y, 1) = f(x, y, 1) * f(x, y, 1);
    f(x, y, 2) = f(x, y, 2) * f(x, y, 2);

    // step 4-5 - find the sum of squares / 2 3x1 

    int varR = 0;
    int varG = 0;
    int varB = 0;

    Expr ssR = sum(f(x, y, 0)) / 2;
    Expr ssG = sum(f(x, y, 1)) / 2;
    Expr ssB = sum(f(x, y, 2)) / 2;

    // step 6 - find the sqrt(variance) / 3x1

    ssR = sqrt(ssR);
    ssG = sqrt(ssG); 
    ssB = sqrt(ssB);

}

void wellExp(Mat src, Mat dst, int height, int width) {

    Buffer<uint8_t> input(src.ptr<uint8_t>(), {width, height});
    Buffer<uint8_t> output(dst.ptr<uint8_t>(), {width, height});

    Var x("x"), y("y"), c("c");

    Expr expo = pow(input(x, y, 0) - 0.5f, 2.0f);
    Expr expo2 = pow(input(x, y, 1) - 0.5f, 2.0f);
    Expr expo3 = pow(input(x, y, 2) - 0.5f, 2.0f);

    expo = -expo / 0.08f;
    expo2 = -expo2 / 0.08f;
    expo3 = -expo3 / 0.08f;

    // fix...

}
