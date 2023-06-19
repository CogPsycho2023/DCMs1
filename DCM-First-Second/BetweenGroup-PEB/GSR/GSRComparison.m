clear all
clc

for timing = {'AllTrials','Block'}
    
    for CORR = {'Corrected', 'Uncorrected'}

        for CON ={'Anti', 'AntiPro'}
     
        GCM1=char(strcat('20221022GSRTimeseries/PEBs/GM/','GCM',timing,CORR,CON,'.mat'))
        GCM2=char(strcat('20221023NoGSRTimeseries/PEBs/GM/','GCM',timing,CORR,CON,'NoGSR.mat'))
        G1=load(GCM1)
        G2=load(GCM2)
        G1X=ones(length(G1.GCM),1)
        G2X=ones(length(G2.GCM),1).*-1
        X=[G1X;G2X]
        X=X-mean(X)
        GCM=[G1.GCM;G2.GCM]
        outname=char(strcat('GSRComparison/',timing,CORR,CON,'.mat'))
        save(outname,'GCM')
        outX=char(strcat('GSRComparison/',timing,CORR,CON,'.X'))
        dlmwrite(outX,X)
        clearvars -except CORR timing
    end
end
end