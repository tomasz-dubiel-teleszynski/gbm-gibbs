function out = gbmnginf(S,dt,m0,k0,a0,b0,iters,muqt,sigqt)

X     = diff(log(S));
n     = length(X);
meanX = sum(X)/n;
 varX = sum((X-meanX).^2)/(n-1);

kn = k0 + n;
mn = (k0*m0 + n*meanX)/kn;
an = a0 + n/2;
bn = b0 + (n-1)*varX/2 + (k0*n*((meanX-m0)^2))/(2*kn);

bs2 = 1./gamrnd( an , 1/bn *ones(iters,1) );
bm  = normrnd( mn, bs2/kn);

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

end