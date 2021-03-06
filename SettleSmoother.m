% Created by Daniel Riehm
% Last edited 16 April 2018

% It's a class and not a bunch of separate functions because it's more
% elegant this way 

% Object used to "settle" output that jumps or oscillates around a certain
% value by returning the average of all updates fed to it so far. This was
% necessary because when live-streaming data, the boundary conditions are
% continuously changing, so the Fourier Transofmr, and by extension the
% frequency-filtered data, was erratic

% Subclass of handle so data is not continuously copied
classdef SettleSmoother < handle
	% Members are private because we don't want people messing with the
	% internals
	properties (SetAccess = private)
		% [nRows, nColumns]
		bufferSize
		
		% Contains averages so far all data points in corresponding
		% positions; remains of constant size and dumps old data
		buffer
		
		% Contains number of data samples that have gone into each average
		% in that column
		sampleCounts
	end
	methods
		% Constructor
		function this = SettleSmoother(bufferSize_in)
			this.bufferSize = bufferSize_in;
			this.buffer = zeros(bufferSize_in);
			this.sampleCounts = zeros(1, bufferSize_in(2));
		end
		
		% Shifts data in buffer by <nSteps>, recalculates averages given
		% new data points
		function Feed_Data(this, data, nSteps)
			keepLength = this.bufferSize(2) - nSteps;
            
			% shift buffer
			this.buffer = [data(:, 1:nSteps), ...
				this.buffer(:, 1:keepLength)];
			
			% recalculate averages
			for iRow = 1:this.bufferSize(1)
				this.buffer(iRow, (nSteps+1):end) = ...
					(this.buffer(iRow, (nSteps+1):end) .* ...
					this.sampleCounts((nSteps+1):end) + ...
					data(iRow, (nSteps+1):end)) ./...
					(this.sampleCounts((nSteps+1):end) + 1);
			end 
			
			% update sampleCounts
			this.sampleCounts = [zeros([1, nSteps]),...
				this.sampleCounts(1:keepLength)] + 1;
		end
		
		% necessary because all members are private
		function data = Get_Data(this)
			data = this.buffer;
		end
		
	end
end