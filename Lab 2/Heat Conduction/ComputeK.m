function K = ComputeK(COOR,CN,TypeElement, ConductMglo)
%%%%
% This subroutine   returns the global conductance matrix K (nnode x nnode)
% Inputs
% --------------
% 1. Finite element mesh
% -------------------
% COOR: Coordinate matrix (nnode x ndim)
% CN: Connectivity matrix (nelem x nnodeE)
% TypeElement: Type of finite element (quadrilateral,...)
% -----------
% 2. Material
% -----------
%  ConductMglo (ndim x ndim x nelem)  % Array of conductivity matrices
%%%%
 if nargin == 0
     load('tmp1.mat')
 end

% Dimensions of the problem
nnode = size(COOR,1); ndim = size(COOR,2); nelem = size(CN,1); nnodeE = size(CN,2);
TypeIntegrand = 'K';
[weig,posgp,shapef,dershapef] = ComputeElementShapeFun(TypeElement,nnodeE,TypeIntegrand);

% Assembly of matrix K
% ----------------
K = sparse(nnode,nnode) ;
for e = 1:nelem
    CNloc = CN(e, :); %Coordinates of the nodes of each element  
    Xe = COOR(CNloc, :)'; %Computation of elemental conductance matrix
    Ke = ComputeKeMatrix(ConductMglo(:,:,e) , weig , dershapef , Xe);
    for a = 1:nnodeE
        for b = 1:nnodeE
            A = CN(e, a);
            B = CN(e, b);
            K(A, B) = K(A, B) + Ke(a, b);
        end
    end
end