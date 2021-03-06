function [dot, dash] = InterpretData(y3)

% Robbie Schaefer
% Brain WAVS project

%% interpret received data

threshold = -1150;      % threshold value for when the computer reads a 'tick'
dot = false;        % This will require tons of calibration
dash = false;       % Future plans: Make it more specific for each channel
data = y3;
[~,N] = size(y3);
usable = N -10;
code = 0;
counter = 0;

for i = 1:usable
    if data(1,i) > threshold
        if data (2,i) > threshold
            for k = 1:10
                l = k + i;
                if data(1, l) > threshold && data(2,l) > threshold
                    counter = counter + 1;
                end
            end
            if counter >=8
                space = true;
            end
        else
            g = i+1;
            if data(1, g) > threshold
                if data(2, g) > threshold
                else
                    dot = true;
                end
            end
        end
    elseif data(2,i) > threshold
        if data (1,i) > threshold
        else
            g = i+1;
            if data(2, g) > threshold
                if data(1, g) > threshold
                else
                    dash = true;
                end
            end
        end
    end
    if dot == true
        code = [code + '-.'];
    elseif dash == true
        code = [code + '---.'];
    elseif space == true
        code = [code + '...']
    end
    counter = 0;
    space = false;
    dash = false;
    dot = false;
end