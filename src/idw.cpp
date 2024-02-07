#include <opencv2/opencv.hpp>

#include "algos.hpp"

#include <limits>

using namespace std;

static const int pointCount = 100;

void idw_ref(const uint8_t* src, uint8_t* dst, int height, int width, int* points, float* weights) {
    float* mask = new float[height * width]();

    float maxVal = -numeric_limits<float>::infinity();
    float minVal = numeric_limits<float>::infinity();

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
            if (dot < minVal) {
                minVal = dot;
            }
            if (dot > maxVal) {
                maxVal = dot;
            }
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
