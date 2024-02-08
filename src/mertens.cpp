#include <opencv2/opencv.hpp>
#include <vector>

#ifdef __riscv

#include <HalideBuffer.h>
#include "halide_laplacianFilter_rv.h"
#include "halide_standartDeviation_rv.h"
#include "halide_wellExp_rv.h"
#include "halide_weightsImage_rv.h"
#include "halide_weight_sum_rv.h"

using namespace cv;
using namespace Halide::Runtime;

#else

#include <Halide.h>
#include <iostream>
#include <cmath>

using namespace cv;
using namespace Halide;

#endif

void LaplacianFilter(Mat src, Mat dst, int height, int width) {

    float filter[3][3] = {{0, -1, 0}, {-1, 4, -1}, {0, -1, 0}};
    Buffer<float> input(src.ptr<float>(), {width, height});
    Buffer<float> output(dst.ptr<float>(), {width, height});
    Buffer<float> weights(filter);

#ifdef __riscv
    halide_laplacianFilter_rv(input, output);
#else
    static Func f("contrast");
try {
    if (!f.defined()) {
        Var x("x"), y("y"), c("c");

        RDom r(-1, 3, -1, 3);

        Func input1 = BoundaryConditions::constant_exterior(input, 0);

        f(x, y) = sum(input1(x + r.x, y + r.y) * weights(r.x + 1, r.y + 1));

        // f.vectorize(x, 4);

        Target target;
        target.os = Target::OS::Linux;
        target.arch = Target::Arch::RISCV;
        target.bits = 64;
        target.vector_bits = 128;

        // Tested XuanTie C906 has 128-bit vector unit
        CV_Assert(target.vector_bits <= 128);

        std::vector<Target::Feature> features;
        features.push_back(Target::RVV);
        features.push_back(Target::NoAsserts);
        features.push_back(Target::NoRuntime);
        target.set_features(features);

        std::cout << target << std::endl;
        f.print_loop_nest();

        f.compile_to_header("halide_laplacianFilter_rv.h", {input}, "halide_laplacianFilter_rv", target);
        f.compile_to_assembly("halide_laplacianFilter_rv.s", {input}, "halide_laplacianFilter_rv", target);
    }
} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
#endif
}

void standartDeviation(Mat src, Mat dst, int height, int width) {

    Buffer<float> input = Buffer<float>::make_interleaved(src.ptr<float>(), width, height, 3);
    Buffer<float> output(dst.ptr<float>(), {width, height});

#ifdef __riscv
    halide_standartDeviation_rv(input, output);
#else
    static Func f("deviation");
    Func mean;

try {
    if (!f.defined()) {
    Var x("x"), y("y"), c("c");

    mean(x, y) = cast<float>(input(x, y, 0) + input(x, y, 1) + input(x, y, 2))/3;

    Expr r = mean(x, y) - input(x, y, 0);
    Expr g = mean(x, y) - input(x, y, 1);
    Expr b = mean(x, y) - input(x, y, 2);

    f(x, y) = sqrt(r*r + g*g + b*b);

    // f.vectorize(x, 4);

        Target target;
        target.os = Target::OS::Linux;
        target.arch = Target::Arch::RISCV;
        target.bits = 64;
        target.vector_bits = 128;

        // Tested XuanTie C906 has 128-bit vector unit
        CV_Assert(target.vector_bits <= 128);

        std::vector<Target::Feature> features;
        features.push_back(Target::RVV);
        features.push_back(Target::NoAsserts);
        features.push_back(Target::NoRuntime);
        target.set_features(features);

        std::cout << target << std::endl;
        f.print_loop_nest();

        f.compile_to_header("halide_standartDeviation_rv.h", {input}, "halide_standartDeviation_rv", target);
        f.compile_to_assembly("halide_standartDeviation_rv.s", {input}, "halide_standartDeviation_rv", target);
    }
} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
#endif
}

void wellExp(Mat src, Mat dst, int height, int width) {

    Buffer<float> input = Buffer<float>::make_interleaved(src.ptr<float>(), width, height, 3);
    Buffer<float> output(dst.ptr<float>(), {width, height});

#ifdef __riscv
    halide_wellExp_rv(input, output);

#else
    static Func f("well-exposedness");
try {
    if (!f.defined()) {

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

    // f.vectorize(x, 4);

        Target target;
        target.os = Target::OS::Linux;
        target.arch = Target::Arch::RISCV;
        target.bits = 64;
        target.vector_bits = 128;

        // Tested XuanTie C906 has 128-bit vector unit
        CV_Assert(target.vector_bits <= 128);

        std::vector<Target::Feature> features;
        features.push_back(Target::RVV);
        features.push_back(Target::NoAsserts);
        features.push_back(Target::NoRuntime);
        target.set_features(features);

        std::cout << target << std::endl;
        f.print_loop_nest();

        f.compile_to_header("halide_wellExp_rv.h", {input}, "halide_wellExp_rv", target);
        f.compile_to_assembly("halide_wellExp_rv.s", {input}, "halide_wellExp_rv", target);
    }
} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
#endif
}

void weightsImage(Mat contrast, Mat saturation, Mat wellexp, Mat dst, int height, int width) {
    Buffer<float> input1(contrast.ptr<float>(), {width, height});
    Buffer<float> input2(saturation.ptr<float>(), {width, height});
    Buffer<float> output(dst.ptr<float>(), {width, height});

#ifdef __riscv
    halide_weightsImage_rv(input1, input2, output);

#else
    static Func f("weights");
try {
    if (!f.defined()) {

    Var x("x"), y("y"), c("c");

    f(x, y) = input1(x, y) * input2(x, y) + 1e-12f;

    // f.vectorize(x, 4);

        Target target;
        target.os = Target::OS::Linux;
        target.arch = Target::Arch::RISCV;
        target.bits = 64;
        target.vector_bits = 128;

        // Tested XuanTie C906 has 128-bit vector unit
        CV_Assert(target.vector_bits <= 128);

        std::vector<Target::Feature> features;
        features.push_back(Target::RVV);
        features.push_back(Target::NoAsserts);
        features.push_back(Target::NoRuntime);
        target.set_features(features);

        std::cout << target << std::endl;
        f.print_loop_nest();

        f.compile_to_header("halide_weightsImage_rv.h", {input1, input2}, "halide_weightsImage_rv", target);
        f.compile_to_assembly("halide_weightsImage_rv.s", {input1, input2}, "halide_weightsImage_rv", target);
    }
} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
#endif
}

void weight_sum(Mat src1, Mat src2, Mat src3, Mat src4, Mat dst, int height, int width) {
    Buffer<float> input1(src1.ptr<float>(), {width, height});
    Buffer<float> input2(src2.ptr<float>(), {width, height});
    Buffer<float> input3(src3.ptr<float>(), {width, height});
    Buffer<float> input4(src4.ptr<float>(), {width, height});
    Buffer<float> output(dst.ptr<float>(), {width, height});

#ifdef __riscv
    halide_weight_sum_rv(input1, input2, input3, input4, output);

#else
    static Func f("summary");

try {
    if (!f.defined()) {

    Var x("x"), y("y"), c("c");

    f(x, y) = input1(x, y) + input2(x, y) + input3(x, y) + input4(x, y);

        // f.vectorize(x, 4);

        Target target;
        target.os = Target::OS::Linux;
        target.arch = Target::Arch::RISCV;
        target.bits = 64;
        target.vector_bits = 128;

        // Tested XuanTie C906 has 128-bit vector unit
        CV_Assert(target.vector_bits <= 128);

        std::vector<Target::Feature> features;
        features.push_back(Target::RVV);
        features.push_back(Target::NoAsserts);
        features.push_back(Target::NoRuntime);
        target.set_features(features);

        std::cout << target << std::endl;
        f.print_loop_nest();

        f.compile_to_header("halide_weight_sum_rv.h", {input1, input2, input3, input4}, "halide_weight_sum_rv", target);
        f.compile_to_assembly("halide_weight_sum_rv.s", {input1, input2, input3, input4}, "halide_weight_sum_rv", target);
    }
} catch (const Halide::Error& ex) {
    std::cout << ex.what() << std::endl;
    exit(1);
}
#endif
}
