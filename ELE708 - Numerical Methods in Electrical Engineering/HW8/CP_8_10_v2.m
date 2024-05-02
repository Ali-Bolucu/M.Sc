function CP_8_10_v2
clear
clc
% This function evaluates various numerical integration methods for the gamma function.

% Define the function to be integrated
f = inline('t.^(x-1).*exp(-t)', 't', 'x');

% Define integration limits and minimum step size
a = 0;
b = 1e2;
h_min = 1e-3;

% Values of x for gamma function
x = [1 2 4 6 8 10];

% Loop over each value of x
for i = 1:6
    fprintf('For x = %d\n', x(i));
    
    % Part (a): Error in quadrature rules for given step size h
    disp('(a) Error in quadrature rules for given stepsize h:');
    disp(' h      Midpoint    Trapezoid    Simpson');
    
    k = 0;
    h = b - a;
    while h >= h_min
        k = k + 1;
        err_m = abs((Midpoint(f, a, b, h, x(i)) - gamma(x(i))) / gamma(x(i)));
        err_t = abs((Trapezoid(f, a, b, h, x(i)) - gamma(x(i))) / gamma(x(i)));
        err_s = abs((Simpson(f, a, b, h, x(i)) - gamma(x(i))) / gamma(x(i)));
        fprintf('%8.1e %10.3e %10.3e %10.3e\n', h, err_m, err_t, err_s);
        h = h / 10;
    end
    disp(' ');
    
    % Part (b): Error and function evaluations for given tolerance tol
    disp('(b) Error and function evaluations for given tolerance tol:');
    disp('  tol       err (quad)    evals (quad)    err (quadl)    evals (quadl)');
    
    for k = 1:7
        tol = 10^(-k);
        [Q, fcnt] = quad(f, a, b, tol, [], x(i));
        err_q = abs((Q - gamma(x(i))) / gamma(x(i)));
        [Ql, fcntl] = quadl(f, a, b, tol, [], x(i));
        err_ql = abs((Ql - gamma(x(i))) / gamma(x(i)));
        fprintf('%8.1e %10.3e %5d %10.3e %5d\n', tol, err_q, fcnt, err_ql, fcntl);
    end
    disp(' ');
    
    % Part (c): Error in n-point Gauss-Laguerre quadrature
    disp('(c) Error in n-point Gauss-Laguerre quadrature:');
    disp(' n       err');
    
    for n = 2:5
        err_g = abs((GaussLaguerre(f, n, x(i)) - gamma(x(i))) / gamma(x(i)));
        fprintf('%2d %10.3e\n', n, err_g);
    end
    disp(' ');
end
end

% Function for composite midpoint quadrature
function [I] = Midpoint(f, a, b, h, x)
    t = [a + h / 2: h: b - h / 2]';
    I = h * sum(feval(f, t, x));
end

% Function for composite trapezoid quadrature
function [I] = Trapezoid(f, a, b, h, x)
    t = [a: h: b]';
    I = h * (sum(feval(f, t, x)) - (feval(f, a, x) + feval(f, b, x)) / 2);
end

% Function for composite Simpson quadrature
function [I] = Simpson(f, a, b, h, x)
    I = (2 * Midpoint(f, a, b, h, x) + Trapezoid(f, a, b, h, x)) / 3;
end

% Function for Gauss-Laguerre quadratures
function [I] = GaussLaguerre(f, n, x)
    switch n
        case 2
            t = [0.585786437627; 3.414213562373];
            w = [8.53553390593e-1; 1.46446609407e-1];
        case 3
            t = [0.415774556783; 2.294280360279; 6.289945082937];
            w = [7.11093009929e-1; 2.78517733569e-1; 1.03892565016e-2];
        case 4
            t = [0.322547689619; 1.745761101158; 4.536620296921; 9.395070912301];
            w = [6.03154104342e-1; 3.57418692438e-1; 3.88879085150e-2; 5.39294705561e-4];
        case 5
            t = [0.263560319718; 1.413403059107; 3.596425771041; 7.085810005859; 12.640800844276];
            w = [5.21755610583e-1; 3.98666811083e-1; 7.59424496817e-2; 3.61175867992e-3; 2.33699723858e-5];
    end
    I = w' * (feval(f, t, x) .* exp(t));
end
