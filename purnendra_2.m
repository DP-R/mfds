%normalise and find the probabilites using lean sigma
%and extended applications
%Assume that a company requires a product of tight tolerances within +-sigma
%the dimensions of the product are 
syms x mu sigma mu1 sigma1 mu2 sigma2 y z
P(x,mu,sigma)=sqrt(1/(2*pi*sigma^2))*exp(-(x-mu)^2/((2)*sigma^2))
P(x,mu1,sigma1)*P(x,mu2,sigma2)
%solve([P(x,mu1,sigma1)*P(y,mu2,mu2)==P(z,mu,sigma) z==x+y],[mu sigma])
