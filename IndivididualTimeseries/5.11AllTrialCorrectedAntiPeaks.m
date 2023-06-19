clear all
clc

WD={'/home/sfzhang/Desktop/NoIntNorm/GSR'}

Group={'SecondLevel'}

timing={'AllTrials'}

IndCon={'ContrastsGSR'}

contrast={'Anti'}
       
Corr={'Corrected'}   

sublist=string(strcat(WD,'/',Group,'/',timing,'/',timing,Corr,contrast,'.left.txt'))

list=load(sublist)

for subj = list'

for ROI = {'AMCC', 'LINS', 'RINS', 'LIPS', 'RIPS', 'LPMC', 'RPMC', 'LDLPFC', 'RDLPFC'}
    
    WAY=string(strcat(WD,'/',IndCon,'/',timing,'/',Corr,'/',contrast,'/',num2str(subj)))
 
    cd (WAY)

    input=string(strcat(ROI,'_',Corr,'_zstat',contrast,'.nii'))

    nii = load_untouch_nii(input{1});
    
    % Rotation matrix
    % ---------------
    T = [nii.hdr.hist.srow_x;nii.hdr.hist.srow_y;nii.hdr.hist.srow_z;0,0,0,1];
    
    %-Turn location list to binary 3D volume
    %--------------------------------------------------------------------------
    dim        = nii.hdr.dime.dim(2:4);
    vol        = zeros(dim(1),dim(2),dim(3));
    lgc        = nii.img(:) > 0;
    X          = nii.img(lgc);
    index      = find(lgc);
    [L1,L2,L3] = ind2sub(dim,index);
    L          = [L1,L2,L3]';
    vol(index) = 1;
    clear lgc

%-Label each cluster with its own label using an 18 connectivity criterion
% cci = connected components image volume
%--------------------------------------------------------------------------
[cci,num]  = spm_bwlabel(vol,18);

%-Get size (in no. of voxels) for each connected component
% ccs = connected component size
%--------------------------------------------------------------------------
ccs        = histc(cci(:),(0:num) + 0.5);
ccs        = ccs(1:end-1);

%-Get indices into L for voxels that are indeed local maxima (using an 18 
% neighbour criterion)
%--------------------------------------------------------------------------
vol(index) = X;
Lindex     = spm_get_lm(vol,L);

M          = L(:,Lindex);
Z          = X(Lindex);
mindex     = sub2ind(dim,L(1,Lindex)',L(2,Lindex)',L(3,Lindex)');
A          = cci(mindex);
N          = ccs(A);

M=M-1

out=string(strcat(WD,'/',IndCon,'/',timing,'/',Corr,'/',contrast,'/',num2str(subj),'/',ROI,Corr,contrast))

dlmwrite(out,M,'\t')
clearvars -except timing Corr contrast ROI subj WD IndCon
end
end
