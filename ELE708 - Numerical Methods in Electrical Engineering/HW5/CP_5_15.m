function CP_5_15()
clear
clc

disp('(a)'); 
n = fzero(@fa, [10 30]) ;
fprintf("%f \n\n", n);

disp('(b)'); 
r = fzero(@fb, [0.05 0.1]) ;
fprintf("%f \n\n", r);

disp('(c)'); 
p = fzero(@fc, [5000 10000]);
fprintf("%f \n\n", p);

function [y] = fa(n)
    a = 100000; p = 10000; r = 0.06; y = (a*r-p)*(1+r)^n+p;
end

function [y] = fb(r)
    a = 100000; p = 10000; n = 20; y = (a*r-p)*(1+r)^n+p;
end

function [y] = fc(p)
    a = 100000; r = 0.06; n = 20; y = (a*r-p)*(1+r)^n+p;
end

end