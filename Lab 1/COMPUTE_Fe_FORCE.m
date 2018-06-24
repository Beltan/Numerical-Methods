function Fe = COMPUTE_Fe_FORCE(COOR, e)
% Computes the element force using Gauss Quadrature
he = COOR(e+1) - COOR(e);
xi_g_1 = -1/sqrt(3);
xi_g_2 = 1/sqrt(3);
Ne_1 = 0.5*[1-xi_g_1 1+xi_g_1];
Ne_2 = 0.5*[1-xi_g_2 1+xi_g_2];
w = 1;
xe = [COOR(e) COOR(e+1)].';
xe_1 = Ne_1*xe;
xe_2 = Ne_2*xe;
fg_1 = -xe_1^2; % f = -x^2
fg_2 = -xe_2^2;
q_1 = Ne_1.'*fg_1;
q_2 = Ne_2.'*fg_2;
Fe = 0.5*he*(w*q_1 + w*q_2);
