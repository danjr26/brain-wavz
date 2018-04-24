function [newdata, y4 , code] = InterpretData(num, olddata, newdata)

% Robbie Schaefer
% Brain WAVS project

%% Set Parameters

threshold = -25;      % threshold value for when the computer reads a 'tick'
dot = false;        % This will require tons of calibration
dash = false;       % Future plans: Make it more specific for each channel
space = false;
data = newdata;
[~,N] = size(newdata);

%% Find out how much of the data is new
y3 = newdata;
caughtup = false;
n = 1;
length3 = size(olddata);
oldlength = length3(1,1);
length4 = size(newdata);
newlength = length4(1,1);

    while caughtup == false
        if olddata(1, oldlength) == newdata(1, n)
            caughtup = true;
            newdata = newdata(:, [n, newlength]);
        else
            n = n+1;
        end
    end
    
%% Interpret the data

data = newdata;
usable =  N-33;
code = '0';
counter = 0;

for i = 1:usable
    if data(1,i) > threshold
        if data (2,i) > threshold
            for k = 1:33
                l = k + i;
                if data(1, l) > threshold && data(2,l) > threshold
                    counter = counter + 1;
                end
            end
            if counter >= 31
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
        code = [code, '10'];
        i = i + 20;
    elseif dash == true
        code = [code, '1110'];
        i = i + 20;
    elseif space == true
        code = [code, '000'];
        i = i + 53;
    end
    counter = 0;
    space = false;
    dash = false;
    dot = false;
end