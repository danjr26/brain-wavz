function letter=letterTransF(string)

% Author: Joe Delle Donne
% 04/05/2018
%
% Translates a single binary morse letter string into a letter

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
else
    letter='NONSENSE';
end
