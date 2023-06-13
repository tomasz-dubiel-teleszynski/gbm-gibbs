function out = gbmmle(S,dt)

X = diff(log(S));
n = length(X);

m  = sum(X)/n;
s2 = sum((X-m).^2)/(n-1);
s = sqrt(s2);

sig2 = s2/dt;
sig  = sqrt(sig2);
mu   = m/dt + sig2/2;

out.mu  = mu;
out.sig = sig;
out.m = m;
out.s = s;

end

