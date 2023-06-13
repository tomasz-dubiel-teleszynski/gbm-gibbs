function [v, F, K, a, P, L] = fnKFllt(y,H,Q)

[Z, T, R] = fnSMllt();

a1 = [y(1); acos(1/sqrt(1+(y(2)-y(1))^2))];
%a1 = [y(1);0];

n = length(y);

P1 = 1e6*eye(2);

for t=1:n
    
       [v1, F1, K1, L1] = fnERR(y(t),a1,P1,Z,T,H);
       
       v(t)     = v1;
       F(t)     = F1;
       K(:,t)   = K1;
       L(:,:,t) = L1;
        
       [a1, P1] = fnUPD(a1,P1,v1,K1,L1,T,R,Q);
       
       a(:,t)   = a1;
       P(:,:,t) = P1;

end

end

function [v1, F1, K1, L1] = fnERR(y1,a1,P1,Z1,T,H)

    F1 = Z1 * P1 * Z1' + H;
    v1 = y1 - Z1 * a1;
    K1 = T * P1 * Z1' / F1;
    L1 = T - K1 * Z1;    

end

function [a2, P2] = fnUPD(a1,P1,v1,K1,L1,T,R,Q)

    a2 = T * a1 + K1 * v1;
    P2 = T * P1 * L1' + R * Q * R';

end