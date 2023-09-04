#include <stdio.h>
#include <string>
#include <iostream>
#include <fstream>
#include <cmath>
#include <float.h>
#include <iomanip>

#include <universal/number/posit/posit.hpp>

using Posit32 = sw::universal::posit<32, 2>;
using Posit64 = sw::universal::posit<64, 2>;

// ==========================
// Modify this parameter
#ifndef POLYB
#define POLYB "gemm"
#endif
// ==========================

#define OUTPUTS_PATH "../../outputs/" POLYB "/"

void print_accuracy(size_t n_vec_size, std::string dataset_size);

int main()
{
    size_t n_mini, n_small, n_medium, n_large;
    if (strcmp(POLYB, "cholesky") == 0)
    { // POLYB is the cholesky benchmark
        n_mini = 40;
        n_small = 120;
        n_medium = 400;
        n_large = 2000;
    }
    else if (strcmp(POLYB, "ludcmp") == 0)
    {
        n_mini = 40;
        n_small = 120;
        n_medium = 400;
        n_large = 2000;
    }
    else if (strcmp(POLYB, "3mm") == 0)
    {
        n_mini = 16 * 22;
        n_small = 40 * 70;
        n_medium = 180 * 210;
        n_large = 800 * 1100;
    }
    else if (strcmp(POLYB, "covariance") == 0)
    { // In covariance, these are the M values
        n_mini = 28;
        n_small = 80;
        n_medium = 240;
        n_large = 1200;
    }
    else if (strcmp(POLYB, "gemm") == 0)
    {
        n_mini = 20 * 25;
        n_small = 60 * 70;
        n_medium = 200 * 220;
        n_large = 1000 * 1100;
    }
    else if (strcmp(POLYB, "seidel-2d") == 0)
    {
        n_mini = 40;
        n_small = 120;
        n_medium = 400;
        n_large = 2000;
    }
    else if (strcmp(POLYB, "fdtd-2d") == 0)
    {
        n_mini = 20 * 30;
        n_small = 60 * 80;
        n_medium = 200 * 240;
        n_large = 1000 * 1200;
    }
    else if (strcmp(POLYB, "durbin") == 0)
    {
        n_mini = 40;
        n_small = 120;
        n_medium = 400;
        n_large = 2000;
    }
    else
    {
        std::cout << "ERROR: Unsupported PolyBench benchmark " POLYB << std::endl;
        return 1;
    }

    print_accuracy(n_mini, "MINI");
    std::cout << std::endl;
    print_accuracy(n_small, "SMALL");
    std::cout << std::endl;
    print_accuracy(n_medium, "MEDIUM");
    std::cout << std::endl;
    print_accuracy(n_large, "LARGE");
    std::cout << std::endl;

    return 0;
}

void print_accuracy(size_t n, std::string dataset_size)
{

    size_t n_vec_size;
    if (strcmp(POLYB, "cholesky") == 0)
    { // POLYB is the cholesky benchmark
        n_vec_size = (n * (n + 1)) / 2;
    }
    else if (strcmp(POLYB, "ludcmp") == 0)
    {
        n_vec_size = n;
    }
    else if (strcmp(POLYB, "3mm") == 0)
    {
        n_vec_size = n;
    }
    else if (strcmp(POLYB, "covariance") == 0)
    {
        n_vec_size = n * n;
    }
    else if (strcmp(POLYB, "gemm") == 0)
    {
        n_vec_size = n;
    }
    else if (strcmp(POLYB, "seidel-2d") == 0)
    {
        n_vec_size = n * n;
    }
    else if (strcmp(POLYB, "fdtd-2d") == 0)
    {
        n_vec_size = 3 * n;
    }
    else if (strcmp(POLYB, "durbin") == 0)
    {
        n_vec_size = n;
    }
    else
    {
        std::cout << "ERROR: Unsupported PolyBench benchmark " POLYB << std::endl;
        return;
    }

    std::ifstream polybFloatOutputs;
    std::ifstream polybDoubleOutputs;
    std::ifstream polybPosit32Outputs;
    std::ifstream polybPosit64Outputs;
    std::ifstream polybLongDoubleOutputs;
    std::ifstream polybPositMemFP32Outputs;
    std::ifstream polybPositMemFP64Outputs;
    

    float *polybFloat = (float *)malloc(n_vec_size * sizeof(float));
    double *polybDouble = (double *)malloc(n_vec_size * sizeof(double));
    Posit32 *polybPosit32 = (Posit32 *)malloc(n_vec_size * sizeof(Posit32));
    Posit64 *polybPosit64 = (Posit64 *)malloc(n_vec_size * sizeof(Posit64));
    long double *polybLongDouble = (long double *)malloc(n_vec_size * sizeof(long double));
    Posit32 *polybPositMemFP32 = (Posit32 *)malloc(n_vec_size * sizeof(Posit32));
    Posit32 *polybPositMemFP64 = (Posit32 *)malloc(n_vec_size * sizeof(Posit32));

    std::cout << "PolyBench " POLYB " " + dataset_size + " accuracy comparison" << std::endl;
    std::cout << std::setw(18) << std::left << "Format" << std::right << \
                std::setw(18) << "MSE" << \
                std::setw(18) << "Max abs. error" \
                << std::setw(18) << "Relative error" << std::endl;

    // Read double outputs
    polybDoubleOutputs.open(OUTPUTS_PATH POLYB "_double_" + dataset_size + ".txt");
    if (!polybDoubleOutputs.is_open())
    {
        std::cout << "ERROR: Could not open " OUTPUTS_PATH POLYB "_double_" + dataset_size + ".txt" << std::endl;
        free(polybFloat);
        free(polybDouble);
        free(polybPosit32);
        free(polybPosit64);
        free(polybLongDouble);
        free(polybPositMemFP32);
        free(polybPositMemFP64);
        return;
    }
    for (int i = 0; i < n_vec_size; ++i)
    {
        polybDoubleOutputs >> polybDouble[i];
    }
    polybDoubleOutputs.close();

    // Read posit64 outputs
    polybPosit64Outputs.open(OUTPUTS_PATH POLYB "_C_posit64_" + dataset_size + ".txt");
    if (!polybPosit64Outputs.is_open())
    {
        std::cout << "ERROR: Could not open " OUTPUTS_PATH POLYB "_C_posit64_" + dataset_size + ".txt" << std::endl;
        free(polybFloat);
        free(polybDouble);
        free(polybPosit32);
        free(polybPosit64);
        free(polybLongDouble);
        free(polybPositMemFP32);
        free(polybPositMemFP64);
        return;
    }
    uint64_t tmp64;
    for (int i = 0; i < n_vec_size; ++i)
    {
        polybPosit64Outputs >> std::hex >> tmp64;
        polybPosit64[i].setbits(tmp64);
    }
    polybPosit64Outputs.close();

    // Read posit32 outputs
    polybPosit32Outputs.open(OUTPUTS_PATH POLYB "_C_posit32_" + dataset_size + ".txt");
    if (!polybPosit32Outputs.is_open())
    {
        std::cout << "ERROR: Could not open " OUTPUTS_PATH POLYB "_C_posit32_" + dataset_size + ".txt" << std::endl;
        free(polybFloat);
        free(polybDouble);
        free(polybPosit32);
        free(polybPosit64);
        free(polybLongDouble);
        free(polybPositMemFP32);
        free(polybPositMemFP64);
        return;
    }
    uint64_t tmp32;
    for (int i = 0; i < n_vec_size; ++i)
    {
        polybPosit32Outputs >> std::hex >> tmp32;
        polybPosit32[i].setbits(tmp32);
    }
    polybPosit32Outputs.close();

    // Read float outputs
    polybFloatOutputs.open(OUTPUTS_PATH POLYB "_float_" + dataset_size + ".txt");
    if (!polybFloatOutputs.is_open())
    {
        std::cout << "ERROR: Could not open " OUTPUTS_PATH POLYB "_float_" + dataset_size + ".txt" << std::endl;
        free(polybFloat);
        free(polybDouble);
        free(polybPosit32);
        free(polybPosit64);
        free(polybLongDouble);
        free(polybPositMemFP32);
        free(polybPositMemFP64);
        return;
    }
    for (int i = 0; i < n_vec_size; ++i)
    {
        polybFloatOutputs >> polybFloat[i];
    }
    polybFloatOutputs.close();

    // Read long double outputs
    polybLongDoubleOutputs.open(OUTPUTS_PATH POLYB "_longdouble_" + dataset_size + ".txt");
    if (!polybLongDoubleOutputs.is_open())
    {
        std::cout << "ERROR: Could not open " OUTPUTS_PATH POLYB "_longdouble_" + dataset_size + ".txt" << std::endl;
        free(polybFloat);
        free(polybDouble);
        free(polybPosit32);
        free(polybPosit64);
        free(polybLongDouble);
        free(polybPositMemFP32);
        free(polybPositMemFP64);
        return;
    }
    for (int i = 0; i < n_vec_size; ++i)
    {
        polybLongDoubleOutputs >> polybLongDouble[i];
    }
    polybLongDoubleOutputs.close();

    // Read posit32_mem_float outputs
    polybPositMemFP32Outputs.open(OUTPUTS_PATH POLYB "_C_posit_mem_float_" + dataset_size + ".txt");
    if (!polybPositMemFP32Outputs.is_open())
    {
        std::cout << "ERROR: Could not open " OUTPUTS_PATH POLYB "_C_posit_mem_float_" + dataset_size + ".txt" << std::endl;
        free(polybFloat);
        free(polybDouble);
        free(polybPosit32);
        free(polybPosit64);
        free(polybLongDouble);
        free(polybPositMemFP32);
        free(polybPositMemFP64);
        return;
    }
    uint64_t tmp32_mem;
    for (int i = 0; i < n_vec_size; ++i)
    {
        polybPositMemFP32Outputs >> std::hex >> tmp32_mem;
        polybPositMemFP32[i].setbits(tmp32_mem);
    }
    polybPositMemFP32Outputs.close();

    // Read posit64_mem_float outputs
    polybPositMemFP64Outputs.open(OUTPUTS_PATH POLYB "_C_posit_mem_double_" + dataset_size + ".txt");
    if (!polybPositMemFP64Outputs.is_open())
    {
        std::cout << "ERROR: Could not open " OUTPUTS_PATH POLYB "_C_posit_mem_double_" + dataset_size + ".txt" << std::endl;
        free(polybFloat);
        free(polybDouble);
        free(polybPosit32);
        free(polybPosit64);
        free(polybLongDouble);
        free(polybPositMemFP32);
        free(polybPositMemFP64);
        return;
    }
    uint64_t tmp64_mem;
    for (int i = 0; i < n_vec_size; ++i)
    {
        polybPositMemFP64Outputs >> std::hex >> tmp64_mem;
        polybPositMemFP64[i].setbits(tmp64_mem);
    }
    polybPositMemFP64Outputs.close();

    /* ERROR COMPUTATION */
    long double module_golden = 0;
    for (int i = 0; i < n_vec_size; ++i)
        module_golden += polybLongDouble[i]*polybLongDouble[i];

    // Compute posit32 error
    long double msePosit32 = 0;
    long double maxAbsErrorPosit32 = 0;
    long double diff_pos32;
    long double r_errPosit32;
    for (int i = 0; i < n_vec_size; ++i)
    {
        diff_pos32 = polybLongDouble[i] - (long double)polybPosit32[i];
        msePosit32 += diff_pos32 * diff_pos32;
        maxAbsErrorPosit32 = fmax(maxAbsErrorPosit32, std::abs(diff_pos32));
    }
    r_errPosit32 = sqrt(msePosit32)/sqrt(module_golden);
    msePosit32 /= n_vec_size;
    std::cout << std::setw(18) << std::left << "Posit32" << std::right;
    std::cout << std::setw(18) << msePosit32 << std::setw(18) << maxAbsErrorPosit32 << std::setw(18) << r_errPosit32 << std::endl;

    // Compute posit64 error
    long double msePosit64 = 0;
    long double maxAbsErrorPosit64 = 0;
    long double diff_pos64;
    long double r_errPosit64;
    for (int i = 0; i < n_vec_size; ++i)
    {
        diff_pos64 = polybLongDouble[i] - (long double)polybPosit64[i];
        msePosit64 += pow(diff_pos64, 2);
        maxAbsErrorPosit64 = fmax(maxAbsErrorPosit64, std::abs(diff_pos64));
    }
    r_errPosit64 = sqrt(msePosit64)/sqrt(module_golden);
    msePosit64 /= n_vec_size;
    std::cout << std::setw(18) << std::left << "Posit64" << std::right;
    std::cout << std::setw(18) << msePosit64 << std::setw(18) << maxAbsErrorPosit64 << std::setw(18) << r_errPosit64 << std::endl;

    // Compute float error
    long double mseFloat = 0;
    long double maxAbsErrorFloat = 0;
    long double diff_fl;
    long double r_errFloat;
    for (int i = 0; i < n_vec_size; ++i)
    {
        diff_fl = polybLongDouble[i] - (long double)polybFloat[i];
        mseFloat += pow(diff_fl, 2);
        maxAbsErrorFloat = fmax(maxAbsErrorFloat, std::abs(diff_fl));
    }
    r_errFloat = sqrt(mseFloat)/sqrt(module_golden);
    mseFloat /= n_vec_size;
    std::cout << std::setw(18) << std::left << "Float32" << std::right;
    std::cout << std::setw(18) << mseFloat << std::setw(18) << maxAbsErrorFloat << std::setw(18) << r_errFloat << std::endl;

    // Compute double error
    long double mseDouble = 0;
    long double maxAbsErrorDouble = 0;
    long double diff_db;
    long double r_errDouble;
    for (int i = 0; i < n_vec_size; ++i)
    {
        diff_db = polybLongDouble[i] - (long double)polybDouble[i];
        mseDouble += pow(diff_db, 2);
        maxAbsErrorDouble = fmax(maxAbsErrorDouble, std::abs(diff_db));
    }
    r_errDouble = sqrt(mseDouble)/sqrt(module_golden);
    mseDouble /= n_vec_size;
    std::cout << std::setw(18) << std::left << "Float64" << std::right;
    std::cout << std::setw(18) << mseDouble << std::setw(18) << maxAbsErrorDouble << std::setw(18) << r_errDouble << std::endl;

    // Compute posit32_mem FP32 error
    long double msePositMemFP32 = 0;
    long double maxAbsErrorPositMemFP32 = 0;
    long double diff_pos_mem_fp32;
    long double r_errPos_mem_fp32;
    for (int i = 0; i < n_vec_size; ++i)
    {
        diff_pos_mem_fp32 = polybLongDouble[i] - (long double)polybPositMemFP32[i];
        msePositMemFP32 += pow(diff_pos_mem_fp32, 2);
        maxAbsErrorPositMemFP32 = fmax(maxAbsErrorPositMemFP32, std::abs(diff_pos_mem_fp32));
    }
    r_errPos_mem_fp32 = sqrt(msePositMemFP32)/sqrt(module_golden);
    msePositMemFP32 /= n_vec_size;
    std::cout << std::setw(18) << std::left << "PositMem_FP32" << std::right;
    std::cout << std::setw(18) << msePositMemFP32 << std::setw(18) << maxAbsErrorPositMemFP32 << std::setw(18) << r_errPos_mem_fp32 << std::endl;

    // Compute posit32_mem FP64 error
    long double msePositMemFP64 = 0;
    long double maxAbsErrorPositMemFP64 = 0;
    long double diff_pos_mem_fp64;
    long double r_errPos_mem_fp64;
    for (int i = 0; i < n_vec_size; ++i)
    {
        diff_pos_mem_fp64 = polybLongDouble[i] - (long double)polybPositMemFP64[i];
        msePositMemFP64 += pow(diff_pos_mem_fp64, 2);
        maxAbsErrorPositMemFP64 = fmax(maxAbsErrorPositMemFP64, std::abs(diff_pos_mem_fp64));
    }
    r_errPos_mem_fp64 = sqrt(msePositMemFP64)/sqrt(module_golden);
    msePositMemFP64 /= n_vec_size;
    std::cout << std::setw(18) << std::left << "PositMem_FP64" << std::right;
    std::cout << std::setw(18) << msePositMemFP64 << std::setw(18) << maxAbsErrorPositMemFP64 << std::setw(18) << r_errPos_mem_fp64 << std::endl;

    free(polybFloat);
    free(polybDouble);
    free(polybPosit32);
    free(polybPosit64);
    free(polybLongDouble);
    free(polybPositMemFP32);
    free(polybPositMemFP64);
}