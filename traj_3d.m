clc;clear;close all
%%
save_path = 'E:/QT/Resonator/Resonator/data/';
%%
N = 600;
theta = linspace(0,6*pi,N)';
[xcn,ycn] = sp.get_sphere_in(N);
%%
Wcn = repmat(xcn,N,1);
Tcn = repmat(theta,1,N);
Zcn = repmat(ycn,N,1);  
%%
[Xcn,Ycn,~] = pol2cart(Tcn,Wcn,Zcn);
[row,col] = size(Xcn);
LL = min(size(Xcn));
idx_curve = (1+row)*(1:LL)-row;
%%
tr = Tcn(idx_curve); wr = Wcn(idx_curve);
%%
xr = Xcn(idx_curve);yr = Ycn(idx_curve);zr = Zcn(idx_curve);
%%
surf(Xcn,Ycn,Zcn,'EdgeColor','None')
colormap jet
axis equal
xlabel('X(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')
hold on
plot3(xr,yr,zr,'k.')
axis equal
%%
dt = 1;
A = [1,dt;0,1];
A = blkdiag(A,A,A);
H = [1,0,0,0,0,0;0,0,1,0,0,0;0,0,0,0,1,0];
P = diag([5e+7,3e+7,5e+7,3e+7,5e+7,3e+7])/1000;
Q = eye(6);
R = 1.5*10^6*eye(3);

%%
x0 = [Wcn(LL,LL),0,Tcn(LL,LL),0,Zcn(LL,LL),0];
Rb = 1.5;
xprev = x0';
Xp = zeros(6,LL);
for k = 1:LL
    xpred = A*xprev;
    P = A*P*A'+Q;
    xprev = xpred;
    Y = [Wcn(end-k+1,end-k+1),Tcn(end-k+1,end-k+1),Zcn(end-k+1,end-k+1)]';
    K = P*H'/(H*P*H'+R);
    xpred = xprev + K*(Y - H*xprev);
    P = (eye(6)-K*H)*P;
    Xp(:,k) = xpred;
    xprev = xpred;
    pause(0.1)
    clf
    surf(Xcn,Ycn,Zcn,'EdgeColor','None')
    hold on
    plot3(xr,yr,zr,'k-','LineWidth',1.5)
    [x,y,z] = pol2cart(Xp(3,k),Xp(1,k)+Rb,Xp(5,k));
    sp.vis_ball(x,y,z,Rb);
    view([1,1,3])
    axis equal
    grid on
    colormap jet
end
%%
plot(1:10);