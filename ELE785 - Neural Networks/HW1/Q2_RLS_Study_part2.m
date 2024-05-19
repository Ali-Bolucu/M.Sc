% Data
data = [1 2 2 2 3 3 4 5 5 5 6 7 8 8 9;
        2 5 3 2 4 5 6 5 6 7 8 6 4 9 8;
        2 1 2 2 1 3 2 3 4 3 4 2 4 3 4];

% Add bias term to the inputs
X = [ones(1, size(data, 2)); data(1:2,:)]; 
y = data(3,:);

% LMS algorithm
learning_rate = 0.0001;
epochs = 30000;
weight = zeros(size(X, 1), 1);
weight_history = zeros(size(X, 1), epochs+1);
weight_history(:,1) = weight;

for epoch = 1:epochs
    for i = 1:size(X, 2)
        % Predicted output
        y_pred = X(:,i)' * weight;
        % Error
        error = y(i) - y_pred;
        % Update parameters
        weight = weight + learning_rate * error * X(:,i);
        % Store parameter values for plotting
        weight_history(:,epoch+1) = weight;
    end
end
%weight
% Plotting
figure (2);
iterations = 0:epochs;
plot(iterations, weight_history(1,:), 'LineWidth', 2);
hold on;
plot(iterations, weight_history(2,:), 'LineWidth', 2);
plot(iterations, weight_history(3,:), 'LineWidth', 2);
xlabel('Iterations');
ylabel('Parameter Value');
legend('\theta_0', '\theta_1', '\theta_2');
grid on;

