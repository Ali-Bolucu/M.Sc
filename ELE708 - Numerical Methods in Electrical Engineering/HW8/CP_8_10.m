function CP_8_10
clear
clc
% This function evaluates various numerical integration methods for the gamma function.

% Define the function to be integrated
f = inline('t.^(x-1).*exp(-t)', 't', 'x');

% Define integration limits and minimum step size
a = 0;
b = 1e2;
h_min = 1e-4;

% Values of x for gamma function
x = 1:1:10;

fprintf("(a) Truncate the infinite interval of integration with Trapezoid");
for k = 1:10
    fprintf('For x = %d,\n', k);
    disp('(a) Error in quadrature rules for given stepsize h:');
    disp(' Interval      Midpoint    Trapezoid    Simpson');

    b = 1e2;
    h = b - a;
    while h >= h_min
        
        val_m = Midpoint(f, a, b, h, k);
        val_t = Trapezoid(f, a, b, h, k);
        val_s = Simpson(f, a, b, h, k);

        err_m = abs((Midpoint(f, a, b, h, k) - gamma(k)) / gamma(k));
        err_t = abs((Trapezoid(f, a, b, h, k) - gamma(k)) / gamma(k));
        err_s = abs((Simpson(f, a, b, h, k) - gamma(k)) / gamma(k));
        fprintf('%8.1e %10.3e %10.3e %10.3e %10.3e %10.3e %10.3e\n', b, val_m, val_t, val_s, err_m, err_t, err_s);
        h = h / 10;
    end
    disp(' ');

end

%------------------------------------------------------------------------------

fprintf("(b) Truncate the infinite interval of integration with Sandard Adaptive Quadrature routine");
for k = 1:10
    fprintf('For x = %d,\n', k);
    % Part (b): Error and function evaluations for given tolerance tol
    disp('(b) Error and function evaluations for given tolerance tol:');
    disp('  Interval       err (quad)    evals (quad)    err (quadl)    evals (quadl)');
    tol = 1e-3;
    h = 1e-3;
    while b <= 1e+4
        tol = 10^(-k);
        [Q, fcnt] = quad(f, a, b, tol, [], k);
        err_q = abs((Q - gamma(k)) / gamma(k));
        [Ql, fcntl] = quadl(f, a, b, tol, [], k);
        err_ql = abs((Ql - gamma(k)) / gamma(k));
        fprintf('%8.1e %10.3e %5d %10.3e %5d\n', b, err_q, fcnt, err_ql, fcntl);
        b = b .* 10;
    end
    disp(' ');

end

%--------------------------------------------------------------------------

fprintf("(c) Truncate the infinite interval of integration with Trapezoid");
for k = 1:10
    fprintf('For x = %d,\n', k);
    disp('(c) Error in n-point Gauss-Laguerre quadrature:');
    disp(' n       err');

    h = 1e-3;
    while b <= 1e+4

        err_g = abs((GaussLaguerre(f, n, k) - gamma(k)) / gamma(k));
        fprintf('%2d %10.3e\n', n, err_g);
        b = b .* 10;
    end
    disp(' ');

end
end

%------------------------------------------------------------------------------

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
