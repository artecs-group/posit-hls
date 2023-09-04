include ../../config.mk

EXTRA_FLAGS=

# ====================
# Generate the names depending on the current configuration
# ====================
P32_NAME := covariance_posit32_
FP32_NAME := covariance_float_
P64_NAME := covariance_posit64_
FP64_NAME := covariance_double_
LDBL_NAME := covariance_longdouble_
P_FP32_NAME := covariance_posit_mem_float_
P_FP64_NAME := covariance_posit_mem_double_

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

all: covariance_posit32 covariance_float covariance_posit64 covariance_double covariance_longdouble covariance_posit_mem_float covariance_posit_mem_double

# covariance: covariance.c covariance.h
# 	${VERBOSE} ${CC} -o covariance covariance.c ${CFLAGS} -I. -I../../utilities ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 32-bit posits
covariance_posit32: covariance.c covariance.h polybench.o
	${VERBOSE} ${CC} -o ${P32_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT32 -DPOSIT_FAST_POSIT_32_2 -I. -I../../utilities covariance.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using floats
covariance_float: covariance.c covariance.h polybench.o
	${VERBOSE} ${CC} -o ${FP32_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_FLOAT -I. -I../../utilities covariance.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 64-bit posits
covariance_posit64: covariance.c covariance.h polybench.o
#	${VERBOSE} ${CC} -o ${P64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT64 -DPOSIT_FAST_POSIT_64_2 -I. -I../../utilities covariance.c ../../utilities/polybench.c ${EXTRA_FLAGS}
	${VERBOSE} ${CC} -o ${P64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_POSIT64 -I. -I../../utilities covariance.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using doubles
covariance_double: covariance.c covariance.h polybench.o
	${VERBOSE} ${CC} -o ${FP64_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_DOUBLE -I. -I../../utilities covariance.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using long doubles
covariance_longdouble: covariance.c covariance.h polybench.o
	${VERBOSE} ${CC} -o ${LDBL_EXEC_NAME} ${CFLAGS} -DDATA_TYPE_IS_LONGDOUBLE -I. -I../../utilities covariance.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# Using 32-bit posits in memory, floats in computation
covariance_posit_mem_float: covariance_posit_mem.c covariance.h polybench.o
	${VERBOSE} ${CC} -o ${P_FP32_EXEC_NAME} ${CFLAGS} -DPOSIT_MEM -DDATA_TYPE_IS_FLOAT -DPOSIT_FAST_POSIT_32_2 -I. -I../../utilities covariance_posit_mem.c ../../utilities/polybench.c ${EXTRA_FLAGS}
	
# Using 32-bit posits in memory, doubles in computation
covariance_posit_mem_double: covariance_posit_mem.c covariance.h polybench.o
	${VERBOSE} ${CC} -o ${P_FP64_EXEC_NAME} ${CFLAGS} -DPOSIT_MEM -DDATA_TYPE_IS_DOUBLE -DPOSIT_FAST_POSIT_32_2 -I. -I../../utilities covariance_posit_mem.c ../../utilities/polybench.c ${EXTRA_FLAGS}

# PolyBench files
polybench.o: ../../utilities/polybench.h
	${CC} -o polybench.o ${CCFLAGS} -c -I../../utilities ../../utilities/polybench.c

# ====================
# Clean
# ====================
.PHONY: clean clean-obj

clean: clean-obj
	@ rm -f covariance_*.elf

clean-obj:
	@ rm -f *.o



