function Copy_of_CP_9_1
    % Predatory-prey models
    [t_lv, y_lv] = ode45(@Lotka_Volterra, 0:0.1:25, [25; 10]);
    xlim([0 30]);
    ylim([0 50]);
    % Plot Lotka-Volterra Model
    figure(1);
    subplot(2,1,1);
    plot(xlim,ylim,"w", t_lv, y_lv(:,1), 'b-', t_lv, y_lv(:,2), 'r-');
    legend('y1 = 25', 'y2 = 10', 'Location', 'Best');

    xlabel('t');
    ylabel('y');
    title('Time vs ((y1(t), y2(t)))');
    
    % Plot Phase Portrait for Lotka-Volterra Model
    subplot(2,1,2);
    plot(y_lv(:,1), y_lv(:,2), 'k-');   
    xlabel('y_1');
    ylabel('y_2');
    title('y1(t) vs y2(t)');

end

function [yprime] = Lotka_Volterra(t,y)
    alpha1 = 1;
    beta1 = 0.1;
    alpha2 = 0.5;
    beta2 = 0.02;

    yprime = [y(1)*(alpha1-beta1*y(2)); y(2)*(-alpha2+beta2*y(1))]; % Y' matrisi olarak yazıyor
end

function [yprime] = Leslie_Gower(t,y)
    alpha1 = 1.0;
    beta1 = 0.1;
    alpha2 = 0.5;
    beta2 = 10;

    yprime = [y(1)*(alpha1-beta1*y(2)); y(2)*(alpha2-beta2*y(2)/y(1))];
end