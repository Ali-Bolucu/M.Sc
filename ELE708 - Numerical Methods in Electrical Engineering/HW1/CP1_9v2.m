% Write a program to compute the exponential function ex using the infinite series
% e^x = 1+x+ x^2/2! + x^3/3! + ...  
% (b) Summing in the natural order, what stopping criterion should you use?
% (c) Test your program for x = ±1, ±5, ±10, ±15, ±20, and compare your results with the built-in function exp(x).
% (d) Can you use the series in this form to obtain accurate results for x < 0? (Hint: e−x = 1/ex.)
% (e) Can you rearrange the series or regroup the terms in any way to obtain more accurate results for x < 0?

function CP1_4(exponent)

    if exponent < 0
        x = abs(exponent);
        True_value = 1/exp(x);
     
    else
        x = exponent;
        True_value = exp(x);

    end
        
    n = 1;
    Approximate_value = 1;
    
    
    while abs(x^n) < 1e300 && factorial(n) < 1e300
        Approximate_value = (x^n/factorial(n)) + Approximate_value;
        n = n+1;
    end
    
    Approximate_value = 1/Approximate_value;


        Absolute_error = abs(Approximate_value - True_value);
        Relative_error = Absolute_error / True_value;

        disp(['Approximate value: ', num2str(Approximate_value)]);
        disp(['True value: ', num2str(True_value)]);
        disp(['Absolute Error: ', num2str(Absolute_error)]);
        disp(['Relative Error: ', num2str(Relative_error)]);
        disp('--------------------------------------------');
end
