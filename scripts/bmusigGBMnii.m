clear all
close all
clc

[~,~,TIbtxt] = xlsread('SNLdata.xls','NII');

bindic = TIbtxt(1,2:end); bindic = bindic(1:end-1);
bvars  = TIbtxt(2,2:end); bvars = bvars(1:end-1);

bdates = TIbtxt(3:end,1);

TIb = cell2mat(TIbtxt(3:end,2:end)); TIb = TIb(:,1:end-1);

bJ=numel(bvars);
bMUnii  = zeros(bJ,4);
bSIGnii = bMUnii;

% settings
outl = 0;
dspl = 1;
plti = 0;
% --------

% prior beliefs -------
prs.belief_Emu = 0.1; % plus/minus 10%
prs.belief_E1sig2 = 5; % better 10 or 15 % fixed!
% ---------------------

load cMUSIGnii;

for jb = 1:bJ
    
    prs.prior_Emu = cMUnii(ismember(cvars,bindic(jb)),3);
    prs.prior_Esig = cSIGnii(ismember(cvars,bindic(jb)),3);
    
    est   = gbmest(TIb(:,jb),plti,dspl,outl,bvars{jb},prs);
    
    bMUnii(jb,1) = est.mlee.mu;
    bMUnii(jb,2) = est.mcmcinfe.qt.mu;
    bMUnii(jb,3) = est.mcmcinfe.md.mu;
    bMUnii(jb,4) = est.mcmcinfe.qt.swp.mu;
    
    bSIGnii(jb,1) = est.mlee.sig;
    bSIGnii(jb,2) = est.mcmcinfe.qt.sig;
    bSIGnii(jb,3) = est.mcmcinfe.md.sig;
    bSIGnii(jb,4) = est.mcmcinfe.qt.swp.sig;
    
    if plti 
        input('Hit ENTER to continue!')
        close all;
        clc;
    end
end

save bMUSIGnii bMUnii bSIGnii bvars bindic bdates