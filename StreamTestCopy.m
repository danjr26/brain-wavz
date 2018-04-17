function StreamTestCopy(handles)
% Created by Daniel Riehm
% Last edited 16 April 2018

% Whlie our GUI is being perfected, this is how we are testing the
% streaming code

%% Initialize variables

% set by OpenBCI
sampleRate = 200;

% how much data you want to be used for processing
nSecBuffer = 10;

% how much data you want to be used for graphing
nSecDisplay = 5;

% live: set to a very high number
% non-live: adjust to adjust speed - exact value depends on computer
maxRead = 0.08;

% range of frequencies to isolate
lowFreq = 7;
highFreq = 13;

% y-axis limits on graph -- usually 100 is about right
maxAmplitude = 100;

% create streaming object (initialized for reading pre-recorded data)
stream = OpenBCIStream('OpenBCI-RAW-testing123.txt', sampleRate, 4, nSecBuffer);

% uncomment this to initialize for live streaming
%stream.Go_To_End();

% smooths graph by averaging over time
smoother = SettleSmoother([4, sampleRate * nSecDisplay]);



%% Processing loop

% To stop it you have to Ctrl-C; Sorry! -- no GUI yet
while true
	% read
	timeRead = stream.Read_New_Data(maxRead) * sampleRate;
	[x, y] = stream.Get_Raw_Data(-nSecDisplay, 0);

	% process
	[freqX, freqY] = To_Frequencies(y, nSecDisplay);
	y2 = Isolate_Frequency_Range(y, freqX, freqY, lowFreq, highFreq);
	
	% smooth
	smoother.Feed_Data(y2, timeRead);
	y3 = smoother.Get_Data();
	
	% plot
	
	plot(handles.BrainAxesTop,x, y3(1, :));
	axis([-nSecDisplay, 0, -maxAmplitude, maxAmplitude]);
	
	
	plot(handles.BrainAxesBottom,x, y3(2, :));
	axis([-nSecDisplay, 0, -maxAmplitude, maxAmplitude]);
	
	
	
	drawnow;
end
