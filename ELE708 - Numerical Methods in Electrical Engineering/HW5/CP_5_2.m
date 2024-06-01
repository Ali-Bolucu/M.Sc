function CP_5_2()
clear
clc
format short

fs = {'(x^2+2)/3', 'sqrt(3*x-2)', '3-2/x', '(x^2-2)/(2*x-3)'};
f1 = @(x) (x^2+2)/3;
f2 = @(x) sqrt(3*x-2);
f3 = @(x) 3-2/x;
f4 = @(x) (x^2-2)/(2*x-3);
functions = {f1, f2, f3, f4};

    tol = eps;
    maxits = 10;
    x_true = 2;

    disp('(b)');
    for i = 1:4
        fprintf('g%d(x) = %s\n', i, fs{i});
        g = functions{i};

        disp(' k     x ');
        
        k = 0;
        x = 2.5;
        err = abs(x - x_true);
        fprintf('%3d %20.12e\n', k, x);
        
        while err > tol && k < maxits
            k = k + 1;
            x = g(x);
            err_new = abs(x - x_true);
            err = err_new;
            fprintf('%3d %20.12e\n', k, x );
        end
        
        disp(' ');
    end
end
