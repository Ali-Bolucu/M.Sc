function CP_6_3()
fs = {@(x) x.^4-14*x.^3+60*x.^2-70*x, @(x) 0.5*x.^2-sin(x), @(x) x.^2+4*cos(x), @(x) gamma(x)};
function_num = {'(a)', '(b)', '(c)', '(d)'};

for i = 1:4
    f = fs{i};
    func_str = func2str(f);
    disp([function_num{i} ' f(x) = ' func_str]);
    min = fminbnd(f, 0, 3);
    figure(i);
    x = linspace(0, 3, 100);
    y = f(x);
    plot(x, y);
    hold on;
    plot(min, f(min), 'rx', 'MarkerSize', 15); % Plotting the minimum point
    xlabel('x');
    ylabel('f(x)');
    title([function_num{i} ': Minimum of f(x) = ' func_str(5:end)]);
    hold off;
end
