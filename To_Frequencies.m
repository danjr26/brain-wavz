function [freqX, freqY] = To_Frequencies(y, segmentLength)

% Created by Daniel Riehm
% Last edited 31 March 2018

% Uses fft() to create xy-pairing of frequencies of input evenly-spaced
% data points

% y :				m x n array of evenly-spaced samples of a function
% segmentLength :	value representing total time spanned by samples

% freqX :	m x n array of frequency values, in Hertz
% freqY :	m x n array of freqency amplitudes

%% Calculate return values

dataSize = size(y);

freqX = zeros(dataSize);
freqY = zeros(dataSize);

for iRow = 1:dataSize(1)
	freqX(iRow, :) = linspace(0, dataSize(2) / segmentLength, dataSize(2));
	freqY(iRow, :) = fft(y(iRow, :)) / dataSize(2) * 2;
end