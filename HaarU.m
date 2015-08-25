%% Haar-random unitary generator
% This function generates and returns matrix uniformly sampled from the
% Haar measure in $SU(n)$.

function U = HaarU(n)
    [Q,R] = qr((randn(n) + 1i*randn(n))/sqrt(2));
    U = Q*diag(diag(R)./abs(diag(R)));
end