function Q3_Derivative_Based_Optimization_DFP_Quasi_Newton_method
    tolerance = 1e-6;


    q0 = [1; 1];

    E = @(q) q(1)^2 + 4*q(2)^2 + 2*q(1)*q(2) + q(1) - 11*q(2);
    gradE = @(q) [2*q(1) + 2*q(2) + 1; 2*q(1) + 8*q(2) - 11];

    H_inv = eye(2);

    figure(3);
    EE = @(a1,a2) a1.^2 + 4*a2.^2 + 2*a1.*a2 + a1 - 11*a2;
    fcontour(EE, [-4 2 -2 10], 'LevelStep', 20);
    hold on;

    plot(q0(1), q0(2), 'o');

    % Main optimization loop
    while true
        % Calculate search direction using inverse Hessian approximation
        s = -H_inv * gradE(q0);

        % Line search along the search direction
        sE = @(alpha) E(q0 + alpha * s);
        step_size = fminsearch(sE, 0);

        % Update the current point
        q_old = q0;
        q0 = q0 + step_size * s;

        % Update the inverse Hessian approximation using DFP formula
        y = gradE(q0) - gradE(q_old);
        H_inv = H_inv + ((step_size * s) * (step_size * s)') / (step_size * s' * s) - (H_inv * y * y' * H_inv) / (y' * H_inv * y);

        % Plot the current point and the line segment
        plot(q0(1), q0(2), 'x');
        plot([q_old(1), q0(1)], [q_old(2), q0(2)], '-');

        if norm(gradE(q0)) < tolerance
            break;
        end


    end

    plot(q0(1), q0(2), 'o');
end
