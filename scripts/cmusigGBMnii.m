clear all
close all
clc

[~,~,TIctxt] = xlsread('SNLdata.xls','NII');

cindic = TIctxt(1,2:end); cindic = cindic(1);
cvars  = TIctxt(2,2:end); cvars = cvars(end);
cdates = TIctxt(3:end,1); 

TIc = cell2mat(TIctxt(3:end,2:end)); TIc = TIc(:,end);

cJ=numel(cvars);
cMUnii  = zeros(cJ,4);
cSIGnii = cMUnii;

% settings
outl = 0;
dspl = 1;
plti = 0;
% --------

% prior beliefs -------
prs.prior_Emu     = 0.0; % zeros growth
prs.belief_Emu    = 0.1; % plus/minus 10%
prs.prior_Esig    = 0.2; % 20% volatility
prs.belief_E1sig2 = 5.0;% better 10 or 15; % fixed!
% ---------------------

labels = {'Greece - NII'};

for jc = 1:cJ
    
    est   = gbmest(TIc(:,jc),plti,dspl,outl,labels{jc},prs);
    
    cMUnii(jc,1) = est.mlee.mu;
    cMUnii(jc,2) = est.mcmcinfe.qt.mu;
    cMUnii(jc,3) = est.mcmcinfe.md.mu;
    cMUnii(jc,4) = est.mcmcinfe.qt.swp.mu;
    
    cSIGnii(jc,1) = est.mlee.sig;
    cSIGnii(jc,2) = est.mcmcinfe.qt.sig;
    cSIGnii(jc,3) = est.mcmcinfe.md.sig;
    cSIGnii(jc,4) = est.mcmcinfe.qt.swp.sig;
    
    if plti 
        input('Hit ENTER to continue!')
        close all;
        clc;
    end
end

save cMUSIGnii cMUnii cSIGnii cvars cindic cdates