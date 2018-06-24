clc
% Finite Element Program for Modal problems  
% ECA.
% Polytechnical University of Catalonia
% ---------------------------------------------------
if exist('ElemBnd')==0
    addpath('ROUTINES_AUX') ;
end
 
%%% INPUT  %%% 
% Input data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DATA.nMODESplot = 6;
NAME_INPUT_DATA = 'BEAM3D' ;  % Name of the mesh file 
%------------------------------------------------------

% PREPROCESS  
[COOR,CN,TypeElement,TypeElementB, celasglo,  DOFr,dR, Tnod,CNb,fNOD,Fpnt,NameFileMesh,...
    typePROBLEM,celasgloINV, BoundaryNodes, eignumb] = ReadInputDataFile(NAME_INPUT_DATA)  ; 

% SOLVER 
% --------------------------------------------
[Modes, omega]= SolveModes(Mll, Kll, eignumb)  ; 

% POSTPROCESS
% --------------------------------------------
GidPostProcessModes(COOR,CN,TypeElement,Modes,posgp,NameFileMesh,DATA,DOFl); 