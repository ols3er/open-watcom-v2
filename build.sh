#!/bin/sh
#
# Build script to bootstrap build the Linux version of the compiler
# using the GNU C/C++ compiler tools. If you already have a working
# Open Watcom compiler, you do not need to use the bootstrap process

if [ -f setvars ]; then
    . ./setvars
else
    . ./setvars.sh
fi
if [ ! -f $OWBINDIR/wtouch ]; then
    cp -p `which touch` $OWBINDIR/wtouch
fi
cd bld/wmake
$MAKE -f gnumake
mkdir -p ../builder/$OWOBJDIR
cd ../builder/$OWOBJDIR
wmake -h -f ../linux386/makefile builder.exe bootstrap=1
cd ../..
export BUILDMODE=bootstrap
builder rel2 os_linux
unset BUILDMODE
