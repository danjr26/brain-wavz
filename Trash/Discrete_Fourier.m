function results = Discrete_Fourier(x)

N = length(x);

results = zeros(1, N);

for k = 1:N
	for n = 1:N
		results(k) = results(k) + x(n) * exp(-2i * pi * (k-1) * (n-1) / N); 
	end
end
