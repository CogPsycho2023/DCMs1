#!/bin/bash

if [ -e $fMRI/$subject/fMRI$n/mc ] ; then 

rm -rf $fMRI/$subject/fMRI$n/mc

fi

mkdir -p $fMRI/$subject/fMRI$n/mc

#we may do the motion correction first.

#register 4D fMRI data 
mcflirt -in $fMRI/$subject/fMRI$n/$input -out $fMRI/$subject/fMRI$n/mc/${input}_mcf -refvol 0

#extract example_func and brain
fslmaths $fMRI/$subject/fMRI$n/mc/${input}_mcf -Tmean $fMRI/$subject/fMRI$n/mc/example_func

bet $fMRI/$subject/fMRI$n/mc/example_func $fMRI/$subject/fMRI$n/mc/example_func_brain -f 0.4 -m  

rm -rf $fMRI/$subject/fMRI$n/mc/${input}_mcf.nii.gz

#motion correction
mcflirt -in $fMRI/$subject/fMRI$n/$input -out $fMRI/$subject/fMRI$n/mc/${input}_mcf -mats -plots -reffile $fMRI/$subject/fMRI$n/mc/example_func -rmsrel -rmsabs -spline_final

#slice timing correction is the second step
if [ $SliceTiming = 1 ] ; then

slicetimer -i $fMRI/$subject/fMRI$n/mc/${input}_mcf -o $fMRI/$subject/fMRI$n/mc/${input}_mcf -r $TR --ocustom=$Order

echo "Slice-timing is performed" >> $fMRI/$subject/fMRI$n.log.txt

elif [ $SliceTiming = 0 ] ; then

echo "Slice-timing is not performed" >> $fMRI/$subject/fMRI$n.log.txt

fi

#functional series brain extraction 
fslmaths $fMRI/$subject/fMRI$n/mc/${input}_mcf -mas $fMRI/$subject/fMRI$n/mc/example_func_brain_mask $fMRI/$subject/fMRI$n/mc/${input}_mcf

input=${input}_mcf

if [ $HeadMotion = 6 ] ; then

cp $fMRI/$subject/fMRI$n/mc/prefiltered_func_data_mcf.par  $fMRI/$subject/fMRI$n/mc/MotionRegressors.txt

elif [ $HeadMotion = 24 ] ; then 

source ${Pipelines}/HeadMotionModel.sh

fi






