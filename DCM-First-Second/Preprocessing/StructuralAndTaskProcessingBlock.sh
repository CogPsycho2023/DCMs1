#!/bin/bash

#This script is about structural preprocessing and functional preprocessing. It will will call other separated scripts for each module.
#The first step for you to run this script, please change the following parameters based on your conditions.

subj=$1

subject=${subj}

threads=2

#FSL
source /etc/fsl/fsl.sh
#AFNI
source /etc/afni/afni.sh
#ants
export ANTSPATH=/usr/local/bin/ants
export PATH=${PATH}:${ANTSPATH}

#module selection, Structural Module and rest minimal preprocessing are recommended to be mandatory. Rest enhanced preprocessing and Rest extraction are optional. 1: to do; 0: not to do.
StructuralModule=0
ExtendedModule=0
FirstAnalysis=1

#server path for Jurece
#set the path for Raw data and out directory
server=/mnt
Orig=/mnt/Orig/Converted #Raw data path
sMRI=/mnt/0620preprocessing/sMRI #strucutral output directory
fMRI=/mnt/0620preprocessing/fMRI #functional output directory
#Original dataset could be nii.gz or nii, which depends on the converting settings
postfix=nii #we may find different postfix name for converted images (nii or nii.gz).
#set the path for the directory saving the functional scripts
Pipelines=/mnt/Pipelines #please make sure all the separated scripts are saved in one directory
ANTSTEMP=${ANTSPATH}/antsTemp #ants prior brain extraction

#Here are parameters for structural module
#set the image types. 
T2w=0 #If T2w is included for structural preprocessing, please set T2w=1, or T2w=0.
#set the number of sessions. 
Session=1 #If the data is not multi-session scanned, just set Session=1
#Structural average.
Concat=0 #If the structural images are scanned with multiple sessions, set Concat = 1, or 0. No-multi sessions, no average.
#Standard template images for normalization with different resolutions. Here is the default-in images in the FSL source directory.
StandardT12mm=$FSLDIR/data/standard/MNI152_T1_2mm.nii.gz
StandardT12mm_brain=$FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz
StandardT12mm_brain_mask=$FSLDIR/data/standard/MNI152_T1_2mm_brain_mask.nii.gz
StandardT11mm=$FSLDIR/data/standard/MNI152_T1_1mm.nii.gz
StandardMask=$FSLDIR/data/standard/MNI152_T1_2mm_brain_mask_dil.nii.gz
StandardT22mm=$FSLDIR/data/standard/MNI152_T2_2mm.nii.gz #This image is only for T2w image preprocessing. Please copy it from HCP pipelines
#BrainSize for image cropping
BrainSize=150 #BrainSize cropping at the Z axis. Numbers from 150 to 180 are accepted.
biascorr=0 #biascorr using fsl_anat
#set structural normalization methods.
StructuralNormalization=2 # If fsl-fnirt is included, please set StructuralNormalization = 1. If ants is included, please set StructuralNormalization = 2.

#Here are specific parameters for the task minimal processing module.
exvol=4 #Usually the number could be 5 or 10.
TR=2.03 #Time for one timepoint that can be seen in the head file.
SliceTiming=0 #Slice-timing correct option.
Order=$server/Design/1000BRAINMatrix/SliceOrder.txt #the path for the slice order text, which is not suitable for multiband slice-timing correction.
HeadMotion=24 #6 or 24 head motion parameters.
IntensityNormalization=1 #for EPI intensity normalization.
Range=10000 #Normalize the signal range
Smoothing=1 #If Smoothing is included, please set Smoothing=1, or 0.
SmoothingFWHM=8 #The number for Smoothing kernel
#Temporal filtering procedure.
TemporalFilter=1 #If Temporal filtering procedure is included, please set TemporalFilter = 1, or 0. 
HighPassSeconds=128 #high pass cut-off seconds, if it is not included, set highbands < 0.
CovarianceRegression=1 #perform covariance or not
Covariances=27 #Covariance number consists of headmotion parameters (6 or 24), CSF, WM, and global signals), The largest number for this part could be 27.

#For the task first-level analysis, we may define the path for timing files.
TimingDesign=Block
Timing=${server}/Design/Timing/$TimingDesign
Templatefsf=${server}/Design/Feat
FEATDir=$fMRI/FirstLevel/${TimingDesign}/${subject}


if [ $StructuralModule = 1 ] ; then 

source $Pipelines/StructuralModules.sh

fi

if [ $ExtendedModule = 1 ] ; then 

source $Pipelines/TaskExtendedModules.sh

fi

if [ $FirstAnalysis = 1 ] ; then 

source $Pipelines/TaskFirstLevelAnalysisBlock.sh

fi
