import sys

filename = sys.argv[1]
period = sys.argv[2]


def read_accuracy_file(synthesis_results_file):
    lines = []
    with open(synthesis_results_file) as screen_outputs:
        lines = screen_outputs.readlines()

    # Obtain resources
    resources = dict.fromkeys(
        ['Slices', 'LUTs', 'Registers', 'DSPs', 'BRAMs', 'Cycles', 'Period'], 0)
    for line in lines:
        if 'Simulation ended after' in line:
            resources['Cycles'] = int(line.split(' ')[-2])
        elif 'SLICE"' in line:
            resources['Slices'] = int((line.split('"'))[-2])
        elif 'SLICE_REGISTERS' in line:
            resources['Registers'] = int((line.split('"'))[-2])
        elif 'SLICE_LUTS' in line:
            resources['LUTs'] = int((line.split('"'))[-2])
        elif 'BLOCK_RAMFIFO' in line:
            resources['BRAMs'] = int((line.split('"'))[-2])
        elif 'DSPS' in line:
            resources['DSPs'] = int((line.split('"'))[-2])
        elif 'DELAY' in line:
            resources['Period'] = float((line.split('"'))[-2])

    return resources


results = read_accuracy_file(filename)

# Overwrite the file
with open(filename, 'w') as f:
    f.write('Analyzing Xilinx synthesis results\n')
    f.write(f'  Slices                   : {results["Slices"]}\n')
    f.write(f'  Luts                     : {results["LUTs"]}\n')
    f.write(f'  Registers                : {results["Registers"]}\n')
    f.write(f'  DSPs                     : {results["DSPs"]}\n')
    f.write(f'  BRAMs                    : {results["BRAMs"]}\n')
    f.write(f'  Clock period             : {period}\n')
    f.write(f'  Design minimum period    : {results["Period"]}\n')
    f.write(f'  Design slack             : {float(period) - results["Period"]}\n')
    f.write(f'  Frequency                : {1000/results["Period"]}\n')
    f.write(f'  Total cycles             : {results["Cycles"]} cycles\n')
    f.write(f'  Number of executions     : 1\n')
    f.write(f'  Average execution        : {results["Cycles"]} cycles\n')
    time = results["Cycles"] * results["Period"] / 1000
    f.write(f'  AreaxTime                : {results["LUTs"] * time}\n')
    f.write(f'  Time                     : {time}\n')
    f.write(f'  Tot. Time                : {time}\n')
