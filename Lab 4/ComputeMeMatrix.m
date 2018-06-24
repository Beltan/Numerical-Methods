function Me = ComputeMeMatrix(dens,weig,dershapef,Xe,Ne)
% Given  % dens: Density Matrix
% weig: Vector of Gauss weights (1xngaus)
% dershapef: Array with the derivatives of shape functions, with respect to  element coordinates (ndim x nnodeE x ngaus)
% Xe: Global coordinates of the nodes of the element 
% This function returns the element mass matrix Me
ndim = size(Xe,1) ; ngaus = length(weig) ; nnodeE = size(Xe,2)  ;  
Me = zeros(nnodeE*ndim,nnodeE*ndim) ; 
for  g = 1:ngaus
    BeXi = dershapef(:,:,g) ; % Matrix of derivatives for Gauss point "g"
    Je = Xe*BeXi' ; % Jacobian Matrix
    detJe = det(Je) ; % Jacobian
    shapef=Ne(:,:,g); % Matrix of derivatives with respect to physical coordinates 
    Me = Me + weig(g)*detJe*(shapef'*dens*shapef) ; 
end