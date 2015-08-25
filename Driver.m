%% Driver
% Runs the decomposition code on a Haar-random unitary matrix (HaarU.m)
% and computes the 2-norm distance between the factorization and the expected
% matrices.

%% Test for the algorithm to decompose into internal and CS matrices
ns = 5; % Number of spatial modes
np = 2; % Dimensional of inernal degree of freedom
U = HaarU(ns*np);

%U = blkdiag([0,1i;-1i,0],[0,1i;-1i,0])
elementaryOperations = Decomposition(U,ns,np);
celldisp(elementaryOperations);

% Multiplying the matrices obtained from the factorization
W = 1;
for m = 1:ns*(3*ns-1)/2
    W = W*elementaryOperations{m};
end

% Distance between the expected matrix and the factorization
norm(U-W)

%% Test for the decomposition of a given CS matrix into internal and beamsplitter matrices

ns = 2; % Number of spatial modes (Fixed at 2 for this version of code)
np = 3; % Dimensional of inernal degree of freedom (>2 for this version)
U2 = HaarU(ns*np);

el = Decomposition(U2,ns,np);
InternalAndBeamsplitter = CSMatrix(el{3},np);
celldisp(InternalAndBeamsplitter);

W2 = 1;
for m = 1:3*np
    W2 = W2*InternalAndBeamsplitter{m};
end

% Distance between the expected matrix and the factorization
norm(el{3}-W2)
