% Generate problem data
rng(1)
m = 30;
n = 20;
Ad = sprandn(m, n, 0.7);
b = randn(m, 1);

% OSQP data
P = blkdiag(sparse(n, n), speye(m));
q = zeros(n+m, 1);
A = [Ad, -speye(m);
     speye(n), sparse(n, m)];
l = [b; zeros(n, 1)];
u = [b; ones(n, 1)];

% Create an OSQP object
prob = osqp;

% Setup workspace
prob.setup(P, q, A, l, u);

% Solve problem
res = prob.solve();