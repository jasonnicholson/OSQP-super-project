% Generate problem data
rng(1)
n = 10;
m = 1000;
Ad = sprandn(m, n, 0.5);
x_true = (randn(n, 1) > 0.8) .* randn(n, 1) / sqrt(n);
b = Ad * x_true + 0.5 * randn(m, 1);
gammas = linspace(1, 10, 11);

% OSQP data
P = blkdiag(sparse(n, n), speye(m), sparse(n, n));
q = zeros(2*n+m, 1);
A = [Ad, -speye(m), sparse(m,n);
    speye(n), sparse(n, m), -speye(n);
    speye(n), sparse(n, m), speye(n);];
l = [b; -inf*ones(n, 1); zeros(n, 1)];
u = [b; zeros(n, 1); inf*ones(n, 1)];

% Create an OSQP object
prob = osqp;

% Setup workspace
prob.setup(P, q, A, l, u, 'warm_start', true);

% Solve problem for different values of gamma parameter
for i = 1 : length(gammas)
    % Update linear cost
    gamma = gammas(i);
    q_new = [zeros(n+m,1); gamma*ones(n,1)];
    prob.update('q', q_new);

    % Solve
    res = prob.solve();
end