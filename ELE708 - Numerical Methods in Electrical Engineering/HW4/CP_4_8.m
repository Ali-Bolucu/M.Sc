function CP_4_8
    % compute roots of polynomial using companion matrix
    p = [24; -40; 35; -13; 1]; 
    n = length(p); 
    C = diag(ones(n-2,1),-1);

    disp('Output of MATLAB function roots:');
    Roots = roots(flipud(p))


    disp('Companion matrix:'); 
    C(:,n-1) = -p(1:n-1)
    disp('Eigenvalues of companion matrix:');
    Eigenvalues = eig(C)


end
