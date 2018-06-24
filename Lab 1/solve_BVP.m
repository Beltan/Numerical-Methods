function [COOR, d] =  solve_BVP(n, plot_bool)
% This functions solves the BVP using FEM. It also plots the computed
% and exact solution for comparison
% n: number of elements

lambda = pi^2;
g = 1-2/lambda^2;
b = 2/lambda;
x_min = 0;
x_max = 1;

% Main program
COOR = linspace(x_min, x_max, n+1).';
CN = [(1:n).', (2:n+1).'];
nnodeE = size(CN, 2);
nnode = n+1;
K = AssemblyK(COOR, CN, lambda); % Global Matrix K
F_nbc = zeros(nnode, 1);
F_nbc(end) = b; % End boundary condition
F = F_nbc;
for e = 1:n
    Fe = COMPUTE_Fe_FORCE(COOR, e);
    for a = 1:nnodeE
        A = CN(e, a);
        F(A) = F(A) + Fe(a); % Assembly of F
    end
end

% Solver
h = COOR(2) - COOR(1);
% r and l sets: r = {1}  l = {2:end}
Kll = K(2:end, 2:end);
Fl = F(2:end);
Klr = K(2:end, 1);
dl = Kll\(Fl-g*Klr);
d = [g; dl];

% Plots
if plot_bool
    x = 0:0.0001:1;
    y = cos(sqrt(lambda).*x) + x.^2/lambda - 2/lambda^2;
    figure;
    plot(x,y, COOR, d);
    title('Approximated and exact solutions of the BVP');
    xlabel('x');
    ylabel('u');
    legend(sprintf('Exact Solution for n = %d', n), 'FEM solution');
end
