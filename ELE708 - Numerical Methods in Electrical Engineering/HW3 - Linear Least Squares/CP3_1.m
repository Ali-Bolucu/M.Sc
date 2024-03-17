% For n = 0, 1, . . . , 5, fit a polynomial of degree n by least squares to the following data:
% t 0.0 1.0 2.0 3.0 4.0 5.0 
% y 1.0 2.7 5.8 6.6 7.5 9.9
% Make a plot of the original data points along with each resulting polynomial curve
% (you may make separate graphs for each curve or a single graph containing all of the curves).
% Which polynomial would you say captures the general trend of the data better? 
% Obviously, this is a subjective question, and its answer depends on both the nature of the given 
% data (e.g., the uncertainty of the data values) and the purpose of the fit. 
% Explain your assumptions in answering.

function CP3_1()
    
    t = [0; 1; 2; 3; 4; 5];
    y = [1; 2.7; 5.8; 6.6; 7.5; 9.9];
    m = size(t,1);
    A = ones(m,1);
    p = 51;
    ts = linspace(0,5,p)';


    for n = 1:5
        subplot(3,2,n);
        hold on;
        plot(t, y, 'kx');
        x = A(:,1:n)\y;
        ys(1:p,n) = x(n);

        for k = 2:n
            ys(:,n) = ys(:,n).* ts+x(n-k+1);
        end


        plot(ts, ys(:,n));
        title(['Polynomial Fit (Degree ', num2str(n), ')']);
        xlabel('t'); ylabel('y');
        legend('Data points', 'Polynomial Curve');
        hold off;
        A(:,n+1) = A(:,n) .*t;
    end
end