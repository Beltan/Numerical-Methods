function  [Ne BeXi] = Hexahedra8N(xiV) 
% Shape functions and derivatives for 8-node hexaedra 
xi = xiV(1) ; eta = xiV(2) ; zeta = xiV(3); 
% Matrix of shape functions
Ne =1/8*[(1-xi)*(1-eta)*(1-zeta), (1+xi)*(1-eta)*(1-zeta), (1+xi)*(1+eta)*(1-zeta), (1-xi)*(1+eta)*(1-zeta), (1-xi)*(1-eta)*(1+zeta), (1+xi)*(1-eta)*(1+zeta),...
    (1+xi)*(1+eta)*(1+zeta), (1-xi)*(1+eta)*(1+zeta)]; 
% Matrix of the gradient of shape functions 
BeXi = 1/8*[ -(1-eta)*(1-zeta),  (1-eta)*(1-zeta),  (1+eta)*(1-zeta), -(1+eta)*(1-zeta), -(1-eta)*(1+zeta),  (1-eta)*(1+zeta),  (1+eta)*(1+zeta), -(1+eta)*(1+zeta) ; 
             -(1-xi)*(1-zeta) , -(1+xi)*(1-zeta) , (1+xi)*(1-zeta), (1-xi)*(1-zeta), -(1-xi)*(1+zeta) , -(1+xi)*(1+zeta) , (1+xi)*(1+zeta), (1-xi)*(1+zeta);
             -(1-xi)*(1-eta) , -(1+xi)*(1-eta) , -(1+xi)*(1+eta), -(1-xi)*(1+eta), (1-xi)*(1-eta) , (1+xi)*(1-eta) , (1+xi)*(1+eta), (1-xi)*(1+eta)] ; 
