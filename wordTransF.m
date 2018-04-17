function word=wordTransF(string)

% Adapted from wordTrans.m
% Author: Joe Delle Donne
% Section 11
% 04/05/2018
%
% Takes a string of morse code as an input, and utilizes letterTransF 
%       to output a translated string.

if strcmp(string,'0') == true
    word=' ';
else
    
    % Set Parameters
    
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
        
        if zeroCount==3
            space=space+1;
            letterspace(space)=id-2;
            space=space+1;
            letterspace(space)=id;
        end
        
    end
    
    % Gather structure of letters
    
    % first letter
    
    letter(1).string=string(1:letterspace(1)-1);
    
    % middle letters
    
    letterBack=0;
    letterFront=1;
    
    while doContinue==true
        
        letterBack=letterBack+1;
        letterFront=letterFront+1;
        
        letter(letterFront).string=string(letterspace(letterBack)+1:letterspace(letterFront)-1);
        
        if letterFront >= length(letterspace)
            doContinue=false;
        end
        
    end
    
    % last letter
    
    letter(letterFront+1).string=string(letterspace(letterFront)+1:end);
    
    
    % Display word
    
    Size=size(letter);
    word='';
    
    for it=1:Size(2)
        
        l=letterTransF(letter(it).string);
        word=[word l];
        
    end
    
end
