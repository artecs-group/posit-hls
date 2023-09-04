import numpy as np
import sys

_gemm_size_dict = {
    "MINI": {"TSTEPS": 20, "N": 40},
    "SMALL": {"TSTEPS": 40, "N": 120},
    "MEDIUM": {"TSTEPS": 100, "N": 400},
    "LARGE": {"TSTEPS": 500, "N": 2000},
    "EXTRALARGE": {"TSTEPS": 1000, "N": 4000},
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
            'tsteps="{}" n="{}" '.format(_gemm_size_dict[size]['TSTEPS'], _gemm_size_dict[size]['N']))
        # A = np.random.rand() # Output might be not correct for posits due to simulation uses float for checking
        A = np.zeros((_gemm_size_dict[size]['N'],
                     _gemm_size_dict[size]['N']))
        A_str = np.array2string(A, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('A="{}" '.format(A_str))

        # Ending
        output.write('/>\n')
        output.write('</function>')
