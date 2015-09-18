%% Decomposition of a given CS matrix into internal and beamsplitter matrices

% This code implements the decomposition algorothm presented in Section
% IIIc of article "Realization of arbitrary discrete unitary transformation
% using spatial and internal modes of light" by Ish Dhand and Sandeep Goyal.
%
% The inputs comprise:
% U, a 2n_p X 2n_p unitary matrix to be decomposed
% np, the number of internal modes
%
% The output of the code is a cell of 2n_p X 2n_p matrices, each of which
% represents either an internal transformation or a beamsplitter
% transformation.
%
% For an illustration of using this code, refer to Driver.m

function BS = CSMatrix(S,np)

% S is the CS matrix

Theta = real(acos(diag(S(1:np,1:np)))); % Use the CS matrix to compute the theta values
B = [1 1i; 1i 1]/sqrt(2); % Beamsplitter matrix
Uinternal = diag(exp(1i*Theta)); % internal diagonal Unitary matrix
BS = cell(1,3);

    BS{1} = kron(B,eye(np));
    BS{2} = blkdiag(Uinternal,conj(Uinternal));
    BS{3} = BS{1}';

end

