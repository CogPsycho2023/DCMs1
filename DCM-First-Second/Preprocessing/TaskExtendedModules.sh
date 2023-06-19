#!/bin/bash
#This script is about all preprocessing steps for functional images. The main steps included volume exclusion, slice-timing (optional), motion correction, 
#smoothing (optional), temporal filtering (optional), and normalization. Further steps about ICA+AROMA and ICA+FIX could be seen in another scripts.
#Before running it, you should make sure you have installed HCP workbench software, scripts and T2w images.
#During functional preprocessing, this script will call other separated scripts for different functions.

startingtime=$(date +%s)

n=1

#Session loop
while [ $n -le $Session ] ; do 

fMRIlist=""

mkdir -p $fMRI/$subject/fMRI${n}

date >> $fMRI/$subject/fMRI${n}.log.txt

if [ -f $fMRI/$subject/fMRI${n}/prefiltered_func_data.nii.gz ] ; then 

echo "detect prefiltered_func_data" >> $fMRI/$subject/fMRI${n}.log.txt

elif [ -f $Orig/$subject/Parad/*.${postfix} ] ; then 

echo "task functional image is copying" >> $fMRI/$subject/fMRI${n}.log.txt

#start pre-exclusion processes for fMRI images, remove the initial volumes
imcp $Orig/$subject/Parad/*.${postfix} $fMRI/$subject/fMRI${n}/prefiltered_func_data.${postfix}

totalvol=$(fslinfo $Orig/$subject/Parad/*.${postfix} | sed -n '5p' | awk '{ print $2 }')

length=$(expr $totalvol - $exvol )

fslroi $fMRI/$subject/fMRI$n/prefiltered_func_data.${postfix} $fMRI/$subject/fMRI$n/prefiltered_func_data.nii.gz $exvol $length

else 

echo "can't find functional images" >> $fMRI/$subject/fMRI${n}.log.txt

fi 

if [ $postfix = nii ] ; then 

rm -rf $fMRI/$subject/fMRI$n/prefiltered_func_data.${postfix}

fi

#check and copy the structural images

if [ ! -f $fMRI/$subject/fMRI$n/reg/highres.nii.gz ] ; then 

mkdir -p $fMRI/$subject/fMRI$n/reg

if [ $biascorr = 1 ]; then 

imcp $sMRI/$subject/T1w/T1_biascorr_brain.nii.gz $fMRI/$subject/fMRI$n/reg/highres.nii.gz

else 

imcp $sMRI/$subject/T1w/T1w_acpc_brain.nii.gz $fMRI/$subject/fMRI$n/reg/highres.nii.gz

fi

else 

echo "detect highres" >> $fMRI/$subject/fMRI${n}.log.txt

fi

#Motion-correction and slice-timing procedures.

if [ ! -f $fMRI/$subject/fMRI$n/mc/prefiltered_func_data_mcf.nii.gz ] ; then 

input=prefiltered_func_data

source $Pipelines/TaskSliceAndMotionCorrection.sh

else 

echo "detect prefiltered_func_data_mcf" >> $fMRI/$subject/fMRI${n}.log.txt

fi

#start intensity normalization

if [ $IntensityNormalization = 1 ] ; then 

source ${Pipelines}/IntensityNormalization.sh

fi 

#start Functional Normalization

source $Pipelines/FunctionalNormalization.sh

#start EPI signal smoothing 

if [ $Smoothing = 1 ] ; then 

source $Pipelines/TaskSmoothing.sh

else 

echo "don't perform smooting" >> $fMRI/$subject/fMRI$n.log.txt

fi

if [ $CovarianceRegression = 1 ] ; then

source $Pipelines/TaskCovarianceRegression.sh

else 

echo "don't perform covariance regression" >> $fMRI/$subject/fMRI$n.log.txt

fi

if [ $TemporalFilter = 1 ] ; then 

source $Pipelines/TaskTemporalFiltering.sh

else

echo "don't perform temporal filtering" >> $fMRI/$subject/fMRI$n.log.txt

fi

#clear files for saving space

rm -rf $fMRI/$subject/fMRI${n}/*MNI*

et=$fMRI/$subject/fMRI${n}.Taskelapsedtime.txt

elapsedtime=$(($(date +%s) - $startingtime))

printf "task processing elapsed time = ${elapsedtime} seconds.\n"

echo "${elapsedtime}" >> ${et}

n=$(($n+1))

done

