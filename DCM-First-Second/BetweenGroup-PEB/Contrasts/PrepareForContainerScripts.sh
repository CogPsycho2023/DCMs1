#!/bin/bash

for timing in AllTrials

do 

for CORR in Corrected Uncorrected

do 

cp -rf template.m AntiPro-Anti${timing}${CORR}.m

sed -i "s/PEBNAME/AntiPro-Anti${timing}${CORR}/g" AntiPro-Anti${timing}${CORR}.m

sed -i "s#GCMMAT#AntiPro-Anti${timing}${CORR}.mat#g" AntiPro-Anti${timing}${CORR}.m

Mat=`cat AntiPro-Anti${timing}${CORR}.X`

Mat=$(echo ${Mat})

sed -i "s#DesignMatrix#${Mat}#g" AntiPro-Anti${timing}${CORR}.m

sh /home/sfzhang/Documents/Container_JURECA_SPM/opt/spm12-r7219/run_spm12.sh /home/sfzhang/Documents/Container_JURECA_SPM/opt/matlabmcr-2010a/v713/ batch AntiPro-Anti${timing}${CORR}.m

done

done
