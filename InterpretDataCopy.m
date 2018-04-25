function [code] = InterpretData(num, data)

% Robbie Schaefer
% Brain WAVS project

% left wink = dot
% right wink = dash
% DOUBLE wink = new letter
% a tercet of DOUBLE winks = new word

%% Set Parameters

threshold = 70;      % threshold value for when the computer reads a 'tick'
dot = false;        % This will require tons of calibration
dash = false;       % Future plans: Make it more specific for each channel
space = false;

%% Find out how much of the data is new
[~, N ] = size(data);

%% Interpret the data
num = N - num-100;
usable =  N-100;
code = '';

for i = num:usable
    if data(1,i) > (threshold-10)
        if data (2,i) > (threshold)
            space = true;
        else
            
            dot = true;
            
        end
    elseif data(2,i) > (threshold)
        
        dash = true;
        
    end
    
    if dot == true
        code = [code, '10'];
        i = i + 190;
        disp('dot');
    elseif dash == true
        code = [code, '1110'];
        i = i + 190;
        disp('dash');
    elseif space == true
        code = [code, '00'];
        i = i + 190;
        disp('space');
    end
    
    space = false;
    dash = false;
    dot = false;
    
end