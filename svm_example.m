% Generate problem data
rng(1)
n = 10;
m = 1000;
N = ceil(m/2);
gamma = 1;
A_upp = sprandn(N, n, 0.5);
A_low = sprandn(N, n, 0.5);
Ad = [A_upp / sqrt(n) + (A_upp ~= 0) / n;
      A_low / sqrt(n) - (A_low ~= 0) / n];
b = [ones(N, 1); -ones(N,1)];

% OSQP data
P = blkdiag(speye(n), sparse(m, m));
q = [zeros(n,1); gamma*ones(m,1)];
A = [diag(b)*Ad, -speye(m);
     sparse(m, n), speye(m)];
l = [-inf*ones(m, 1); zeros(m, 1)];
u = [-ones(m, 1); inf*ones(m, 1)];

% Create an OSQP object
prob = osqp;

% Setup workspace
prob.setup(P, q, A, l, u);

% Solve problem
res = prob.solve();