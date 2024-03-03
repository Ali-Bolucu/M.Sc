% Write a program to compute the absolute and relative errors in Stirling’s approximation
% n! ≈√ 2πn (n/e)^n for n = 1 to 10. 
% Does the absolute error grow or shrink as n increases? 
% Does the relative error grow or shrink as n increases?
%
% Absolute error = Approximate value - True value
% Relative error = Absolute error - True value

function CP1_1()
    
    range = 10;
    Absolute_Errors = zeros(1,range);
    Relative_Errors = zeros(1,range);

    for n = 1:range

        True_value = factorial(n);
        Stirling_approximation = sqrt(2*pi*n) * (n/exp(1))^n;

        Absolute_error = abs(Stirling_approximation - True_value);
        Relative_error = Absolute_error / True_value;

        Absolute_Errors(n) = Absolute_error;
        Relative_Errors(n) = Relative_error;

        disp(['For n = ', num2str(n)]);
        disp(['Approximate value: ', num2str(Stirling_approximation)]);
        disp(['True value: ', num2str(True_value)]);
        disp(['Absolute Error: ', num2str(Absolute_error)]);
        disp(['Relative Error: ', num2str(Relative_error)]);
        disp('--------------------------------------------');
    end

    figure;
    subplot(2, 1, 1);
    plot(1:range, Absolute_Errors,'-x');
    title('Absolute Error vs. n');
    xlabel('n');
    ylabel('Absolute Error');
    
    subplot(2, 1, 2);
    plot(1:range, Relative_Errors, '-o');
    title('Relative Error vs. n');
    xlabel('n');
    ylabel('Relative Error');


end




% Line Styles:
% 
% - : solid line (default)
% -- : dashed line
% : : dotted line
% -. : dash-dot line
% Marker Styles:
% 
% o : circle
% + : plus sign
% * : asterisk
% . : point
% x : cross