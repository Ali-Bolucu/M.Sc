function CP_4_13()
    % Generalized eigenvalue problem for spring-mass system
    K = [2, -1, 0; -1, 2, -1; 0, -1, 1];
    M = diag([2, 3, 4]);
    A = M\K;
    B = A;
    tol = eps;

    for i = 1:size(A,1)
        x = rand(size(B,1), 1);
        delx = 1;

        while delx > tol
            y = B*x;
            y = y/norm(y, inf);
            delx = norm(abs(y) - abs(x), inf);
            x = y;
        end

        y = B*x;
        [xk, k] = max(abs(x));
        lambda = y(k)/x(k);
        omega = sqrt(lambda);
        x = x/x(k);
        e = zeros(size(B,1), 1);
        e(k) = 1;
        u = B'*e;
        B = B - x*u';
    end

    [X, Lambda] = eig(K, M);
    Lambda = diag(Lambda);
    Omega = sqrt(Lambda);
    X
    Lambda
    Omega
end
