clc;
clear all;
C= rand(1,1);
D= rand(1,1);
e= rand(1,1);
f= rand(1,1);
g= rand(1,1);
h= rand(1,1);

fprintf( "The energy of a particle in the 2D coordinate system is defined as %.2f*(x(2)-x(1)^2)^2 + (%.2f-x(1))^2 Joules.\n",C,D);
fprintf( "It is defined in the region such that x(1)+%.2f*x(2)<=%.2f; %.2f*x(1)+x(2)=%.2f; x(1)>=0, x(2)>=0",e,f,g,h);
fprintf( "Find the position of minimum energy of the particle.\n");
fun = @(x) C*(x(2)-x(1)^2)^2 + (D-x(1))^2;
    
% constraints are written in the bellow form
    %c(x) <=0
    %ceq(x) = 0
    %A.x <=b
    %Aeq.x = beq
    %lb <= x <= ub

x0 = [0.5,0]; % initial guess
A = [1,e];
b = f;
Aeq = [g,1];
beq = h;
lb = [0,0];
x = fmincon(fun,x0,A,b,Aeq,beq);

fprintf("\nOptions\n");
Id=["A.","B.","C.","D."];

options_generation = [1+rand(1,1) rand(1,1) rand(1,1) rand(1,1) rand(1,1) rand(1,1)];
for i = 1:3
    fprintf("%s  %f %f \n",Id(i), options_generation(i), options_generation(i+3));
end
   fprintf("%s  %f %f \n",Id(4), x)
   
fprintf("\nANSWER: D\n");
