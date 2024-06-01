function CP_5_28(A)

tol = 1e-1;
maxits = 50; 
k = 0;
S = ones(size(A)); 

I = eye(size(A));

X = A'/(norm(A,1)*norm(A,inf)); % best initial guess
R = I-A*X; % residual matrix
E = A'-X;  % error matrix

while norm(E) > tol && k < maxits 

    S = X*R;
    X = X+S;

    R = I-A*X;
    E = A'- X;

    k = k+1;
end
disp('-----------------------------')
disp('Newtons method:')
X 
disp('-----------------------------')
disp('Library routine:')
inv_A_library = inv(A)
disp('-----------------------------')