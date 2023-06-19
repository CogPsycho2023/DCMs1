#!/bin/bash

source /etc/fsl/fsl.sh

Timing=$1

FirstLevel=/mnt/0620preprocessing/fMRINoGSR/FirstLevel/$Timing

SecondLevel=/mnt/0620preprocessing/fMRINoGSR/SecondLevel/$Timing

Matrix=/mnt/Design/1000BRAINMatrix

if [ -e $SecondLevel ] ; then 

rm -rf $SecondLevel

fi

mkdir -p $SecondLevel

if [ $Timing = Block ]; then

Counter=3

else Counter=5

fi

COPEMERGE=""

VARCOPEMERGE=""

for subject in `cat $Matrix/Initial_Subject_Jureca_266`

do 

subject=T$subject

COPEMERGE="$COPEMERGE ${FirstLevel}/${subject}*/stats/cope${Counter}.nii.gz"

VARCOPEMERGE="$VARCOPEMERGE ${FirstLevel}/${subject}*/stats/varcope${Counter}.nii.gz"

done

echo $COPEMERGE >> $SecondLevel/Cope${Counter}.list

echo $VARCOPEMERGE >> $SecondLevel/VarCope${Counter}.list

fslmerge -t $SecondLevel/Cope${Counter}.nii.gz $COPEMERGE

fslmerge -t $SecondLevel/VarCope${Counter}.nii.gz $VARCOPEMERGE

randomise -i $SecondLevel/Cope${Counter}.nii.gz -m ${Matrix}/GM_mask.nii.gz -o $SecondLevel/OneSampleCope${Counter} -1 -T --uncorrp -x -n 5000

