function [bc,xas,b2,delta] = bankcost(mu,sig,cv,cg,r) 

n=numel(mu);

%mu=0.0056*ones(n,1); %Rate of return
%sig=0.42*ones(n,1); %Volatiltiy

r=r*ones(n,1); %Interest rate 0.06
rho=0.0*ones(n,1); %Royalties 

%Operating cost 
cv=cv*ones(n,1); % Private 2747
cg=cg*ones(n,1); % Gov 2747

%Calculating beta2 
b2=0.5-mu./(sig.^2)-sqrt((0.5-mu./(sig.^2)).^2+2.*r./(sig.^2));

%Renaming stuff:
delta = r - mu; 

%Abandonment trigger for the private
xas=b2.*delta.*cv./((b2-1).*r.*(1-rho));

% %Value function
GU_xas = xas./delta-cg./r;
bc = GU_xas;