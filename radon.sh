#
# Custom build script for Radon kernel
#
# Copyright 2016 Umang Leekha (Umang96@xda)
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it.
#

yellow='\033[0;33m'
white='\033[0m'
red='\033[0;31m'
gre='\e[0;32m'
echo -e ""
echo -e "$gre ====================================\n\n Welcome to Radon building program !\n\n ===================================="
echo -e "$gre \n 1.Build radon for Treble Rom\n\n 2.Build radon for normal Rom\n"
echo -n " Enter your choice:"
read pt
echo -e "$gre \n 1.Build radon without qc\n\n 2.Build radon with qc\n"
echo -n " Enter your choice:"
read qc
echo -e "$white"
KERNEL_DIR=$PWD
cd arch/arm/boot/dts/
rm *.dtb > /dev/null 2>&1
cd $KERNEL_DIR
Start=$(date +"%s")
DTBTOOL=$KERNEL_DIR/dtbTool
cd $KERNEL_DIR
export ARCH=arm64
export CROSS_COMPILE="/home/pratik_pithore/gcc-linaro-6.4.1-2018.04-rc1-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-"
echo -e "$yellow Running make clean before compiling \n$white"
make clean > /dev/null
if [ $qc == 2 ]; then
echo -e "$yellow Applying quick charging patch \n $white"
git apply qc.patch
elif [ $qc == 1 ]; then
git apply -R qc.patch > /dev/null 2>&1
fi
if [ $pt != 1 ]; then
git apply pt.patch
fi
make lineageos_kenzo_defconfig
export KBUILD_BUILD_HOST="DeathNote_27"
export KBUILD_BUILD_USER="Pratik Pithore"
make -j8
time=$(date +"%d-%m-%y-%T")
$DTBTOOL -2 -o $KERNEL_DIR/arch/arm64/boot/dt.img -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/
if [ $pt -eq 1 ]; then
pt_in="1"
else
pt_in="2"
fi
dt_img_name="dt"$pt_in$qc".img"
mv $KERNEL_DIR/arch/arm64/boot/dt.img $KERNEL_DIR/build/tools/$dt_img_name
zimage=$KERNEL_DIR/arch/arm64/boot/Image
if ! [ -f $zimage ];
then
echo -e "$red << Failed to compile zImage, fix the errors first >>$white"
else
cp $KERNEL_DIR/arch/arm64/boot/Image $KERNEL_DIR/build/tools/Image1
cd $KERNEL_DIR/build
rm *.zip > /dev/null 2>&1
echo -e "$yellow\n Build succesful, generating flashable zip now \n $white"
zip -r Radon-Kenzo-pie.zip * > /dev/null
End=$(date +"%s")
Diff=$(($End - $Start))
echo -e "$yellow $KERNEL_DIR/build/Radon-Kenzo-pie.zip \n$white"
echo -e "$gre << Build completed in $(($Diff / 60)) minutes and $(($Diff % 60)) seconds, variant($qc) >> \n $white"
fi
cd $KERNEL_DIR
if [ $qc == 2 ]; then
git apply -R qc.patch
fi
if [ $pt != 1 ]; then
git apply -R pt.patch > /dev/null 2>&1
fi
