#!/bin/bash

#This script is about structural preprocessing and functional preprocessing. It will will call other separated scripts for each module.
#The first step for you to run this script, please change the following parameters based on your conditions.

#FSL
source /etc/fsl/fsl.sh

FirstLevel=/mnt/0620preprocessing/fMRINoGSR/FirstLevel

Matrix=/mnt/Design/1000BRAINMatrix

fMRI=/mnt/0620preprocessing/fMRINoGSR

subj=$1

TimingDesign=$2

Contrast=$3

tval=$4

pval=$5

subject=T${subj}

if [ ! -e ${FirstLevel}/${TimingDesign}/${subject}/stats/tempMean_mask.nii.gz ]; then 

fslmaths ${fMRI}/${subject}/fMRI1/tempMean.nii.gz -bin ${FirstLevel}/${TimingDesign}/${subject}/stats/tempMean_mask.nii.gz

fi

cd ${FirstLevel}/${TimingDesign}/${subject}/stats

DOF=`cat dof`

if [ ! -e  smoothness ] ; then 

smoothest -d ${DOF} -m tempMean_mask.nii.gz -r res4d.nii.gz >> smoothness 

fi

DLH=`cat smoothness |tail -3| head -n 1| awk '{print $2}'`

VOLUME=`cat smoothness |tail -2| head -n 1| awk '{print $2}'`

RESELS=`cat smoothness |tail -1| head -n 1| awk '{print $2}'`

fslmaths zstat${Contrast}.nii.gz -mas tempMean_mask.nii.gz thresh_zstat${Contrast}.nii.gz

cluster -i thresh_zstat${Contrast}.nii.gz  -t  $tval -p  $pval --dlh=${DLH} --volume=${VOLUME} --othresh=thresh_zstat${Contrast}clusters -o zstat${Contrast}_clusters --connectivity=26 --scalarname=Z

fslmaths zstat${Contrast}_clusters  -bin zstat${Contrast}_clusters_mask

fslmaths thresh_zstat${Contrast}.nii.gz -mas zstat${Contrast}_clusters_mask.nii.gz  Corrected_zstat${Contrast}.nii.gz

fslmaths thresh_zstat${Contrast}.nii.gz -thr $tval  Uncorrected_zstat${Contrast}.nii.gz

