function CP_6_14()
f = @(x, t) x(1) .* exp(x(2) .* t);
t = [0.5:0.5:4]'; 
y = [6.8; 3; 1.5; 0.75; 0.48; 0.25; 0.2; 0.15];

options = optimset('TolX', 1e-6, 'MaxIter', 50, 'Display', 'off');

x = [ones(length(t),1), t] \ log(y);
x0 = [exp(x(1)); x(2)];

disp('(a) Nonlinear fit:');
x = lsqcurvefit(@(x,t) f(x,t), x0, t, y, [], [], options);
disp(x);

figure;
plot(t, y, 'o-', 'DisplayName', 'Data');
hold on;
y_fit = f(x, t);
plot(t, y_fit, 'x-', 'DisplayName', 'LSQCurveFit Data');
hold off;



disp('(b) Linear fit:');
log_y = log(y);
x = x0
