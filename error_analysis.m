clc;clear;close all
%%
N = 600;
theta = linspace(0,6*pi,N)';
[xcn,ycn] = sp.get_corner_in(N);
%%
Wcn = repmat(xcn,N,1);
Tcn = repmat(theta,1,N);
Zcn = repmat(ycn,N,1);  
%%
[Xcn,Ycn,~] = pol2cart(Tcn,Wcn,Zcn);
[row,col] = size(Xcn);
LL = min(size(Xcn));
idx_curve = (1+row)*(1:LL)-row;
wr = Wcn(idx_curve);tr = Tcn(idx_curve);zr = Zcn(idx_curve);
%%
noise_w = (rand(size(wr))*2 - 1)*0.005;
noise_z = (rand(size(wr))*2 - 1)*0.005;
wr = wr + noise_w;
zr = zr + noise_z;
%%
[xr,yr,zr] = pol2cart(tr,wr,zr);
%%
[xr0,yr0,R] = sp.fit_sphere([wr;zr]');
%%
