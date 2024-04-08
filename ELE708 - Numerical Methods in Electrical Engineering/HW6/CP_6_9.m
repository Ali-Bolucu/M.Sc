function CP_6_9()

f = @(x) 100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
gradf = @(x) [400*x(1)*(x(1)^2-x(2))+2*(x(1)-1); 200*(x(2)-x(1)^2)];
hessf = @(x) [1200*x(1)^2-400*x(2)+2, -400*x(1); -400*x(1), 200];

tolerance = 1e-6;
max_iteration = 50;
x0 = [-1 0 2; 1 1 1];

[x, y] = meshgrid(-1.0:0.01:2.0, 0.0:0.01:2.0);
figure;
hold on;
contour(-1.0:0.01:2.0, 0.0:0.01:2.0, 100*(y-x.^2).^2 + (1-x).^2, 50);
plot(1, 1, 'x');
xlabel('x');
ylabel('y');
title('Plot of the function');

for i = 1:3
    k = 0;
    x = x0(:, i);
    s = ones(size(x));
    fprintf('Starting point:\n');
    disp(x);
    
    disp('Steepest descent:');
    while norm(s) > tolerance && k < max_iteration
        k = k + 1;
        s = -gradf(x);
        [x_new, alpha] = LineSearch(f, x, s);
        s = x_new - x;
        x = x_new;
    end
    disp(x);
    disp(k);
    
    disp('Newton''s method:');
    k = 0;
    x = x0(:, i);
    s = ones(size(x));
    while norm(s) > tolerance && k < max_iteration
        k = k + 1;
        s = -(hessf(x)\gradf(x));
        x = x + s;
    end
    disp(x);
    disp(k);
    
    disp('Damped Newton method:');
    k = 0;
    x = x0(:, i);
    s = ones(size(x));
    while norm(s) > tolerance && k < max_iteration
        k = k + 1;
        s = -(hessf(x)\gradf(x));
        [x_new, alpha] = LineSearch(f, x, s);
        s = x_new - x;
        x = x_new;
    end
    disp(x);
    disp(k);
end

function [x_new, alpha] = LineSearch(f, x, s)
    % min_alpha f(x+alpha*s)
    k = 0;
    max_iteration = 10;
    f0 = phi(0, f, x, s);
    alpha = 1;
    f1 = phi(alpha, f, x, s);
    
    while f1 > f0 && k < max_iteration
        k = k + 1;
        alpha = alpha / 2;
        f1 = phi(alpha, f, x, s);
    end
    
    options = optimset('TolX', 1e-6, 'MaxIter', 50);
    alpha = fminbnd(@(alpha) phi(alpha, f, x, s), 0, 2*alpha, options);
    x_new = x + alpha * s;
end

function val = phi(alpha, fun, x, s)
    val = feval(fun, x + alpha * s);
end
end