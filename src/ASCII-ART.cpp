#include <opencv2/opencv.hpp>
#include <vector>
#include <string>
#include <cfloat>
#include <iostream>

#ifdef __riscv
#include <HalideBuffer.h>
#include "ascii_art.h"

using namespace Halide::Runtime;

#else

#include <Halide.h>

using namespace Halide;

#endif
static const int norm_w = 3;
static const int norm_h = 3;
static const int rx = 15;
static const int ry = 19;

void ascii_art_halide(uint8_t* src, uint8_t* dst, int input_height, int input_width) {
    int output_width = input_width / rx;
    int output_height = input_height / ry;
 
    
    Buffer<uint8_t> input(src, {input_width, input_height});
    Buffer<uint8_t> output(dst, {input_width / rx, input_height / ry});
#ifdef __riscv
    ascii_art(input, output);
#else
    static Func ascii("ascii_art");
    if (!ascii.defined()) {
        // Func padded = BoundaryConditions::constant_exterior(input, 0);

        Var x("x"), y("y");
        RDom r(0, rx, 0, ry);
        Expr s = sum(cast<uint32_t>(input(x*rx + r.x, y*ry + r.y)));
    
        //s = Halide::clamp(s/(rx*ry),0,255);
        ascii(x, y) = cast<uint8_t>(s/(rx*ry));
        // ascii.realize(output);
        // Compile
        Target target;
        target.os = Target::OS::Linux;
        target.arch = Target::Arch::RISCV;
        target.bits = 64;
        //target.vector_bits = factor * sizeof(uint8_t) * 8;

        // Tested XuanTie C906 has 128-bit vector unit
        CV_Assert(target.vector_bits <= 128);

        std::vector<Target::Feature> features;
        features.push_back(Target::RVV);
        features.push_back(Target::NoAsserts);
        features.push_back(Target::NoRuntime);
        target.set_features(features);

        std::cout << target << std::endl;
        ascii.print_loop_nest();

        // Dump AOT code
        ascii.compile_to_header("ascii_art.h", {input}, "ascii_art", target);
        ascii.compile_to_assembly("ascii_art.s", {input}, "ascii_art", target);
    }
    #endif
}
void ascii_art_ref(const uint8_t* src, uint8_t* dst, int input_height, int input_width) {
    int output_width = input_width / rx;
    int output_height = input_height / ry;
    for(int y = 0; y < output_height; y++){
        for(int x = 0; x < output_width; x++){
            float lum = 0;
            for(int j = 0; j < ry; ++j){
                for(int i = 0; i < rx; ++i){
                    lum += src[ (y * ry + j) * input_width + x * rx +i];   
                }   
            }
            dst[y * output_width + x] = static_cast<uint8_t>(lum/(rx*ry));
            lum = 0;
        }   
    }
}
