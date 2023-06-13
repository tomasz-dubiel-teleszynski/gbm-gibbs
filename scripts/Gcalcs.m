%% bank parameters

clear all
close all
clc

tau = 0.25;
  r = 0.06;
 dt = 0.25;

load bCVCG
load bMUSIG

[~,~,TIbtxt] = xlsread('SNLdata.xls','TIb_PTBES_NEW');
bindic = TIbtxt(1,2:end);
bvars  = TIbtxt(2,2:end);
bdates = TIbtxt(3:end,1);
TIb = cell2mat(TIbtxt(3:end,2:end));
TIb = TIb(end,:)/1e6;

nBanks = numel(bvars);
G = zeros(nBanks,1);
for iBank = 1:nBanks
    G(iBank) = value4gov(TIb(iBank),bMU(iBank,3),...
        bSIG(iBank,3),bCvg(iBank,1),bCvg(iBank,2),r,tau);
end

%% country paramters
clear all
close all
clc

tau = 0.25;
  r = 0.06;
 dt = 0.25;

load bCVCG
load cMUSIG
load bMUSIG

[~,~,TIbtxt] = xlsread('SNLdata.xls','TIb_PTBES_NEW');
bindic = TIbtxt(1,2:end);
bvars  = TIbtxt(2,2:end);
bdates = TIbtxt(3:end,1);
TIb = cell2mat(TIbtxt(3:end,2:end));
TIb = TIb(end,:)/1e6;

nBanks = numel(bvars);
G = zeros(nBanks,1);
for iBank = 1:nBanks
    idx = find(ismember(cindic,bindic(iBank)));
    G(iBank) = value4gov(TIb(iBank),cMU(idx,3),...
        cSIG(idx,3),bCvg(iBank,1),bCvg(iBank,2),r,tau);
end

