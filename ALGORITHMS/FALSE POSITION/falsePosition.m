function [root,fx,ea,iter] =  falsePosition(func,xl,xu,es,maxiter)
%  falsePosition: this function finds the roots using false position method 
%   [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter):
%   uses the false position method to locate the root of a function 
% 
%----------------------------------------------------------------------——
% Here is an example of how the function should be typed into the command
% window :

%fx = @(x) put function here
%falsePosition(@(x) fx(x),xl,xu,es)



% -------------------------------------------------------------------------
% 
% The input arguments are :
%   func = is the name of the function 
%   xl = lower bound guess (root will should be between this and xu) 
%   xu = upper bound guess (root will should be between this and xl) 
%   es = is the desired relative error (default = 0.0001%)
%   maxiter = maximum allowable iterations (default = 200)
%
% 
% The outputs of the falsePosition are:
%   root = the real root of the function 
%   fx = function value at root
%   ea = approximate relative error (%)
%   iter = number of iterations

%--------------------------------------------------------------------------   
format long 

% 
% if user inputs less than 3 input give them an error message
if nargin < 3, error(' ohh noo! A minimum of 3 input are arguments required'),end  

% test to see if upper and lower guesses will contain a root
Usermistake = func(xl) * func(xu);
if Usermistake > 0,error('There is no sign change between these bounds, you did not bracket the root'),end

% 
% If user only has three inputs make the desired relative error default to 0.0001%)
if nargin < 4||isempty(es), es = 0.0001;end

% 
% If user only has four inputs set the max iterations to 200 times
if nargin <5 || isempty(maxiter), maxiter = 200;end

% 
% To start things off: set the iterations equal to 0
iter = 0; 

% For the first iteration xr will equall xl
xr = xl; 

% Set ea equal to a some value   
ea = 100;

% Check if end-points are a root(you never know, it could happen)

if  func(xl) == 0 ,xr = xl;
    fprintf('\n Good Guess! Root was equal to lower guess and it is located at %d \n', xl);
	
end	
if func(xu) == 0 , xr = xu;
	fprintf('\n Good Guess!Root was equal to upper guess and it is located at %d \n', xu);
end	

% Check to see if upper or lower guess exists 
% For example log(0) = neg infinity

if func(xl) == -Inf || func(xl) == Inf, error(' ohh noo! Your guess for a lower bound doesnt exist'),end 
if func(xu) == -Inf || func(xu) == Inf, error(' ohh noo! Your guess for a upper bound doesnt exist'),end 
  
%
% Start a while loop?
% loop will end when max iterations are done or error is small enough 
while (1)
  oldxr = xr;% set a variable oldxr equal to xr
                   
  xr =  xu- ((func(xu))*((xl-xu))/(func(xl)-func(xu))); % create a function to find the new root estimate
  
  iter = iter + 1;  % increase the number of iterations
  
  if xr ~= 0,ea = abs((xr - oldxr)/xr) * 100;end 
  % if the new xr doesnt equal 0 set the approximate relative error (%)
  
  testfunc = func(xl) * func(xr);    % if the value of f(xl) * the value of f(xr) is less than zero
   if testfunc < 0
   xu = xr;            % set xu equal to xr 
   elseif testfunc > 0   % if testfunc is bigger than zero then xr should be lower bound 
    xl = xr;
   else
    ea = 0; % wow!  Approximate relative error (%) is 0
   end
  
  if ea <= es || iter >= maxiter,break,end  
end


root = xr; 
fx = func(xr);

fprintf('\n The root was calculated to be %d \n', root);
fprintf('\n %d iterations were required to find root \n', iter);
fprintf('\n The approximate relative error was %d \n', ea);
fprintf('\n The function value at this root is %d \n', fx);

