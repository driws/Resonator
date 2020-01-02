function varargout = get_roundness(data)
[xfit,yfit,Rfit] = sp.fit_sphere(data);
data = data - [xfit,yfit];
L = sqrt(sum(data.^2,2)) - Rfit;
varargout = {L,xfit,yfit,Rfit};
end