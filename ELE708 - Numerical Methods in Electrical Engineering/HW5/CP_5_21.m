function CP_5_21
clear
clc

%  soruda verilenler
sigma = 10;
r =28;
b = 8/3;

f  =  @(x,y,z) [sigma*(y-x); r*x-y-x*z; x*y-b*z];
df = @(x,y,z) [-sigma sigma 0; r-z -1 -x; y x -b];



k = 0;
step_size = [1,1,1];

%     x0 = [-0.5 9 -9; 1 12 -12; -1 30 30];
x0 = [10 10 10];
x = x0(1);
y = x0(2);
z = x0(3);

while norm(step_size) > 1e-10 && k < 30

    fx = f(x, y,z);
    dfx = df(x, y,z);

    step_size = - dfx\fx;

    x = x + step_size(1);
    y = y + step_size(2);
    z = z + step_size(3);

    k = k+1;
end
x
y
z

end