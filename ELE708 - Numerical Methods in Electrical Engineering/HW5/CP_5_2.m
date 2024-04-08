function CP_5_2()
    fs = {'(x^2+2)/3', 'sqrt(3*x-2)', '3-2/x', '(x^2-2)/(2*x-3)'};
    tol = eps;
    maxits = 10;
    x_true = 2;

    disp('(b)');
    for i = 1:4
        fprintf('g_%d(x) = %s\n', i, fs{i});
        g = inline(fs{i}, 'x');
        disp(' k     x                 err              ratio');
        
        k = 0;
        x = 2.5;
        err = abs(x - x_true);
        fprintf('%3d %20.12e %20.12e\n', k, x, err);
        
        while err > tol && k < maxits
            k = k + 1;
            x = g(x);
            err_new = abs(x - x_true);
            ratio = err_new / err;
            err = err_new;
            fprintf('%3d %20.12e %20.12e %20.12e\n', k, x, err, ratio);
        end
        
        disp(' ');
    end
end
