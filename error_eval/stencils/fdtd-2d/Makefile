include ../../config.mk

EXTRA_FLAGS=

# ====================
# Generate the names depending on the current configuration
# ====================
P32_NAME := fdtd-2d_posit32_
FP32_NAME := fdtd-2d_float_
P64_NAME := fdtd-2d_posit64_
FP64_NAME := fdtd-2d_double_
LDBL_NAME := fdtd-2d_longdouble_
P_FP32_NAME := fdtd-2d_posit_mem_float_
P_FP64_NAME := fdtd-2d_posit_mem_double_

P32_NAME := $(addsuffix ${DATASET_SIZE},$(P32_NAME))
FP32_NAME := $(addsuffix ${DATASET_SIZE},$(FP32_NAME))
P64_NAME := $(addsuffix ${DATASET_SIZE},$(P64_NAME))
FP64_NAME := $(addsuffix ${DATASET_SIZE},$(FP64_NAME))
LDBL_NAME := $(addsuffix ${DATASET_SIZE},$(LDBL_NAME))
P_FP32_NAME := $(addsuffix ${DATASET_SIZE},$(P_FP32_NAME))
P_FP64_NAME := $(addsuffix ${DATASET_SIZE},$(P_FP64_NAME))

P32_EXEC_NAME := $(addsuffix .elf,$(P32_NAME))
FP32_EXEC_NAME := $(addsuffix .elf,$(FP32_NAME))
P64_EXEC_NAME := $(addsuffix .elf,$(P64_NAME))
FP64_EXEC_NAME := $(addsuffix .elf,$(FP64_NAME))
LDBL_EXEC_NAME := $(addsuffix .elf,$(LDBL_NAME))
P_FP32_EXEC_NAME := $(addsuffix .elf,$(P_FP32_NAME))
P_FP64_EXEC_NAME := $(addsuffix .elf,$(P_FP64_NAME))

# ====================
# Targets
# ====================
.PHONY: all

all: fdtd-2d_posit32 fdtd-2d_float fdtd-2d_posit64 fdtd-2d_double fdtd-2d_longdouble fdtd-2d_posit_mem_float fdtd-2d_posit_mem_double

# fdtd-2d: fdtd-2d.c fdtd-2d.h
# 	${VERBOSE} ${CC} -o fdtd-2d fdtd-2d.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 32-bit posits
fdtd-2d_posit32: fdtd-2d.c fdtd-2d.h polybench.o
	${VERBOSE} ${CC} -o ${P32_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT32 -DPOSIT_FAST_POSIT_32_2 -I. -I../../utilities fdtd-2d.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using floats
fdtd-2d_float: fdtd-2d.c fdtd-2d.h polybench.o
	${VERBOSE} ${CC} -o ${FP32_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_FLOAT -I. -I../../utilities fdtd-2d.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 64-bit posits
fdtd-2d_posit64: fdtd-2d.c fdtd-2d.h polybench.o
#	${VERBOSE} ${CC} -o ${P64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT64 -DPOSIT_FAST_POSIT_64_2 -I. -I../../utilities fdtd-2d.c ../../utilities/polybench.c ${EXTRA_FLAGS}
	${VERBOSE} ${CC} -o ${P64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT64 -I. -I../../utilities fdtd-2d.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using doubles
fdtd-2d_double: fdtd-2d.c fdtd-2d.h polybench.o
	${VERBOSE} ${CC} -o ${FP64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_DOUBLE -I. -I../../utilities fdtd-2d.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using long doubles
fdtd-2d_longdouble: fdtd-2d.c fdtd-2d.h polybench.o
	${VERBOSE} ${CC} -o ${LDBL_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_LONGDOUBLE -I. -I../../utilities fdtd-2d.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 32-bit posits in memory, floats in computation
fdtd-2d_posit_mem_float: fdtd-2d_posit_mem.c fdtd-2d.h polybench.o
	${VERBOSE} ${CC} -o ${P_FP32_EXEC_NAME} ${CFLAGS} -DPOSIT_MEM -DDATA_TYPE_IS_FLOAT -DPOSIT_FAST_POSIT_32_2 -I. -I../../utilities fdtd-2d_posit_mem.c ../../utilities/polybench.c ${EXTRA_FLAGS}
	
# Using 32-bit posits in memory, doubles in computation
fdtd-2d_posit_mem_double: fdtd-2d_posit_mem.c fdtd-2d.h polybench.o
	${VERBOSE} ${CC} -o ${P_FP64_EXEC_NAME} ${CFLAGS} -DPOSIT_MEM -DDATA_TYPE_IS_DOUBLE -DPOSIT_FAST_POSIT_32_2 -I. -I../../utilities fdtd-2d_posit_mem.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# PolyBench files
polybench.o: ../../utilities/polybench.h
	${CC} -o polybench.o ${CCFLAGS} -c -I../../utilities ../../utilities/polybench.c

# ====================
# Clean
# ====================
.PHONY: clean clean-obj

clean: clean-obj
	@ rm -f fdtd-2d_*.elf

clean-obj:
	@ rm -f *.o



