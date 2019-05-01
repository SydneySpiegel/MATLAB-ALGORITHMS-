function I = Simpson(x,y)
%  This is a function that will use the Simpsons 1/3 rule for integrating 
% experimental data

% Function does the following:
% Error Checks inputs are the same length
% Error Checks that x input is equally spaced
% Warns user if there are an unequal number of intervals and then uses
% trapizoial rule on the last interval 

% CREATED BY SYDNEY SPIEGEL
% 4/19/2019
   
%% Error Checks

L_of_y = length(y);       %length of y
L_of_x = length(x);       %length of x
n = L_of_x-1;             % number of sections = n
h = x(end) - x(1); 

if nargin < 2             % if there are less than 2 inputs
    error(' THERE MUST BE TWO INPUTS')
elseif nargin >2          % if there are more than 2 inputs
    error(' THERE MUST ONLY BE TWO INPUTS')
end
                          % make sure inputs are the same length
if L_of_x ~= L_of_y 
    error( '!!INPUTS (x,y) MUST BE SAME LENGTH!!')
end

                          % check to see if x input is equally spaced 
                          % if equally spaced this will equal zero 
equalspaced = range(x(2:end)-x(1:end-1)) ;
if equalspaced ~= 0 
    error( '!!X INPUT IS NOT EQUALLY SPACED!!')
end

                          % see if there are odd number of intervals
oddnumbintervals = rem(n,2);  
%% USE SIMPSONS 1/3 RULE IF THERE ARE EVEN NUMBER OF INTERVALS

if oddnumbintervals == 0 %if there are an even number of intervals
    % use simpsons 1/3 rule
    simpthird4 = 0;
    simpthird2 = 0 ;

    for i = 2:2:n   % even values of y
        simpthird4 = simpthird4 + y(i);
    end

    for i = 3:2:n-1 % odd values of y 
        simpthird2 = simpthird2 + y(i);
    end
    I = (h) * ((y(1) + (4*simpthird4) + (2*simpthird2) +y(end))/(3*n));
    disp( 'THE VALUE OF THE INTEGRAL JUST USING SIMPSONS 1/3 RULE EQUALS: ')
    disp(I)
end
%% USE COMBINATION OF SIMPSONS AND TRAPIZOIDAL RULE IF ODD NUMBER OF INTERVALS
if oddnumbintervals == 1 % if there are an odd number of intervals
   
    warning(' WARNING -THERE ARE ODD NUMBER OF INTERVALS: ')
    fprintf('TRAPIZOIDAL RULE WILL BE USED FOR LAST INTERVAL: \n ') 
    fprintf('HIT ANY KEY TO CONTINUE: \n')
    pause

    h_s = (x(end-1)-x(1));    % h of simpsons function
    h_t = (x(end)- x(end-1)); % h of trap function 

    simpthird4 = 0;  % set initial variables
    simpthird2 = 0 ; 
    
    % calculate odd terms 
    for i = 2:2:n-1
        simpthird4 = simpthird4 + y(i);
    end
    
    % calculate even terms
    for i = 3:2:n-2
        simpthird2 = simpthird2 + y(i);
    end
        I_SIMPSONS = (h_s) * ((y(1) + (4*simpthird4) + (2*simpthird2) +y(end-1))/(3*(n-1)));

    % NOW USE TRAPIZOIDAL RULE ON LAST INTERVAL 
    I_TRAP = (h_t)*((y(end-1)+y(end)) /2);

    I = I_SIMPSONS + I_TRAP;
    disp('THE VALUE OF THE INTEGRAL USING SIMPSONS AND TRAPIZOIDAL RULES EQUALS: ')
    disp(I)
end
%% COMPARE WITH MATLABS TRAP FUNCTION 
q = trapz(x,y);
disp('MATLABS BUILT IN TRAPZ FUNCTION EVALUATED AT X AND Y TO EQUAL: ')
disp(q)
rerror= abs((q - I)/q)*100;
disp('PERCENT DIFFERENCE OF MY FUNCTION SIMPSON.M COMPARED WITH TRAPZ IS: ')
disp(rerror)
end