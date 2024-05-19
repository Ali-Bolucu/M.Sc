function Q2_RLS_Study
clear
clc
%y = teta_0 + teta_.x1 + teta_2.x;

table = [1 2 2 2 3 3 4 5 5 5 6 7 8 8 9;
         2 5 3 2 4 5 6 5 6 7 8 6 4 9 8;
         2 1 2 2 1 3 2 3 4 3 4 2 4 3 4];

table_x1 = [1 2 2 2 3 3 4 5 5 5 6 7 8 8 9];  
table_x2 = [2 5 3 2 4 5 6 5 6 7 8 6 4 9 8];
table_y  = [2 1 2 2 1 3 2 3 4 3 4 2 4 3 4];


disp("a) Find the least square estimator");

% A. teta = y

A = [1 1 2;
     1 2 5;
     1 2 3;
     1 2 2;
     1 3 4;
     1 3 5;
     1 4 6;
     1 5 5;
     1 5 6;
     1 5 7;
     1 6 8;
     1 7 6;
     1 8 4;
     1 8 9;
     1 9 8];

y = transpose(table_y);
answer = (transpose(A)*A)^-1* transpose(A)*y

answer_line = answer(1) + answer(2)*table_x1 + answer(3)*table_x2;

figure (1);
plot3(table_x1,table_x2,y,'bo','linewidth',2);
hold on;

n=length(table_x1);
A=[ones(n,1) table_x1' table_x2'];
c=pinv(A)*y;
x1=linspace(1,10,10);
x2=linspace(1,10,10);
[x1,x2]=meshgrid(x1,x2);
y=c(1)+c(2)*x1+c(3)*x2;
mesh(x1,x2,y)

xlabel('x1');
ylabel('x2');
zlabel('y');
hold off;

end