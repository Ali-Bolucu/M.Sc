function untitled()
format short;
f = @(x) 100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
gradf = @(x) [400*x(1)*(x(1)^2-x(2))+2*(x(1)-1); 200*(x(2)-x(1)^2)];
hessf = @(x) [1200*x(1)^2-400*x(2)+2, -400*x(1); -400*x(1), 200];

tolerance = 1e-6;
max_iteration = 100;
x0 = [-1 0 2; 1 1 1];



for i = 2:2
    
[x, y] = meshgrid(-3.0:0.01:3.0, -3.0:0.01:3.0);
figure(i);
hold on;
contour(-3.0:0.01:3.0, -3.0:0.01:3.0, 100*(y-x.^2).^2 + (1-x).^2, 50);
plot(x0(1,i), x0(2,i), 'x');
text(x0(1,i), x0(2,i), 'Initial Point', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
xlabel('x');
ylabel('y');
title('Plot of the function');


    disp('Damped Newton method:');
    iter_3 = 0;
    x = x0(:, i);
    s = ones(size(x));
    while norm(s) > tolerance && iter_3 < max_iteration
        iter_3 = iter_3 + 1;
        s = -(hessf(x)\gradf(x));
        [x_dampnew, alpha] = LineSearch(f, x, s);
        plot([x(1), x_dampnew(1)], [x(2), x_dampnew(2)], '-');
        s = x_dampnew - x;
        x = x_dampnew;
    end
    disp(x);
    disp(iter_3);

    plot(x_dampnew(1), x_dampnew(2) , 'x');
    text(x_dampnew(1), x_dampnew(2), 'Damped Newton method', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    
hold off;


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