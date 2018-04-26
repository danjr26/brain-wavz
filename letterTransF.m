function letter=letterTransF(string)

% Author: Joe Delle Donne
% 04/05/2018
%
% Translates a single binary morse letter string into a letter

% Letter

if strcmp(string, '10111') == true
    letter=('A');
elseif strcmp(string, '111010101') == true
    letter=('B');
elseif strcmp(string, '11101011101') == true
    letter=('C');
elseif strcmp(string, '1110101') == true
    letter=('D');
elseif strcmp(string, '1') == true
    letter=('E');
elseif strcmp(string, '101011101') == true
    letter=('F');
elseif strcmp(string, '111011101') == true
    letter=('G');
elseif strcmp(string, '1010101') == true
    letter=('H');
elseif strcmp(string, '101') == true
    letter=('I');
elseif strcmp(string, '1011101110111') == true
    letter=('J');
elseif strcmp(string, '111010111') == true
    letter=('K');
elseif strcmp(string, '101110101') == true
    letter=('L');
elseif strcmp(string, '1110111') == true
    letter=('M');
elseif strcmp(string, '11101') == true
    letter=('N');
elseif strcmp(string, '11101110111') == true
    letter=('O');
elseif strcmp(string, '10111011101') == true
    letter=('P');
elseif strcmp(string, '1110111010111') == true
    letter=('Q');
elseif strcmp(string, '1011101') == true
    letter=('R');
elseif strcmp(string, '10101') == true
    letter=('S');
elseif strcmp(string, '111') == true
    letter=('T');
elseif strcmp(string, '1010111') == true
    letter=('U');
elseif strcmp(string, '101010111') == true
    letter=('V');
elseif strcmp(string, '101110111') == true
    letter=('W');
elseif strcmp(string, '11101010111') == true
    letter=('X');
elseif strcmp(string, '11101110111') == true
    letter=('Y');
elseif strcmp(string, '11101110101') == true
    letter=('Z');
    
    % Error
elseif strcmp(string, '101110') == true
    letter=('A');
elseif strcmp(string, '1110101010') == true
    letter=('B');
elseif strcmp(string, '111010111010') == true
    letter=('C');
elseif strcmp(string, '11101010') == true
    letter=('D');
elseif strcmp(string, '10') == true
    letter=('E');
elseif strcmp(string, '1010111010') == true
    letter=('F');
elseif strcmp(string, '1110111010') == true
    letter=('G');
elseif strcmp(string, '10101010') == true
    letter=('H');
elseif strcmp(string, '1010') == true
    letter=('I');
elseif strcmp(string, '10111011101110') == true
    letter=('J');
elseif strcmp(string, '1110101110') == true
    letter=('K');
elseif strcmp(string, '1011101010') == true
    letter=('L');
elseif strcmp(string, '11101110') == true
    letter=('M');
elseif strcmp(string, '111010') == true
    letter=('N');
elseif strcmp(string, '111011101110') == true
    letter=('O');
elseif strcmp(string, '101110111010') == true
    letter=('P');
elseif strcmp(string, '11101110101110') == true
    letter=('Q');
elseif strcmp(string, '10111010') == true
    letter=('R');
elseif strcmp(string, '101010') == true
    letter=('S');
elseif strcmp(string, '1110') == true
    letter=('T');
elseif strcmp(string, '10101110') == true
    letter=('U');
elseif strcmp(string, '1010101110') == true
    letter=('V');
elseif strcmp(string, '1011101110') == true
    letter=('W');
elseif strcmp(string, '111010101110') == true
    letter=('X');
elseif strcmp(string, '111011101110') == true
    letter=('Y');
elseif strcmp(string, '111011101010') == true
    letter=('Z');
    
    % Nonsense
elseif strcmp(string, '0') == true
    letter=('');
elseif strcmp(string,'') == true
    letter=('');
elseif strcmp(string,'000') == true
    letter=('');
else


    letter='';

end
