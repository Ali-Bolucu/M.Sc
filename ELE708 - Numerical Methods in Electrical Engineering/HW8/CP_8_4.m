function CP_8_4
clear
clc

syms x
f1 = @(x) x.^(3/2);
disp("f1 = @(x) x.^(3/2)");
fprintf(" Ans : %d", integral(f1,0,1));
disp(" ");
disp(" ");

f2 = @(x) 1./(1+10*x.^2);
disp("f2 = @(x) 1./(1+10*x.^2);");
fprintf(" Ans : %d", integral(f2,0,1));
disp(" ");
disp(" ");

f3 = @(x) (exp(-9*x.^2)+exp(-1024*(x-0.25).^2))/sqrt(pi);
disp("f3 = @(x) exp(-9*x.^2)+exp(-1024*(x-0.25).^2))/sqrt(pi);");
fprintf(" Ans : %d", integral(f3,0,1));
disp(" ");
disp(" ");

f4 = @(x) 50./(pi*(2500*x.^2+1));
disp("f4 = @(x) 50./(pi*(2500*x.^2+1))");
fprintf(" Ans : %d", integral(f4,0,10));
disp(" ");
disp(" ");

f5 = @(x) 1./sqrt(abs(x));
disp("f5 = @(x) 1./sqrt(abs(x))");
fprintf(" Ans : %d", integral(f5,-9,100));
disp(" ");
disp(" ");

f6 = @(x) 25*exp(-25*x);
disp("f6 = @(x) 25*exp(-25*x)");
fprintf(" Ans : %d", integral(f6,0,10));
disp(" ");
disp(" ");

f7 = @(x) log(x);
disp("f7 = @(x) log(x);");
fprintf(" Ans : %d", integral(f7,0,1));
disp(" ");
disp(" ");









end

