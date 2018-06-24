function Ne = ComputeNe(ndim,nnodeE,weig,shapef)
Ne=zeros(ndim,nnodeE,length(weig));
for i=1:length(weig)
    for j=1:ndim
        for k=1:length(weig)
              if (j==1)
                  Ne(j,3*k-2,i) = shapef(i,k) ;
              elseif (j==2)
                  Ne(j,3*k-1,i) = shapef(i,k) ;
              else
                  Ne(j,3*k,i) = shapef(i,k);
              end
        end
    end
end