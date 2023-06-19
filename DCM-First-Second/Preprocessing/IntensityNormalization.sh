#!/bin/bash

#This script is about epi signal normalization

echo "$input is the input for IntensityNormalization.sh" >> $fMRI/$subject/fMRI$n.log.txt
#It seems better that we can use -ing parameter to normalize fMRI data
fslmaths $fMRI/$subject/fMRI$n/mc/${input} -inm $Range $fMRI/$subject/fMRI$n/mc/${input}_norm

echo "${input}_norm is the output for IntensityNormalization.sh" >>$fMRI/$subject/fMRI$n.log.txt

input=${input}_norm


