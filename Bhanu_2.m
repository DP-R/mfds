clc;
clear all;

%f= @(x) x(1).^2+ (x(2)-1).^2
syms x y ;
f= @(x,y) x^2+ (x*y-4)^2
f=x^2+ (x*y-4)^2
%gradf = @(x,y) [ 2*x(1), 2*x(2)-2];
p=diff(f,x)
q=diff(f,y)

starting_guess = [1,1];

a= subs(p, {x,y}, starting_guess)
b= subs(q, {x,y}, starting_guess)

gradf = [a b]

iterations = 500;
step_size = 0.01;
%epsilon = 0.0000001;

guesses = [ starting_guess];

next_guess = starting_guess;
optimum_value = subs(f, {x,y}, gradf) ;
for i=1:iterations
    next_guess = next_guess - step_size*gradf;
    guesses = [ guesses,next_guess];
   if optimum_value > subs(f, {x,y}, next_guess)
       optimum_value = subs(f, {x,y}, next_guess);
       optimal_point = next_guess;
   end 
       
        
end

optimum_value
optimal_point