function File_Test()

clear
clc

filename = 'OpenBCI-RAW-testing123.txt';
line = 'line';
charStart = 0;
nLines = 0;
maxSec = 5;
refreshRate = 200;
maxLines = maxSec * refreshRate;
nChannels = 4;

fileID = fopen(filename);

% go to where we left off
fseek(fileID, charStart, 'bof');

% count number of lines
while line(1) ~= -1 && nLines <= maxLines
	line = fgetl(fileID);
	if line(1) == '%'
		charStart = ftell(fileID);
	else
		nLines = nLines + 1;	
	end
end

% ignore possibly partial last line
nLines = nLines - 1;

channelData = zeros(nChannels, nLines);
timestamps = zeros(1, nLines);

fseek(fileID, charStart, 'bof');

for iLine = 1:nLines
	line = fgetl(fileID);
	
	startIndices = strfind(line, ',') + 2;
	endIndices = [startIndices(2:end) - 3, length(line)];
	
	% first values are channel data
	for iChannel = 1:nChannels
		channelData(iChannel, iLine) = str2double(line(startIndices(iChannel):endIndices(iChannel)));
	end
	
	% next three are useless accelerometer data
	
	% last one is timestamp hh:mm:ss.mmm
% 	iValue = nChannels + 4;
% 	timestamps(iLine) = int64(0);
% 	timestamps(iLine) = timestamps(iLine) +...
% 		str2double(line((startIndices(iValue) + 0):(startIndices(iValue) + 1)))...
% 		* 60 * 60 * 1000;
% 	timestamps(iLine) = timestamps(iLine) +...
% 		str2double(line((startIndices(iValue) + 3):(startIndices(iValue) + 4)))...
% 		* 60 * 1000;
% 	timestamps(iLine) = timestamps(iLine) +...
% 		str2double(line((startIndices(iValue) + 6):(startIndices(iValue) + 7)))...
% 		* 1000;
% 	timestamps(iLine) = timestamps(iLine) +...
% 		str2double(line((startIndices(iValue) + 9):(startIndices(iValue) + 11)));
end

fclose(fileID);

freqX = zeros(nChannels, length(channelData(1, :)));
freqY = zeros(nChannels, length(channelData(1, :)));
for iChannel = 1:nChannels
	[freqX(iChannel, :), freqY(iChannel, :)] = To_Frequencies(channelData(iChannel, :), nLines / refreshRate);
	channelData(iChannel, :) = channelData(iChannel, :) - freqY(iChannel, 1) / 2;
end

freqY(:, 1) = zeros(nChannels, 1);

figure(1);
hold off
plot(linspace(0, maxSec, length(channelData(1, :))), channelData(:, :));
hold on
figure(2);
plot(freqX(1, 1:nLines/2), abs(freqY(:, 1:nLines/2)));

filteredFreqY = zeros(nChannels, length(freqY));

filteredFreqY(:, 9*maxSec:14*maxSec) = freqY(:, 9*maxSec:14*maxSec);
reX = zeros(size(channelData));
reY = zeros(size(channelData));

for iChannel = 1:nChannels
	[reX(iChannel, :), reY(iChannel, :)] = ...
		From_Frequencies(filteredFreqY(iChannel, :), 0, maxSec);
end

figure(3);
plot(reX, reY(1, :));

