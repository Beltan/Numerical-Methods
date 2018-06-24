function Ke  =  ComputeKeMatrix( ConductM , weig , dershapef , Xe )
%ConductM: Conductivity Matrix
%weig: Vector of Gauss weighs
%dershapef: Array with the derivatives of shape functions
%Xe: Global Coordinates
ngaus  = length ( weig );
nnodeE  = size( Xe , 2 );
Ke  = zeros( nnodeE , nnodeE );
for g = 1 : ngaus
    BeXi  =  dershapef( : , : , g); %Matrix of derivatives for each Gauss point
    Je  =  Xe*BeXi'; %Jacobian Matrix
    detJe = det( Je ); %Jacobian Calculation
    Be  = inv( Je )'*BeXi; %Matrix of derivatives respect to physical coordinates
    Ke  =  Ke  +  weig ( g )*detJe*(Be'*ConductM*Be);
end

