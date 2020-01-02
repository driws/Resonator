classdef plt
    methods (Static)
        function [] = makeGif(filename,num,dirs,dt)
            if nargin < 4
                dt = 0.01;
            end
            for i = 1:num
                picname=[dirs,num2str(i),'.fig'];
                open(picname)
                set(gcf,'outerposition',[100,100,500,500]);
                frame=getframe(gcf); 
                im=frame2im(frame);
                [I,map]=rgb2ind(im,256);          
                if i==1
                    imwrite(I,map,filename,'gif', 'Loopcount',inf,'DelayTime',dt);
                else
                    imwrite(I,map,filename,'gif','WriteMode','append','DelayTime',dt);
                end
                close all
%                 delete(picname) 
            end
        end
        
        function [] = makeVideo(filename,num,dirs,frame)
            if nargin < 4
                frame = 24;
            end
            aviobj = VideoWriter(filename,'MPEG-4');
            aviobj.FrameRate = frame;
            open(aviobj)
            for i = 1:num
                if mod(i,10) == 0
                    disp(i)
                end
                frame = imread([dirs,num2str(i),'.jpg']);
                writeVideo(aviobj,frame);
            end
            close(aviobj)
        end
        
        function varargout = plot3(data,color)
            if nargin < 2
                color = [0,0.447,0.812];
            end
            H = plot3(data(:,1),data(:,2),data(:,3),'.','Color',color);
            axis equal
            grid on
            xlabel('x')
            ylabel('y')
            zlabel('z')
            if nargout >0
                varargout{1} = H;
            else
                varargout = {};
            end
        end
        
        
        function varargout = vis_circle(x,y,Rc,mode)
            if nargin < 4
                mode = 'n';
            end
            theta = linspace(0,2*pi,100);
            xc = Rc*cos(theta);  yc = Rc*sin(theta);
            if mode == 'n'
                H = plot(x+xc,y+yc,'r.','LineWidth',1.5);
            else
                H = fill(x+xc,y+yc,'r','EdgeColor','None');
            end
            varargout = {H};
            varargout = varargout(1:nargout);
        end
        
        function varargout = vis_ball(x,y,z,Rc,color)
            if nargin < 5
                color = [0,0.447,0.714];
            end
            [X,Y,Z] = sphere(100);
            X = X*Rc+x;
            Y = Y*Rc+y;
            Z = Z*Rc+z;
            H = surf(X,Y,Z,'EdgeColor','None','FaceColor',color);
            varargout = {H};
            varargout = varargout(1:nargout);
        end
        
        
        function name = get_var_name(varargin)
            name = inputname(1);
        end
    end
end