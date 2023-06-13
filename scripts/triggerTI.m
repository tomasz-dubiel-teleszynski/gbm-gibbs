clear all
close all
clc

% CY – Bank of Cyprus
% ES – Bankinter
% GR – Eurobank
% IT – Unicredit
% PT – Banco Comercial Portugues

tau = 0.25;
  r = 0.06;
 dt = 0.25;

load bCVCG
load bMUSIG

[~,~,TIbtxt] = xlsread('SNLdata.xls','TIb');
bindic = TIbtxt(1,2:end);
bvars  = TIbtxt(2,2:end);
bdates = TIbtxt(3:end,1);
TIb = cell2mat(TIbtxt(3:end,2:end))/1e6;

nNaNs = 8;
N         = size(TIb,1);
startDate = 2008.25;
endDate   = 2014.75+nNaNs/4;
dates     = linspace(startDate,endDate,N+nNaNs);

nBanks = numel(bvars);
for iBank = 1:nBanks
    
    [~,xa] = bankcost(bMU(iBank,3),bSIG(iBank,3),bCvg(iBank,1),bCvg(iBank,2),r);
    
    figure
    set(gcf,'color','w');
    set(gca,'FontSize',14)
    plot(dates,[TIb(:,iBank);NaN(nNaNs,1)],'k','LineWidth',2);
    hold on
    plot(dates,xa*ones(N+nNaNs,1),'--k','LineWidth',2);
    title(bvars{iBank})
    xlabel('total income (solid), bailout trigger (dashed)')
    ylabel('EUR billion')
    axis([startDate endDate 0 1.2*max(TIb(:,iBank))])
    hold off
 
end