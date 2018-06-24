function [weig,posgp,shapef,dershapef] = Hexahedra8NInPoints
% This function returns, for each 8-node hexaedra elements, 
% and using a 2x2x2 Gauss rule (ngaus=8): 
%
% weig = Vector of Gauss weights (1xngaus)
% posgp: Position of Gauss points  (ndim x ngaus)
% shapef: Array of shape functions (ngaus x nnodeE)
% dershape: Array with the derivatives of shape functions, with respect to
% element coordinates (ndim x nnodeE x ngaus)

%switch TypeIntegrand
%    case {'K','RHS'}
        % Four integration points
        weig  = [1 1 1 1 1 1 1 1] ;
        posgp = 1/sqrt(3)*[-1 1 1 -1 -1 1 1 -1
            -1 -1 1 1 -1 -1 1 1
            -1 -1 -1 -1 1 1 1 1];
        ndim = 3; nnodeE = 8 ;
        ngaus = length(weig) ;
        shapef = zeros(ngaus,nnodeE) ;
        dershapef = zeros(ndim,nnodeE,ngaus) ;
        for g=1:length(weig) ;
            xiV = posgp(:,g) ;
            [Ne, BeXi] = Hexahedra8N(xiV) ;
            shapef(g,:) = Ne ;
            dershapef(:,:,g) = BeXi ;
        end
%end