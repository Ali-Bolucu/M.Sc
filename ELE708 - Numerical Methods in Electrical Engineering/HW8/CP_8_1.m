function CP_8_1()
    clear
    clc

    %Define the integral and its limits.
    f = @(x) 4./(1+x.^2);
    a = 0;
    b = 1;
    
    %Define the variables
    k = 0;
    h = b - a;
    h_min = 1e-06;
    I_true = pi;
    
    % Display headers for error comparison
    disp('(a) Values and Error of midpoint, trapezoid, and Simpson composite quadrature rules');
    disp(' ');
    disp('Values');
    fprintf('Stepsize   | Midpoint   | Trapezoid   | Simpson\n');
    % Loop through different step sizes and calculate errors
    while h >= h_min
        k = k + 1;
        tic;
        val_m = Midpoint(f, a, b, h);
        time_m = toc;
        tic;
        val_t = Trapezoid(f, a, b, h);
        time_t = toc;
        tic;
        val_s = Simpson(f, a, b, h);
        time_s = toc;
        
        
        fprintf('%10.3e | %10.3e | %10.3e  | %10.3e\n', h, val_m, val_t, val_s);
        h = h / 5;
    end
    disp(' ');

    disp('Errors');
    fprintf('Stepsize   | Midpoint   | Trapezoid   | Simpson\n');
    h = b - a;
    % Loop through different step sizes and calculate errors
    while h >= h_min
        k = k + 1;
        err_m = abs(Midpoint(f, a, b, h) - I_true);
        err_t = abs(Trapezoid(f, a, b, h) - I_true);
        err_s = abs(Simpson(f, a, b, h) - I_true);
        
        
        fprintf('%10.3e | %10.3e | %10.3e  | %10.3e\n', h, err_m, err_t, err_s);
        h = h / 5;
    end
    disp(' ');

    disp('Timing');
    h = b - a;
    fprintf('Stepsize   | Midpoint   | Trapezoid   | Simpson\n');
    % Loop through different step sizes and calculate errors
    while h >= h_min
        k = k + 1;
        tic;
        val_m = Midpoint(f, a, b, h);
        time_m = toc;
        tic;
        val_t = Trapezoid(f, a, b, h);
        time_t = toc;
        tic;
        val_s = Simpson(f, a, b, h);
        time_s = toc;
        
        
        fprintf('%10.3e | %10.3e | %10.3e  | %10.3e\n', h, time_m, time_t, time_s);
        h = h / 5;
    end
    disp(' ');

    disp('(b) Repeat using Ramborg rule');
    disp(' ');
    fprintf('Stepsize   | Ramborg | error   | Timing \n');
    k = 0;
    h = b - a;
    while h >= h_min
        k = k + 1;
        tic;
        val_r = Romberg(f, a, b, h);
        time_r = toc;
        err_r = abs(Romberg(f, a, b, h) - I_true);
        fprintf('%8.1e    %10.3e %10.3e, %10.3e\n', h, val_r, err_r, time_r);
        h = h / 10;
    end
    disp(' ');
    disp(' ');
    % Display headers for error and function evaluations for given tolerance
    disp('(c) Error and function evaluations:');
    disp(' quad                        || quadl');
    disp(' tolerance | error | iter_num | errror | iter_num | timing1   | timing2');
    
    % Loop through different tolerances and calculate errors and evaluations
    for k = 1:6
        tol = 10^(-k);
        tic;
        [Q, fcnt] = quad(f, a, b, tol);
        time_quad = toc;
        err_q = abs(Q - I_true);
        tic;
        [Ql, fcntl] = quadl(f, a, b, tol);
        time_quadl = toc;
        err_ql = abs(Ql - I_true);
        fprintf('%8.1e   %10.3e %5d   %10.3e %5d     %10.3e %10.3e\n', tol, err_q, fcnt, err_ql, fcntl, time_quad, time_quadl);
    end
    disp(' ');
    
    % Display headers for error in Monte Carlo integration using n random evaluation points
    disp('(d) Error in Monte Carlo:');
    disp(' n       | value    | error   | 1/(sqrt(n) | timing');
   
    % Loop through different numbers of random evaluation points
    n = 1;
    for k = 1:7
        tic;
        val_mc = MonteCarlo(f, a, b, n);
        time_mc = toc;
        err_mc = abs(MonteCarlo(f, a, b, n) - I_true);
        fprintf('%8d %10.3e %10.3e %10.3e %10.3e\n', n, val_mc, err_mc, 1 / sqrt(n), time_mc);
        n = n * 10;
    end
    disp(' ');









    % Define the Midpoint algorithm
    function[sum_of_Midpoint] = Midpoint(f, a, b, h)
        
            values = a:h:b;
            sum_of_Midpoint  = 0;
            for k=1:length(values)
                
                iter =  feval(f, values(k) - h/2 );
                sum_of_Midpoint = sum_of_Midpoint + iter;
            end
            sum_of_Midpoint = h * sum_of_Midpoint;
    end
    
    % Define the Trapezoid algorithm
    function [sum_of_Trapezoid] = Trapezoid(f, a, b, h)
    
        values = [a:h:b];
        sum_of_Trapezoid = h * (sum(feval(f, values)) - (feval(f, a) + feval(f, b)) / 2);
    
    end
    
    % Define the Simpson's algorithm
    function [sum_of_Simpson] = Simpson(f, a, b, h)
        sum_of_Simpson = (2 * Midpoint(f, a, b, h) + Trapezoid(f, a, b, h)) / 3;
    end
    
    % Define the Romberg algorithm
    function [sum_of_Romberg] = Romberg(f, a, b, h_min)
        k = 1;
        h = b - a;
        T(k, k) = Trapezoid(f, a, b, h);
        while h > h_min
            k = k + 1;
            h = h / 2;
            T(k, 1) = Trapezoid(f, a, b, h);
            for j = 2:k
                T(k, j) = (4^(j - 1) * T(k, j - 1) - T(k - 1, j - 1)) / (4^(j - 1) - 1);
            end
        end
        sum_of_Romberg = T(k, k);
    end
    
    % Define the Monte Carlo algorithm
    function [sum_of_MonteCarlo] = MonteCarlo(f, a, b, n)
        x = a + (b - a) * rand(n, 1);
        sum_of_MonteCarlo = (b - a) * sum(feval(f, x)) / n;
    end

end