% CS-Decomposition of an (m+n)X(m+n) unitary matrix
% Input consists of U, an (m+n)X(m+n) unitary matrix, and positive integers
% m and n.

function [L1,L2,R1,R2,S] = CSD(U,m,n)

A = U(1:m,1:m);
B = U(1:m,(m+1):m+n);
C = U((m+1):m+n,1:m);
D = U((m+1):m+n,(m+1):m+n);

[L1,D1,R1] = svd(A);
[L2,D2,R2] = svd(D);

[D1 I] = sort(diag(D1),'ascend');
L1 = L1(:,I);
R1 = R1(:,I);


[D2 I] = sort(diag(D2),'ascend');
L2 = L2(:,I);
R2 = R2(:,I);

D1 = diag(D1);

% Here we have assumed that m < n
if m ==1
    dg = L1'*B*R2;
    P = exp(1i*angle(dg(1)));
else
P = diag(exp(1i*angle(diag(L1'*B*R2))));
end
L1 = L1*P;
R1 = R1*P;

L = blkdiag(L1,L2);
R = blkdiag(R1,R2);
S = L'*U*R;
end