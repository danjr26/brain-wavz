function [x, y] = From_Frequencies(freqY, x0, segmentLength)

% Created by Daniel Riehm
% Last edited 16 April 2018

% Uses ifft() to create xy pairs from list of frequencies (calculated by 
% twin function To_Frequencies()). Think of it as reassembling a function
% from the frequencies it has been broken down into. Each row of the input
% <freqy> matrix is treated as its own separate set of frequencies, so all
% input channels can be dealt with at once.

% Input variables
% freqY :			m by n array of frequencies (Hz)
% x0 :				offset of output segment (sec)
% segmentLength :	length of output segment (sec)

% Output variables
% x :	m by n array of x-values
% y :	m by n array of y-values


%% Initialize variables

dataSize = size(freqY);

x = zeros(dataSize);
y = zeros(dataSize);

%% Calculate output

for iRow = 1:dataSize(1)
	x(iRow, :) = linspace(x0, x0 + segmentLength, dataSize(2));
	y(iRow, :) = real(ifft(freqY(iRow, :) * dataSize(2) / 2));
end