%% bank parameters

clear all
close all
clc

tau = 0.25;
  r = 0.06;
 dt = 0.25;

load bCVCG
load bMUSIGnii

[~,~,TIbtxt] = xlsread('SNLdata.xls','NII');
bindic = TIbtxt(1,2:end); bindic = bindic(1:end-1);
bvars  = TIbtxt(2,2:end); bvars = bvars(1:end-1);
bdates = TIbtxt(3:end,1); 
TIb = cell2mat(TIbtxt(3:end,2:end)); TIb = TIb(:,1:end-1);

rtios = [0.776696559; 0.792751103; 0.841794798; 0.708042438];

TIb = TIb(end,:)/1e6;

bCvg = bCvg(16:19,:);

nBanks = numel(bvars);
G = zeros(nBanks,1);
for iBank = 1:nBanks
    G(iBank) = value4gov(TIb(iBank),bMUnii(iBank,3),...
        bSIGnii(iBank,3),rtios(iBank)*bCvg(iBank,1),rtios(iBank)*bCvg(iBank,2),r,tau);
end

%% country paramters
clear all
close all
clc

tau = 0.25;
  r = 0.06;
 dt = 0.25;

load bCVCG
load cMUSIGnii
load bMUSIGnii

[~,~,TIbtxt] = xlsread('SNLdata.xls','NII');
bindic = TIbtxt(1,2:end); bindic = bindic(1:end-1);
bvars  = TIbtxt(2,2:end); bvars = bvars(1:end-1);
bdates = TIbtxt(3:end,1); 
TIb = cell2mat(TIbtxt(3:end,2:end)); TIb = TIb(:,1:end-1);

rtios = [0.776696559; 0.792751103; 0.841794798; 0.708042438];
TIb = TIb(end,:)/1e6;

bCvg = bCvg(16:19,:);

nBanks = numel(bvars);
G = zeros(nBanks,1);
for iBank = 1:nBanks
    idx = find(ismember(cindic,bindic(iBank)));
    G(iBank) = value4gov(TIb(iBank),cMUnii(idx,3),...
        cSIGnii(idx,3),rtios(iBank)*bCvg(iBank,1),rtios(iBank)*bCvg(iBank,2),r,tau);
end

