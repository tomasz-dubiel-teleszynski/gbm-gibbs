clear all
close all
clc

[~,~,TIctxt] = xlsread('SNLdata.xls','TIc');

cindic = TIctxt(1,2:end);
cvars  = TIctxt(2,2:end);
cdates = TIctxt(3:end,1);

TIc = cell2mat(TIctxt(3:end,2:end));
% convert to EUR billion
TIc = TIc/1e6;

bJ   = numel(cvars);
bCvg = zeros(bJ,2);

% plot or not
plt = 1;

% settings
stnmlv    = 1.96;
startDate = 2008.25;
endDate   = 2014.75;
dates     = linspace(startDate,endDate,size(TIc,1));
fctr      = 0.25;

aTIc = zeros(size(TIc));
for jb = 1:bJ
    
    y = TIc(:,jb);
    
    [DUMM,LEVS,SCS,auxEps,auxKsiLS,auxKsiSC] = fnINTVENlltman(y,stnmlv);
    yn = fnADJ(y,[],DUMM,LEVS,[]);
    aTIc(:,jb) = yn;
    
    % plot results
    figure
        
    subplot(1,2,1)
    plot(dates,auxEps,'k');
    hold on
    plot(dates,auxKsiLS,'--k');
    plot(dates,auxKsiSC,':k');
    plot(dates, stnmlv*ones(length(y),1),'k');
    plot(dates,-stnmlv*ones(length(y),1),'k');
    title('Smoothed disturbances from local level model')
    xlabel('additive outliers (solid), level shifts (dashed), slope changes (dotted)')
    axis([startDate endDate -2.5*stnmlv 2.5*stnmlv])
    hold off
    
    subplot(1,2,2)
    plot(dates,yn,'k')
    hold on
    plot(dates,y,'--k');
    title(cvars{jb})
    minY = min(y);
    maxY = max(y);
    axis([startDate endDate minY-fctr*maxY maxY+fctr*maxY])
    xlabel('adjusted total income (solid), non-adjusted total income (dashed)')
    ylabel('EUR billion')
    
    disp(jb)
    input('Hit ENTER to continue!')
    close all;
    clc;
   
end