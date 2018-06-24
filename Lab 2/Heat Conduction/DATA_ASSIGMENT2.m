clc;clear;
if exist('ElemBnd')==0
    addpath('ROUTINES_AUX') ; % Add the functions inside the folder
end
% Inputs example assigment 2 
% ----------------------------
%%%%%%%%%%%%%%%%%
 % ---------------
% 1.  Finite element mesh:  COORDINATES AND CONNECTIVITIES for both the volume domain and the boundary domain
% OUTPUT: COOR,CN,TypeElement,CONNECTb,TypeElementB
NameFileMesh = 'mallanostra900.msh'; % Name of the file containing the mesh information (Generated with GID)
[COOR,CN,TypeElement,CONNECTb,TypeElementB] = ReadMeshFile(NameFileMesh);

nnode = size(COOR,1) ;% Number of nodes 

% 2. MATERIAL PROPERTIES: output ConductMglo  
%-----------------------
ndim = size(COOR,2); % Number of spatial dimensions (ndim=2 for 2D problems)
nelem = size(CN,1) ; % Number of elements
ConductMglo = zeros(ndim,ndim,nelem) ; 
% Conductivity matrix (isotropic)
kappa =  10  ; %  W/ºC
ConductM = kappa*eye(ndim) ; % eye = IDENTITY MATRIX
for e=1:nelem 
    ConductMglo(:,:,e) = ConductM ; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Dirichlet (essential) boundary conditions, OUTPUT: dR and rnod
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List of nodes at which temperature is prescribed
%   Copy here the list of nodes from GID
rnod =[1         0.0 0.0 0.0
2         0.0 0.0333333333 0.0
3         0.0 0.0666666667 0.0
4         0.0666666667 0.0166666667 0.0
6         0.0 0.1 0.0
8         0.0 0.133333333 0.0
10         0.133333333 0.0333333333 0.0
14         0.0 0.166666667 0.0
17         0.0 0.2 0.0
18         0.2 0.05 0.0
23         0.0 0.233333333 0.0
28         0.0 0.266666667 0.0
30         0.266666667 0.0666666667 0.0
36         0.0 0.3 0.0
42         0.0 0.333333333 0.0
44         0.333333333 0.0833333333 0.0
51         0.0 0.366666667 0.0
59         0.0 0.4 0.0
62         0.4 0.1 0.0
69         0.0 0.433333333 0.0
78         0.0 0.466666667 0.0
84         0.466666667 0.116666667 0.0
90         0.0 0.5 0.0
101         0.0 0.533333333 0.0
108         0.533333333 0.133333333 0.0
114         0.0 0.566666667 0.0
128         0.0 0.6 0.0
135         0.6 0.15 0.0
142         0.0 0.633333333 0.0
158         0.0 0.666666667 0.0
167         0.666666667 0.166666667 0.0
172         0.0 0.7 0.0
189         0.0 0.733333333 0.0
201         0.733333333 0.183333333 0.0
207         0.0 0.766666667 0.0
226         0.0 0.8 0.0
241         0.8 0.2 0.0
246         0.0 0.833333333 0.0
265         0.0 0.866666667 0.0
283         0.866666667 0.216666667 0.0
285         0.0 0.9 0.0
308         0.0 0.933333333 0.0
327         0.933333333 0.233333333 0.0
331         0.0 0.966666667 0.0
355         0.0 1.0 0.0
376         1.0 0.25 0.0
417         1.06666667 0.266666667 0.0
457         1.13333333 0.283333333 0.0
493         1.2 0.3 0.0
531         1.26666667 0.316666667 0.0
566         1.33333333 0.333333333 0.0
601         1.4 0.35 0.0
638         1.46666667 0.366666667 0.0
671         1.53333333 0.383333333 0.0
705         1.6 0.4 0.0
738         1.66666667 0.416666667 0.0
772         1.73333333 0.433333333 0.0
806         1.8 0.45 0.0
839         1.86666667 0.466666667 0.0
873         1.93333333 0.483333333 0.0
906         2.0 0.5 0.0];  
rnod =rnod(:,1); % Obtain only the nodes  

% Prescribed temperature 
temp_DAB = 0 ; % Degrees Celsius 
% Vector of prescribed temperatures
dR = temp_DAB*ones(size(rnod)) ; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Neumann (natural) boundary conditions : OUTPUT: qFLUXglo, CNb
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List of boundary nodes whose boundary elements have prescribed heat flux
% (different from zero !)
% Edge DC 
% Copy here the list of nodes from GID
NODESb = [355         0.0 1.0 0.0
358         0.0666666667 1.0 0.0
362         0.133333333 1.0 0.0
368         0.2 1.0 0.0
380         0.266666667 1.0 0.0
393         0.333333333 1.0 0.0
406         0.4 1.0 0.0
419         0.466666667 1.0 0.0
439         0.533333333 1.0 0.0
456         0.6 1.0 0.0
476         0.666666667 1.0 0.0
496         0.733333333 1.0 0.0
520         0.8 1.0 0.0
542         0.866666667 1.0 0.0
564         0.933333333 1.0 0.0
589         1.0 1.0 0.0
613         1.06666667 1.0 0.0
636         1.13333333 1.0 0.0
663         1.2 1.0 0.0
689         1.26666667 1.0 0.0
715         1.33333333 1.0 0.0
741         1.4 1.0 0.0
768         1.46666667 1.0 0.0
796         1.53333333 1.0 0.0
823         1.6 1.0 0.0
851         1.66666667 1.0 0.0
877         1.73333333 1.0 0.0
905         1.8 1.0 0.0
934         1.86666667 1.0 0.0
952         1.93333333 1.0 0.0
961         2.0 1.0 0.0] ; 
%
NODESb = NODESb(:,1) ; % Obtain only the nodes
% Connectivity matrix for boundary elements (Neumann boundary)
CNb = ElemBnd(CONNECTb,NODESb) ; 
% prescribed flux (constant)
qBAR = -20 ; % W/m
% Global vector of 
qFLUXglo = qBAR*ones(size(CNb)) ; 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Heat source
%%
f = 4 ; %   W/m2
% Global vector of heat sources (constant)
fNOD = f*ones(nnode,1) ; 
