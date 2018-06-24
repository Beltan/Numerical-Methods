function [ResReact] = ResReact(React, Ftrac, COOR, BoundaryNodes)
ymax = max(COOR(BoundaryNodes,2)); ymax = ymax(1); % Maximmum y coordinate
zmax = max(COOR(BoundaryNodes,3)); zmax = zmax(1); % Maximmum z coordinate
ymin = min(COOR(BoundaryNodes,2)); ymin = ymin(1); % Minimmum y coordinate
zmin = min(COOR(BoundaryNodes,3)); zmin = zmin(1); % Minimmum z coordinate
ymed = (ymax-ymin)/2; % Center y coordinate
zmed = (zmin-zmax)/2; % Center z coordinate
lenghtReact = length(React)/3;
Rx = 0;
Ry = 0;
Rz = 0;
MRx = 0;
for i = 1:lenghtReact % Computation of the resultant reactions
    Rx = Rx+React((i-1)*3+1,1);
    Ry = Ry+React((i-1)*3+2,1);
    Rz = Rz+React((i-1)*3+3,1);
    MRx = MRx+React((i-1)*3+3,1)*(COOR(i,2)-ymed);
    MRx = MRx-React((i-1)*3+2,1)*(COOR(i,3)-zmed);
end
lenghtFtrac = length(Ftrac)/3;
Fx = 0;
Fy = 0;
Fz = 0;
Mx = 0;
for i = 1:lenghtFtrac % Computation of the resultant forces
    Fx = Fx+Ftrac((i-1)*3+1,1);
    Fy = Fy+Ftrac((i-1)*3+2,1);
    Fz = Fz+Ftrac((i-1)*3+3,1);
    Mx = Mx+Ftrac((i-1)*3+3,1)*(COOR(i,2)-ymed);
    Mx = Mx-Ftrac((i-1)*3+2,1)*(COOR(i,3)-zmed);
end
ResReact = [Fx Fy Fz Mx; Rx Ry Rz MRx];
end
