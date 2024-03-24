function CP_4_5()

    A = [9, 4.5, 3; -56, -28, -18; 60, 30, 19];
    [X, D] = eig(A);
    fprintf('(a) Eigenvalues of original matrix: [ %6.3f %6.3f %6.3f ]\n\n', D(1,1), D(2,2), D(3,3));
    condx = cond(X); 
    [Y, C] = eig(A');
    YHX = Y'*X;
    A(3,3) = 18.95;
    [X2, D2] = eig(A);
    fprintf('(b) Eigenvalues of first modified matrix: [ %6.3f %6.3f %6.3f ]\n', D2(1,1), D2(2,2), D2(3,3))
    fprintf('    Relative change in largest eigenvalue: %6.3f \n\n', abs(max(D2)-max(D))/max(D))
    A(3,3) = 19.05;
    [X3, D3] = eig(A);
    fprintf('(c) Eigenvalues of second modified matrix: [ %6.3f %6.3f %6.3f ]\n', D3(1,1), D3(2,2), D3(3,3))

    fprintf('    Relative change in largest eigenvalue: [ %6.3f ]\n\n', abs(max(D3)-max(D))/max(D))
    fprintf('(d) Eigenvalues are sensitive;\n')
    fprintf('    Condition number of eigenvector matrix: [ %6.3f ]\n', condx)

    fprintf('    Inner products of right and left eigenvectors: [ %6.3f %6.3f %6.3f ]\n', YHX(1,1), YHX(2,2), YHX(3,3))
    fprintf('    Condition numbers of eigenvalues: [ %6.3f %6.3f %6.3f ]\n', abs(1/YHX(1,1)), abs(1/YHX(2,2)), abs(1/YHX(3,3)))
    fprintf('    Angles between right and left eigenvectors: [ %6.3f %6.3f %6.3f ]\n', acos(YHX(1,1))*180/pi, acos(YHX(2,2))*180/pi, acos(YHX(3,3))*180/pi)

end
