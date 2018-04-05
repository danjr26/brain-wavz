classdef SettleSmoother < handle
	properties (SetAccess = private)
		bufferSize
		buffer
		sampleCounts
	end
	methods
		function this = SettleSmoother(bufferSize_in)
			this.bufferSize = bufferSize_in;
			this.buffer = zeros(bufferSize_in);
			this.sampleCounts = zeros(1, bufferSize_in(2));
		end
		
		function Feed_Data(this, data, nSteps)
			keepLength = this.bufferSize(2) - nSteps;
			
			this.buffer = [data(:, 1:nSteps), ...
				this.buffer(:, 1:keepLength)];
			
			for iRow = 1:this.bufferSize(1)
				this.buffer(iRow, (nSteps+1):end) = ...
					(this.buffer(iRow, (nSteps+1):end) .* ...
					this.sampleCounts((nSteps+1):end) + ...
					data(iRow, (nSteps+1):end)) ./...
					(this.sampleCounts((nSteps+1):end) + 1);
			end 
			
			this.sampleCounts = [zeros([1, nSteps]),...
				this.sampleCounts(1:keepLength)] + 1;
		end
		
		function data = Get_Data(this)
			data = this.buffer;
		end
		
	end
end