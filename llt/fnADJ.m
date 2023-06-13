function [ynew,OLSadj] = fnADJ(y,x,DUMM,LEVS,SCS)

%LEVS = ~LEVS;
D = [DUMM LEVS SCS];

D = unique(D','rows')';

if ~isempty(D)
    if ~isempty(x)
        results = fnOLS(y,[ones(length(y),1) x D]);
        OLSadj  = (results.beta(3:end)' * D')';
        ynew    = y - OLSadj;
    else
        results = fnOLS(y,[ones(length(y),1) D]);
        OLSadj  = (results.beta(2:end)' * D')';
        ynew    = y - OLSadj;
    end
else
    OLSadj = zeros(length(y),1); 
    ynew   = y - OLSadj;   
end

end