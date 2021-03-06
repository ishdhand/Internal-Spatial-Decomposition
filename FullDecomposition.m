
% Matlab code for the decomposition algorithm presented in the article 
% "Realization of arbitrary discrete unitary transformations using spatial 
% and internal modes of light" by Ish Dhand and Sandeep K. Goyal. 
% If you use this decomposition or code, please consider citing our article.

% Article Ref.: arXiv:1508.06259

%% Decomposition of a given unitary matrix into internal and CS matrices
%
% This code implements the decomposition algorothm presented in Section
% IIIb of article "Realization of arbitrary discrete unitary transformation
% using spatial and internal modes of light" by Ish Dhand and Sandeep Goyal.
%
% The inputs comprise:
% U, an n_s*n_p X n_s*n_p unitary matrix to be decomposed
% ns, the number of spatial modes
% np, the number of internal modes
%
% The output of the code is a cell of ns*np X ns*np matrices, each of which
% represents either an internal transformation or a beamsplitter
% transformation.
%
% For an illustration of using this code, refer to Driver.m


function el = FullDecomposition(U,ns,np)

el = cell((ns-1)*(5*ns+2)/2+1,1);
V1 = U;

nmax = 0;
for mm = 1:ns-1 % for mm-th column
    % in mm-th column we have ns-mm number of cs matrices and ns-mm
    % number of block internal matrices
    Ns = ns-mm+1; % Number of effective spatial modes in mmth iteration
    nmax = nmax + 5*(Ns-1) + 1;
    V = V1;
    V1 = 1;
    %         size(V)
    
    for ii = 1:ns-mm
        %                     ii
        % calculating the first cs matrix
        
        [L1,L2,R1,R2,S] = CSD(V,np,np*(ns-mm-ii+1));
        
        % Calculating Beamsplitter and Internal matrices from the S matrix
        Theta = real(acos(diag(S(1:np,1:np)))); % Use the CS matrix to compute the theta values
        B = [1 1i; 1i 1]/sqrt(2); % Beamsplitter matrix
        Uinternal = diag(exp(1i*Theta)); % internal diagonal Unitary matrix
        
        el{nmax-5*(ii-1)} = blkdiag(eye(np*(mm+ii-2)),R1',eye(np*(ns-mm-ii+1)));
        el{nmax-5*(ii-1)-1} = blkdiag(eye(np*(mm+ii-2)),kron(B',eye(np)),eye(np*(ns-mm-ii)));
        el{nmax-5*(ii-1)-2} = blkdiag(eye(np*(mm+ii-2)),blkdiag(Uinternal,conj(Uinternal)),eye(np*(ns-mm-ii)));
        el{nmax-5*(ii-1)-3} = blkdiag(eye(np*(mm+ii-2)),kron(B,eye(np)),eye(np*(ns-mm-ii)));
        el{nmax-5*(ii-1)-4} = blkdiag(eye(np*(mm+ii-2)),L1,eye(np*(ns-mm-ii+1)));
        V = L2;
        V1 = blkdiag(eye(np*(ii-1)),R2')*V1;
    end
    %         mm
    el{nmax-5*(Ns-1)} = blkdiag(eye(np*(mm+ii-1)),L2,eye(np*(ns-mm-ii)));
end
el{end} = blkdiag(eye(np*(mm+ii-1)),R2',eye(np*(ns-mm-ii)));

nn = 1;
W = 1;
% elementary = cell(ns*(3*ns-1)/2,1);
for m = 1:(ns-1)*(5*ns+2)/2+1
    W = W*el{m};
end

% find(abs(U-W)>1e-10)

nor = norm(U-W)

end
