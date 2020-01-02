function varargout = fit_line_3d(data)
if size(data,1)==3
    data = data';
end
L = length(data);
Xfit = [data(:,3),ones(L,1)]; Yfit = data(:,1:2);
A = (Xfit'*Xfit)\Xfit'*Yfit;
A = A([2,4,1,3]);
varargout = num2cell(A(:));
end