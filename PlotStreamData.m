function PlotStreamData(handles)
% Created by Daniel Riehm
% Last edited 16 April 2018

% Whlie our GUI is being perfected, this is how we are testing the
% streaming code

%% Initialize variables

% live: set to a very high number
% non-live: adjust to adjust speed - exact value depends on computer
maxRead = 0.5;

% range of frequencies to isolate
lowFreq = 7;
highFreq = 13;

% y-axis limits on graph -- usually 100 is about right
maxAmplitude = 20;

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

if handles.figure1.UserData.totalSamples >= 1000
    handles.figure1.UserData.code = [handles.figure1.UserData.code, InterpretDataCopy(timeRead, y3, handles)];
    handles.figure1.UserData.totalSamples = handles.figure1.UserData.totalSamples - 1000;
    handles.mText.String = morseTransF(handles.figure1.UserData.code);
    disp('cycle');
    disp(handles.figure1.UserData.code);
end

% plot

y4 = zeros([1, 1000]);
for i = 1:1000
    low = max(1, i - 15);
    high = min(1000, i + 15);
    total1 = sum(abs(y3(1,low:high)));
    y4(i) = total1/(high - low);
end

plot(handles.BrainAxesTop, x, y4, 'r:');
hold(handles.BrainAxesTop, 'on');
plot(handles.BrainAxesTop, x, y3(1, :));
axis(handles.BrainAxesTop, [-handles.figure1.UserData.nSecDisplay, 0, -maxAmplitude, maxAmplitude]);
hold(handles.BrainAxesTop, 'off');

plot(handles.BrainAxesBottom, x, y3(2, :));
axis(handles.BrainAxesBottom, [-handles.figure1.UserData.nSecDisplay, 0, -maxAmplitude, maxAmplitude]);

j = 1;
while j <= length(handles.figure1.UserData.markers.indices)
	handles.figure1.UserData.markers.indices(j) = handles.figure1.UserData.markers.indices(j) + timeRead;
	if(handles.figure1.UserData.markers.indices(j) > 1000) 
		handles.figure1.UserData.markers.indices(j) = [];
        handles.figure1.UserData.markers.types(j) = [];
    end
    j = j + 1;
end

hold(handles.BrainAxesTop, 'on');
hold(handles.BrainAxesBottom, 'on');
for i = 1:length(handles.figure1.UserData.markers.indices)
	type = '';
	switch handles.figure1.UserData.markers.types(i)
		case 0
			type = 'ro';
		case 1
			type = 'kx';
		case 2
			type = 'k^';
	end
	plot(handles.BrainAxesTop, handles.figure1.UserData.markers.indices(i) / -200, 0, type);
	plot(handles.BrainAxesBottom, handles.figure1.UserData.markers.indices(i) / -200, 0, type);
end
hold(handles.BrainAxesTop, 'off');
hold(handles.BrainAxesBottom, 'off');

drawnow;

