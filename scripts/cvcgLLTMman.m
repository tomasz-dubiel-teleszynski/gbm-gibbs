clear all
close all
clc

[~,~,TCbtxt] = xlsread('SNLdata.xls','TCb_PTBES_NEW');

bindic = TCbtxt(1,2:end);
bvars  = TCbtxt(2,2:end);
bdates = TCbtxt(3:end,1);

TCb = cell2mat(TCbtxt(3:end,2:end));
% convert to EUR billion
TCb = TCb/1e6;

bJ   = numel(bvars);
bCvg = zeros(bJ,2);

% plot or not
plt = 0;

% settings
stnmlv    = 1.96;
startDate = 2008.25;
endDate   = 2014.75;
dates     = linspace(startDate,endDate,size(TCb,1));
fctr      = 0.25;

N = numel(TCb(:,1));

% uncomment when identifying new breaks
%brks = zeros(bJ,1);

% load breaks already identified 
load brks

for jb = 1:bJ
    
    y = TCb(:,jb);
    
    [DUMM,LEVS,SCS,auxEps,auxKsiLS,auxKsiSC] = fnINTVENlltman(y,stnmlv);
    
    % plot results
    figure
 
    subplot(1,2,1)
    set(gcf,'color','w');
    set(gca,'FontSize',20)
    plot(dates,auxEps,'k','LineWidth',2.5);
    hold on
    plot(dates,auxKsiLS,'--k','LineWidth',2.5);
    plot(dates,auxKsiSC,':k','LineWidth',2.5);
    plot(dates, stnmlv*ones(length(y),1),'k','LineWidth',2.5);
    plot(dates,-stnmlv*ones(length(y),1),'k','LineWidth',2.5);
    title('Smoothed disturbances from local linear trend model','FontSize',16)
    xlabel('additive outliers (solid), level shifts (dashed), slope changes (dotted)','FontSize',16)
    axis([startDate endDate -2.5*stnmlv 2.5*stnmlv])
    hold off
    
    subplot(1,2,2)
    set(gcf,'color','w');
    set(gca,'FontSize',20)
    plot(dates,y,'k','LineWidth',2.5);
    title(bvars{jb})
    minY = min(y);
    maxY = max(y);
    axis([startDate endDate minY-fctr*maxY maxY+fctr*maxY])
    hold on
    
    % uncomment when identifying new breaks
%     disp(' ')
%     disp('Pick break point date:')
%     disp(' ')
%     disp([1:numel(dates);dates])
%     disp(' ')
%     brk = input('Insert brak point date number: ');
%     disp(' ')
%     brks(jb) = brk;
    
    % load saved breaks
    brk = brks(jb);
    
    bCvg(jb,1) = mean(y(1:brk-1));
    bCvg(jb,2) = mean(y(brk:end));
    
    plot(dates,[bCvg(jb,1)*ones(brk-1,1);NaN(N-brk+1,1)],'--k','LineWidth',2.5);
    plot(dates,[NaN(brk-1,1);bCvg(jb,2)*ones(N-brk+1,1)],':k','LineWidth',2.5);   
    xlabel('total cost (solid), private investor cost (dashed), government cost (dotted)','FontSize',16)
    ylabel('EUR billion','FontSize',16)
    
    hold off
    
    disp(' ')
    disp(bvars{jb})
    disp(' ')
    disp(['cv = ' num2str(round(bCvg(jb,1)*100)/100)])
    disp(['cg = ' num2str(round(bCvg(jb,2)*100)/100)])
    disp(' ')
    
    disp(jb)
    input('Hit ENTER to continue!')
    close all;
    clc;
   
end

save bCVCG bCvg TCb bvars