function est = gbmest(S,plt,dspl,outl,varbc,prs)

if outl 
    
    [DUMM,LEVS] = fnINTVENlltman(S,stnmlv);
    
    Snew = fnADJ(S,[],DUMM,LEVS,[]);
      S0 = S;
      S1 = S;
       S = Snew;
    
else
    
    Snew = S;
      S0 = S;
      S1 = S;
       S = Snew;
end

dt = 0.25;
muqt = 0.95;
sigqt = 1-muqt;
iters = 100000;

mlee            = gbmmle(S,dt);
ngnoninfe       = gbmngnoninf(S,dt,iters,muqt,sigqt);

[m0,tau0,phi0,v0] = gbmmcmcinfp(dt,prs.prior_Emu,...
    prs.belief_Emu,prs.prior_Esig,prs.belief_E1sig2);

mcmcinfe = gbmmcmcinf(S,dt,m0,tau0,v0,phi0,iters,muqt,sigqt,mlee);

S = S1;

if plt
    
%     figure
%     subplot(2,1,1)
%     plot(S,'g')
%     hold on
%     plot(S0);
%     plot(Snew,'r')
%     title('time series levels (blue/green) and adjusted (red)')
%     subplot(2,1,2)
%     plot(diff(log(S)),'g')
%     plot(diff(log(S0)))
%     hold on
%     plot(diff(log(Snew)),'r')
%     hold off
%     title('time series log returns (blue/green) and adjusted (red)')
%     xlabel(varbc)
    
    figure
    
    subplot(1,2,1)
    set(gcf,'color','w');
    set(gca,'FontSize',22)
    
    % prior for mu
    pmu = m0 + 1/2*prs.prior_Esig^2 + 1/(tau0*dt)*randn(100000,1);
    
    [a,b]=ksdensity(pmu);plot(b,a,'--k','LineWidth',2.5);
    hold on
    [a,b]=ksdensity(mcmcinfe.postr.mu);plot(b,a,'k','LineWidth',2.5);
    
    title('mu','FontSize',22)
    xlabel('normal: prior (dashed) and posterior (solid)','FontSize',22)
    ylabel(varbc,'FontSize',28)
    hold off
    
    subplot(1,2,2)
    set(gcf,'color','w');
    set(gca,'FontSize',22)
    
    % prior for sig
    psig = 1./sqrt(gamrnd(v0/2,1/(v0/(2*dt*phi0^2)),100000,1));
    
    [a,b]=ksdensity(psig);plot(b,a,'--k','LineWidth',2.5);
    hold on
    [a,b]=ksdensity(mcmcinfe.postr.sig);plot(b,a,'k','LineWidth',2.5);
    
    title('sig','FontSize',22)
    xlabel('inverse-gamma: prior (dashed) and posterior (solid)','FontSize',22)
    
    hold off
    
    
    
end
    
if dspl
    
    disp(' ')
    disp(['MLE for ' varbc])
    disp(' ')
    disp([' mu = ' num2str(mlee.mu)])
    disp(['sig = ' num2str(mlee.sig)])
    disp(' ')
    disp('Bayesian flat prior')
    disp(' ')
    disp([' mu (99th prct) = ' num2str(ngnoninfe.qt.mu)])
    disp(['sig ( 1st prct) = ' num2str(ngnoninfe.qt.sig)])
    disp(' ')
    disp([' mu (mean) = ' num2str(ngnoninfe.mn.mu)])
    disp(['sig (mean) = ' num2str(ngnoninfe.mn.sig)])
    disp(' ')
    disp(' ')
    disp([' mu (median) = ' num2str(ngnoninfe.md.mu)])
    disp(['sig (median) = ' num2str(ngnoninfe.md.sig)])
    disp(' ')
    disp(' ')
    disp([' mu ( 1st prct) = ' num2str(ngnoninfe.qt.swp.mu)])
    disp(['sig (99th prct) = ' num2str(ngnoninfe.qt.swp.sig)])
    disp(' ')
    disp('Bayesian informative prior (mu and sig priors independent)')
    disp(' ')
    disp([' mu (99th prct) = ' num2str(mcmcinfe.qt.mu)])
    disp(['sig ( 1st prct) = ' num2str(mcmcinfe.qt.sig)])
    disp(' ')
    disp([' mu (mean) = ' num2str(mcmcinfe.mn.mu)])
    disp(['sig (mean) = ' num2str(mcmcinfe.mn.sig)])
    disp(' ')
    disp(' ')
    disp([' mu (median) = ' num2str(mcmcinfe.md.mu)])
    disp(['sig (median) = ' num2str(mcmcinfe.md.sig)])
    disp(' ')
    disp(' ')
    disp([' mu ( 1st prct) = ' num2str(mcmcinfe.qt.swp.mu)])
    disp(['sig (99th prct) = ' num2str(mcmcinfe.qt.swp.sig)])
    disp(' ')
    
end

% output
est.mlee      = mlee;
est.ngnoninfe = ngnoninfe;
est.mcmcinfe  = mcmcinfe;







