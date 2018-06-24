clc
clear all
% Finite Element Program for Elastostatic problems  
% ECA.
% Technical University of Catalonia
% JoaquIn A. Hdez, October 23-th, 2015
% ---------------------------------------------------
if exist('ElemBnd')==0
    addpath('ROUTINES_AUX') ;
end

 
%%% INPUT  %%% 
% Input data file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NAME_INPUT_DATA = 'BEAM3D' ;  % Name of the mesh file 
%------------------------------------------------------

% PREPROCESS  
[COOR,CN,TypeElement,TypeElementB, celasglo,  DOFr,dR,...  
    Tnod,CNb,fNOD,Fpnt,NameFileMesh,typePROBLEM,celasgloINV, BoundaryNodes, eignumb, densglo] = ReadInputDataFile(NAME_INPUT_DATA)  ; 

% SOLVER 
% --------------------------------------------
[d, strainGLO, stressGLO,  React, posgp, Ftrac, DOFl, Mll, Kll]= SolveElastFE(COOR,CN,TypeElement,...
TypeElementB, celasglo, DOFr, dR, Tnod,CNb,fNOD,Fpnt,typePROBLEM,celasgloINV, densglo)  ; 

% POSTPROCESS
% --------------------------------------------
GidPostProcess(COOR,CN,TypeElement,d,strainGLO, stressGLO,  React,NAME_INPUT_DATA,posgp,NameFileMesh);