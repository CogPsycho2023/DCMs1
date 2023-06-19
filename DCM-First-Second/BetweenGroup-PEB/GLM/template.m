%-----------------------------------------------------------------------
% Job saved on 11-Mar-2022 06:44:28 by cfg_util (rev $Rev: 6942 $)
% spm SPM - Unknown
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.dcm.peb.specify.name = 'PEBNAME';
matlabbatch{1}.spm.dcm.peb.specify.model_space_mat = {'GCMMAT'};
matlabbatch{1}.spm.dcm.peb.specify.dcm.index = 1;
%%
matlabbatch{1}.spm.dcm.peb.specify.cov.design_mtx.cov_design = [DesignMatrix]';
%%
matlabbatch{1}.spm.dcm.peb.specify.cov.design_mtx.name = {'ExperimentalDesigns'};
matlabbatch{1}.spm.dcm.peb.specify.fields.default = {
                                                     'A'
                                                     'B'
                                                     }';
matlabbatch{1}.spm.dcm.peb.specify.priors_between.ratio = 16;
matlabbatch{1}.spm.dcm.peb.specify.priors_between.expectation = 0;
matlabbatch{1}.spm.dcm.peb.specify.priors_between.var = 0.0625;
matlabbatch{1}.spm.dcm.peb.specify.priors_glm.group_ratio = 1;
matlabbatch{1}.spm.dcm.peb.specify.show_review = 0;
