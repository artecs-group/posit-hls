import numpy as np
import sys

_gemm_size_dict = {
    "MINI": {"M": 28, "N": 32},
    "SMALL": {"M": 80, "N": 100},
    "MEDIUM": {"M": 240, "N": 260},
    "LARGE": {"M": 1200, "N": 1400},
    "EXTRALARGE": {"M": 2600, "N": 3000},
}

np.set_printoptions(threshold=sys.maxsize)

# for dataset_size in ["MINI", "SMALL", "MEDIUM", "LARGE"]:
for size in ["MINI"]:
    with open('test_' + size + '.xml', 'w') as output:
        # Beginning
        output.write('<?xml version="1.0"?>\n<function>\n')
        output.write('\n  <testbench ')
        # Write variables
        output.write(
            'm="{}" n="{}" '.format(_gemm_size_dict[size]['M'], _gemm_size_dict[size]['N']))
        # C = np.random.rand() # Output might be not correct for posits due to simulation uses float for checking
        data = np.zeros((_gemm_size_dict[size]['N'],
                     _gemm_size_dict[size]['M']))
        data_str = np.array2string(data, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('data="{}" '.format(data_str))

        cov = np.zeros((_gemm_size_dict[size]['M'],
                     _gemm_size_dict[size]['M']))
        cov_str = np.array2string(cov, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('cov="{}" '.format(cov_str))

        # Ending
        output.write('/>\n')
        output.write('</function>')
