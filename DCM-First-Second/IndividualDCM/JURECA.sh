#!/bin/bash

SUB=$1

timing=$2

corr=$3

CON=$4

cd /mnt/${timing}/${corr}/${CON}/${SUB}

sh /mnt/Container_JURECA_SPM/opt/spm12-r7219/run_spm12.sh /mnt/Container_JURECA_SPM/opt/matlabmcr-2010a/v713 batch DCM.estimation.m

