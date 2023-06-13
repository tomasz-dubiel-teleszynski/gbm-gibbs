function [G,bc,xas] = value4gov(x,mu,sig,cv,cg,r,tau)

[bc,xas,b2,delta] = bankcost(mu,sig,cv,cg,r);

G = (x/delta-cv/r)*tau-(xas/delta-cv/r)*tau*((x/xas)^b2)+bc*((x/xas)^b2);

end

