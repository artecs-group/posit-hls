import numpy as np
import sys

_gemm_size_dict = {
    "MINI": {"TMAX": 20, "NX": 20, "NY": 30},
    "SMALL": {"TMAX": 40, "NX": 60, "NY": 80},
    "MEDIUM": {"TMAX": 100, "NX": 200, "NY": 240},
    "LARGE": {"TMAX": 500, "NX": 1000, "NY": 1200},
    "EXTRALARGE": {"TMAX": 1000, "NX": 2000, "NY": 2600},
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
            'tmax="{}" nx="{}" ny="{}" '.format(_gemm_size_dict[size]['TMAX'], _gemm_size_dict[size]['NX'], _gemm_size_dict[size]['NY']))
        # C = np.random.rand() # Output might be not correct for posits due to simulation uses float for checking
        ex = np.zeros((_gemm_size_dict[size]['NX'],
                     _gemm_size_dict[size]['NY']))
        ex_str = np.array2string(ex, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('ex="{}" '.format(ex_str))

        ey = np.zeros((_gemm_size_dict[size]['NX'],
                     _gemm_size_dict[size]['NY']))
        ey_str = np.array2string(ey, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('ey="{}" '.format(ey_str))

        hz = np.zeros((_gemm_size_dict[size]['NX'],
                     _gemm_size_dict[size]['NY']))
        hz_str = np.array2string(hz, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('hz="{}"'.format(hz_str))

        _fict_ = np.zeros((_gemm_size_dict[size]['TMAX']))
        _fict__str = np.array2string(_fict_, separator=',', formatter={
                                'float_kind': lambda x: "%.2f" % x}).replace('[', '{').replace(']', '}')
        output.write('_fict_="{}"'.format(_fict__str))

        # Ending
        output.write('/>\n')
        output.write('</function>')
