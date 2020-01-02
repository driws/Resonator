function distance = dis_to_line_3d(data,x0,y0,a,b)
c = 1;
Sx = data(:,1) - x0; Sy = data(:,2) - y0; Sz = data(:,3);
M = [Sy*c-Sz*b,Sz*a-Sx*c,Sx*b-Sy*a];
V = sqrt(a^2+b^2+c^2);
distance = sqrt(sum(M.^2,2))/V;
end