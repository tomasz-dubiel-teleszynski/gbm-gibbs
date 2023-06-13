function S = gbmsim(S0,mu,sig,dt,N)

S = zeros(N+1,1);
S(1) = S0;

MEAN = (mu-0.5*sig^2)*dt;
STDE = sig*sqrt(dt);

for n = 2:N+1 
    S(n) = S(n-1)*exp( MEAN + STDE*randn() );
end

end