function [] = update_func()
input_path = 'E:\MatlabCode\Resonator\code\@sp\';
name = 'sp.m';
new_name = 'sp_1.m';
orgname = fullfile(input_path, name);
dstname = fullfile(input_path, new_name);
backup_name = fullfile(input_path,'sp.txt');

copyfile(orgname,backup_name);
fr = fopen(orgname,'r');
fw = fopen(dstname,'w');

while true
    tline = fgetl(fr);
    if tline == -1
        break;
    end
    flag = contains(tline,'begin_of_out_file');
    if ~flag
        fprintf(fw,'%s\r\n',tline);       
    else
        fprintf(fw,'%s\r\n',tline);
        funcList = dir([input_path,'/*.m']);
        func_str = '';
        for k = 1:length(funcList)
            if strcmp(funcList(k).name,name)==0&&...
                    strcmp(funcList(k).name,new_name)==0
                
                fid = fopen(fullfile(funcList(k).folder,...
                    funcList(k).name),'r');
                tline = fgetl(fid);              
                tline = strrep(tline,'function ',repmat(' ',1,8));
                func_str = sprintf('%s%s\n',func_str,tline);
            end
        end
        fprintf(fw,'%s\r\n',func_str);
        while 1
            tline = fgetl(fr);
            flag = contains(tline,'end_of_out_file');
            if flag == 1
                fprintf(fw,'%s\r\n',tline);
                break;
            end
        end
    end
    
end

fclose(fr);
fclose(fw);

movefile(dstname,orgname)
end