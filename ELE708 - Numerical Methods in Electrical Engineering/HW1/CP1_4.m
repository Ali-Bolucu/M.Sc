% Write a program to compute the mathematical constant e, the base of natural logarithms, from the definition
% e = lim n→∞ (1 + 1/n)^n.
% Specifically, compute (1 + 1/n)n for n = 10k, k = 1, 2,..., 20.
% Determine the error in your successive approximations by comparing them with the value of exp(1).
% Does the error always decrease as n increases?

function CP1_4()
    
    range = 20;

    for k = 1:range

        n = 10^k;

        True_value = exp(1);
        Approximate_value = (1+1/n)^n;

        Absolute_error = abs(Approximate_value - True_value);
        Relative_error = Absolute_error / True_value;

        disp(['For k = ', num2str(k)]);
        disp(['For n = ', num2str(n)]);
        disp(['Approximate value: ', num2str(Approximate_value)]);
        disp(['True value: ', num2str(True_value)]);
        disp(['Absolute Error: ', num2str(Absolute_error)]);
        disp(['Relative Error: ', num2str(Relative_error)]);
        disp('--------------------------------------------');
    end
end
