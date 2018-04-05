function data = Isolate_Frequency_Range...
	(rawData, freqX, freqY, lowFreq, highFreq)

dataSize = size(rawData);
newFreqY = zeros(dataSize);

for iRow = 1:dataSize(1)
	for iColumn = 1:dataSize(2)
		if freqX(iRow, iColumn) < lowFreq 
			newFreqY(iRow, iColumn) = 0;
		elseif freqX(iRow, iColumn) > highFreq
			newFreqY(iRow, iColumn) = 0;
		else
			newFreqY(iRow, iColumn) = freqY(iRow, iColumn);
		end
	end
end

[~, data] = From_Frequencies(newFreqY, 0, 1);