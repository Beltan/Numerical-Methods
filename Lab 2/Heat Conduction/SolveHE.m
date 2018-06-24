function [d qheatGLO posgp] = SolveHE(K,Fs,Fbnd,dR,rnod,COOR,CN,TypeElement,ConductMglo) ; 
% This function returns  n returns the (nnode x 1) vector of nodal temperatures (d),
% as well as the vector formed by the heat flux vector at all gauss
%%% points  (qheatGLO)
% Input data
% K = Global conductance matrix   (nnode x nnode)
% Fs = Global source flux vector  (nnode x 1)
% Fbnd = Global boundary flux vector  (nnode x 1)
% rnod = Set of nodes at which temperature is prescribed 
% dR = Vector of prescribed displacements 
% ----------------------
nnode = size(COOR,1); ndim = size(COOR,2); nelem = size(CN,1); nnodeE = size(CN,2) ;     posgp=[] ;

lnod = 1:nnode ; 
lnod(rnod) = [] ;

% Solution of the system of FE equation
% Right-hand side 
F = Fs + Fbnd ; 
Fl = F(lnod);
% Set of nodes at which temperature is unknown 
Kll = K(lnod, lnod);
Klr = K(lnod, rnod);
dL = Kll\(Fl-Klr*dR);
if ~any(K)
    warning('You must code the equation dL =  Kll^{-1}*(Fl -Klr*dR) ')
    dL = zeros(size(lnod));   
end
 
% Vector of   temperatures 
d = zeros(nnode,1) ; 
d(lnod)= dL ; 
d(rnod) = dR ;

%%%% Computation of heat flux vector at each gauss point 
disp('Computation of heat flux vector at each gauss point and elements')
ngaus = 4; qheatGLO = zeros(ngaus*ndim,nelem); 
% Computing this array is not mandatory.... 
%[qheatGLO posgp]= HeatFlux(COOR,CN,TypeElement,ConductMglo,d) ; 

