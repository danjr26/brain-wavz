function sentence=sentenceTransF(string)

% sentenceTrans.m
% Author: Joe Delle Donne
% 04/05/2018
% 
% Utilizes wordTransF to translate entire sentences of morse code

%% Set Parameters

%string='10111011101110001110111011100010000000101000101010001011100010111000111010111010000000111010100010111000111010000000101110001110100011101010000000101110100011101110111000111010101';

n=length(string);

doContinue=true;

position=0;
zeroCount=0;
space=0;

for id=1:n
    
    position=position+1;
    
    if strcmp(string(position),'0')==true
        zeroCount=zeroCount+1;
    end
    
    if strcmp(string(position),'0')==false
        zeroCount=0;
    end
    
    if zeroCount==7
        space=space+1;
        wordspace(space)=id-2;
        space=space+1;
        wordspace(space)=id;
    end
    
end

%% Gather structure of letters

% first letter

word(1).string=string(1:wordspace(1)-1);

% middle letters

wordBack=0;
wordFront=1;

while doContinue==true
    
    wordBack=wordBack+1;
    wordFront=wordFront+1;
    
    word(wordFront).string=string(wordspace(wordBack)+1:wordspace(wordFront)-1);
    
    if wordFront >= length(wordspace)
        doContinue=false;
    end
    
end

% last letter

word(wordFront+1).string=string(wordspace(wordFront)+1:end);


%% Display word

Size=size(word);
sentence='';

for it=1:Size(2)
    
    w=wordTransF(word(it).string);
    sentence=[sentence w];

end


