function [Eps, Ksi, VarEps, VarKsi,u,D,r,N] = fnDSllt(v,F,K,H,Q)

[Z, T, R] = fnSMllt();

n = length(v);

r(:,n) = zeros(2,1);
N(:,:,n) = zeros(2);

for t=n:-1:1
    
    % observation disturbance
    
    u(t) = inv( F(t) ) * v(t) - K(:,t)' * r(:,t);
    D(t) = inv( F(t) ) + K(:,t)' * N(:,:,t) * K(:,t);
    
    Eps(t) = H * u(t);
    VarEps(t) = H^2 * D(t);
    VarEpsSmth(t) = H - H * D(t) * H;
               
    % state disturbance
    
    Ksi(:,t) = Q * R' * r(:,t);
    VarKsi(:,:,t) = Q' * R' * N(:,:,t) * R * Q;
    VarKsiSmth(:,:,t) =  Q - Q' * R' * N(:,:,t) * R * Q;
       
    if t > 1
 
        r(:,t-1) = Z' * u(t) + T' * r(:,t);        
        N(:,:,t-1) = Z' * D(t) * Z + T' * N(:,:,t) * T - Z' * K(:,t)' * N(:,:,t) * T - T' * N(:,:,t) * K(:,t) * Z;
 
    end
    
end