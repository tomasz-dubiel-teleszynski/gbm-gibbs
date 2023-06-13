clear all
close all
clc

load bCVCG
load bMUSIGnii

[~,~,TIbtxt] = xlsread('SNLdata.xls','NII');
bindic = TIbtxt(1,2:end); bindic = bindic(1:end-1);
bvars  = TIbtxt(2,2:end); bvars = bvars(1:end-1);
bdates = TIbtxt(3:end,1); 
TIb = cell2mat(TIbtxt(3:end,2:end)); TIb = TIb(:,1:end-1);

rtios = [0.776696559; 0.792751103; 0.841794798; 0.708042438]; % hard coded

% assumption
r = 0.06;
% ----------

dt = 0.25;

     J = size(bMUnii,2);
nBanks = size(bvars,2);

   XASbnii = zeros(nBanks,J);
    BCbnii = zeros(nBanks,J);
   ATTAnii = zeros(nBanks,J);
lastTIbnii = zeros(nBanks,J);

bCvg = bCvg(16:19,:);

for iBank = 1:nBanks
    
    bCvg(iBank,1) = rtios(iBank)*bCvg(iBank,1);
    bCvg(iBank,2) = rtios(iBank)*bCvg(iBank,2);
    
    for j = 1:J
        [bc,xas] = bankcost(bMUnii(iBank,j),bSIGnii(iBank,j),bCvg(iBank,1),bCvg(iBank,2),r);
        XASbnii(iBank,j) = xas;
         BCbnii(iBank,j) = bc;
     lastTIbnii(iBank,j) = TIb(end,iBank)/1e6;
        ATTAnii(iBank,j) = log(XASbnii(iBank,j)/lastTIbnii(iBank,j))/(bMUnii(iBank,j)-0.5*bSIGnii(iBank,j)^2);
    end
    
end

bMUnii = flipud(bMUnii(:,2:end)');
bSIGnii = flipud(bSIGnii(:,2:end)');

BCbnii = flipud(BCbnii(:,2:end)');
BCbnii = -BCbnii;
XASbnii = flipud(XASbnii(:,2:end)');
ATTAnii = flipud(real(ATTAnii(:,2:end)'));