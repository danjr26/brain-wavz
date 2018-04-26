function PlotStreamData(handles)
% Created by Daniel Riehm
% Last edited 16 April 2018

% Whlie our GUI is being perfected, this is how we are testing the
% streaming code

%% Initialize variables

d = handles.figure1.UserData;

% live: set to a very high number
% non-live: adjust to adjust speed - exact value depends on computer
maxRead = 1.0;

% range of frequencies to isolate
lowFreq = 7;
highFreq = 10;

% y-axis limits on graph -- usually 100 is about right
maxAmplitude = 100;

%% Processing loop

% read
timeRead = handles.figure1.UserData.stream.Read_New_Data(maxRead);
[x, y] = handles.figure1.UserData.stream.Get_Raw_Data(-handles.figure1.UserData.nSecDisplay, 0);

% process
[freqX, freqY] = To_Frequencies(y, handles.figure1.UserData.nSecDisplay);
y2 = Isolate_Frequency_Range(y, freqX, freqY, lowFreq, highFreq);

% smooth
handles.figure1.UserData.smoother.Feed_Data(y2, timeRead);
y3 = handles.figure1.UserData.smoother.Get_Data();

handles.figure1.UserData.totalSamples = handles.figure1.UserData.totalSamples + timeRead;

if d.totalSamples >= 1000
    handles.figure1.UserData.code = [handles.figure1.UserData.code, InterpretDataCopy(timeRead, y3)];
    handles.figure1.UserData.totalSamples = handles.figure1.UserData.totalSamples - 1000;
    handles.mText.String = morseTransF(handles.figure1.UserData.code);
    disp('cycle');
    disp(handles.figure1.UserData.code);
end

% plot

plot(handles.BrainAxesTop, x, y3(1, :));
axis(handles.BrainAxesTop, [-handles.figure1.UserData.nSecDisplay, 0, -maxAmplitude, maxAmplitude]);


plot(handles.BrainAxesBottom, x, y3(2, :));
axis(handles.BrainAxesBottom, [-handles.figure1.UserData.nSecDisplay, 0, -maxAmplitude, maxAmplitude]);

drawnow;

