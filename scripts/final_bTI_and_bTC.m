clear all
close all
clc

load bCVCG
load bMUSIG

[~,~,TIbtxt] = xlsread('SNLdata.xls','TIb_PTBES_NEW');
bindic = TIbtxt(1,2:end);
bvars  = TIbtxt(2,2:end);
bdates = TIbtxt(3:end,1);
TIb = cell2mat(TIbtxt(3:end,2:end));

% assumption
r = 0.06;
% ----------

dt = 0.25;

     J = size(bMU,2);
nBanks = size(bvars,2);

   XASb = zeros(nBanks,J);
    BCb = zeros(nBanks,J);
   ATTA = zeros(nBanks,J);
lastTIb = zeros(nBanks,J);

for iBank = 1:nBanks

    for j = 1:J
        [bc,xas] = bankcost(bMU(iBank,j),bSIG(iBank,j),bCvg(iBank,1),bCvg(iBank,2),r);
        XASb(iBank,j) = xas;
         BCb(iBank,j) = bc;
     lastTIb(iBank,j) = TIb(end,iBank)/1e6;
        ATTA(iBank,j) = log(XASb(iBank,j)/lastTIb(iBank,j))/(bMU(iBank,j)-0.5*bSIG(iBank,j)^2);
    end
    
end


bMU = flipud(bMU(:,2:end)');
bSIG = flipud(bSIG(:,2:end)');

bCvg = bCvg';

BCb = flipud(BCb(:,2:end)');
BCb = -BCb;
XASb = flipud(XASb(:,2:end)');
ATTA = flipud(real(ATTA(:,2:end)'));