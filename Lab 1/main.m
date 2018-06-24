clc; clear; close all;

% n = {5, 10, 50} (number of elements)
% Compute the solution and plot it for the number of elements specified
solve_BVP(5, true);
solve_BVP(10, true);
solve_BVP(50, true);

% Error computation
ncomputations = 4; % 10 100 1000 10000 elements
[reg_f_coeff, reg_der_coeff] = error_computation(ncomputations)