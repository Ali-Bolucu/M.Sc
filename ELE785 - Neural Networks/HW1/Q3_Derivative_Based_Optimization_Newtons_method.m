function Q3_Derivative_Based_Optimization_Newtons_method

tolerance = 1e-6;

% Initial conditions
q1_0 = 5;
q2_0 = 3.2;

q1_new = q1_0;
q2_new = q2_0;


E = @(q1,q2) q1.^2 + 4*q2.^2 + 2*q1.*q2 + q1 - 11*q2;

gradf = @(x) [2*x(1) + 2*x(2) + 1; 2*x(1) + 8*x(2) - 11];
hessf = @(x) [2, 2; 2,8];

dEdq1 = @(q1,q2) 2*q1 + 2*q2 + 1;
dEdq2 = @(q1,q2) 2*q1 + 8*q2 - 11;

figure (3);

fcontour(E,[-4 2 -2 10],'LevelStep',20);
grid;
hold on;
plot(q1_0,q2_0,'o');

s1 = -dEdq1(q1_new,q2_new);
s2 = -dEdq2(q1_new,q2_new);


while norm([s1,s2]) > tolerance

    % Search Direction
    s = hessf([q1_new,q2_new])\gradf([q1_new,q2_new]);
    s1 = -s(1)
    s2 = -s(2)

    q1_d = @(d) q1_new+s1;
    q2_d = @(d) q2_new+s2;
    sE = @(d) E(q1_d(d),q2_d(d)); % bulunan yönde ilerliyecek


    q1_old = q1_new;
    q2_old = q2_new;

    % bu method da burası gereksiz, sil
    q1_new = q1_d(step_size)
    q2_new = q2_d(step_size)

    plot(q1_new,q2_new,'x');
    plot([q1_old, q1_new], [q2_old, q2_new], '-');
    

end

 plot(q1_new,q2_new,'o');

end


