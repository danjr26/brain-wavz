function [dot, dash] = InterpretData(num)

% Robbie Schaefer
% Brain WAVS project

clc
clear
%% interpret received data
threshold = 1;      % threshold value for when the computer reads a 'tick'
dot = false;        % This will require tons of calibration
dash = false;       % Future plans: Make it more specific for each channel
%data = load(data) get the revised data % get the new data
N = length(data)

for i = 1:N
    if data(1,i) > threshold
        if data (2,i) > threshold
        else
            g = i+1;
            if data(1, g) > threshold
                if data(2, g) > threshold
                else
                    dot = true;
                end
            end
        end
    else
        if data(2,i) > threshold
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
    end
    if dot = true
end