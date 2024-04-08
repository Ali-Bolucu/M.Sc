function CP_6_9()
format short;
f = @(x) 100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
gradf = @(x) [400*x(1)*(x(1)^2-x(2))+2*(x(1)-1); 200*(x(2)-x(1)^2)];
hessf = @(x) [1200*x(1)^2-400*x(2)+2, -400*x(1); -400*x(1), 200];

tolerance = 1e-6;
max_iteration = 100;
x0 = [-1 0 2; 1 1 1];



for i = 1:1
    
[x, y] = meshgrid(-3.0:0.01:3.0, -3.0:0.01:3.0);
figure(i);
hold on;
contour(-3.0:0.01:3.0, -3.0:0.01:3.0, 100*(y-x.^2).^2 + (1-x).^2, 50);
plot(x0(1,i), x0(2,i), 'x');
text(x0(1,i), x0(2,i), 'Initial Point', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
xlabel('x');
ylabel('y');
title('Plot of the function');


    iter_1 = 0;
    x = x0(:, i); % takes the start points column by column
    s = ones(size(x));
    fprintf('Starting point:\n');
    disp(x);
    disp('Steepest descent:');

    %fprintf("\n\n");
    %fprintf("k ||   X || f(x) || grad_x |- \n");
    while norm(s) > tolerance && iter_1 < max_iteration
        iter_1 = iter_1 + 1;
        s = -gradf(x);
        [x_new, alpha] = LineSearch(f, x, s);
        s = x_new - x;
        %fprintf("%d || %12d %12d || %12d || %14d %14d |-\n", iter_1, x, f(x_new), s);
        plot([x(1), x_new(1)], [x(2), x_new(2)], '-');
        x = x_new;
        
        plot(x_new(1), x_new(2) , 'x');
        
        
    end
    fprintf("\n\n");
    disp(x);
    disp(iter_1);
    %plot([x0(1,i), x_new(1)], [x0(2,i), x_new(2)], '-');
    
    plot(x_new(1), x_new(2) , 'x');
    text(x_new(1), x_new(2), 'Steepest descent', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

    disp('Newton''s method:');
    iter_2 = 0;
    x_newton = x0(:, i);
    s = ones(size(x_newton));
    while norm(s) > tolerance && iter_2 < max_iteration
        iter_2 = iter_2 + 1;
        s = -(hessf(x_newton)\gradf(x_newton));
        x_newton_old = x_newton;
        x_newton = x_newton + s;
        plot([x_newton_old(1), x_newton(1)], [x_newton_old(2), x_newton(2)], '-');
    end
    disp(x_newton);
    disp(iter_2);

    plot(x_newton(1), x_newton(2) , 'x');
    text(x_newton(1), x_newton(2), 'Newton''s method', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');


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