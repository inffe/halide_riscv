#include <opencv2/opencv.hpp>
#include <ker_weight.hpp>

#ifdef __riscv
  #include <HalideBuffer.h>
  #include "deconvolution.h"
  using namespace Halide::Runtime;
#else
  #include <Halide.h>
  using namespace Halide;
#endif
namespace voxel_upscale_const
{
    static const int scale_depth = 2;
    static const int scale_height = 2;
    static const int scale_width = 2;

    static const int ker_depth = (2 * scale_depth - scale_depth % 2);
    static const int ker_height = (2 * scale_height - scale_height % 2);
    static const int ker_width = (2 * scale_width - scale_width % 2);

    static const int pad_depth = std::ceil(( scale_depth - 1) / 2);
    static const int pad_height = std::ceil(( scale_height - 1) / 2);
    static const int pad_width = std::ceil(( scale_width - 1) / 2);
};

using namespace voxel_upscale_const;

void voxel_up( float* src, float* kernel, float* dst,
                    int inpChannels, int width, int height, int depth){

    Buffer<float> input(src, {width, height, depth, inpChannels});
    Buffer<float> weights(kernel, { ker_width, ker_height, ker_depth});
    Buffer<float> output(dst, { width * scale_width, height * scale_height, depth * scale_depth, inpChannels});

#ifdef __riscv
    deconvolution(input, output);
#else
    static Halide::Func deconv("deconvolution");
    if (!deconv.defined()) {
        input.set_name("input");
        weights.set_name("weights");
        Halide::Var x("x"), y("y"), d("d"), c("c");

        Halide::Func padded_input("constant_exterior");
        Halide::Func dilated_input("dilated_input");

        Halide::RDom r1(0, width, 0, height, 0, depth);

        dilated_input(x,y,d,c) = 0.0f;
        dilated_input( r1.x * scale_width, r1.y * scale_height, r1.z * scale_depth, c) =
                    input( r1.x, r1.y, r1.z, c);
        dilated_input.compute_root();
        Halide::Func bounded =
            Halide::BoundaryConditions::constant_exterior(dilated_input, 0,
                                                          0, (width - 1) * scale_width + 1,
                                                          0, (height - 1) * scale_height + 1,
                                                          0, (depth - 1) * scale_depth + 1,
                                                          0, inpChannels
                                                          );

        padded_input(x,y,d,c) = bounded(x,y,d,c);

        Halide::RDom r(0, ker_width, 0, ker_height, 0, ker_depth);
        Halide::Expr kx = x + pad_width - r.x;
        Halide::Expr ky = y + pad_height - r.y;
        Halide::Expr kd = d + pad_depth - r.z;
        deconv(x, y, d, c) = Halide::sum(padded_input(kx, ky, kd, c) *
                                         weights(r.x, r.y, r.z));
        padded_input.compute_root();

        deconv.bound(x, 0, width * scale_width)
              .bound(y, 0, height * scale_height)
              .bound(d, 0, depth * scale_depth)
              .bound(c, 0, inpChannels);

        // deconv.realize(output);

        // Compile
        Halide::Target target;
        target.os = Halide::Target::OS::Linux;
        target.arch = Halide::Target::Arch::RISCV;
        target.bits = 64;

        std::vector<Halide::Target::Feature> features;
        features.push_back(Halide::Target::NoAsserts);
        features.push_back(Halide::Target::NoRuntime);
        target.set_features(features);

        std::cout << target << std::endl;
        deconv.print_loop_nest();

        // Dump AOT code
        deconv.compile_to_header("deconvolution.h", {input}, "deconvolution", target);
        deconv.compile_to_assembly("deconvolution.s", {input}, "deconvolution", target);
    }
#endif
}

void upscale(std::vector<std::string> img_path, int width, int height)
{
  const int img_num = static_cast<int>(img_path.size());
  cv::Mat voxels({4, img_num, width, height}, CV_32F);
  for(size_t i = 0; i < img_num; ++i)
  {
    cv::Mat img = cv::imread(img_path[i], cv::IMREAD_UNCHANGED);
    cv::Mat colors[4];
    for (size_t j = 0; j < 4; ++j)
    {
        colors[j] = cv::Mat(std::vector<int>{width, height}, CV_32F, voxels.ptr<float>(j, i));
    }
    img.convertTo(img, CV_32F);
    cv::split(img, colors);
  }

  cv::Mat res({4, img_num * scale_depth, width * scale_width, height * scale_height },CV_32F);

  voxel_up(voxels.ptr<float>(), ker_weight, res.ptr<float>(),
                  4, width, height, img_num);

  for(size_t i = 0; i < img_num * scale_depth; ++i)
  {
    cv::Mat img;
    cv::Mat colors[4];
    for(size_t j = 0; j < 4; ++j)
    {
      colors[j] = cv::Mat(std::vector<int>{width * scale_width, height * scale_height}, CV_32F, res.ptr<float>(j, i));
    }
    // colors[0] /= 0.75f;
    // colors[1] /= 0.75f;
    // colors[2] /= 0.75f;
    //colors[0].setTo(255);
    //colors[1].setTo(255);
    //colors[2].setTo(255);
    //colors[3].setTo(255);
    cv::merge(colors, 4, img);
    img.convertTo(img, CV_8U);
    cv::imwrite(cv::format("./new_image%04d.png", i + 1) , img);
  }

}
