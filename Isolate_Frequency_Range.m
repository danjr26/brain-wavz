function data = Isolate_Frequency_Range...
	(rawData, freqX, freqY, lowFreq, highFreq)

% Created by Daniel Riehm
% Last edited 16 April 2018

% Given an array of raw data and pre-calculated frequencies, assembles
% copy of input data composed only of frequencies in selected range

% Input Variables
% rawData :		m by n array of evenly-spaced y-values of m different
%					unprocessed functions 
% freqX :		m by n array of frequency x-values (Hz)
% freqY :		m by n array of frequency y-values (amplitude)
% lowFreq :		value representing lower end of desired frequency range
% highFreq :	value representing higher end of desired frequency rnage

% Output Variables
% data :	m by n array of evenly-spaced y-values of m different processed
%				functions

%% Initialize variables

dataSize = size(rawData);
newFreqY = zeros(dataSize);

%% Set unwanted frequencies to 0

for iRow = 1:dataSize(1)
	for iColumn = 1:dataSize(2)
		if freqX(iRow, iColumn) < lowFreq || freqX(iRow, iColumn) > highFreq
			newFreqY(iRow, iColumn) = 0;
		else
			newFreqY(iRow, iColumn) = freqY(iRow, iColumn);
		end
	end
end

%% Reassemble from altered frequencies

[~, data] = From_Frequencies(newFreqY, 0, 1);