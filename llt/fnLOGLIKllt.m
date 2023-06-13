function [LL, GR] = fnLOGLIKllt(THETA,y)

H = exp(THETA(1,1));

Q = eye(2);
Q(1,1) = exp(THETA(2,1));
Q(2,2) = exp(THETA(3,1));

n = size(y,1);

[v, F,K] = fnKFllt(y,H,Q);
[~, ~, ~, ~,u,D,r,N] = fnDSllt(v,F,K,H,Q);

LL = sum( log(F) + (v.^2)./F );

GR = zeros(3,1);
GR(1) = -sum(u.^2-D)*H;

tr = zeros(n-1,1);
for t = 1:n-1
    tr(t) = trace((r(:,t)*r(:,t)'-N(:,:,t))*[Q(1,1) 0; 0 0]);
end
str = sum(tr);

GR(2) = -str;

tr = zeros(n-1,1);
for t = 1:n-1
    tr(t) = trace((r(:,t)*r(:,t)'-N(:,:,t))*[0 0; 0 Q(2,2)]);
end
str = sum(tr);

GR(3) = -str;


end