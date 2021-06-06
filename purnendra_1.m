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
fprintf('Assume that the arrival of people in a 24/7 vaccination centre follows a poisson distribution. Assume a typical demographic distribution of \n')
fprintf('0/0 dividend\n %d 0-18 \n %d 18-45 \n %d 45-60 \n %d above 60',a,b,c,d)
fprintf('\nprobability that in an interval of 24 hrs the category of above 60 has the highest vaccination status given only 100 per day')

double(P(10,0,0))
% double(P(5,2))

