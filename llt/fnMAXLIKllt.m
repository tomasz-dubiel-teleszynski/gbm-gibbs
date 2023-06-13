function [THETA,LL,exitflag]=fnMAXLIKllt(y)

THETA0 = log(ones(3,1));

r = y-(y\ones(numel(y),1))*ones(numel(y),1);
v = acos(1./sqrt(1+(diff(y)).^2));

THETA0(1) = log(var(r));
THETA0(2) = log(var(diff(y)-v));
THETA0(3) = log(var(diff(v)));

fun = 'fnLOGLIKllt';
options = optimset('Display','off','GradObj','on','MaxIter',2000,...
    'MaxFunEvals',2000,'TolFun',1e-5,'TolX',1e-5,'LargeScale','on');
[THETA,LL,exitflag] = fminunc(fun,THETA0,options,y);
THETA = exp(THETA);

end

