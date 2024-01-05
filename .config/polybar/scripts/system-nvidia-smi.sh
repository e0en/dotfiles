#!/bin/sh

GPU_UTILIZATION=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
MEM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
MEM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
echo "${GPU_UTILIZATION}% ${MEM_USED}/${MEM_TOTAL}MiB"
