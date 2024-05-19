% Data
data = [1 2 2 2 3 3 4 5 5 5 6 7 8 8 9;
        2 5 3 2 4 5 6 5 6 7 8 6 4 9 8;
        2 1 2 2 1 3 2 3 4 3 4 2 4 3 4];

% Input data
X = [ones(1, size(data, 2)); data(1:2,:)]; 
% Output data
y = data(3,:);

% Autocorrelation matrix
R = X * X' / size(X, 2)
eig(R)

% Cross-correlation vector
p = X * y' / size(X, 2);

% Wiener's optimal solution
theta_optimal = inv(R) * p;
disp('Wiener''s Optimal Solution:');
disp(theta_optimal);
