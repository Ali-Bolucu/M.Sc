function Copy_of_CP_9_1
    % Solve Leslie-Gower Model
    [t_lg, y_lg] = ode45(@Leslie_Gower, 0:0.1:25, [100;50]);
    
    % Plot Leslie-Gower Model
    figure(1);
    subplot(2,1,1);
    plot(xlim,ylim,"w", t_lg, y_lg(:,1), 'b-', t_lg, y_lg(:,2), 'r-');
    legend('y1 = 200', 'y2 = 10', 'Location', 'Best');

    xlabel('t');
    ylabel('y');
    title('Time vs ((y1(t), y2(t)))');
    
    % Plot Phase Portrait for Leslie-Gower Model
    subplot(2,1,2);
    plot(y_lg(:,1), y_lg(:,2));
    xlabel('y_1');
    ylabel('y_2');
    title('Phase Portrait');
end


function [yprime] = Leslie_Gower(t,y)
    alpha1 = 1.0;
    beta1 = 0.1;
    alpha2 = 0.5;
    beta2 = 10;

    yprime = [y(1)*(alpha1-beta1*y(2)); y(2)*(alpha2-beta2*y(2)/y(1))];
end