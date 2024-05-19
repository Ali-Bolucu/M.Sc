
clc
clear all
close all
a=[9.76 10 10
9.64 15 13
7.26 36 37
6.57 55 45
7.55 34 36
9.89 5 8
8.45 27 25
2.53 85 85
8.56 23 26
6.56 45 46 
5.87 67 52  
7.78 32 33
3.98 79 71
3.89 77 71
1.10 98 99
2.01 89 89
5.98 61 51
6.67 54 43
3.95 78 71
8.65 23 23
7.87 31 31
6.98 49 41
2.89 81 82
1.87 92 92
8.67 22 27];
y=a(:,1)';
x1=a(:,2)';
x2=a(:,3)';
plot3(x1,x2,y,'bo','linewidth',4);
hold on;
n=length(x1);
a=[ones(n,1) x1' x2'];
c=pinv(a)*y';
x1=linspace(1,100,100);
x2=linspace(1,100,100);
[x1,x2]=meshgrid(x1,x2);
y=c(1)+c(2)*x1+c(3)*x2;
mesh(x1,x2,y)
xlabel('Distance from Base station');
ylabel('Mobility of user');
zlabel('Signal strength');
title('Signal strength variation with mobility of the user and distance from base station ')
grid on;