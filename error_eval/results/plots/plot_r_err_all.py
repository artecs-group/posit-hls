import matplotlib.pyplot as plt
import numpy as np
import re

plt.rcParams.update({'hatch.color': 'w'})

labels = ['MINI', 'SMALL', 'MEDIUM', 'LARGE']

x = np.arange(len(labels))  # the label locations
width = 0.15  # the width of the bars
# colors = ['#a6cee3', '#1f78b4', '#fdbf6f', '#ff7f00', '#b2df8a', '#33a02c']
# colors = ['#a6cee3', '#fdbf6f', '#b2df8a',
#           '#1f78b4', '#ff7f00', '#33a02c']
colors = ['#79B1D3', '#FEAF53', '#88CA6B', '#1f78b4', '#ff7f00', '#33a02c']
hatches = ([''] * (3)) + (['//'] * (3))


def read_accuracy_file(accuracy_results_file, benchmark_name):
    lines = []
    with open(accuracy_results_file) as screen_outputs:
        lines = screen_outputs.readlines()

    # Search for benchmark
    l = 0
    while(benchmark_name not in lines[l]):
        l += 1
    
    error_type = 3

    # Obtain accuracies
    posit32_error = []
    float_error = []
    posit64_error = []
    double_error = []
    posit_float_error = []
    posit_double_error = []
    for line in lines[l:l+36]:
        line_d = re.sub(r'\s+', ' ', line).split(' ')
        if 'Posit32' == line_d[0]:
            posit32_error.append(float(line_d[error_type]))
        elif 'Float32' == line_d[0]:
            float_error.append(float(line_d[error_type]))
        elif 'Posit64' == line_d[0]:
            posit64_error.append(float(line_d[error_type]))
        elif 'Float64' == line_d[0]:
            double_error.append(float(line_d[error_type]))
        elif 'PositMem_FP32' == line_d[0]:
            posit_float_error.append(float(line_d[error_type]))
        elif 'PositMem_FP64' == line_d[0]:
            posit_double_error.append(float(line_d[error_type]))

    return (posit32_error, float_error, posit64_error, double_error, posit_float_error, posit_double_error)


def add_plot(benchmark_name, ylim_top, ax):
    shift = width/2
    (posit32_error, float_error, posit64_error, double_error, posit_float_error, posit_double_error) = read_accuracy_file('../accuracy/accuracy_results.txt', benchmark_name)

    # alpha=0.99, # Bug with hatches: https://stackoverflow.com/questions/5195466/matplotlib-does-not-display-hatching-when-rendering-to-pdf
    rect_flt = ax.bar(x - (2*width+shift), float_error,  width, label='Float32', color=colors[0], alpha=0.99, hatch=hatches[0])
    rect_pos32 = ax.bar(x - (1*width+shift), posit32_error, width, label='Posit32', color=colors[1], alpha=0.99, hatch=hatches[1])
    rect_p_fp32 = ax.bar(x - (0*width+shift), posit_float_error, width, label='Posit$_{mem}$Float32', color=colors[2], alpha=0.99, hatch=hatches[2])
    rect_dbl = ax.bar(x + (0*width+shift), double_error,  width, label='Float64', color=colors[3], alpha=0.99, hatch=hatches[3])
    rect_pos64 = ax.bar(x + (1*width+shift), posit64_error, width, label='Posit64', color=colors[4], alpha=0.99, hatch=hatches[4])
    rect_p_fp64 = ax.bar(x + (2*width+shift), posit_double_error,  width, label='Posit$_{mem}$Float64', color=colors[5], alpha=0.99, hatch=hatches[5])

    plt.sca(ax)
    ax.set_ylabel('Relative Error')
    ax.set_title(benchmark_name)
    ax.set_xticks(x, labels)
    ax.set_yscale('log')
    # ax.legend(False)
    # plt.yticks(fontsize=20)

    ax.bar_label(rect_flt, rotation=90, fmt='%1.2e', padding=3 if float_error[-1] < ylim_top else -60)
    ax.bar_label(rect_pos32, rotation=90, fmt='%1.2e', padding=3 if posit32_error[-1] < ylim_top else -60)
    ax.bar_label(rect_dbl, rotation=90, fmt='%1.2e', padding=3 if double_error[-1] < ylim_top else -60)
    ax.bar_label(rect_pos64, rotation=90, fmt='%1.2e', padding=3 if posit64_error[-1] < ylim_top else -60)
    ax.bar_label(rect_p_fp32, rotation=90, fmt='%1.2e', padding=3 if posit_float_error[-1] < ylim_top else -60)
    ax.bar_label(rect_p_fp64, rotation=90, fmt='%1.2e', padding=3 if posit_double_error[-1] < ylim_top else -60)
    # plt.ylim(top=ylim_top)

    # plt.legend([rect_pos32, rect_flt, rect_pos64, rect_dbl], ['Posit32', 'Float', 'Posit64', 'Double'],
    #            loc='upper left')


if __name__ == "__main__":
    # fig, axs = plt.subplots(nrows=1, ncols=1)
    # add_plot('gemm',       1e-8, axs)

    # fig, axs = plt.subplots(nrows=3, ncols=2)
    # add_plot('3mm',        1e-9, axs[0, 0])
    # add_plot('cholesky',   1e-9, axs[0, 1])
    # add_plot('covariance', 1e-9, axs[1, 0])
    # add_plot('fdtd-2d',    1e-9, axs[1, 1])
    # add_plot('gemm',       1e-9, axs[2, 0])
    # add_plot('ludcmp',     1e-9, axs[2, 1])
    fig, axs = plt.subplots(nrows=2, ncols=3)
    add_plot('3mm',        1e-9, axs[0, 0])
    add_plot('cholesky',   1e-9, axs[0, 1])
    add_plot('covariance', 1e-9, axs[0, 2])
    add_plot('fdtd-2d',    1e-9, axs[1, 0])
    add_plot('gemm',       1e-9, axs[1, 1])
    add_plot('ludcmp',     1e-9, axs[1, 2])

    # Set global legend
    axLine, axLabel = axs[0,0].get_legend_handles_labels()
    fig.legend(axLine, axLabel,
            loc='upper center',
            ncol=len(axLabel),
            title='Format',
            bbox_to_anchor=(0.5, 1.0)
            )


    figure = plt.gcf()  # get current figure
    # figure.set_size_inches(15, 14)  # set figure's size manually
    figure.set_size_inches(18, 8)  # set figure's size manually
    # figure.tight_layout()
    plt.savefig('plot_error.png', bbox_inches='tight', dpi=300)
    plt.savefig("plot_error.pdf", bbox_inches="tight")
