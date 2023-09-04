import re

def inplace_change(filename, old_string, new_string):
    # Safely read the input filename using 'with'
    with open(filename) as f:
        s = f.read()
        # if old_string not in s:
        #     print('"{old_string}" not found in {filename}.'.format(**locals()))
        #     return

    # Safely write the changed content, if found in the file
    with open(filename, 'w') as f:
        # print('Changing "{old_string}" to "{new_string}" in {filename}'.format(**locals()))
        # s = s.replace(old_string, new_string)
        s = re.sub(old_string, new_string, s)
        f.write(s)

polyb = 'fdtd-2d'

for dataset_size in ["MINI", "SMALL", "MEDIUM", "LARGE"]:
    for format in ["_float_", "_double_", "_longdouble_", "_posit32_", "_posit64_", "_posit_mem_float_", "_posit_mem_double_"]:
        infile = polyb + '/' + polyb + format + dataset_size + '.txt'

        inplace_change(infile, r'==.+DUMP\_ARRAYS==\n', "")
        inplace_change(infile, r'.+dump:.+\n', "")