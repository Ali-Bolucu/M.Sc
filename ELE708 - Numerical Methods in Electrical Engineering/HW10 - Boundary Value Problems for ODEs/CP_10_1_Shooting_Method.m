function CP_10_1_Shooting_Method 
clear
clc
% Initial Paramaters
t0 = 0;
t1 = 1;
u0 = 0;
u1 = 1;
func_initial = @(t, u) (10*u.^3+3*u+ t.^2);
func = @(t, y) [y(2); 10*y(1)^3 + 3*y(1) + t.^2];

disp('(b) Solving using Finite Difference Method:');

    n = [1 3 7 15]; 
    figure (2);
    options = optimset('MaxFunEvals', 5000, 'Display', 'off');
    for i = 1:1
        t = linspace(t0,t1,n(i)+2); % hesaplanacak t degerleri

        % fd fonksiyonuna hesaplamasını istedigimiz t degerlerini veriyoruz
         y_middle = fsolve(@finite_difference,t(2:n(i)+1),options)
        
        % y'nin bas, ara ve son degerleri
        y = [u0; y_middle.'; u1];
        plot(t,y); 
        hold on;
    end
   
    function [middle_vals] = finite_difference(y)
        y
        n_fd = length(y);
        h = 1/(n_fd+1); % step'ler
        t_fd = linspace(h,1-h,n_fd); 
        f = func_initial(t_fd,y);
        if n > 1
            middle_vals = [(y(2)-2*y(1)+u0)/h^2-f(1); 
                ((y(3:n_fd)-2*y(2:n_fd-1)+y(1:n_fd-2))/h^2-f(2:n_fd-1))';
                (u1-2*y(n_fd)+y(n_fd-1))/h^2-f(n_fd)]
        else
            middle_vals = (u1-2*y+u0)/h^2-f;
        end
    end
end