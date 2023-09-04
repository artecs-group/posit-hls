import numpy as np
import sys

_gemm_size_dict = {
    "MINI": {"NI": 16, "NJ": 18, "NK": 20, "NL": 22, "NM": 24},
    "SMALL": {"NI": 40, "NJ": 50, "NK": 60, "NL": 70, "NM": 80},
    "MEDIUM": {"NI": 180, "NJ": 190, "NK": 200, "NL": 210, "NM": 220},
    "LARGE": {"NI": 800, "NJ": 900, "NK": 1000, "NL": 1100, "NM": 1200},
    "EXTRALARGE": {"NI": 1600, "NJ": 1800, "NK": 2000, "NL": 2200, "NM": 2400},
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
            'ni="{}" nj="{}" nk="{}" nl="{}" nm="{}" '.format(_gemm_size_dict[size]['NI'], _gemm_size_dict[size]['NJ'], _gemm_size_dict[size]['NK'], _gemm_size_dict[size]['NL'], _gemm_size_dict[size]['NM']))
        # A = np.random.rand() # Output might be not correct for posits due to simulation uses float for checking
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

        C = np.zeros((_gemm_size_dict[size]['NJ'],
                     _gemm_size_dict[size]['NM']))
        C_str = np.array2string(C, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('C="{}" '.format(C_str))

        D = np.zeros((_gemm_size_dict[size]['NM'],
                     _gemm_size_dict[size]['NL']))
        D_str = np.array2string(D, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('D="{}" '.format(D_str))

        G = np.zeros((_gemm_size_dict[size]['NI'],
                     _gemm_size_dict[size]['NL']))
        G_str = np.array2string(G, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('G="{}" '.format(G_str))

        # Ending
        output.write('/>\n')
        output.write('</function>')
