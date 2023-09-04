include ../../../config.mk

EXTRA_FLAGS=

# ====================
# Generate the names depending on the current configuration
# ====================
P32_NAME := gemm_posit32_
FP32_NAME := gemm_float_
P64_NAME := gemm_posit64_
FP64_NAME := gemm_double_
LDBL_NAME := gemm_longdouble_
P_FP32_NAME := gemm_posit_mem_float_
P_FP64_NAME := gemm_posit_mem_double_

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

all: gemm_posit32 gemm_float gemm_posit64 gemm_double gemm_longdouble gemm_posit_mem_float gemm_posit_mem_double

# gemm: gemm.c gemm.h
# 	${VERBOSE} ${CC} -o gemm gemm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 32-bit posits
gemm_posit32: gemm.c gemm.h polybench.o
	${VERBOSE} ${CC} -o ${P32_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT32 -DPOSIT_FAST_POSIT_32_2 -I. -I../../../utilities gemm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using floats
gemm_float: gemm.c gemm.h polybench.o
	${VERBOSE} ${CC} -o ${FP32_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_FLOAT -I. -I../../../utilities gemm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 64-bit posits
gemm_posit64: gemm.c gemm.h polybench.o
#	${VERBOSE} ${CC} -o ${P64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT64 -DPOSIT_FAST_POSIT_64_2 -I. -I../../../utilities gemm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}
	${VERBOSE} ${CC} -o ${P64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT64 -I. -I../../../utilities gemm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using doubles
gemm_double: gemm.c gemm.h polybench.o
	${VERBOSE} ${CC} -o ${FP64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_DOUBLE -I. -I../../../utilities gemm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using long doubles
gemm_longdouble: gemm.c gemm.h polybench.o
	${VERBOSE} ${CC} -o ${LDBL_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_LONGDOUBLE -I. -I../../../utilities gemm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 32-bit posits in memory, floats in computation
gemm_posit_mem_float: gemm_posit_mem.c gemm.h polybench.o
	${VERBOSE} ${CC} -o ${P_FP32_EXEC_NAME} ${CFLAGS} -DPOSIT_MEM -DDATA_TYPE_IS_FLOAT -DPOSIT_FAST_POSIT_32_2 -I. -I../../../utilities gemm_posit_mem.c ../../../utilities/polybench.c ${EXTRA_FLAGS}
	
# Using 32-bit posits in memory, doubles in computation
gemm_posit_mem_double: gemm_posit_mem.c gemm.h polybench.o
	${VERBOSE} ${CC} -o ${P_FP64_EXEC_NAME} ${CFLAGS} -DPOSIT_MEM -DDATA_TYPE_IS_DOUBLE -DPOSIT_FAST_POSIT_32_2 -I. -I../../../utilities gemm_posit_mem.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# PolyBench files
polybench.o: ../../../utilities/polybench.h
	${CC} -o polybench.o ${CCFLAGS} -c -I../../../utilities ../../../utilities/polybench.c

# ====================
# Clean
# ====================
.PHONY: clean clean-obj

clean: clean-obj
	@ rm -f gemm_*.elf

clean-obj:
	@ rm -f *.o



