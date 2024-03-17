function CP3_4()

A = [0.16, 0.10;
    0.17, 0.11;
    2.02, 1.29;];

b1 = [0.26; 0.28; 3.31];
x1_ne = A \ b1;
[U, S, V] = svd(A, 'econ');
x1_svd = V * (S' * inv(S * S')) * U' * b1;
disp('a):');
disp('Normal Equation:');
disp(x1_ne);
disp('SVD:');
disp(x1_svd);



b2 = [0.27; 0.25; 3.33];
x2_ne = A \ b2;
[U, S, V] = svd(A, 'econ');
x2_svd = V * (S' * inv(S * S')) * U' * b2;
disp('b):');
disp('Normal Equation:');
disp(x2_ne);
disp('SVD:');
disp(x2_svd);

%psudo_inverse_A = inv(transpose(A)*A)*transpose(A)

condA = cond(A);
cos_theta_1 = norm(A*x1_ne) / norm(b1);
cos_theta_2 = norm(A*x2_ne) / norm(b2);
cos_theta = norm(b2 - b1) / norm(b1);

delta_x_over_x = norm(x2_ne - x1_ne) / norm(x1_ne);
delta_b_over_b = norm(b2 - b1) / norm(b1);
bound = condA * cos_theta * delta_b_over_b;

disp('c)');
disp(['condA = ', num2str(condA)]);
disp(['cos_theta_1 = ', num2str(cos_theta_1)]);
disp(['cos_theta_2 = ', num2str(cos_theta_2)]);
disp(['cos_theta = ', num2str(cos_theta)]);

disp(['delx_over_x = ', num2str(delta_x_over_x)]);
disp(['delb_over_b = ', num2str(delta_b_over_b)]);
disp(['bound = ', num2str(bound)]);


end