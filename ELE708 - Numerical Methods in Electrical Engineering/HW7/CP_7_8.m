function cp07_08 
    % interpolation of population data
    t = [1900:10:1980]';
    y = [76212168;
         92228496;
         106021537;
         123202624;
         132164569;
         151325798; 
         179323175;
         203302031;
         226542199];

     y2 = [76000000; 92000000; 106000000; 123000000;
           132000000; 151000000; 179000000; 203000000; 227000000];
    
%-----------------------------------------------------------------

    disp('(a) Condition number of basis matrices:');
    cond_A1 = cond(vander(t));
    cond_A2 = cond(vander(t-1900));
    cond_A3 = cond(vander(t-1940)); 
    cond_A4 = cond(vander((t-1940)/40));
    fprintf('1: %d \n', cond_A1);
    fprintf('2: %d \n', cond_A2);
    fprintf('3: %d \n', cond_A3);
    fprintf('4: %d \n', cond_A4);
    disp('--------------------------------');

%-----------------------------------------------------------------

    % Evaluation at specific points
    ts = linspace(1900,1980,81)';

    % Polynomial interpolation
    % en büyük X^n li degerin katsayısı en önde olsun diye flip ettik
    xp = fliplr(vander((t-1940)/40))\y;
    xp2 = fliplr(vander((t-1940)/40))\y2;

    tic; 
    yp = heval(xp,ts); 
    time_p = toc;

    tic; 
    xh = pchip(t,y); % Piecewise Cubic Hermite Interpolating Polynomial
    yh = ppval(xh,ts); 
    time_h = toc;

    tic; 
    xs = spline(t,y);
    ys = ppval(xs,ts); 
    time_s = toc;

%-----------------------------------------------------------------
    disp('(b) polynomial of best cond:');
    figure;
    plot(t,y,'ko',ts,yp,'k-');
    xlabel('t'); 
    ylabel('y');
    legend('data points','polynomial');
    title('(b) polynomial of best cond');
%-----------------------------------------------------------------
        
%-----------------------------------------------------------------
    disp('(c) Hermite cubic interpolation and (b):');
    figure;
    plot(t,y,'ko',ts,yp,'k-',ts,yh,'b--');
    xlabel('t'); 
    ylabel('y');
    legend('data points','polynomial', 'Hermite cubic');
    title('(c) Hermite cubic interpolation and (b)');
%-----------------------------------------------------------------

%-----------------------------------------------------------------
    disp('(d) cubic spline and (b), (c):');
    figure;
    plot(t,y,'ko',ts,yp,'k-',ts,yh,'b--',ts,ys,'r-.');
    xlabel('t'); 
    ylabel('y');
    legend('data points','polynomial','Hermite cubic','Cubic spline');
    title('(d) cubic spline and (b), (c)');
%-----------------------------------------------------------------

%-----------------------------------------------------------------
    % Extrapolation
    ts = linspace(1980,1990,11)';
    yp = heval(xp,ts);
    yh = pchip(t,y,ts); 
    ys = spline(t,y,ts);
    figure;
    plot([t(9);1990],[y(9);248709873],'ko',ts,yp,'k-',ts,yh,'b--',ts,ys,'r-.');
    xlabel('t'); 
    ylabel('y');
    legend('data points','polynomial','Hermite cubic','Cubic spline');
    title('(e) Extrapolation to 1990');
%-----------------------------------------------------------------
    
%-----------------------------------------------------------------
    % Lagrange interpolation
    ts = linspace(1900,1980,81)';
    tic; 
    yl = leval(t,y,ts); 
    time_l = toc; 
    figure;
    plot(t,y,'ko',ts,yl,'k-'); 
    xlabel('t'); 
    ylabel('y');
    legend('data points','Lagrange poly');
    title('(f) Lagrange Poly');
%-----------------------------------------------------------------
    
%-----------------------------------------------------------------
    
    % Newton interpolation
    tic;
    xn = Newton_interp(t,y); 
    yn = Newton_eval(xn,t,ts); 
    time_n = toc;
    ts = linspace(1900,1990,91)';
    yn = Newton_eval(xn,t,ts);
    [xn2, t, y] = Newton_addpt(xn,t,y,1990,248709873); 
    yn2 = Newton_eval(xn2,t,ts);
    figure; 
    plot(t,y,'ko',ts,yn,'b--',ts,yn2,'r-.'); 
    xlabel('t'); 
    ylabel('y');
    legend('data points','degree of 8','degree of 9');
    title('(g) Newton interpolating');
    
    disp('(f) Timing of each basis:');
    fprintf('Monomial basis: %g\n', time_p); 
    fprintf('Hermite cubic: %g\n', time_h);
    fprintf('Cubic spline: %g\n', time_s); 
    fprintf('Newton basis: %g\n', time_n);
    fprintf('Lagrange basis: %g\n', time_l);
    disp(' ');
%-----------------------------------------------------------------
    
    disp('(h) Coefficients:');
    fprintf('Coefficients of original input\n');
    disp(xp);
    fprintf('Coefficients of rounded input\n');
    disp(xp2);
    
end

function [y] = heval(x, t)
    % evaluate polynomial using Horner’s method
    n = length(x); 
    y = zeros(size(t));
    for i=n:-1:1
        y = x(i)+((t-1940)./40).*y;
    end
end

function [yy] = leval(t, y, tt)
    % evaluate Lagrange interpolant
    n = length(t); 
    yy = zeros(size(tt));
    for i = 1:n
        z = ones(size(tt));
        for j = 1:n
            if i ~= j
                z = z.*(tt-t(j))/(t(i)-t(j));
            end
        end
        yy = yy+z*y(i);
    end
end

function [x] = Newton_interp(t, y)
    % compute Newton interpolant
    n = length(t); 
    A = zeros(n,n); 
    A(:,1) = ones(n,1);
    for i = 2:n
        A(i:n,i) = (t(i:n)-t(i-1)).*A(i:n,i-1);
    end
    x = A\y;
end

function [f] = Newton_eval(x, t, t_out)
    % evaluate Newton interpolant
    n = length(x); 
    f = x(n);
    for i = n-1:-1:1
        f = x(i)+f.*(t_out-t(i));
    end
end

function [x, t, y] = Newton_addpt(x, t, y, t_new, y_new)
    % add point to interpolant
    if length(x) == 0 
        % empty interpolant
        x = y_new; 
        t = t_new; 
        y = y_new;
    else
        p = Newton_eval(x, t, t_new); 
        Pi = 1;
        for k = 1:length(t)
            Pi = Pi*(t_new-t(k));
        end
        x = [x; (y_new-p)/Pi]; 
        t = [t; t_new]; 
        y = [y; y_new];
    end
end
