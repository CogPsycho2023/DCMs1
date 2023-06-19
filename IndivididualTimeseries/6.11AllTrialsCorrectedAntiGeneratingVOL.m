clear all
clc

timing='AllTrials'

CON='Anti'

CORR='Corrected'

PATH='/home/sfzhang/Desktop/NoIntNorm/GSR/NoIntNormGSRNodes'
subjlist=string(strcat(PATH,'/',timing,CORR,CON,'.left.txt'))

subject=load(subjlist)

subject=subject'

for n = subject

path=strcat(PATH,'/Timeseries/',timing,'/',CORR,'/',CON,'/',num2str(n))

cd (path)

LAI.Y=load(string(strcat(num2str(n),'.LINS.eig.txt')))
LAI.xY.u=load(string(strcat(num2str(n),'.LINS.eig.txt')))
LAI.xY.Sess=1
LAI.xY.name=('LAI')
LAI.xY.X0=[]
save('VOI_LAI_1.mat','-struct','LAI')

RAI.Y=load(string(strcat(num2str(n),'.RINS.eig.txt')))
RAI.xY.u=load(string(strcat(num2str(n),'.RINS.eig.txt')))
RAI.xY.Sess=1
RAI.xY.name=('RAI')
RAI.xY.X0=[]
save('VOI_RAI_1.mat','-struct','RAI')

AMCC.Y=load(string(strcat(num2str(n),'.AMCC.eig.txt')))
AMCC.xY.u=load(string(strcat(num2str(n),'.AMCC.eig.txt')))
AMCC.xY.Sess=1
AMCC.xY.name=('AMCC')
AMCC.xY.X0=[]
save('VOI_AMCC_1.mat','-struct','AMCC')

LDLPFC.Y=load(string(strcat(num2str(n),'.LDLPFC.eig.txt')))
LDLPFC.xY.u=load(string(strcat(num2str(n),'.LDLPFC.eig.txt')))
LDLPFC.xY.Sess=1
LDLPFC.xY.name=('LDLPFC')
LDLPFC.xY.X0=[]
save('VOI_LDLPFC_1.mat','-struct','LDLPFC')

RDLPFC.Y=load(string(strcat(num2str(n),'.RDLPFC.eig.txt')))
RDLPFC.xY.u=load(string(strcat(num2str(n),'.RDLPFC.eig.txt')))
RDLPFC.xY.Sess=1
RDLPFC.xY.name=('RDLPFC')
RDLPFC.xY.X0=[]
save('VOI_RDLPFC_1.mat','-struct','RDLPFC')

LIPS.Y=load(string(strcat(num2str(n),'.LIPS.eig.txt')))
LIPS.xY.u=load(string(strcat(num2str(n),'.LIPS.eig.txt')))
LIPS.xY.Sess=1
LIPS.xY.name=('LIPS')
LIPS.xY.X0=[]
save('VOI_LIPS_1.mat','-struct','LIPS')

RIPS.Y=load(string(strcat(num2str(n),'.RIPS.eig.txt')))
RIPS.xY.u=load(string(strcat(num2str(n),'.RIPS.eig.txt')))
RIPS.xY.Sess=1
RIPS.xY.name=('RIPS')
RIPS.xY.X0=[]
save('VOI_RIPS_1.mat','-struct','RIPS')

LPMC.Y=load(string(strcat(num2str(n),'.LPMC.eig.txt')))
LPMC.xY.u=load(string(strcat(num2str(n),'.LPMC.eig.txt')))
LPMC.xY.Sess=1
LPMC.xY.name=('LPMC')
LPMC.xY.X0=[]
save('VOI_LPMC_1.mat','-struct','LPMC')

RPMC.Y=load(string(strcat(num2str(n),'.RPMC.eig.txt')))
RPMC.xY.u=load(string(strcat(num2str(n),'.RPMC.eig.txt')))
RPMC.xY.Sess=1
RPMC.xY.name=('RPMC')
RPMC.xY.X0=[]
save('VOI_RPMC_1.mat','-struct','RPMC')

clearvars -except n subject CON CORR PATH timing

end
