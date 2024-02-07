#include <opencv2/opencv.hpp>

#include "algos.hpp"

#include <limits>
#include <iostream>

using namespace std;

#ifdef __riscv
  #include <HalideBuffer.h>
  #include "idw.h"
  using namespace Halide::Runtime;
#else
  #include <Halide.h>
  using namespace Halide;
#endif

static const int pointCount = 100;

void idw_halide(const uint8_t* src, uint8_t* dst, int height, int width, int* pointsBuf, float* weightsBuf) {
    float* maskBuf = new float[height * width]();

    Buffer<float> mask(maskBuf, {width, height});
    Buffer<uint8_t> output(dst, {width, height});

    Buffer<int> points(pointsBuf, {pointCount*3});
    Buffer<float> weights(weightsBuf, {pointCount});
#ifdef __riscv
    idw(mask);
#else
    static Func f("idw");

    // try {
    if (!f.defined()) {
        Var x("x"), y("y");
        RDom r(0, pointCount);

        f(x, y) = 0.F;
        Expr x0 = points(3*r+1);
        Expr y0 = points(3*r);
        Expr dx = x - x0;
        Expr dy = y - y0;
        Expr weight = weights(r);
        f(x, y) += hypot(dx, dy) * weight;

        // f.vectorize(r, 8);
        const int factor = 4;
        f.update().atomic().vectorize(r, factor);

        // Compile
        Target target;
        target.os = Target::OS::Linux;
        target.arch = Target::Arch::RISCV;
        target.bits = 64;
        target.vector_bits = factor * sizeof(float) * 8;

        // Tested XuanTie C906 has 128-bit vector unit
        CV_Assert(target.vector_bits <= 128);

        std::vector<Target::Feature> features;
        features.push_back(Target::RVV);
        features.push_back(Target::NoAsserts);
        features.push_back(Target::NoRuntime);
        target.set_features(features);

        std::cout << target << std::endl;
        f.print_loop_nest();

        // Dump AOT code
        f.compile_to_header("idw.h", {}, "idw", target);
        f.compile_to_assembly("idw.s", {}, "idw", target);
    }
    // }
    // catch (Halide::Error &e) {
    //     cout << e.what() << '\n';
    // }

    f.realize(mask);
#endif

    float maxVal = 193.0;
    float minVal = 58.0;
    float diff = maxVal - minVal;
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            dst[y*width + x] = (uint8_t) (255 * (maskBuf[y*width + x] - minVal) / diff);
        }
    }
    delete[] maskBuf;
}

void idw_ref(const uint8_t* src, uint8_t* dst, int height, int width, int* points, float* weights) {
    float* mask = new float[height * width]();

    float maxVal = 193.0;
    float minVal = 58.0;

    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            float dot = 0;
            for (int i = 0; i < pointCount; i++) {
                int x0 = points[3 * i + 1];
                int y0 = points[3 * i];
                int dx = x - x0;
                int dy = y - y0;

                dot += sqrt(dx*dx + dy*dy) * weights[i];
            }

            mask[y*width + x] = dot;
        }
    }

    float diff = maxVal - minVal;

    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            dst[y*width + x] = (uint8_t) (255 * (mask[y*width + x] - minVal) / diff);
        }
    }

    delete[] mask;
}
