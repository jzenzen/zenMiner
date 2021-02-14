#!/bin/sh

 # Paths to the utilities we will need
 SMI='/usr/bin/nvidia-smi'
 SET='/usr/bin/nvidia-settings'

 # Determine major driver version
 VER=`awk '/NVIDIA/ {print $8}' /proc/driver/nvidia/version | cut -d . -f 1`
 $SMI -pm 1 # enable persistance mode

 # loop through each GPU and individually set fan speed
 #1660S
 n=0
 MEMORY="2000"
 GPUCLOCK="100"
 WATT="75"
 # Set the power limit for each card (note this value is in watts, not percent!
 nvidia-smi -i ${n} -pl $WATT
 xinit ${SET} -c :0 -a [gpu:${n}]/GpuPowerMizerMode=1 \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[2]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[2]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[3]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[3]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[4]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[4]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[5]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[5]=$GPUCLOCK --  :0 -once

 #1660S
 n=1
 MEMORY="2000"
 GPUCLOCK="100"
 WATT="75"
 # Set the power limit for each card (note this value is in watts, not percent!
 nvidia-smi -i ${n} -pl $WATT
 xinit ${SET} -c :0 -a [gpu:${n}]/GpuPowerMizerMode=1 \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[2]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[2]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[3]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[3]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[4]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[4]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[5]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[5]=$GPUCLOCK --  :0 -once

 #3070
 n=2
 MEMORY="2000"
 GPUCLOCK="75"
 WATT="116"
 # Set the power limit for each card (note this value is in watts, not percent!
 nvidia-smi -i ${n} -pl $WATT
 xinit ${SET} -c :0 -a [gpu:${n}]/GpuPowerMizerMode=1 \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[2]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[2]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[3]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[3]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[4]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[4]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[5]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[5]=$GPUCLOCK --  :0 -once

 #1660S
 n=3
 MEMORY="2000"
 GPUCLOCK="100"
 WATT="75"
 # Set the power limit for each card (note this value is in watts, not percent!
 nvidia-smi -i ${n} -pl $WATT
 xinit ${SET} -c :0 -a [gpu:${n}]/GpuPowerMizerMode=1 \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[2]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[2]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[3]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[3]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[4]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[4]=$GPUCLOCK \
     -a [gpu:${n}]/GPUMemoryTransferRateOffset[5]=$MEMORY  -a [gpu:${n}]/GPUGraphicsClockOffset[5]=$GPUCLOCK --  :0 -once


