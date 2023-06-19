clear all
clc
out = {'AntiPro-Anti'}

for timing = {'AllTrials', 'Block'}
    
    for CORR = {'Corrected', 'Uncorrected'}
     
        GCM1=char(strcat('GCM',timing,CORR,'AntiPro.mat'))
        GCM2=char(strcat('GCM',timing,CORR,'Anti.mat'))
        G1=load(GCM1)
        G2=load(GCM2)
        G1X=ones(length(G1.GCM),1)
        G2X=ones(length(G2.GCM),1).*-1
        X=[G1X;G2X]
        X=X-mean(X)
        GCM=[G1.GCM;G2.GCM]
        outname=char(strcat(out,timing,CORR,'.mat'))
        save(outname,'GCM')
        outX=char(strcat(out,timing,CORR,'.X'))
        dlmwrite(outX,X,'\t')
        clearvars -except CORR timing out
    end
end
