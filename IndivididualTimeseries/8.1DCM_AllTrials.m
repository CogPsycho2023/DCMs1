clear all
clc

WD={'/home/sfzhang/Desktop/NoIntNorm/GSR/NoIntNormGSRNodes'}

Template=string(strcat(WD,'/DCM_template.mat'))

load(Template)

timing = {'AllTrials'}

for CORR = {'Corrected', 'Uncorrected'}

for CON= {'Anti', 'AntiPro'}

%loading subject list
list=string(strcat(WD,'/',timing,CORR,CON,'.left.txt'))

subj=sort(load(list))

for subj = subj'

path=string(strcat(WD,'/Timeseries/',timing,'/',CORR,'/',CON,'/',num2str(subj)))

cd (path)

SPM = load(fullfile('SPM.mat'));
SPM = SPM.SPM;

xY = {fullfile('VOI_LIPS_1.mat');
      fullfile('VOI_RIPS_1.mat')
      fullfile('VOI_LAI_1.mat');
      fullfile('VOI_RAI_1.mat');
      fullfile('VOI_LDLPFC_1.mat');
      fullfile('VOI_RDLPFC_1.mat')
      fullfile('VOI_LPMC_1.mat');
      fullfile('VOI_RPMC_1.mat');
      fullfile('VOI_AMCC_1.mat');}

DCM = spm_dcm_specify(SPM,xY,s)

clearvars -except CON CORR WD timing s

end

end

end
