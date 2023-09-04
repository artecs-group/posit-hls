include ../../../config.mk

EXTRA_FLAGS=

# ====================
# Generate the names depending on the current configuration
# ====================
P32_NAME := 3mm_posit32_
FP32_NAME := 3mm_float_
P64_NAME := 3mm_posit64_
FP64_NAME := 3mm_double_
LDBL_NAME := 3mm_longdouble_
P_FP32_NAME := 3mm_posit_mem_float_
P_FP64_NAME := 3mm_posit_mem_double_

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

all: 3mm_posit32 3mm_float 3mm_posit64 3mm_double 3mm_longdouble 3mm_posit_mem_float 3mm_posit_mem_double

# 3mm: 3mm.c 3mm.h
# 	${VERBOSE} ${CC} -o cholesky 3mm.c ${CFLAGS} -I. -I../../../utilities ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 32-bit posits
3mm_posit32: 3mm.c 3mm.h polybench.o
	${VERBOSE} ${CC} -o ${P32_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT32 -DPOSIT_FAST_POSIT_32_2 -I. -I../../../utilities 3mm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using floats
3mm_float: 3mm.c 3mm.h polybench.o
	${VERBOSE} ${CC} -o ${FP32_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_FLOAT -I. -I../../../utilities 3mm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 64-bit posits
3mm_posit64: 3mm.c 3mm.h polybench.o
#	${VERBOSE} ${CC} -o ${P64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT64 -DPOSIT_FAST_POSIT_64_2 -I. -I../../../utilities 3mm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}
	${VERBOSE} ${CC} -o ${P64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT64 -I. -I../../../utilities 3mm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using doubles
3mm_double: 3mm.c 3mm.h polybench.o
	${VERBOSE} ${CC} -o ${FP64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_DOUBLE -I. -I../../../utilities 3mm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using long doubles
3mm_longdouble: 3mm.c 3mm.h polybench.o
	${VERBOSE} ${CC} -o ${LDBL_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_LONGDOUBLE -I. -I../../../utilities 3mm.c ../../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 32-bit posits in memory, floats in computation
3mm_posit_mem_float: 3mm_posit_mem.c 3mm.h polybench.o
	${VERBOSE} ${CC} -o ${P_FP32_EXEC_NAME} ${CFLAGS} -DPOSIT_MEM -DDATA_TYPE_IS_FLOAT -DPOSIT_FAST_POSIT_32_2 -I. -I../../../utilities 3mm_posit_mem.c ../../../utilities/polybench.c ${EXTRA_FLAGS}
	
# Using 32-bit posits in memory, doubles in computation
3mm_posit_mem_double: 3mm_posit_mem.c 3mm.h polybench.o
	${VERBOSE} ${CC} -o ${P_FP64_EXEC_NAME} ${CFLAGS} -DPOSIT_MEM -DDATA_TYPE_IS_DOUBLE -DPOSIT_FAST_POSIT_32_2 -I. -I../../../utilities 3mm_posit_mem.c ../../../utilities/polybench.c ${EXTRA_FLAGS}


# PolyBench files
polybench.o: ../../../utilities/polybench.h
	${CC} -o polybench.o ${CCFLAGS} -c -I../../../utilities ../../../utilities/polybench.c

# ====================
# Clean
# ====================
.PHONY: clean clean-obj

clean: clean-obj
	@ rm -f 3mm_*.elf

clean-obj:
	@ rm -f *.o



