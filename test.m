clc;close all;clear;
%%
input_path = 'data/date/1228/';
%%
data_sp = sp.get_data_from_image(input_path,'sp_in.txt','C',3,26.307);
data_cy = sp.get_data_from_image(input_path,'cy_in.txt','R',3,4.146);
%%  
[xfit,yfit,zfit,Rfit] = sp.fit_sphere(data_sp);
%%
% plt.plot3(data_sp);
% hold on
plt.plot3(data_cy);