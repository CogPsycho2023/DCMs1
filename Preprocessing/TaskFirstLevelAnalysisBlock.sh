#!/bin/bash

input=filtered_func_data

startingtime=$(date +%s)

n=1

#Session loop
while [ $n -le $Session ] ; do 

if [ -e ${FEATDir} ] ; then
	rm -r ${FEATDir}
	mkdir ${FEATDir}
else
	mkdir -p ${FEATDir}
fi

cp $Templatefsf/Blockdesign.fsf $FEATDir/design.fsf

cp $Timing/*${subj}*.txt $FEATDir

if [ $CovarianceRegression = 1 ] ; then

touch $FEATDir/confoundevs.txt

echo "covariance including head-motion parameters has been regressed out"

else 

paste -d  ' '  $fMRI/${subject}/fMRI$n/mc/MotionRegressors.txt > $FEATDir/confoundevs.txt

fi

npts=`fslval $fMRI/${subject}/fMRI$n/${input}.nii.gz dim4`

# find current value for npts in template.fsf
fsfnpts=`grep "set fmri(npts)" ${FEATDir}/design.fsf | cut -d " " -f 3 | sed 's|"||g'`

# Ensure number of time points in fsf matches time series image
if [ $fsfnpts -eq $npts ] ; then
echo "volumes are matched"
else
	sed -i -e  "s|set fmri(npts) \"\?${fsfnpts}\"\?|set fmri(npts) ${npts}|g" ${FEATDir}/design.fsf
fi

# Change the highpass filter string to the desired highpass filter

sed -i -e "s|set fmri(paradigm_hp) \"128\"|set fmri(paradigm_hp) \"${TemporalFiltering}\"|g" ${FEATDir}/design.fsf

# Change smoothing to be equal to additional smoothing in FSF file

sed -i -e "s|set fmri(smooth) "8"|set fmri(smooth) "${FinalSmoothingFWHM}"|g" ${FEATDir}/design.fsf

sed -i -e "s|set fmri(smooth) "8"|set fmri(smooth) "${FinalSmoothingFWHM}"|g" ${FEATDir}/design.fsf

# Change output directory name

sed -i -e "s|/path/to/output|$fMRI/${subject}/fMRI$n/task|g" ${FEATDir}/design.fsf

# Change EVs

sed -i -e "s|ProBlock.txt|${FEATDir}/${subj}ProBlock.txt|g" ${FEATDir}/design.fsf

sed -i -e "s|AntiBlock.txt|${FEATDir}/${subj}AntiBlock.txt|g" ${FEATDir}/design.fsf

confound_matrix=$FEATDir/confoundevs.txt

feat_model ${FEATDir}/design ${confound_matrix}

feat_model ${FEATDir}/design

DesignMatrix=${FEATDir}/design.mat

DesignTContrast=${FEATDir}/design.con

film_gls --rn=${FEATDir}/stats --sa --ms=5 --in=$fMRI/${subject}/fMRI$n/${input}.nii.gz --pd=${DesignMatrix} --con=${DesignTContrast}  --thr=0 

et=$fMRI/$subject/fMRI${n}.Taskelapsedtime.txt

elapsedtime=$(($(date +%s) - $startingtime))

printf "task processing elapsed time = ${elapsedtime} seconds.\n"

echo "${elapsedtime}" >> ${et}

n=$(($n+1))

done
