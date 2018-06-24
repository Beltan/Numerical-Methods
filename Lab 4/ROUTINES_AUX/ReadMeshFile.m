function [COOR,CONNECT,TypeElement1,CONNECTbound,TypeElementBOUND]=...
    ReadMeshFile(nameMSH)
%%% Leer .msh
% J.A. Hernandez
% % JAHO_B
% warning('JAHO_B')
% load('/home/joaquin/USO_COMUN_MATLAB/DATA/jaho.mat')

if nargin == 0
    nameMSH = 'malla1.msh' ;
end
%3) Open file
fid=fopen(nameMSH,'r');

% First Read
%%%%%%%%%%%%
[OkFindRes RestLine] = ReadUntilToken(fid,'MESH'); % Find word "MESH"
% Data of the first mesh
[NameMesh1,ndime1,TypeElement1,nnode_elem1]=ObtInfMsh(RestLine);
%ndime1 = 3;
%nnode_elem1 = 4 ;
leido=fscanf(fid,'%s',1); %read "coordinates"
[OkFindRes ,num_nodos1] = ReadUntCount(fid,'end',ndime1+1) ;% counting nodes of mesh 1
[OkFindRes RestLine] = ReadUntilToken(fid,'Elements');
%leido=fscanf(fid,'%s',2); % read "coordinates" and "elements"
[OkFindRes ,num_elementos_1] = ReadUntCount(fid,'End',nnode_elem1+1); %% counting elements of mesh 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   boundary mesh
[OkFindRes RestLine] = ReadUntilToken(fid,'MESH'); % Find word "MESH"
% Data of the first mesh
[NameMesh1,ndime1,TypeElementBOUND,nnode_elemBOUND]=ObtInfMsh(RestLine);
[OkFindRes RestLine] = ReadUntilToken(fid,'Elements');

%leido=fscanf(fid,'%s',2); % read "coordinates" and "elements"
[OkFindRes ,num_elementosBOUND] = ReadUntCount(fid,'End',nnode_elemBOUND+1); %% counting elements of mesh 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% there's no second mesh
% Global Arrays
nmeshes = 1;
NameMeshes ={NameMesh1};
ndim       = ndime1;
nnode_elem = nnode_elem1;
num_elementos = num_elementos_1;
num_nodos = [num_nodos1];
%
%
% fclose(fid);
%
% % End of first lecture
%
% %%%%%%%% For storing information (structure)
%
% coordenadas = InitStrucField(NameMeshes,num_nodos,ndim+1);
% conexiones  = InitStrucField(NameMeshes,num_elementos,nnode_elem+1);
% material    = InitStrucField(NameMeshes,num_elementos,2*ones(nmeshes,1));

% Second lecture (storing)
fid=fopen(nameMSH,'r');
%% Lectura elementos y material(malla 1)
imesh = 1;
[OkFindRes RestLine] = ReadUntilToken(fid,'MESH');

% Coord
leido=fscanf(fid,'%s',1);  % read "coordinates"
COOR=leer_fichero_colum('',ndim(imesh)+1,0,num_nodos(imesh),0,0,fid);

COOR = COOR(:,2:end) ; 
if ~any(COOR(:,end)) 
 COOR = COOR(:,1:end-1);
end

% Conex
%dummy=fscanf(fid,'%s',3); % read "end coordinates" and "elements"
[OkFindRes RestLine] = ReadUntilToken(fid,'Elements');
CONNECT=leer_fichero_colum('',nnode_elem(imesh)+1,0,num_elementos(imesh),0,0,fid);
CONNECT = CONNECT(:,2:end) ; 
%
%% Boundary mesh  
imesh = 1;
[OkFindRes RestLine] = ReadUntilToken(fid,'MESH');

% % Coord
% leido=fscanf(fid,'%s',1);  % read "coordinates"
% COOR=leer_fichero_colum('',ndim(imesh)+1,0,num_nodos(imesh),0,0,fid);

% Conex
%dummy=fscanf(fid,'%s',3); % read "end coordinates" and "elements"
[OkFindRes RestLine] = ReadUntilToken(fid,'Elements');
CONNECTbound=leer_fichero_colum('',nnode_elemBOUND+1,0,num_elementosBOUND,0,0,fid);
CONNECTbound = CONNECTbound(:,2:end) ; 
fclose(fid);
