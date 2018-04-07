classdef OpenBCIStream < handle
	properties (SetAccess = private)
		charOffset
		fileName
		sampleRate
		bufferSize
		buffer
		bufferOffset
	end
	
	methods
		function this = OpenBCIStream(fileName_in, sampleRate_in, ...
				nChannels_in, bufferLength_in)
			this.charOffset = 0;
			this.fileName = fileName_in;
			this.sampleRate = sampleRate_in;
			this.bufferSize = [nChannels_in, bufferLength_in * sampleRate_in];
			this.buffer = zeros(this.bufferSize);
			this.bufferOffset = 0;
		end
		
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
			
			this.charOffset = ftell(fileID);
			
			if nLines == this.bufferSize(2)
				this.buffer = newData;
			else
				this.buffer = ...
					[newData, this.buffer(:, 1:(this.bufferSize(2) - nLines))];
			end
			
			timeRead = nLines / this.sampleRate;
			
			fclose(fileID);
		end
		
		function [x, y] = Get_Raw_Data(this, time1, time2)
			if time1 > 0 || time1 < -this.bufferSize(2) / this.sampleRate
				error('time1 is out of range');
			end
			if time2 > 0 || time2 < -this.bufferSize(2) / this.sampleRate
				error('time2 is out of range');
			end
			if time1 > time2
				error('time1 > time2');
			end
			
			index2 = floor(time1 * -this.sampleRate);
			index1 = floor(time2 * -this.sampleRate) + 1;
			
			x = linspace(time2, time1, index2 - index1 + 1);
			y = this.buffer(:, index1:index2);
		end
		
		function Go_To_Start(this)
			this.charOffset = 0;
		end
		
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