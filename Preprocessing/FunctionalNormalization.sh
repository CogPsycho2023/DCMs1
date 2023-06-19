#!/bin/bash

#This script is about functional normalization with different methods (ANTs or fsl-fnirt)

echo "$input is the input for FunctionalNormalization.sh" >> $fMRI/$subject/fMRI$n.log.txt

if [ ! -f $fMRI/$subject/fMRI$n/reg/example_func_brain2highres0GenericAffine.mat ] && [ ! -f $fMRI/$subject/fMRI$n/reg/example_func_brain2highres_mask.nii.gz ] ; then 

  echo "create ants_example_func2highres0GernericAffine"

  antsRegistrationSyN.sh -d 3 -m $fMRI/$subject/fMRI$n/mc/example_func_brain.nii.gz -f $fMRI/$subject/fMRI$n/reg/highres.nii.gz -t a -o $fMRI/$subject/fMRI$n/reg/example_func_brain2highres -n $threads

  antsApplyTransforms -d 3 -i $fMRI/$subject/fMRI$n/mc/example_func_brain_mask.nii.gz -r $fMRI/$subject/fMRI$n/reg/highres.nii.gz -t $fMRI/$subject/fMRI$n/reg/example_func_brain2highres0GenericAffine.mat -n NearestNeighbor -o $fMRI/$subject/fMRI$n/reg/example_func_brain2highres_mask.nii.gz

fi

  imcp $sMRI/$subject/T1w/T1w_acpc.nii.gz $fMRI/$subject/fMRI$n/reg/highres_head.nii.gz

  fslmaths $fMRI/$subject/fMRI$n/reg/highres.nii.gz -add  $fMRI/$subject/fMRI$n/reg/example_func_brain2highres_mask.nii.gz -bin $fMRI/$subject/fMRI$n/reg/highres_func_mask.nii.gz

  fslmaths $fMRI/$subject/fMRI$n/reg/highres_head.nii.gz -mas $fMRI/$subject/fMRI$n/reg/highres_func_mask.nii.gz $fMRI/$subject/fMRI$n/reg/highres2.nii.gz

  antsRegistrationSyN.sh -d 3 -m $fMRI/$subject/fMRI$n/reg/highres2.nii.gz -f $StandardT12mm_brain -t s -o $fMRI/$subject/fMRI$n/reg/antsReg2 -n $threads

  antsApplyTransforms -d 3 -i $fMRI/$subject/fMRI${n}/mc/example_func_brain.nii.gz -r $StandardT12mm_brain -t $fMRI/$subject/fMRI$n/reg/antsReg21Warp.nii.gz -t $fMRI/$subject/fMRI$n/reg/antsReg20GenericAffine.mat -t $fMRI/$subject/fMRI$n/reg/example_func_brain2highres0GenericAffine.mat -o $fMRI/$subject/fMRI${n}/mc/example_func_brain2std.nii.gz

  antsApplyTransforms -e 3 -i $fMRI/$subject/fMRI${n}/mc/${input}.nii.gz -r $StandardT12mm_brain -t $fMRI/$subject/fMRI$n/reg/antsReg21Warp.nii.gz -t $fMRI/$subject/fMRI$n/reg/antsReg20GenericAffine.mat -t $fMRI/$subject/fMRI$n/reg/example_func_brain2highres0GenericAffine.mat -o $fMRI/$subject/fMRI${n}/${input}_MNI.nii.gz

  fslmaths $fMRI/$subject/fMRI${n}/${input}_MNI.nii.gz -Tmean $fMRI/$subject/fMRI$n/tempMean

  input=${input}_MNI

echo "${input}_MNI.nii.gz is the output for FunctionalNormalization.sh" >> $fMRI/$subject/fMRI$n.log.txt

