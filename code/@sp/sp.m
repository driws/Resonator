classdef sp
    methods (Static)     
        function [xcn,ycn] = get_corner_in(N)
            load('data\cons.mat','Rcy','Rcn','y0_in');
            xcn = Rcy + Rcn + Rcn*cos(linspace(-pi/2,-pi,N));%asin((y_in-y0_in)/Rcn)
            ycn = y0_in - sqrt(Rcn^2-(xcn-Rcn-Rcy).^2);
        end
        
        function [xcn,ycn] = get_sphere_in(N)
            load('data\cons.mat','Rsp_in','Rsp_out','x_in');
            xcn = Rsp_in*cos(linspace(0,-pi/2+asin(x_in/Rsp_in),N));
            ycn = Rsp_out - sqrt(Rsp_in^2-xcn.^2);
        end
        
        function [xcn,ycn] = get_sphere_out(N)
            load('data\cons.mat','Rsp_out','x_out');
            xcn = Rsp_out*cos(linspace(-pi/2+asin(x_out/Rsp_out),0,N));
            ycn = Rsp_out - sqrt(Rsp_out^2-xcn.^2);
        end
        
        function varargout = fit_sphere(varargin)
            %xn的大小nx1
            if length(varargin) == 1
                data = varargin{1};
            else
                data = cell2mat(varargin);
            end
            [row,col] = size(data);
            if row < col
                error('矩阵的行没有对应数据点数，数据点太少')
            end
            Yfit = sum(data.^2,2);
            Xfit = [data*2,ones(size(data,1),1)];
            omega = (Xfit'*Xfit)\Xfit'*Yfit;
            R = sqrt(omega(end)+sum(omega(1:end-1).^2));
            varargout = num2cell([omega(1:end-1);R]);
        end
        
        function [] = save_data(filename,varargin)
            if nargin > 2
                N = length(varargin);
                [m,n] = size(varargin{1});
                if m == 1
                    L = n;
                    data = cell2mat(varargin')';
                else
                    L = m;
                    data = cell2mat(varargin);
                end
            else
                data = varargin{1};
                [m,n] = size(data);
                if m>n
                    L = m; N = n;
                else
                    L = n; N = m; data = data';
                end
            end
            fid = fopen(filename,'w');
            for k = 1:L
                for m = 1:N
                    fprintf(fid,'%.4f ',data(k,m));
                end
                fprintf(fid,'\r\n');
            end
        end
        
        %begin_of_out_file
        data = adjust_radius(data,R0,mode)
        distance = dis_to_line_3d(data,x0,y0,a,b)
        varargout = fit_line_3d(data)
        data_sp = get_data_from_image(input_path,txtname,varargin)
        varargout = get_roundness(data)
        [] = update_func()

        %end_of_out_file
    end
end
