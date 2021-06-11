C= rand(1,1);
D= rand(1,1);
e= rand(1,1);
f= rand(1,1);
g= rand(1,1);
h= rand(1,1);

fprintf( "The energy of a particle in the 2D coordinate system is defined as \n\t E = %.2f*(q - p^2)^2 + (%.2f - p)^2 Joules.\n\n",C,D);
fprintf( "It is defined in the region such that: \n   p + %.2f*q <= %.2f \n   %.2f*p + q = %.2f \n   p >= 0, q >= 0\n\n",e,f,g,h);
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
    fprintf("%s  %.4f %.4f \n",Id(i), options_generation(i), options_generation(i+3));
end
   fprintf("%s  %.4f %.4f \n",Id(4), x)
   
fprintf("\nAnswer : D\n");
