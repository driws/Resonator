function data_sp = get_data_from_image(input_path,txtname,varargin)
Arg = {'R',3,0};
for k = 1:length(varargin)
    Arg{k} = varargin{k};
end
[prefix,R_ref] = Arg{1:2};
if prefix == 'R'
    dst_pos = Arg{3};
    R_touch = 0;
else
    R_touch = Arg{3};
    dst_pos = 0;
end
data_sp = zeros(10000,3);
start_idx = 1;
touch_pt = importdata(fullfile(input_path,txtname));
touch_pt(:,1) = touch_pt(:,1) + linspace(0,dst_pos,size(touch_pt,1))';
for k = 1:length(touch_pt)
picname = sprintf('%s/%s%d.png',input_path,prefix,k);
I = imread(picname);    
rect = [630,320,630,630];
I = imcrop(I,rect);
Ip = I(:,:,2) - I(:,:,1);
Ib = imbinarize(Ip);
[yr,xr] = find(Ib);
[xfit,yfit,Rfit] = sp.fit_sphere(xr,yr);
if prefix == 'C'
    R0 = abs(touch_pt(k,2) - R_touch) - R_ref;
else
    R0 = R_ref;
end
data = [xr,yr] - [xfit,yfit];
L = sqrt(sum(data.^2,2));
pix_dis_prop = (touch_pt(k,3)-touch_pt(k,4))/(max(L) - min(L))*1e-1;
Rr = (L - Rfit)*pix_dis_prop;
data = data.*(R0+Rr)./L + [xfit,yfit]*pix_dis_prop;
m = length(data);
data_sp(start_idx:start_idx+m-1,:) = [data,touch_pt(k,1)*ones(length(data),1)];
start_idx = start_idx + m;
end
data_sp(all(data_sp==0,2),:) = [];
end