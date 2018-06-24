function [reg_f_coeff, reg_der_coeff] = error_computation(ncomputations)

% Gauss Quadrature points and weights
m = 5;
xi_g = [-1/21*sqrt(245+14*sqrt(70)) -1/21*sqrt(245-14*sqrt(70)) 0 1/21*sqrt(245-14*sqrt(70)) 1/21*sqrt(245+14*sqrt(70))];
w = [1/900*(322-13*sqrt(70)) 1/900*(322+13*sqrt(70)) 128/225 1/900*(322+13*sqrt(70)) 1/900*(322-13*sqrt(70))];

% Number of elements for each computation = 10^i_comptutation
nelem = zeros(ncomputations,1);
for i = 1:ncomputations
    nelem(i) = 10^i;
end

error_function = zeros(ncomputations,1);
error_derivative = zeros(ncomputations,1);

% For all the computations
for i = 1:ncomputations    
    [COOR, d] = solve_BVP(nelem(i), false); % Solve for the elements specified but do not plot
    h = COOR(2) - COOR(1);
    
    error_f = 0; 
    error_der = 0;
    
    % For all the elements
    for e=1:nelem(i)
        
        % Integral accumulators
        sum_f = 0;
        sum_der = 0;        
        
        % Gauss quadrature
        for g = 1:m 
            xi = xi_g(g);
            Ne = 0.5*[1-xi, 1+xi]; 
            Be = 1/h*[-1 1]; 
            
            pos_eq = Ne*[COOR(e) COOR(e+1)]'; % Equivalent position of the gauss point
            
            % Approximate solutions of the function and its derivative
            uh_f=Ne*[d(e) d(e+1)]'; 
            uh_der=Be*[d(e) d(e+1)]';
            % Exact solutions of the function and its derivative
            lambda = pi^2;
            u_f = cos(sqrt(lambda)*pos_eq) + pos_eq^2/lambda - 2/lambda^2;
            u_der = -sqrt(lambda)*sin(sqrt(lambda)*pos_eq) + 2*pos_eq/lambda;
            
            % Error integral of the function calculation
            sum_f = sum_f + 0.5*h*w(g)*(u_f-uh_f)^2;
            % Error integral of the derivative function calculation
            sum_der = sum_der + 0.5*h*w(g)*(u_der-uh_der)^2;
        end
    % Accumulate the errors
    error_f = error_f + sum_f;
    error_der = error_der + sum_der;
    end
    
    error_function(i) = sqrt(error_f);
    error_derivative(i) = sqrt(error_der);
end

% Plots
figure
plot(log10(nelem), log10(error_function), log10(nelem), log10(error_derivative));
legend('Function','Derivative of the function');
title('Error vs number of elements');
xlabel('log(n)');
ylabel('log(error)');

reg_f = regstats(log10(error_function), log10(nelem));
reg_der = regstats(log10(error_derivative), log10(nelem));
reg_f_coeff = reg_f.beta; % Regression coefficients
reg_der_coeff = reg_der.beta;