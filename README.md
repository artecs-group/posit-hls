<!-- # posit-hls -->
# Generating Posit-Based Accelerators With High-Level Synthesis

This repo contains the code to reproduce the experiments, as well as the results, from the paper
[Generating Posit-Based Accelerators With High-Level Synthesis](https://doi.org/10.1109/TCSI.2023.3299009).  
It can also serve as an example of how to use HLS for the generation of posit arithmetic accelerators.

### Prerequisites

You need to install a modified version of the [Bambu framework](https://panda.deib.polimi.it/?page_id=31). More precisely, clone the following repo, which contains the necessary modifications to make Bambu work with posit units: https://github.com/RaulMurillo/PandA-bambu. Then follow the [official installation instructions](https://panda.deib.polimi.it/?page_id=88).

<div style="border: 2px solid #f0f0f0; padding: 10px;">
    <strong>⚠️ Note:</strong>
    Ensure you install Bambu from the `posit_utils` branch.
</div>

After the installation, you must pre-characterize the target device you wish to use. To that end, you need to use the Eucalyptus tool. You can use the `characterize_device_custom.sh` script from `PandA-bambu/etc/devices/` directory with the following arguments:
```bash
--devices=<list of target devices comma separated> --eucalyptus=/bin/eucalyptus --spider=/<bambu installation dir>/bin/spider -j8 -c"--flopoco=posit"

```
The resulting `.xml` file must be copied into the corresponding folder within `PandA-bambu/etc/devices/`.

Finally, compile and install the tool again.

<div style="border: 2px solid #f0f0f0; padding: 10px;">
    <strong>⚠️ Note:</strong>
    This makes Bambu work just with the posit format, breaking compatibility with floating-point. To restore the original functionality, execute the previous script without the `-c"--flopoco=posit"` argument, and repeat the following steps. You can keep the different `.xml` files and just replace and compile (but the name must be preserved).
</div>

### Usage

To generate a posit-based accelerator, take any C program using floating-point numbers, and use the option `--flopoco=posit` when calling Bambu. The `float` and `double` types will be automatically translated by 32 or 64-bit posits.


<div style="border: 2px solid #f0f0f0; padding: 10px;">
    <strong>⚠️ Note:</strong>
    The automatic simulation of Bambu will fail when using posits, since it relies on C floats to simulate the behavior of the accelerator. Generating testbench with all 0's usually avoids this issue.
</div>


### Structure of the repo

* Both `Bambu` and `Vitis_HLS` contain a similar structure, with one subdir per test. Operation-level applications can be found at the root, while real applications are grouped under the `polybench` folder.
* The sources from `Bambu` can serve as examples of how to use Bambu to generate posit-based accelerators. For more details, see the `bambu.sh` scripts.
* In `error_eval`, the numerical error of the different PolyBench applications is computed via software emulation (for faster computation).


### Publications

Overview paper:

> R. Murillo, A. A. D. Barrio, G. Botella and C. Pilato, "Generating Posit-Based Accelerators With High-Level Synthesis," in IEEE Transactions on Circuits and Systems I: Regular Papers, doi: [10.1109/TCSI.2023.3299009](https://doi.org/10.1109/TCSI.2023.3299009).

If you find this project useful, please do not forget to cite this paper.

### Acknowledgments

This work was supported in part by MCIN/AEI/10.13039/ 501100011033 under Grant PID2021-123041OB-I00; in part by the “ERDF—A Way of Making Europe;” in part by the 2020 Leonardo Grant for Researchers and Cultural Creators, BBVA Foundation, under Grant PR2003_20/01; in part by CM under Grant S2018/TCS-4423; in part by the EU Horizon 2020 Programme under Grant 957269; and in part by the HiPEAC6 Network funded by the EU Horizon 2020 Programme under Grant ICT-2019-871174.