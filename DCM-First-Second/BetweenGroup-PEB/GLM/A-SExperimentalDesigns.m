clear all
clc
out='AllTrials-STrials'
for CORR = {'Corrected', 'Uncorrected'}
    for CON = {'Anti', 'AntiPro'}
        GCM1=char(strcat('GCMAllTrials',CORR,CON,'.mat'))
        GCM2=char(strcat('GCMSTrials',CORR,CON,'.mat'))
        G1=load(GCM1)
        G2=load(GCM2)
        G1X=ones(length(G1.GCM),1)
        G2X=ones(length(G2.GCM),1).*-1
        X=[G1X;G2X]
        X=X-mean(X)
        GCM=[G1.GCM;G2.GCM]
        outname=char(strcat(out,CORR,CON,'.mat'))
        save(outname,'GCM')
        outX=char(strcat(out,CORR,CON,'.X'))
        dlmwrite(outX,X,'\t')
        clearvars -except CON CORR out
    end
end
