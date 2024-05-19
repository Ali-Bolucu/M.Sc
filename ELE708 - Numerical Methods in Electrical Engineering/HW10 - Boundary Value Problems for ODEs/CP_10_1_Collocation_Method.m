function CP_10_1_Collocation_Method 
clear
clc
% Initial Paramaters
t0 = 0;
t1 = 1;
u0 = 0;
u1 = 1;
func_initial = @(t, u) (10*u.^3+3*u+ t.^2);
func = @(t, y) [y(2); 10*y(1)^3 + 3*y(1) + t.^2];
options = optimset('MaxFunEvals', 5000, 'Display', 'off');

disp('(c) Solving using Collocation Method:');

    n_cm = [3 4 5 6]; 
    figure (3);
    for i = 1:4
        x = fsolve(@collocation_method,ones(n_cm(i),1),options)'
        t_cm = linspace(t0,t1,50)';
        plot(t_cm,polyval(x,t_cm)); 
        hold on;
    end
   
    legend('n = 3','n = 4','n = 5','n = 6');

    function [z] = collocation_method(x)
        x
        n = length(x); 
        h = 1/(n-1); 
        t = linspace(t0,t1,n)';
        d = (n-1:-1:1)'.*x(1:n-1);
        d2 = (n-2:-1:1)'.*(d(1:n-2));
        z = [polyval(x,t0)-u0;
            polyval(d2,t(2:n-1))-func_initial(t(2:n-1),polyval(x,t(2:n-1)));
            polyval(x,t1)-u1];
    end
end