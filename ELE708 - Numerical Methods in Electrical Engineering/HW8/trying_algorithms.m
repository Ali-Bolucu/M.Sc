function trying_algorithms()


    f = @(x) (x.^2);
    a = 0;
    b = 1;
    
    %Define the variables
    h = b - a;
    h_min = 1e-09;
    I_true = pi;
    

    Midpoint(f,a,b,0.01)


    
    function[sum_of_midpoint] = Midpoint(f, a, b, h)
    
        values = a:h:b;
        sum_of_midpoint  = 0;
        for k=1:length(values)
            
            iter =  feval(f, values(k) - h/2 );
            sum_of_midpoint = sum_of_midpoint + iter;
        end
        sum_of_midpoint = h * sum_of_midpoint;
    end

end

