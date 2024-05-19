function CP_10_1 
    % Two-point boundary value problem
    global a b ua ub rhs ivp; 
    a = 0; 
    b = 1; 
    ua = 0; 
    ub = 1;
    
    rhs = inline('10*u.^3+3*u+t.^2','t','u');
    ivp = inline('[y(2); 10*y(1)^3+3*y(1)+t^2]','t','y');
    
    disp('(a) Initial slope determined by shooting method:');
    slope = fzero(@shooting_fun,1);
    [t, y] = ode45(ivp,[a,b],[ua;slope]);
    plot(t, y(:,1),'r-');
    xlabel('t'); 
    ylabel('u'); 
    axis([0 1 0 1.2]);
    title('Computer Problem 10.1(a) -- Shooting Method for Two-Point BVP');
    
    n = [1 3 7 15]; 
    figure;
    options = optimset('MaxFunEvals', 5000, 'Display', 'off');
    for i = 1:4
        t = linspace(a,b,n(i)+2); 
        y = [ua; fsolve(@fd_fun,t(2:n(i)+1),options)'; ub];
        plot(t,y); 
        hold on;
    end
    xlabel('t'); 
    ylabel('u'); 
    axis([0 1 0 1.2]);
    title('Computer Problem 10.1(b) -- Finite Difference Method for Two-Point BVP');
    
    n = [3 4 5 6]; 
    figure;
    disp('(c) Coefficients of polynomials determined by collocation:');
    for i = 1:4
        x = fsolve(@colloc_fun,ones(n(i),1),options)';
        t = linspace(a,b,50)';
        plot(t,polyval(x,t)); 
        hold on;
    end
    xlabel('t'); 
    ylabel('u'); 
    axis([0 1 0 1.2]);
    title('Computer Problem 10.1(c) -- Collocation Method for Two-Point BVP');

    function [g] = shooting_fun(slope)
        % Shooting method
        [t, y] = ode45(ivp,[a,b],[ua;slope]);
        plot(t, y(:,1)); 
        hold on; 
        g = ub - y(end,1);
    end

    function [z] = fd_fun(y)
        % Finite difference method
        n = length(y); 
        h = 1/(n+1); 
        t = linspace(h,1-h,n); 
        f = rhs(t,y);
        if n > 1
            z = [(y(2)-2*y(1)+ua)/h^2-f(1); ((y(3:n)-2*y(2:n-1)+y(1:n-2))/h^2-f(2:n-1))'; (ub-2*y(n)+y(n-1))/h^2-f(n)];
        else
            z = (ub-2*y+ua)/h^2-f;
        end
    end

    function [z] = colloc_fun(x)
        % Collocation method
        n = length(x); 
        h = 1/(n-1); 
        t = linspace(a,b,n)';
        d = (n-1:-1:1)'.*x(1:n-1); 
        d2 = (n-2:-1:1)'.*(d(1:n-2));
        z = [polyval(x,a)-ua; polyval(d2,t(2:n-1))-rhs(t(2:n-1),polyval(x,t(2:n-1))); polyval(x,b)-ub];
    end
end
