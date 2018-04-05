clear
clc
clf

xMin = 0;
xMax = 1.0;
nX = 256;

x = linspace(xMin, xMax, nX);
y = 0.5 * sin(5 * 2 * pi * x) + 0.2 * sin(21 * 2 * pi * x) + 0.4 * cos(33 * 2 * pi * x);

[freqX, freqY] = To_Frequencies(y, xMax);
%[reX, reY] = From_Frequencies(freqY, xMin, xMax - xMin);

%plot(x, y, 'b--', freqX, abs(freqY), 'r-', reX, reY, 'g-.');
figure(1);
plot(freqX(1:nX / 2), abs(freqY(1:nX / 2)), 'r-');
axis([0, max(freqX) / 2, 0, max(abs(freqY))*1.1]);
title('Absolute value of Fourier Transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
figure(2);
plot(x, y, 'b-');
axis([xMin, xMax, min(y)*1.1, max(y)*1.1]);
title('0.5sin(5*2pi*x) + 0.2sin(21*2pi*x) + 0.4cos(33*2pi*x)');
xlabel('Time (sec)');
ylabel('Amplitude');

