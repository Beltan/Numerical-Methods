function [Modes, omega]= SolveModes(Mll, Kll, eignumb) 
[Modes, eigval] = eigs(Kll,Mll,eignumb,'sm'); % Smallest magnitude eigenvalues
eigval = diag(eigval);
omega = sqrt(eigval);
[omega, modes_order] = sort(omega);
Modes = Modes(:,modes_order);
end