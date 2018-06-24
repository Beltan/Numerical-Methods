function [dy] = YDisplacements(d)
n = length(d)/3;
for i = 1:n % Displacments in the y node
    dy(n-(i-1),1) = d((i-1)*3+2,1);
end
end
