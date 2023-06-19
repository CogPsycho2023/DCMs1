%-----------------------------------------------------------------------
% Job saved on 16-Apr-2021 11:15:53 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear all
clc

WD={'/home/sfzhang/Desktop/NoIntNorm/GSR/NoIntNormGSRNodes'}

timing = {'AllTrials'}

for CORR = {'Corrected', 'Uncorrected'}

for CON = {'Anti'}

%loading subject list
list=string(strcat(WD,'/',timing,CORR,CON,'.left.txt'))

subj=load(list)

for subj = subj'

path=string(strcat(WD,'/Timeseries/',timing,'/',CORR,'/',CON,'/',num2str(subj)))

cd (path)

mat=string(strcat(WD,'/Timing/Mat/',num2str(subj),'TIMING.mat'))

load(mat)

Vol=load('VOI_AMCC_1.mat')

Vol=size(Vol.Y,1)

matlabbatch{1}.spm.stats.fmri_design.dir = {''};
matlabbatch{1}.spm.stats.fmri_design.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_design.timing.RT = 2.03;
matlabbatch{1}.spm.stats.fmri_design.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_design.timing.fmri_t0 = 8;
matlabbatch{1}.spm.stats.fmri_design.sess.nscan = Vol;
matlabbatch{1}.spm.stats.fmri_design.sess.cond(1).name = 'AllTrialsInput';
%%
matlabbatch{1}.spm.stats.fmri_design.sess.cond(1).onset = [Timing.ALL.ProLeft(:,1); Timing.ALL.ProRight(:,1); Timing.ALL.AntiLeft(:,1); Timing.ALL.AntiRight(:,1)];
%%
matlabbatch{1}.spm.stats.fmri_design.sess.cond(1).duration = [0.2];
matlabbatch{1}.spm.stats.fmri_design.sess.cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_design.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_design.sess.cond(1).orth = 0;
matlabbatch{1}.spm.stats.fmri_design.sess.cond(2).name = 'AntiContrast';
%%
matlabbatch{1}.spm.stats.fmri_design.sess.cond(2).onset = [Timing.ALL.AntiLeft(:,1); Timing.ALL.AntiRight(:,1)];
%%
%%
matlabbatch{1}.spm.stats.fmri_design.sess.cond(2).duration = [Timing.ALL.AntiLeft(:,2); Timing.ALL.AntiRight(:,2)];
%%
matlabbatch{1}.spm.stats.fmri_design.sess.cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_design.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_design.sess.cond(2).orth = 0;
%%
spm_jobman('run',matlabbatch)
clear matlabbatch
clearvars -except CON subj WD CORR timing
end
end
end


