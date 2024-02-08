#include <opencv2/ts.hpp>

#include "algos.hpp"

TEST(upscale, halide)
{

    static const int height = 100;
    static const int width = 100;
    std::vector<std::string> img_path(72);
    for (int i = 1; i <= 72; ++i)
    {
        img_path[i - 1] = cv::format("./image%04d.png", i);
    }

    upscale(img_path, width, height);

    ASSERT_EQ(true,true);
}
