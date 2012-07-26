#!/bin/bash

# Variable containing path to toolchain installed
CCTC="arm-linux-androideabi-"

# a little housekeeping before the build
rm boot.img >& /dev/null
rm arch/arm/boot/zImage >& /dev/null
rm ../anykernel/system/modules/*
#make ARCH=arm clean > /dev/null

# the actual kernel is built, now $CCTC makes this short and neat
make -j4 ARCH=arm CROSS_COMPILE=$CCTC 

# copying the modules over into the kernel-update.zip skeleton
#find ./ -name *.ko -not -name scsi_wait_scan.ko -exec cp -v {} ../anykernel/system/modules/ \;
#chmod 711 ../anykernel/system/modules/*

# With an anykernel based flash  skeleton, we do not need to build the boot.img, left for reference, commented ( # )
# ~/bin/mkbootimg --kernel arch/arm/boot/zImage --cmdline 'console=ttyFIQ0 no_console_suspend' --base 0x30000000 --pagesize 0x1000 --ramdisk ../ramdisks/oxygen.gz -o boot.img
# copying the kernel over
cp arch/arm/boot/zImage ../anykernel/kernel >& /dev/null

# just showing we built one, how large, when, for reference
ls -alh arch/arm/boot/zImage
