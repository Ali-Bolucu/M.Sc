function CP_4_10
    disp(' n min singular value max singular value ratio'); 
    disp(' ');
    
    for n = 1:15
        A = eye(n,n);
    
        for i = 1:n-1
            A = A + diag(-1*ones(n-i,1),i);
        end
    
        S = svd(A);
        ratios(n) = S(1)/S(n);
        fprintf('%2g min:[%21.13e] || max:[%21.13e] || ratio:[%10.4e]\n', n, S(n), S(1), S(1)/S(n));
    end


plot(1:15, ratios, '-o');
xlabel('Dimension of the matrix');
ylabel('\sigma_{max}/\sigma_{min}');
title('Behavior of \sigma_{max}/\sigma_{min} as the dimension grows');

end