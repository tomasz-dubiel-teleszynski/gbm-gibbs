function out = gbmmcmcinf(S,dt,m0,tau0,v0,phi0,iters,muqt,sigqt,mlee)

burnin = round(iters/2);

M    = zeros(iters+1,1);
PHI2 = M;

tau02 = tau0^2;

M(1)    = mlee.m;
PHI2(1) = mlee.s^2;

X     = diff(log(S));
n     = length(X);
meanX = sum(X)/n;
 varX = sum((X-meanX).^2)/(n-1);

phi02 = phi0^2;
astar = (v0+n)/2;
for iter = 2:iters+1
    
    phi2star = tau02 + n*PHI2(iter-1);
       mstar = (m0*tau02 + meanX*n*PHI2(iter-1))/phi2star;
    
    m = normrnd( mstar, 1/sqrt(phi2star) );
    
    bstar = (v0/phi02 + (n-1)*varX + n*((meanX-m)^2) )/2;
    
    phi2  = gamrnd( astar, 1/bstar );
    
    M(iter)    = m;
    PHI2(iter) = phi2;
    
end

S2post = 1./PHI2(burnin+1:end);
 Mpost = M(burnin+1:end);

bsig2 = S2post/dt;
 bsig = sqrt(bsig2);
  bmu = Mpost/dt + bsig2/2;

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
out.postr.mu = bmu;
out.postr.sig = bsig;

end