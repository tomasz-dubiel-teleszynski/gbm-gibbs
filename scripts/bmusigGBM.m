clear all
close all
clc

[~,~,TIbtxt] = xlsread('SNLdata.xls','TIb_PTBES_NEW');

bindic = TIbtxt(1,2:end);
bindic{1} = 'CY';
bindic{2} = 'CY';

bvars  = TIbtxt(2,2:end);
bdates = TIbtxt(3:end,1);

TIb = cell2mat(TIbtxt(3:end,2:end));

bJ=numel(bvars);
bMU  = zeros(bJ,4);
bSIG = bMU;

% settings
outl = 0;
dspl = 1;
plti = 0;
% --------

% prior beliefs -------
prs.belief_Emu    = 0.1; % plus/minus 10%
prs.belief_E1sig2 =   5; % better 10 or 15 % fixed!
% ---------------------

load cMUSIG;

for jb = 1:bJ
    
    prs.prior_Emu = cMU(ismember(cvars,bindic(jb)),3);
    prs.prior_Esig = cSIG(ismember(cvars,bindic(jb)),3);
    
    est   = gbmest(TIb(:,jb),plti,dspl,outl,bvars{jb},prs);
    % ismember(vars,indic(j)
    
    bMU(jb,1) = est.mlee.mu;
    bMU(jb,2) = est.mcmcinfe.qt.mu;
    bMU(jb,3) = est.mcmcinfe.md.mu;
    bMU(jb,4) = est.mcmcinfe.qt.swp.mu;
    
    bSIG(jb,1) = est.mlee.sig;
    bSIG(jb,2) = est.mcmcinfe.qt.sig;
    bSIG(jb,3) = est.mcmcinfe.md.sig;
    bSIG(jb,4) = est.mcmcinfe.qt.swp.sig;
    
    if plti 
        input('Hit ENTER to continue!')
        close all;
        clc;
    end
end

save bMUSIG bMU bSIG bvars bindic bdates