import numpy as np
import sys

_gemm_size_dict = {
    "MINI": {"NI": 20, "NJ": 25, "NK": 30},
    "SMALL": {"NI": 60, "NJ": 70, "NK": 80},
    "MEDIUM": {"NI": 200, "NJ": 220, "NK": 240},
    "LARGE": {"NI": 1000, "NJ": 1100, "NK": 1200},
    "EXTRALARGE": {"NI": 2000, "NJ": 2300, "NK": 2600},
}

np.set_printoptions(threshold=sys.maxsize)

# for dataset_size in ["MINI", "SMALL", "MEDIUM", "LARGE"]:
for size in ["MINI", "SMALL"]:
    with open('test_' + size + '.xml', 'w') as output:
        # Beginning
        output.write('<?xml version="1.0"?>\n<function>\n')
        output.write('\n  <testbench ')
        # Write variables
        output.write(
            'ni="{}" nj="{}" nk="{}" alpha="1.5" beta="1.2" '.format(_gemm_size_dict[size]['NI'], _gemm_size_dict[size]['NJ'], _gemm_size_dict[size]['NK']))
        # C = np.random.rand() # Output might be not correct for posits due to simulation uses float for checking
        C = np.zeros((_gemm_size_dict[size]['NI'],
                     _gemm_size_dict[size]['NJ']))
        C_str = np.array2string(C, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('C="{}" '.format(C_str))
        A = np.zeros((_gemm_size_dict[size]['NI'],
                     _gemm_size_dict[size]['NK']))
        A_str = np.array2string(A, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('A="{}" '.format(A_str))
        B = np.zeros((_gemm_size_dict[size]['NK'],
                     _gemm_size_dict[size]['NJ']))
        B_str = np.array2string(B, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('B="{}" '.format(B_str))
        # Ending
        output.write('/>\n')
        output.write('</function>')
