#!/bin/bash

#This script is about structural preprocessing and functional preprocessing. It will will call other separated scripts for each module.
#The first step for you to run this script, please change the following parameters based on your conditions.

#FSL
source /etc/fsl/fsl.sh

NODE=20221023NoGSRNodes

Timing=$1

corr=$2

CON=$3

ROI=$4

GSR=fMRINoGSR

for subj in `cat /mnt/${NODE}/${Timing}${corr}${CON}.left.txt` 

do

mkdir -p /mnt/${NODE}/Timeseries/${Timing}/${corr}/${CON}/${subj}

fslmeants -i /mnt/0620preprocessing/$GSR/T${subj}/fMRI1/filtered_func_data.nii.gz -m /mnt/${NODE}/${Timing}/${corr}/${CON}/${subj}/${ROI}PeakforTSR5.nii.gz --eig -o /mnt/${NODE}/Timeseries/${Timing}/${corr}/${CON}/${subj}/${subj}.${ROI}.eig.txt

done
