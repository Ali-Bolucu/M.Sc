function CP_5_3_Bisection_method
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

    a = -5;
    b = 5;

    tol = 1e-10;
    maxits = 50;


    % Bisection method
    disp(' ');
    disp('Bisection method:');
    fprintf('\n f(x) = %s = 0\n',fs{i});
    disp(' k    a                    f(a)              b                  f(b)');

    k = 0;
    
    fa = f(a);
    fb = f(b);

    fprintf('%3d %17.10e %17.5e %17.5e %17.5e\n', k, a, fa, b, fb);
    while b - a > tol && k < maxits
        k = k + 1;
        m = a + (b - a) / 2; % prevent overflow
        fm = f(m);
        if sign(fa) == sign(fm)
            a = m;
            fa = fm;
        else
            b = m;
            fb = fm;
        end
        fprintf('%3d %17.10e %17.5e %17.5e %17.5e\n', k, a, fa, b, fb);
    end

end






end

