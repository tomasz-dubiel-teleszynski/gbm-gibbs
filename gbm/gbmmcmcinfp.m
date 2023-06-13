function [m0,tau0,phi0,v0] = gbmmcmcinfp(dt,prior_Emu,belief_Emu,prior_Esig,belief_E1sig2)

tau0 = 1/(dt*belief_Emu);

phi0 = 1/(sqrt(dt)*prior_Esig);

m0 = prior_Emu - 0.5*prior_Esig^2;

v0 = 2*(dt^2)*(phi0^4)/(belief_E1sig2^2);

end

