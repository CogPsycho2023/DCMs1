#!/bin/bash

#This script is about task temporal filtering
echo "the main input for TemporalFiltering.sh is $input" >>$fMRI/$subject/fMRI$n.log.txt

# Compute smoothing kernel sigma
hp_sigma=`echo "0.5 * $HighPassSeconds / $TR" | bc -l`
# Use fslmaths to apply high pass filter and then add mean back to image
fslmaths $fMRI/$subject/fMRI$n/${input}.nii.gz -bptf ${hp_sigma} -1 -add $fMRI/$subject/fMRI$n/mc/tempMean.nii.gz $fMRI/$subject/fMRI$n/filtered_func_data.nii.gz

input=filtered_func_data
