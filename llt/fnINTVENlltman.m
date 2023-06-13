function [DUMM,LEVS,SCS,auxEps,auxKsiLS,auxKsiSC]= fnINTVENlltman(y,stnmlv)

y = log(y);

N = length(y);

THETA = fnMAXLIKllt(y);

H = THETA(1);
Q = eye(2);
Q(1,1) = THETA(2);
Q(2,2) = THETA(3);

[v,F,K,a] = fnKFllt(y,H,Q);
[Eps,Ksi,VarEps,VarKsi] = fnDSllt(v,F,K,H,Q);

% identify additive outliers
auxEps = Eps./sqrt(VarEps);
idxEps = (auxEps' < -stnmlv) | (auxEps' > stnmlv);

% create dummies for outliers 
DUMM = [];
idxDUMS = find(idxEps);
I = length(idxDUMS);
if ~isempty(idxDUMS)
    DUMMi = zeros(N,I);
    for i=1:I
        DUMMi(idxDUMS(i),i)=1; 
    end
    DUMM = [DUMM DUMMi];
end

% identify structural breaks
auxKsiLS = Ksi(1,:)./sqrt(squeeze(VarKsi(1,1,:)))';
auxKsiLS = [NaN,auxKsiLS(1:end-1)];
idxKsiLS = ((auxKsiLS' < -stnmlv) | (auxKsiLS' > stnmlv)); 
idxLEVS = find(idxKsiLS);

I = numel(idxLEVS);
if ~isempty(idxLEVS)
    LEVS = zeros(N,I);
    for i = 1:I
        LEVS(idxLEVS(i):end,i) = 1;
    end
else
    LEVS = [];
end

% identify slope changes
auxKsiSC = Ksi(2,:)./sqrt(squeeze(VarKsi(2,2,:)))';
auxKsiSC = [NaN(1,2),auxKsiSC(1:end-2)];
idxKsiSC = ((auxKsiSC' < -stnmlv) | (auxKsiSC' > stnmlv));
idxSCS = find(idxKsiSC);

I = numel(idxSCS);
if ~isempty(idxSCS)
    SCS = zeros(N,I);
    for i = 1:I
        SCS(idxSCS(i):end,i) = 1:(N-idxSCS(i)+1);    
    end
else
    SCS = [];
end

end