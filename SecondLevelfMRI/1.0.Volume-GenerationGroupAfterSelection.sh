#!/bin/bash

Rows=9

for timing in AllTrials STrials Block

do 

for ((k=1; k<=${Rows}; k++))

do

label=`awk 'NR=='${k}' {print $1}' $timing/${timing}GroupPeak.txt`

x=`awk 'NR=='${k}' {print $2}' $timing/${timing}GroupPeak.txt`

y=`awk 'NR=='${k}' {print $3}' $timing/${timing}GroupPeak.txt`

z=`awk 'NR=='${k}' {print $4}' $timing/${timing}GroupPeak.txt`

fslmaths ${FSLDIR}/data/standard/MNI152_T1_2mm.nii.gz -mul 0 -add 1 -roi $x 1 $y 1 $z 1 0 1 $timing/$timing.$label.nii.gz

wb_command -volume-dilate $timing/$timing.$label.nii.gz 10 NEAREST $timing/$timing.$label.D10.nii.gz 

done

done


