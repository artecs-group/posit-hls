# Read outputs and write them in individual files
# for polyb in ["gemm", "3mm", "cholesky", "durbin", "ludcmp", "covariance", "seidel-2d", "fdtd-2d"]:
for polyb in ["4mm"]:
    for dataset_size in ["MINI", "SMALL", "MEDIUM", "LARGE"]:
    # for dataset_size in ["MINI", "SMALL", "MEDIUM"]:
        # for format in ["_posit32_", "_posit64_"]:
        # for format in ["_posit32_", "_posit64_", "_posit_mem_float_", "_posit_mem_double_"]:
        for format in ["_posit_mem_float_", "_posit_mem_double_"]:

            infile = polyb + '/' + polyb + format + dataset_size + '.txt'
            outfile = polyb + '/' + polyb + "_C" + format + dataset_size + '.txt'

            delete_list = ["32.2x", "64.2x", "p"]
            with open(infile) as fin, open(outfile, "w+") as fout:
                for line in fin:
                    for word in delete_list:
                        line = line.replace(word, "")
                    fout.write(line)
