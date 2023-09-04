import math

# Given the size of the cholesky dataset, returns the number of output values of the benchmark.


def _cholesky_output_count(n):
    return math.ceil(((n * (n + 1)) / 2))


def _ludcmp_output_count(n):
    return n


def _3mm_output_count(n):
    return n


def _covariance_output_count(n):
    return n * n


def _gemm_output_count(n):
    return n


def _seidel2d_output_count(n):
    return n * n


def _fdtd2d_output_count(n):
    return 3 * n


def _durbin_output_count(n):
    return n


_cholesky_dataset_size_dict = {
    "MINI": 40,
    "SMALL": 120,
    "MEDIUM": 400,
    "LARGE": 2000,
    "EXTRALARGE": 4000
}

_ludcmp_dataset_size_dict = {
    "MINI": 40,
    "SMALL": 120,
    "MEDIUM": 400,
    "LARGE": 2000,
    "EXTRALARGE": 4000
}

_3mm_dataset_size_dict = {
    "MINI": 16*22,
    "SMALL": 40*70,
    "MEDIUM": 180*210,
    "LARGE": 800*1100,
    "EXTRALARGE": 1600*2200
}

_covariance_dataset_size_dict = {  # In covariance, these are the M values
    "MINI": 28,
    "SMALL": 80,
    "MEDIUM": 240,
    "LARGE": 1200,
    "EXTRALARGE": 2600
}

_gemm_dataset_size_dict = {
    "MINI": 20*25,
    "SMALL": 60*70,
    "MEDIUM": 200*220,
    "LARGE": 1000*1100,
    "EXTRALARGE": 2000*2300
}

_seidel2d_dataset_size_dict = {
    "MINI": 40,
    "SMALL": 120,
    "MEDIUM": 400,
    "LARGE": 2000,
    "EXTRALARGE": 4000
}

_fdtd2d_dataset_size_dict = {
    "MINI": 20*30,
    "SMALL": 60*80,
    "MEDIUM": 200*240,
    "LARGE": 1000*1200,
    "EXTRALARGE": 2000*2600
}

_durbin_dataset_size_dict = {
    "MINI": 40,
    "SMALL": 120,
    "MEDIUM": 400,
    "LARGE": 2000,
    "EXTRALARGE": 4000
}


# ===========================
# Modify these parameters
polyb = "fdtd-2d"
output_count_func = _fdtd2d_output_count
dataset_size_dict = _fdtd2d_dataset_size_dict
# ===========================


# Read screen output
lines = []
with open('raw_output.txt') as screen_outputs:
    lines = screen_outputs.readlines()

# Skip initial phase
idx = 0
while lines[idx][:11] != "begin dump:":
    idx += 1
idx -= 2  # Go back to the beginning of the execution

# Read outputs and write them in individual files
for dataset_size in ["MINI", "SMALL", "MEDIUM", "LARGE"]:
    idx += 2  # Skip timing and ==BEGIN DUMP
    # Copy outputs to each file
    # Must keep the same order as in the execution
    with open(polyb + '/' + polyb + '_float_' + dataset_size + '.txt', 'w') as output:
        count = output_count_func(dataset_size_dict[dataset_size])
        while count > 0:
            if lines[idx][:3] != "beg" and lines[idx][:3] != "end":
                output.write(lines[idx])
                count -= len(lines[idx].split())
            idx += 1
    with open(polyb + '/' + polyb + '_double_' + dataset_size + '.txt', 'w') as output:
        count = output_count_func(dataset_size_dict[dataset_size])
        while count > 0:
            if lines[idx][:3] != "beg" and lines[idx][:3] != "end":
                output.write(lines[idx])
                count -= len(lines[idx].split())
            idx += 1
    with open(polyb + '/' + polyb + '_posit32_' + dataset_size + '.txt', 'w') as output:
        count = output_count_func(dataset_size_dict[dataset_size])
        while count > 0:
            if lines[idx][:3] != "beg" and lines[idx][:3] != "end":
                output.write(lines[idx])
                count -= len(lines[idx].split())
            idx += 1
    with open(polyb + '/' + polyb + '_posit64_' + dataset_size + '.txt', 'w') as output:
        count = output_count_func(dataset_size_dict[dataset_size])
        while count > 0:
            if lines[idx][:3] != "beg" and lines[idx][:3] != "end":
                output.write(lines[idx])
                count -= len(lines[idx].split())
            idx += 1
    # idx += 4  # Skip end dumps, timing and ==BEGIN DUMP
    # with open(polyb + '/' + polyb + '_posit64_' + dataset_size + '.txt', 'w') as output:
    #     count = output_count_func(dataset_size_dict[dataset_size])
    #     while count > 0:
    #         if lines[idx][:3] != "beg" and lines[idx][:3] != "end":
    #             output.write(lines[idx])
    #             count -= len(lines[idx].split())
    #         idx += 1
    idx += 2  # Skip end dumps

# # Write timings to file
# with open(polyb + '/' + polyb + '_timing_results.txt', 'w') as output:
#     for dataset_size in ["MINI", "SMALL", "MEDIUM", "LARGE"]:
#         for arithmetic in ["double", "posit64"]:
#             # Find the beginning of the timing for each dataset size
#             while lines[idx][:22] != "[INFO] Running 5 times":
#                 idx += 1
#             # Write to output file until the end of each dataset size
#             while lines[idx][:23] != "[INFO] Normalized time:":
#                 output.write(lines[idx])
#                 idx += 1
#             output.write(lines[idx])
#             idx += 1
