% Created by Daniel Riehm
% Last edited 16 April 2018

% It's a class and not a bunch of separate functions because it's more
% elegant this way 

% Continuously opens, reads, and closes file to which the OpenBCI software is
% writing the data, live.

% I wasn't sure how to comment this in the "cell" format so I just did the
% best I could...

classdef OpenBCIStream < handle
	properties (SetAccess = private)
		% where we left off in the file
		charOffset
		
		fileName
		
		% Hz
		sampleRate
		
		% [nRows, nColumns]
		bufferSize
		
		% stays constant size, sheds old data
		buffer
	end
	
	methods
		% Constructor
		function this = OpenBCIStream(fileName_in, sampleRate_in, ...
				nChannels_in, bufferLength_in)
			this.charOffset = 0;
			this.fileName = fileName_in;
			this.sampleRate = sampleRate_in;
			this.bufferSize = [nChannels_in, bufferLength_in * sampleRate_in];
			this.buffer = zeros(this.bufferSize);
		end
		
		% Reads data in file from where it left off, until it hits the end
		% of the file or reads <maxTime> seconds, whichever comes
		% first. <maxTime> can be used to throttle the speed when reading
		% from recorded (non-live) data, but should be set to a high number
		% when live-reading. 
		function timeRead = Read_New_Data(this, maxTime)
			% setup file reading
			fileID = fopen(this.fileName, 'r');
			fseek(fileID, this.charOffset, 'bof');
			
			% initialize file-reading variables
			line = fgetl(fileID);
			nLines = 0;
			maxLines = maxTime * this.sampleRate;
			
			% count number of non-comment lines
			while nLines <= maxLines && ~(length(line) == 1 && line(1) == -1)
				if line(1) == '%'
					this.charOffset = ftell(fileID);
				else
					nLines = nLines + 1;	
				end
				line = fgetl(fileID);
			end
			
			% ignore possibly partially written last line
			nLines = nLines - 1;
			
			% restart read from beginning, ignoring comments
			fseek(fileID, this.charOffset, 'bof');
			
			% skip lines too far back to be read into the buffer
			for iLine = this.bufferSize(2):nLines-1
				fgetl(fileID);
				nLines = nLines - 1;
			end
			
			% pre-allocate array
			newData = zeros(this.bufferSize(1), nLines);
			
			if nLines <= 0
				fclose(fileID);
				timeRead = 0;
				return;
			end
			
			% actually read the data
			for iLine = 1:nLines
				line = fgetl(fileID);
				
				% ignores first value, which is converniently useless
				startIndices = strfind(line, ',') + 2;
				endIndices = [startIndices(2:end) - 3, length(line)];

				% next values are channel data
				for iChannel = 1:this.bufferSize(1)
					newData(iChannel, iLine) = str2double(line(startIndices(iChannel):endIndices(iChannel)));
				end
				
				%% the rest of the values can be ignored
			end
			
			% remember where we left off
			this.charOffset = ftell(fileID);
			
			fclose(fileID);
			
			% incorporate new data into buffer
			if nLines == this.bufferSize(2)
				this.buffer = newData;
			else
				this.buffer = ...
					[newData, this.buffer(:, 1:(this.bufferSize(2) - nLines))];
			end
			
			timeRead = nLines;
		end
		
		% Gets data from all channels from time1 to time2, both of which
		% should be nonpositive (since a time of -5 means 5 seconds ago, 
		% positive times would mean requesting data that hasn't been read
		% yet, and while I'm good, I'm not quite that good)
		function [x, y] = Get_Raw_Data(this, time1, time2)
			% yay parameter screening because it's not necessarily
			% intuitive
			if time1 > 0 || time1 < -this.bufferSize(2) / this.sampleRate
				error('time1 is out of range');
			end
			if time2 > 0 || time2 < -this.bufferSize(2) / this.sampleRate
				error('time2 is out of range');
			end
			if time1 > time2
				error('time1 > time2');
			end
			
			% turns time indices into buffer indices
			index2 = floor(time1 * -this.sampleRate);
			index1 = floor(time2 * -this.sampleRate) + 1;
			
			% returns 
			x = linspace(time2, time1, index2 - index1 + 1);
			y = this.buffer(:, index1:index2);
		end
		
		function Go_To_Start(this)
			this.charOffset = 0;
		end
		
		% Do this  to catch up with the live data, skipping everything in
		% between 
		function Go_To_End(this)
			fileID = fopen(this.fileName, 'r');
			fseek(fileID, this.charOffset, 'bof');
			line = '';
			while ~(length(line) == 1 && line(1) == -1)
				line = fgetl(fileID);
				this.charOffset = ftell(fileID);
			end
			fclose(fileID);
		end
	end
end