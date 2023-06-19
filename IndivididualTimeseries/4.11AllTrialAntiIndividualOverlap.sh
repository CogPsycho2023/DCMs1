#!/bin/bash

Group=SecondLevel

num=8

Timing=AllTrials

CON=Anti

GSR=ContrastsGSR

RunDir=/home/sfzhang/Desktop/NoIntNorm/GSR

ROIDir=${RunDir}/${Group}/${Timing}

for subject in `cat ${RunDir}/Initial_Subject_Jureca_266`

do

for Corr in Corrected Uncorrected

do 

cd ${RunDir}/${GSR}/${Timing}/${Corr}/${CON}/${subject}

for ROI in AMCC LINS RINS LIPS RIPS LDLPFC RDLPFC LPMC RPMC

do

fslmaths ${Corr}_zstat${num} -mas ${ROIDir}/${Timing}.${ROI}.D10.nii.gz ${ROI}_${Corr}_zstat${CON}.nii.gz

mri_convert ${ROI}_${Corr}_zstat${CON}.nii.gz ${ROI}_${Corr}_zstat${CON}.nii

voxel=`wb_command -volume-stats ${ROI}_${Corr}_zstat${CON}.nii.gz -reduce COUNT_NONZERO`

if [ $voxel -eq "0" ] ; then

echo "${subject}" >>  ${ROIDir}/${Timing}${Corr}${CON}.check.txt

fi

done

done

done
