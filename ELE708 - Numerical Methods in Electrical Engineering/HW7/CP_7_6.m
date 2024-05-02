function CP_7_6()

% Define data points
t = [0; 1; 4; 9; 16; 25; 36; 49; 64];
y = [0:8]';
% Generate points for plotting
ts = linspace(0, 64, 100)';


%-----------------------------------------------
% Fit polynomial of degree 8 to the data
p_polynomial = polyfit(t, y, 8);

% Evaluate polynomial at interpolation points
y_polynmial = polyval(p_polynomial, ts);
% True square root values
y_polynomial_root= sqrt(ts);
%-----------------------------------------------


%-----------------------------------------------
% Compute cubic spline interpolant
p_spline = spline(t, y);
% Evaluate cubic spline at interpolation points
y_spline = ppval(p_spline, ts);
%-----------------------------------------------



% Plot the results
figure;
hold on;
plot(t, y, 'ko', ts, y_polynomial_root, 'k--', ts, y_spline, 'b--');
%title('Computer Problem 7.6(a)-(c) -- Interpolants to Square Root');
xlabel('t');
ylabel('y');
axis([0, 64, 0, 8]);
legend('data points', 'square root of domain', ' spline');

% Generate points for plotting in a smaller interval
ts = linspace(0, 1, 100)';
y_polynomial_root = sqrt(ts);
y_polynmial = polyval(p_polynomial, ts);
y_spline = ppval(p_spline, ts);

% Plot the results for the smaller interval
figure;
plot(t(1:2), y(1:2), 'ko', ts, y_polynomial_root, 'k-', ts, y_polynmial, 'b--', ts, y_spline, 'r-.');
%title('Computer Problem 7.6(d) -- Interpolants to Square Root');
xlabel('t');
ylabel('y');
axis([0, 1, 0, 1]);
legend('data points', 'square root', 'polynomial', 'spline');

end
