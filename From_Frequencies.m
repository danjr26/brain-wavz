function [x, y] = From_Frequencies(freqY, x0, segmentLength)

% Created by Daniel Riehm
% Last edited 31 March 2018

% Uses ifft() to create xy pairs from list of frequencies (calculated by 
% twin function To_Frequencies)

% freqY :			m by n array of frequencies 
% x0 :				value to offset <x> by
% segmentLength :	value to stretch <y> by

% x :	m by n array of x-values
% y :	m by n array of y-values


%% Calculate return values

dataSize = size(freqY);

x = zeros(dataSize);
y = zeros(dataSize);

for iRow = 1:dataSize(1)
	x(iRow, :) = linspace(x0, x0 + segmentLength, dataSize(2));
	y(iRow, :) = real(ifft(freqY(iRow, :) * dataSize(2) / 2));
end