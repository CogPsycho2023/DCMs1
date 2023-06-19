#!/bin/bash

for timing in AllTrials Block

do 

for CORR in Corrected Uncorrected

do

for CON in Anti AntiPro

do 

cp -rf template.m ${timing}${CORR}${CON}.m

sed -i "s/PEBNAME/${timing}${CORR}${CON}/g" ${timing}${CORR}${CON}.m

sed -i "s#GCMMAT#GCM${timing}${CORR}${CON}.mat#g" ${timing}${CORR}${CON}.m

sh /home/sfzhang/Documents/Container_JURECA_SPM/opt/spm12-r7219/run_spm12.sh /home/sfzhang/Documents/Container_JURECA_SPM/opt/matlabmcr-2010a/v713/ batch ${timing}${CORR}${CON}.m

done

done

done
