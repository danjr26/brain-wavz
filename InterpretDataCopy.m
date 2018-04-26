function [code] = InterpretData(num, data, handles)

% Robbie Schaefer
% Brain WAVS project

% left wink = dot
% right wink = dash
% DOUBLE wink = new letter
% a tercet of DOUBLE winks = new word

%% Set Parameters

threshold = 8.7;      % threshold value for when the computer reads a 'tick'
dot = false;        % This will require tons of calibration
dash = false;       % Future plans: Make it more specific for each channel
space = false;

%% Find out how much of the data is new
[~, N ] = size(data);

%% Interpret the data
num = N - num;
usable =  N;
code = '';
Dotstring = '';
DotOrDash='';
i = 1;
while i <= N
    low = max(1, i - 15);
    high = min(N, i + 15);
    total1 = sum(abs(data(1,low:high)));
    average1 = total1/(high - low);
    total2 = sum(abs(data(2,low:high)));
    average2 = total2/(high - low);
    
    if average1 > (threshold)
        if average1 > (threshold + 2.5)
            if average2 > (threshold+2.5)
                space = true;
                
            else
                
                dot = true;
                
            end
        else
            dot = true;
        end
    elseif average2 > (threshold)
        if average2 > (threshold + 2.5)
            
            if average1 > (threshold + 2.5)
                space = true;
            else
                dash = true;
            end
            
        else
            dash = true;
            
            
        end
        
        if dot == true
            code = [code, '10'];
            DotOrDash = '.';
            i = i + 350;
            disp('dot');
        elseif dash == true
            code = [code, '1110'];
            DotOrDash = '-';
            i = i + 350;
            disp('dash');
        elseif space == true
            code = [code, '00'];
            DotOrDash = '_';
            i = i + 350;
            disp('space');
        end
    end
    space = false;
    dash = false;
    dot = false;
    
    Dotstring = strcat(Dotstring,DotOrDash);
    handles.dotText.String = Dotstring;
    i = i + 1;
    
end