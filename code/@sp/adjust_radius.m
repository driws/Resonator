function data = adjust_radius(data,R0,mode)
if nargin<3
    mode = 0;
end
[xfit,yfit,Rfit] = sp.fit_sphere(data);
if mode
    R0 = Rfit + R0;
end
data = data - [xfit,yfit];
L = sqrt(sum(data.^2,2));
runout = L - Rfit;
data = data.*(R0+runout)./L + [xfit,yfit];
end