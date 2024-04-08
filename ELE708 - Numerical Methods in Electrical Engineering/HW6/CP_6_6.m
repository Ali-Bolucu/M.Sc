function CP_6_6()
x0 = [2; 3];
s = [-5; -7]; 
[x, alpha] = LineSearch(@func, x0, s);


    figure;
    x_vals = linspace(-10, 10, 100);
    y_vals = arrayfun(@(x) func([x; x]), x_vals);
    plot(x_vals, y_vals);
    xlabel('x');
    ylabel('f(x)');
    title('Plot of the function');

end


function [x_new, alpha] = LineSearch(func, x, s)

    alpha = 1;
    max_iteration = 10;
    iteration = 0;
    f0 = phi(0, func, x, s);
    f1 = phi(alpha, func, x, s);

    fprintf('func value 0: %d\n', f0);
    
    
    while f1 > f0 && iteration < max_iteration
        fprintf('func value %d : %d \n' , iteration, f0);
        alpha = alpha / 2;
        f1 = phi(alpha, func, x, s);
        iteration = iteration+1;
    end

      
    options = optimset('TolX', 1e-6, 'MaxIter', 50);
    alpha = fminbnd(@(alpha) phi(alpha, func, x, s), 0, 2 * alpha, options);
    x_new = x + alpha * s;
    fprintf('New X: %d\n', x_new);
    fprintf('New alpha: %d\n', alpha);
    
end


function val = phi(alpha, func, x, s)
    val = feval(func, x + alpha * s);
end

function y = func(x)
    y = 5 * x(1)^2 + 7 * x(2)^2 - 3 * x(1) * x(2);
end