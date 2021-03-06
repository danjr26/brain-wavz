<<<<<<< HEAD

=======
>>>>>>> 76be214f6d088400a5aa48987a3c8b79c988ee37
function [code, markers] = InterpretDataCopy(num, data, handles)


% Robbie Schaefer
% Brain WAVS project

% left wink = dot
% right wink = dash
% DOUBLE wink = new letter
% a tercet of DOUBLE winks = new word

%% Set Parameters

threshold = 25;      % threshold value for when the computer reads a 'tick'
% dot = false;        % This will require tons of calibration
% dash = false;       % Future plans: Make it more specific for each channel
% space = false;

%% Find out how much of the data is new
[~, N ] = size(data);

%% Interpret the data

code = '';
Dotstring = '';
DotOrDash='';
i = 0;
 while i <= N
     low = max(1, i - 20);
     high = min(N, i + 20);
     total1 = sum(abs(data(1,low:high)));
     average1 = total1/(high - low);
     total2 = sum(abs(data(2,low:high)));
    average2 = total2/(high - low);
     
     if average1 > (threshold)
        if average2 > (threshold*0.8)
            space = true;
        else
            dot = true;
        end
    elseif average2 > (threshold)            
        if average1 > (threshold*0.8)
            space = true;
        else
            dash = true;
        end
<<<<<<< HEAD
=======
        
        dash = true;
        
>>>>>>> 76be214f6d088400a5aa48987a3c8b79c988ee37
    end
    
    if dot == true
        code = [code, '10'];
        DotOrDash = '.';
		handles.figure1.UserData.markers.indices = [handles.figure1.UserData.markers.indices, i - num];
		handles.figure1.UserData.markers.types = [handles.figure1.UserData.markers.types, 1];
		i = i + 300;
        disp('dot');
    elseif dash == true
        code = [code, '1110'];
        DotOrDash = '-';
		handles.figure1.UserData.markers.indices = [handles.figure1.UserData.markers.indices, i - num];
		handles.figure1.UserData.markers.types = [handles.figure1.UserData.markers.types, 2];
        i = i + 300;
        disp('dash');
    elseif space == true
        code = [code, '00'];
        DotOrDash = '_';
		handles.figure1.UserData.markers.indices = [handles.figure1.UserData.markers.indices, i - num];
		handles.figure1.UserData.markers.types = [handles.figure1.UserData.markers.types, 0];
        i = i + 500;
        disp('space');
<<<<<<< HEAD



=======
        if dot == true
            code = [code, '10'];
            %DotOrDash = '.';
            i = i + 350;
            disp('dot');
        elseif dash == true
            code = [code, '1110'];
            %DotOrDash = '-';
            i = i + 350;
            disp('dash');
        elseif space == true
            code = [code, '00'];
            %DotOrDash = '_';
            i = i + 350;
            disp('space');
        end
    end
>>>>>>> 76be214f6d088400a5aa48987a3c8b79c988ee37
    space = false;
    dash = false;
    dot = false;
    
%     Dotstring = strcat(Dotstring,DotOrDash);
%     handles.dotText.String = Dotstring;
    i = i + 1;
    
end