function handles = SetupStreamPlot(handles)

%% Initialize variables

% set by OpenBCI
handles.figure1.UserData.sampleRate = 200;

% how much data you want to be used for processing
handles.figure1.UserData.nSecBuffer = 10;

% how much data you want to be used for graphing
handles.figure1.UserData.nSecDisplay = 5;

d = handles.figure1.UserData;

% create streaming object (initialized for reading pre-recorded data)
handles.figure1.UserData.stream = ...
	OpenBCIStream('/Applications/SavedData/OpenBCI-RAW-FirstStreamTest.txt', d.sampleRate, 4, d.nSecBuffer);

% uncomment this to initialize for live streaming
% stream.Go_To_End();

% smooths graph by averaging over time
handles.figure1.UserData.smoother = ... 
	SettleSmoother([4, d.sampleRate * d.nSecDisplay]);

handles.figure1.UserData.updater = timer(...
	'ExecutionMode', 'fixedRate',...
	'Period', 0.033,...
	'TimerFcn', {@UpdateGUI, handles}...
	);