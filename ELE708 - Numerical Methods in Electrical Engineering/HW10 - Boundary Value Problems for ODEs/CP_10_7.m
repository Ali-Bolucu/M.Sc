function CP_10_7 
clc
clear
    for n = 2:5
        h = 1/(n+1);
        A = diag(-ones(n-1,1),-1) + diag(2*ones(n,1),0) + diag(-ones(n-1,1),1);
        E = eig(A) / h^2;
        Exact = ((1:1:n)' * pi).^2;
        
        disp("----------------------------------------------------------")
        fprintf("n:%d\n",n);
        disp('computed');
        disp([E']);
        disp('exact');
        disp([Exact']);
    end
    disp("----------------------------------------------------------")
end
