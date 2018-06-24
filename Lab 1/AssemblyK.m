function K = AssemblyK(COOR, CN, lambda)
nelem = size(CN, 1); nnode = nelem+1; nnodeE = size(CN, 2);
K = sparse(nnode, nnode); % sparse matrix for better efficiency
for e = 1:nelem
    NODOSe = CN(e, :);   COOR_e = COOR(NODOSe);  he = COOR_e(2) - COOR_e(1);
    Ke = 1/he*[1 -1; -1 1] - lambda*he/6*[2 1; 1 2]; % analitical deduction
    for a = 1:nnodeE
        for b = 1:nnodeE
            A = CN(e, a);
            B = CN(e, b);
            K(A, B) = K(A, B) + Ke(a, b);
        end
    end
end

