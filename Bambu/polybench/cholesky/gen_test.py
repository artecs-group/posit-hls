import numpy as np
import sys

_gemm_size_dict = {
    "MINI": {"N": 40},
    "SMALL": {"N": 120},
    "MEDIUM": {"N": 400},
    "LARGE": {"N": 2000},
    "EXTRALARGE": {"N": 4000},
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
            'n="{}" '.format(_gemm_size_dict[size]['N']))
        # A = np.random.rand() # Output might be not correct for posits due to simulation uses float for checking
        A = np.zeros((_gemm_size_dict[size]['N'],
                      _gemm_size_dict[size]['N']))
        A_str = np.array2string(A, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('A="{}" '.format(A_str))

        # Ending
        output.write('/>\n')
        output.write('</function>')
