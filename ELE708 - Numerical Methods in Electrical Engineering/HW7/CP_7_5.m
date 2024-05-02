function CP_7_5 % interpolation of experimental data

t = [0; 0.5; 1; 6; 7; 9]; % Time data points
y = [0; 1.6; 2; 2; 1.5; 0]; % Corresponding experimental data points

% Generate 50 evenly spaced points between 0 and 9 for plotting
ts = linspace(0, 9, 50);

% --------------------------------------------------
% Fit a polynomial of degree 5 to the data
% Using monomial basis
p_monomial = polyfit(t, y, 3); % returns coefficient of polynomial
% Evaluate the polynomial at the generated points
y_monomial = polyval(p_monomial, ts);
% --------------------------------------------------


% --------------------------------------------------
% Use spline interpolation to interpolate the data
p_spline = spline(t, y);
% Evaluate the spline at the generated points
ys = ppval(p_spline, ts);
% --------------------------------------------------


% --------------------------------------------------
% Use linear interpolation to interpolate the data
p_linear = interp1(t, y, ts, "linear");

% --------------------------------------------------



% Plot the experimental data points, polynomial interpolation, spline interpolation, and piecewise linear interpolation
plot(t, y, 'ko', ts, y_monomial, 'b-', ts, ys, 'r-.',ts, p_linear, 'g-');
xlabel('t'); % Label for the x-axis
ylabel('y'); % Label for the y-axis
axis([0, 9, -1, 3]); % Set the axis limits
%title('Computer Problem 7.5 -- Interpolants to Experimental Data'); % Title for the plot
legend('data points', 'polynomial degree of 5', 'cubic spline', 'piecewise linear'); % Add a legend to the plot

% Display explanations for the choices of interpolants
disp('(c) Polynomial gives unreasonable values between data points because');
disp(' it necessarily oscillates. Spline gives somewhat more reasonable');
disp(' values between data points, but it overshoots to achieve smoothness.');
disp('(d) Piecewise linear interpolation may be better in this case because');
disp(' it yields more reasonable values between data points, although it');
disp(' is less smooth.');
