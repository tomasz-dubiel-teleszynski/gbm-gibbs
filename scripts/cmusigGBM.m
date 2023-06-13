clear all
close all
clc

[~,~,TIctxt] = xlsread('SNLdata.xls','TIc_PTBES_NEW');

cindic = TIctxt(1,2:end);
cvars  = TIctxt(2,2:end);
cdates = TIctxt(3:end,1);

TIc = cell2mat(TIctxt(3:end,2:end));

cJ=numel(cvars);
cMU  = zeros(cJ,4);
cSIG = cMU;

% settings
outl = 0;
dspl = 1;
plti = 1;
% --------

% prior beliefs -------
prs.prior_Emu     = 0.0; % zeros growth
prs.belief_Emu    = 0.1; % plus/minus 10%
prs.prior_Esig    = 0.2; % 20% volatility
prs.belief_E1sig2 = 5.0;% better 10 or 15; % fixed!
% ---------------------

labels = {'Cyprus';'Spain';'Greece';'Greece+Cyprus';'Italy';'Portugal'};

for jc = 1:cJ
    
    est   = gbmest(TIc(:,jc),plti,dspl,outl,labels{jc},prs);

    
    cMU(jc,1) = est.mlee.mu;
    cMU(jc,2) = est.mcmcinfe.qt.mu;
    cMU(jc,3) = est.mcmcinfe.md.mu;
    cMU(jc,4) = est.mcmcinfe.qt.swp.mu;
    
    cSIG(jc,1) = est.mlee.sig;
    cSIG(jc,2) = est.mcmcinfe.qt.sig;
    cSIG(jc,3) = est.mcmcinfe.md.sig;
    cSIG(jc,4) = est.mcmcinfe.qt.swp.sig;
    
    if plti 
        input('Hit ENTER to continue!')
        close all;
        clc;
    end
end

save cMUSIG cMU cSIG cvars cindic cdates