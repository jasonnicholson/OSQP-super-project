% Generate problem data
rng(1)
n = 10;
m = 100;
Ad = sprandn(m, n, 0.5);
x_true = randn(n, 1) / sqrt(n);
ind95 = rand(m, 1) > 0.95;
b = Ad*x_true + 10*rand(m, 1).*ind95 + 0.5*randn(m, 1).*(1-ind95);

% OSQP data
Im = speye(m);
Om = sparse(m, m);
Omn = sparse(m, n);
P = blkdiag(sparse(n, n), 2*Im, sparse(2*m, 2*m));
q = [zeros(m + n, 1); 2*ones(2*m, 1)];
A = [Ad,  -Im, -Im, Im;
     Omn,  Om,  Im, Om;
     Omn,  Om,  Om, Im];
l = [b; zeros(2*m, 1)];
u = [b; inf*ones(2*m, 1)];

% Create an OSQP object
prob = osqp;

% Setup workspace
prob.setup(P, q, A, l, u);

% Solve problem
res = prob.solve();