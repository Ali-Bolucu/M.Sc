function CP_5_3_Secant_method
clear
clc

fs = {'x^3-2*x-5', 'exp(-x)-x', 'x*sin(x)-1', 'x^3-3*x^2+3*x-1'};
dfs = {'3*x^2-2', '-exp(-x)-1', 'x*cos(x)+sin(x)', '3*x^2-6*x+3'};


f1 = @(x) x^3-2*x-5;
f2 = @(x) exp(-x)-x;
f3 = @(x) x*sin(x)-1;
f4 = @(x) x^3-3*x^2+3*x-1;

functions = {f1, f2, f3, f4};


for i =1:4
    f = functions{i};

    tol = 1e-10;
    maxits = 20;

    a0 = 0;
    b0 = -5;


    % Secant method
    disp('Secant method:');
    fprintf('\n f(x) = %s = 0\n',fs{i});
    disp(' k    x                  f(x)');
    delx = 1;
    k = 0;
    x0 = a0;
    fx0 = f(x0);
    fprintf('%3d %17.10e %17.10e\n', k, x0, fx0);
    k = 1;
    x1 = b0;
    fx1 = f(x1);
    fprintf('%3d %17.10e %17.10e\n', k, x1, fx1);
    while abs(delx) > tol && k < maxits
        k = k + 1;
        d = (fx1 - fx0) / (x1 - x0);
        delx = -fx1 / d;
        x0 = x1;
        fx0 = fx1;
        x1 = x0 - fx0 / d;
        fx1 = f(x1);
        fprintf('%3d %17.10e %17.10e\n', k, x1, fx1);
    end
    disp(' ');



end

