function CP_9_6 
clear
clc
format short
    % Lorenz model for atmospheric circulation
    n = 2001;
    [t, y] = ode45(@lorenz, 0:0.02:200, [0; 1; 0]); 
    
    % Plotting solutions
    figure (1);
    %subplot(2,2,1);
    plot(t, y(:, 1), 'b-');
    legend('y1', 'Location', 'Best');
    xlabel('t');

    figure (2);
    plot(t, y(:, 2), 'b-');
    legend('y2', 'Location', 'Best');
    xlabel('t');

    figure (3);
    plot(t, y(:, 3), 'b-');
    legend('y3', 'Location', 'Best');
    xlabel('t');
    
    % Plotting y1 vs y2
    figure (4);
    %subplot(2,2,2);
    plot(y(:, 1), y(:, 2));
    xlabel('y1(t)');
    ylabel('y2(t)');
    title('y1(t) vs y2(t)');
    
    % Plotting y1 vs y3
    figure (5);
    %subplot(2,2,3);
    plot(y(:, 1), y(:, 3));
    xlabel('y1(t)');
    ylabel('y3(t)');
    title('y1(t) vs y3(t)');
    
    % Plotting y2 vs y3
    figure (6);
    %subplot(2,2,4);
    plot(y(:, 2), y(:, 3));
    xlabel('y2(t)');
    ylabel('y3(t)');
    title('y2(t) vs y3(t)');
    
    % Displaying original solution at t = 100
    fprintf("Initial values : %d %d %d \n", 0, 1, 0 );
    disp('Results at t = 100:');
    disp(['y1 = ', num2str(y(1001, 1))]);
    disp(['y2 = ', num2str(y(1001, 2))]);
    disp(['y3 = ', num2str(y(1001, 3))]);

    
    xval = [0.01; 1; 0];
    fprintf("\n\nInitial values : %d %d %d \n", xval(1), xval(2), xval(3) );
    % Perturbing solution at t = 100
    [t, y] = ode45(@lorenz, 0:0.1:100, xval(:));
    disp('Perturbed solution at t = 100:');
    disp(['y = ', num2str(y(1001, :))]);

    xval = [0; 0.99; 0];
    fprintf("\n\nInitial values : %d %d %d \n", xval(1), xval(2), xval(3) );
    % Perturbing solution at t = 100
    [t, y] = ode45(@lorenz, 0:0.1:100, xval(:));
    disp('Perturbed solution at t = 100:');
    disp(['y = ', num2str(y(1001, :))]);

    xval = [0.01; 0.99; -0.01];
    fprintf("\n\nInitial values : %d %d %d \n", xval(1), xval(2), xval(3) );
    % Perturbing solution at t = 100
    [t, y] = ode45(@lorenz, 0:0.1:100, xval(:));
    disp('Perturbed solution at t = 100:');
    disp(['y = ', num2str(y(1001, :))]);
end

function [yprime] = lorenz(t, y)
    % Parameters
    sigma = 10;
    b = 8 / 3;
    r = 28;
    
    % Lorenz equations
    yprime = [sigma * (y(2) - y(1)); 
              r * y(1) - y(2) - y(1) * y(3); 
              y(1) * y(2) - b * y(3)];
end
