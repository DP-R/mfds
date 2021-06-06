% poisson dist.

syms x  P k lambda

P(k,x,lambda)=exp(-lambda*x)*(lambda*x)^k/factorial(k)
% k no. of events
% x no.test cases// time intervals
% P(10,1,18)

% avg time req.
% int(P(x,lambda,56),x,[60 100])

% probability of k at an instant
% k=randi(10)
x=randi([1 33],[1 3])
hi=num2cell(x);
[a,b,c]=hi{:}
d=100-a-b-c
% [a,b,c,d]=[31 33 17 19]
a=31
b=33
c=17
d=19
fprintf('Assume that the arrival of people in a 24/7 vaccination centre follows a poisson distribution. Assume a typical demographic distribution of \n')
fprintf('0/0 dividend\n %d 0-18 \n %d 18-45 \n %d 45-60 \n %d above 60',a,b,c,d)
fprintf('\nAlso,the arrival rate of each age group at the vaccination centre is proportional to population percentage normalised to 10 per hour.')
fprintf('\nThe probability that in an interval of 1 hr, the older ones get more vaccines than their younger ones .The highest vaccination status given only 13 per hr')
lambda_sol=num2cell([a,b,c,d]/10)
[a,b,c,d]=lambda_sol{:}
double(P(7,1,a)*P(3,1,b)*P(2,1,c)*P(1,1,d))+double(P(6,1,a)*P(4,1,b)*P(2,1,c)*P(1,1,d))+double(P(5,1,a)*P(4,1,b)*P(3,1,c)*P(1,1,d))


