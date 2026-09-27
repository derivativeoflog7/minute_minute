#! /bin/bash
export ROOTDIR=$(pwd)

SETTINGS=(BLUE_LED_AFTER_MINUTE ODD_POWER)
NUM=${#SETTINGS[@]}
EXP=$((2**NUM))


for i in $(seq 0 $(($EXP-1)));
do
    fname=fw_fastboot-
    for j in $(seq 0 $(($NUM-1)));
    do
        export "${SETTINGS[j]}"=$((i>>j&1));
        var="${SETTINGS[j]}";
        fname+=$var;
        fname+==;
        fname+="${!var}";
        fname+=-;
    done
    fname=${fname::-1};
    fname+=.img
    echo $fname;
    make -f Makefile.fastboot --always-make
    mv ${ROOTDIR}/fw_fastboot.img ${ROOTDIR}/${fname}
done
