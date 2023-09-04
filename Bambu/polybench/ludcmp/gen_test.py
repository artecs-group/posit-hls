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
        # beginning
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
        
        b = np.zeros((_gemm_size_dict[size]['N']))
        b_str = np.array2string(b, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('b="{}" '.format(b_str))
        
        x = np.zeros((_gemm_size_dict[size]['N']))
        x_str = np.array2string(x, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('x="{}" '.format(x_str))
        
        y = np.zeros((_gemm_size_dict[size]['N']))
        y_str = np.array2string(y, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('y="{}" '.format(y_str))

        # Ending
        output.write('/>\n')
        output.write('</function>')
