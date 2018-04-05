function results = Inv_Discrete_Fourier(x)

N = length(x);

results = zeros(1, N);

for n = 1:N
	for k = 1:N
		results(n) = results(n) + real((1 / N) * x(k) * ...
			exp(2i * pi * (k-1) * (n-1) / N)); 
	end
end