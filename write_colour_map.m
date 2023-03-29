function [map] = write_colour_map(style)

%%

%% Select style

int_step = 10000;

if double(strcmp(style,'normal')) == 1
    
    colors = [0 0 0; 0 0 1; 0 1 1; 1 1 0; 1 0 0; 0.5 0 0];
    
elseif double(strcmp(style,'difference')) == 1
    
    colors = [0 0 0.5; 0 0 1; 0 0.5 1; 0 1 1; 0 0.5 0.5; 0 0 0; 0.5 0.5 0; 1 1 0; 1 0.5 0; 1 0 0; 0.5 0 0];
    
elseif double(strcmp(style,'white_yellow')) == 1
    
    colors = [1 1 1; 1 1 0.5; 1 1 0; 1 0.5 0; 1 0 0; 0.5 0 0];
    
elseif double(strcmp(style,'fire')) == 1

    colors = [0 0 0; 0.5 0 0.5; 1 0.5 0; 1 1 0; 1 1 1]; 
    
elseif double(strcmp(style,'difference_white')) == 1
    
    colors = [0 0 0.5; 0 0 1; 0 0.5 1; 0 1 1; 1 1 1; 1 1 0; 1 0.5 0; 1 0 0; 0.5 0 0];
    
elseif double(strcmp(style, 'red/blue')) == 1
    
    colors = [0 0 0.5; 0 0 1; 0.5 0.5 1; 1 1 1; 1 0.5 0.5; 1 0 0; 0.5 0 0];
    
elseif double(strcmp(style, 'Mairesse_Rainbow')) == 1
    
    colors = [1 1 1; 1 0 1; 0 0 1; 0 1 1; 0 0.5 0; 1 1 0; 1 0 0];
    
end

%% Write map

map = [];

for i = 1:3
    
    x = [];
    
    for n = 1:size(colors,1)-1
        
        x_new = linspace(colors(n,i),colors(n+1,i),int_step);
        
        if n ~= size(colors,1)-1
            
            x_new = x_new(1,1:end-1);
            
        else
        
        end
        
        x = [x, x_new];
        
    end
    
    map = [map; x];
    
end

map = map';

end