function Q3_Derivative_Based_Optimization_FletcherReeves 

    f = @(x) x(1).^2 + 4*x(2).^2 + 2*x(1)*x(2) + x(1) - 11*x(2);
    gradf = @(x) [2*x(1) + 2*x(2) + 1; 2*x(1) + 8*x(2) - 11];
    hessf = @(x) [2, 2; 2,8];
    ms = {'Fletcher-Reeves', 'Polak-Ribiere'};
    x0 = [1;1];
    tol = 1e-6;
    maxits = 30;
    
    E = @(q1,q2) q1.^2 + 4*q2.^2 + 2*q1.*q2 + q1 - 11*q2;
    fcontour(E,[-4 2 -2 10],'LevelStep',20);
    grid;
    hold on;
    plot(x0(1),x0(2),'o');

    k = 0; 
    x = x0; 
    g = gradf(x); 
    s = -g;
    
    while norm(s) > tol && k < maxits
        k = k+1; 
        x_old =x;
        [x, alpha] = LineSearch(f, x, s); 
        g_new = gradf(x);
      
        beta = (g_new'*g_new)/(g'*g);

        s = -g_new + beta*s; 
        g = g_new;

        plot(x(1),x(2),'x');
        plot([x_old(1), x(1)], [x_old(2),  x(2)], '-');
        
    end

    hold off;
end

function [x_new, alpha] = LineSearch(f, x, s) 
    % min_alpha f(x+alpha*s)
    k = 0; 
    maxits = 10; 
    f0 = phi(0, f, x, s); 
    alpha = 1; 
    f1 = phi(alpha, f, x, s);
    
    while f1 > f0 && k < maxits
        k = k+1; 
        alpha = alpha/2; 
        f1 = phi(alpha, f, x, s);
    end
    
    options = optimset('TolX', 1e-6, 'MaxIter', 50);
    alpha = fminbnd(@phi, 0, 2*alpha, options, f, x, s); 
    x_new = x + alpha*s;
end

function [val] = phi(alpha, fun, x, s)
    val = feval(fun, x + alpha*s);
end
