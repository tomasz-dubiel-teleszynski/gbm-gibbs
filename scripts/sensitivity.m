clear all
close all
clc

%% assumptions

mu  = 0.2;
sig = 0.15;
cv  = 0.20;
cg  = 0.70;
r   = 0.06;
tau = 0.25;
x   = 2.00;
xa  = 0.30;

N = 100;

G = zeros(N,1);
BC = G;
XA = G;
T2XA = G;

%% sensitivity 2 mu

MU = linspace(-0.1,0.1,N);

for n =1:N
    [G(n),BC(n),XA(n)] = value4gov(x,MU(n),sig,cv,cg,r,tau);
     T2XA(n) = time2xa(MU(n),sig,x,xa);
end

G = real(G);
BC = real(BC);
XA = real(XA);
T2XA = real(T2XA);

figure 
subplot(2,2,1)
plot(MU,XA)
ylabel('xa')
xlabel('mu')
axis tight
subplot(2,2,2)
plot(MU,T2XA)
ylabel('t2xa')
xlabel('mu')
axis tight
subplot(2,2,3)
plot(MU,BC)
ylabel('bc')
xlabel('mu')
axis tight
subplot(2,2,4)
plot(MU,G)
ylabel('G')
xlabel('mu')
axis tight

%% sensitivity 2 sig

SIG = linspace(0.05,0.5,N);

for n =1:N
    [G(n),BC(n),XA(n)] = value4gov(x,mu,SIG(n),cv,cg,r,tau);
     T2XA(n) = time2xa(mu,SIG(n),x,xa);
end

G = real(G);
BC = real(BC);
XA = real(XA);
T2XA = real(T2XA);

figure 
subplot(2,2,1)
plot(SIG,XA)
ylabel('xa')
xlabel('sig')
axis tight
subplot(2,2,2)
plot(SIG,T2XA)
ylabel('t2xa')
xlabel('sig')
axis tight
subplot(2,2,3)
plot(SIG,BC)
ylabel('bc')
xlabel('sig')
axis tight
subplot(2,2,4)
plot(SIG,G)
ylabel('G')
xlabel('sig')
axis tight

%% sensitivity 2 cv

CV = linspace(0.00,1.00,N);

for n =1:N
    [G(n),BC(n),XA(n)] = value4gov(x,mu,sig,CV(n),cg,r,tau);
     T2XA(n) = time2xa(mu,sig,x,xa);
end

G = real(G);
BC = real(BC);
XA = real(XA);
T2XA = real(T2XA);

figure 
subplot(2,2,1)
plot(CV,XA)
ylabel('xa')
xlabel('cv')
axis tight
subplot(2,2,2)
plot(CV,T2XA)
ylabel('t2xa')
xlabel('cv')
axis tight
subplot(2,2,3)
plot(CV,BC)
ylabel('bc')
xlabel('cv')
axis tight
subplot(2,2,4)
plot(CV,G)
ylabel('G')
xlabel('cv')
axis tight

%% sensitivity 2 cg

CG = linspace(0.00,1.00,N);

for n =1:N
    [G(n),BC(n),XA(n)] = value4gov(x,mu,sig,cv,CG(n),r,tau);
     T2XA(n) = time2xa(mu,sig,x,xa);
end

G = real(G);
BC = real(BC);
XA = real(XA);
T2XA = real(T2XA);

figure 
subplot(2,2,1)
plot(CG,XA)
ylabel('xa')
xlabel('cg')
axis tight
subplot(2,2,2)
plot(CG,T2XA)
ylabel('t2xa')
xlabel('cg')
axis tight
subplot(2,2,3)
plot(CG,BC)
ylabel('bc')
xlabel('cg')
axis tight
subplot(2,2,4)
plot(CG,G)
ylabel('G')
xlabel('cg')
axis tight

%% sensitivity 2 tau

TAU = linspace(0.1,0.5,N);

for n =1:N
    [G(n),BC(n),XA(n)] = value4gov(x,mu,sig,cv,cg,r,TAU(n));
     T2XA(n) = time2xa(mu,sig,x,xa);
end

G = real(G);
BC = real(BC);
XA = real(XA);
T2XA = real(T2XA);

figure 
subplot(2,2,1)
plot(TAU,XA)
ylabel('xa')
xlabel('tau')
axis tight
subplot(2,2,2)
plot(TAU,T2XA)
ylabel('t2xa')
xlabel('tau')
axis tight
subplot(2,2,3)
plot(TAU,BC)
ylabel('bc')
xlabel('tau')
axis tight
subplot(2,2,4)
plot(TAU,G)
ylabel('G')
xlabel('tau')
axis tight