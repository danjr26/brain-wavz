function trans=morseTransF(phrase)

% Author: Joe Delle Donne
% 04/06/2018
% 
% Detemrines whether or not a morse code phrase is a word or sentence, then 
% utilizes either wordTransF or sentenceTransF to translate the phrase.

%string='10111011101110001110111011100010000000101000101010001011100010111000111010111010000000111010100010111000111010000000101110001110100011101010000000101110100011101110111000111010101';

n=length(phrase);

position=0;
zeroCount=0;

sentence=0;
word=0;
%fiveZeros=false;

if strcmp(phrase(end-6:end),'0000000') == true
    phrase=phrase(1:end-1);
end

n=length(phrase);

for id=1:n
    
    position=position+1;
    
    if strcmp(phrase(position),'0')==true
        zeroCount=zeroCount+1;
    end
    
    if strcmp(phrase(position),'0')==false
        zeroCount=0;
    end
    
    if zeroCount==7
        sentence=sentence+1;
    end
    
    if zeroCount==3
        word=word+1;
    end
    
%     if zeroCount==5
%         fiveZeros=true;
%     end
    
end

if sentence ~= 0
    trans=sentenceTransF(phrase);
else
    
    if word ~= 0 %&& fiveZeros
        trans=wordTransF(phrase);
    else
        trans=letterTransF(phrase);
    end
end


