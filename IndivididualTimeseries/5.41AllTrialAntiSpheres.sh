#!/bin/bash

RunDir=/home/sfzhang/Desktop/NoIntNorm/GSR

Timing=AllTrials

CON=Anti

NUM=8

Group=SecondLevel

IndCon=ContrastsGSR

outdir=NoIntNormGSRNodes

for corr in Corrected Uncorrected

do 

for subject in `cat ${RunDir}/${Group}/${Timing}/${Timing}${corr}${CON}.left.txt`

do

cd ${RunDir}/${IndCon}/${Timing}/${corr}/${CON}/${subject}

for ROI in AMCC LINS RINS LIPS RIPS LDLPFC RDLPFC LPMC RPMC

do

Column=`awk 'END{print NF}' ${ROI}${corr}${CON}`

mkdir -p ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}

for ((k=1; k<=${Column}; k++))

do

x=`awk "NR==1 {print "'$'$k"}" ${ROI}${corr}${CON}`

y=`awk "NR==2 {print "'$'$k"}" ${ROI}${corr}${CON}`

z=`awk "NR==3 {print "'$'$k"}" ${ROI}${corr}${CON}`

fslmaths ${FSLDIR}/data/standard/MNI152_T1_2mm.nii.gz -mul 0 -add 1 -roi $x 1 $y 1 $z 1 0 1 ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}Peak${k}.nii.gz

done

fsladd ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}AllPeak.nii.gz -m ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}Peak*.nii.gz

fslmaths ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}AllPeak.nii.gz -bin ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}AllPeak.nii.gz

voxel=`wb_command -volume-stats ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}AllPeak.nii.gz -reduce COUNT_NONZERO`

if [ $voxel -eq "0" ] ; then 

	echo "${subject}" >> ${RunDir}/${Group}/${Timing}/${Timing}${corr}${CON}absentLmax.check

fi

fslmaths ${corr}_zstat${NUM}.nii.gz -mas ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}AllPeak.nii.gz ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}AllPeakTval.nii.gz 

fslstats ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}AllPeakTval.nii.gz -x >> ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}.lmax

f=`awk 'NR==1 {print $1}' ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}.lmax`

s=`awk 'NR==1 {print $2}' ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}.lmax`

l=`awk 'NR==1 {print $3}' ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}.lmax`

fslmaths ${FSLDIR}/data/standard/MNI152_T1_2mm.nii.gz -mul 0 -add 1 -roi $f 1 $s 1 $l 1 0 1 ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}PeakforTS.nii.gz

wb_command -volume-dilate ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}PeakforTS.nii.gz 4 NEAREST ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}PeakforTSR5.nii.gz

fslmaths ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}PeakforTSR5.nii.gz -mas ${corr}_zstat${NUM}.nii.gz ${RunDir}/${outdir}/${Timing}/${corr}/${CON}/${subject}/${ROI}PeakforTSR5.nii.gz

done

rm -rf *nii

done

done
