sampleRate = 200;
nSecBuffer = 10;
nSecDisplay = 5;

stream = OpenBCIStream('OpenBCI-RAW-testing123.txt', sampleRate, 4, nSecBuffer);
smoother = SettleSmoother([4, sampleRate * nSecDisplay]);
hold off
figure(1);
clf
while true
	nSteps = stream.Read_New_Data(0.08) * sampleRate;
	[x, y] = stream.Get_Raw_Data(-nSecDisplay, 0);

	[freqX, freqY] = To_Frequencies(y, nSecDisplay);
	y2 = Isolate_Frequency_Range(y, freqX, freqY, 18, 25);
	smoother.Feed_Data(y2, nSteps);
	y3 = smoother.Get_Data();
	
	subplot(4, 1, 1);
	plot(x, y3(1, :));
	axis([-nSecDisplay, 0, -100, 100]);
	
	subplot(4, 1, 2);
	plot(x, y3(2, :));
	axis([-nSecDisplay, 0, -100, 100]);
	
	subplot(4, 1, 3);
	plot(x, y3(3, :));
	axis([-nSecDisplay, 0, -100, 100]);
	
	subplot(4, 1, 4);
	plot(x, y3(4, :));
	axis([-nSecDisplay, 0, -100, 100]);
	
	drawnow;
end
