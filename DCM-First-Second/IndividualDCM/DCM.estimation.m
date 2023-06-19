% DCM Estimation
%--------------------------------------------------------------------------

data_path = '/mnt/sub'

clear matlabbatch

matlabbatch{1}.spm.dcm.fmri.estimate.dcmmat = {fullfile(data_path,'DCM_full.mat')};

