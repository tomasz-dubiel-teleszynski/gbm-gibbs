clear all
close all
clc

load bCVCG
load cMUSIG

[~,~,TIbtxt] = xlsread('SNLdata.xls','TIb_PTBES_NEW');
bindic = TIbtxt(1,2:end);
bvars  = TIbtxt(2,2:end);
bdates = TIbtxt(3:end,1);
TIb = cell2mat(TIbtxt(3:end,2:end));

bindic{1} = 'CY';
bindic{2} = 'CY';

% assumption
r = 0.06;
% ----------

dt = 0.25;

     J = size(cMU,2);
nBanks = size(bvars,2);

   XASb = zeros(nBanks,J);
    BCb = zeros(nBanks,J);
   ATTA = zeros(nBanks,J);
lastTIb = zeros(nBanks,J);

for iBank = 1:nBanks

    idx = ismember(cindic,bindic(iBank));
    for j = 1:J
        [bc,xas] = bankcost(cMU(idx,j),cSIG(idx,j),bCvg(iBank,1),bCvg(iBank,2),r);
        XASb(iBank,j) = xas;
         BCb(iBank,j) = bc;
     lastTIb(iBank,j) = TIb(end,iBank)/1e6;
        ATTA(iBank,j) = log(XASb(iBank,j)/lastTIb(iBank,j))/(cMU(idx,j)-0.5*cSIG(idx,j)^2);
    end
    
end

cindic(4)=[];
cMU(4,:) = [];
cMU = flipud(cMU(:,2:end)');
cSIG(4,:)=[];
cSIG = flipud(cSIG(:,2:end)');

bCvg = bCvg';

BCb = flipud(BCb(:,2:end)');
BCb= -BCb;
XASb = flipud(XASb(:,2:end)');
ATTA = flipud(real(ATTA(:,2:end)'));