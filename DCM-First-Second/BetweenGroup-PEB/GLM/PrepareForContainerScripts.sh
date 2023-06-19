#!/bin/bash

for timing in AllTrials-STrials

do 

for CORR in Corrected Uncorrected

do

for CON in Anti AntiPro

do 

cp -rf template.m ${timing}${CORR}${CON}.m

sed -i "s/PEBNAME/${timing}${CORR}${CON}/g" ${timing}${CORR}${CON}.m

sed -i "s#GCMMAT#${timing}${CORR}${CON}.mat#g" ${timing}${CORR}${CON}.m

Mat=`cat ${timing}${CORR}${CON}.X`

Mat=$(echo ${Mat})

sed -i "s#DesignMatrix#${Mat}#g" ${timing}${CORR}${CON}.m

sh /home/sfzhang/Documents/Container_JURECA_SPM/opt/spm12-r7219/run_spm12.sh /home/sfzhang/Documents/Container_JURECA_SPM/opt/matlabmcr-2010a/v713/ batch ${timing}${CORR}${CON}.m

done

done

done
