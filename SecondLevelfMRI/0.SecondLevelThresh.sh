#!/bin/bash

Pval=0.95 #FSL generate 1-p images.

for timing in AllTrials Block STrials

do 

if [ $timing = Block ] ; then 

contrast=3

else 

contrast=5

fi

fslmaths $timing/OneSampleCope${contrast}_tfce_corrp_tstat1.nii.gz -thr 0.95 -bin $timing/Thre_95_mask.nii.gz

fslmaths $timing/OneSampleCope${contrast}_tstat1.nii.gz -mas $timing/Thre_95_mask.nii.gz $timing/Thre_OneSampleCope${contrast}_tstat1.nii.gz

mri_convert $timing/Thre_OneSampleCope${contrast}_tstat1.nii.gz $timing/Thre_OneSampleCope${contrast}_tstat1.nii

done
