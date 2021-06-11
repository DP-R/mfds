a= randi([1,6],1,1);
b= randi([1,5],1,1);
step_size = 0.01* randi([1,7],1,1);
iterations = 50*randi([2,6],1,1);
fprintf( "You are stuck at a high altitude on a snow mountain while skewing.\n" )
fprintf( "There is a drone, which can capture the topography of the region around you and converts it into a mathematical expression:\n\n");
fprintf("\tf(x,y) = (x - %.2f)^2 + (%.2f - x*y)^2.\n\n",a,b);
fprintf( "You have to reach the possible lowest altitude by following a steepest decent path at every step with the step size of %0.2f and find the lowest possible altitude w.r.t mean sea level that can be reached in %d steps.\n",step_size,iterations)
fprintf("Starting guess can be taken as [2,1]\n");


%f= @(x) x(1).^2+ (x(2)-1).^2
syms x y ;
%f= @(x,y) x^2+ (x*y-4)^2
f= (x-a)^2 + (b-x*y)^2;
%gradf = @(x,y) [ 2*x(1), 2*x(2)-2];
dfdx=diff(f,x);
dfdy=diff(f,y);

%starting_guess = [2*rand(1,1),rand(1,1)]
starting_guess = [2,1];
gradf = [vpa(subs(dfdx, {x,y}, starting_guess)) subs(dfdy, {x,y}, starting_guess)];
%epsilon = 0.0000001;

guesses = [starting_guess];
next_guess = starting_guess;
optimum_value = subs(f, {x,y}, gradf) ;
k(iterations,2)=0;

for i=1:iterations
    next_guess = next_guess - step_size*gradf;
    k(i,:) =  next_guess;
    gradf = [round(subs(dfdx, {x,y}, next_guess),3) round(subs(dfdy, {x,y}, next_guess),3)];
   if optimum_value > subs(f, {x,y}, next_guess)
       optimum_value = subs(f, {x,y}, next_guess);
       optimal_point = next_guess;
   end 
end

optimum_value = round(vpa(optimum_value),3);
optimal_point;

fprintf("\nOptions\n");
Id=["A.","B.","C.","D."];
for i = 1:3
    fprintf("%s  %f  \n",Id(i), subs(f, {x,y}, k(randi([0, (iterations - rem(iterations,4))/4],1,1),:)));
end
    fprintf("%s  %f \n",Id(4), optimum_value);
    fprintf("\Answer: D\n");
