function CP_6_6_v2
    % general line search routine
    x0 = [1;-2];
    s = [-1; 2];
    [x, alpha] = LineSearch(@test, x0, s);
    disp(x);
    test(x)



    % Define the range for x1 and x2
    x1 = linspace(-5, 5, 100);  % Adjust the range as needed
    x2 = linspace(-5, 5, 100);  % Adjust the range as needed
    
    % Create a grid of points
    [X1, X2] = meshgrid(x1, x2);
    
    % Calculate the function values at each point
    Y = 5 * X1.^2 + 2 * X2.^2 - X1.*4;
    
    % Plot the surface
    surf(X1, X2, Y);
    hold on;
    plot3(x0(1), x0(2), test([x0(1), x0(2)]), 'r*', 'MarkerSize', 10);
    plot3(x(1), x(2), test([x(1), x(2)]), 'r*', 'MarkerSize', 10);



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
        k = k + 1;
        alpha = alpha / 2;
        f1 = phi(alpha, f, x, s);
    end

    options = optimset('TolX', 1e-6, 'MaxIter', 50);
    alpha = fminbnd(@(alpha) phi(alpha, f, x, s), 0, 2 * alpha, options);
    x_new = x + alpha * s;
end

function [val] = phi(alpha, fun, x, s)
    val = feval(fun, x + alpha * s);
end

function [y] = test(x)
    y = 5 * x(1)^2 + 2 * x(2)^2 - x(1)^4;
end
