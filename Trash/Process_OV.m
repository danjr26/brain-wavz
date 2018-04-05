function outBox = Process_OV(inBox)

for i = 1:OV_getNbPendingInputChunk(inBox,1)
	disp(inBox);
	%inBox.user_data.nb_matrix_processed = inBox.user_data.nb_matrix_processed + 1;
	[inBox, startTime, endTime, data] = OV_popInputBuffer(inBox,1);
	[freqX, freqY] = To_Frequencies(data(1, 1:end), endTime - startTime);
	%plot(linspace(0, 1, length(data)), data);
	nX = length(freqX);
	plot(freqX(1:nX / 2), abs(freqY(1:nX / 2)), 'k-');
	axis([0, max(freqX) / 2, 0, 3]);
end

outBox = inBox;