function CP_5_3_Newton_method
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

    a0 = 0.5;


    % Newton's method
    disp('Newton''s method:');
    fprintf('\n f(x) = %s = 0\n',fs{i});
    disp(' k    x                  f(x)');
    delx = 1;
    k = 0;
    x = a0;
    fx = f(x);
    df = inline(dfs{i}, 'x');
    fprintf('%3d %17.10e %17.5e\n', k, x, fx);

    while abs(delx) > tol && k < maxits
        k = k + 1;
        d = df(x);
        delx = -fx / d;
        x = x + delx;
        fx = f(x);
        fprintf('%3d %17.10e %17.5e\n', k, x, fx);
    end
    disp(' ');



end

