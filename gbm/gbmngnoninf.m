function out = gbmngnoninf(S,dt,iters,muqt,sigqt)

X     = diff(log(S));
n     = length(X);
meanX = sum(X)/n;
 varX = sum((X-meanX).^2)/(n-1);
 
bs2 = 1./gamrnd( (n-1)/2 , 2./(varX*(n-1) ) *ones(iters,1) );
bs = sqrt(bs2);
bm  = normrnd(meanX, bs2/n);

bsig2 = bs2/dt;
bsig  = sqrt(bsig2);
bmu   = bm/dt + bsig2/2;

% mean
out.mn.mu   = mean(bmu);
out.mn.sig  = mean(bsig);

% median
out.md.mu  = median(bmu);
out.md.sig = median(bsig);

% quantile
out.qt.mu  = quantile(bmu,muqt);
out.qt.sig = quantile(bsig,sigqt);

% quantile reverse
out.qt.swp.mu  = quantile(bmu,1-muqt);
out.qt.swp.sig = quantile(bsig,1-sigqt);

% distributions
out.postr.m = bm;
out.postr.s = bs;
out.postr.mu = bmu;
out.postr.sig = bsig;

end