clc;
clear all;
%random input population data
input_matrix=[31 33 17 19;27 32 22 19;24 30 32 14;26 27 29 18];
%selection of one row
pop_percent=randomgenerator(input_matrix);
%random normaliser for rate constant
rate_normaliser=randi([8,15]);
% poisson dist.
syms x  P k lambda;
% probability of k events occuring at a given time interval x
P(k,x,lambda)=exp(-lambda*x)*(lambda*x)^k/factorial(k);
% k no. of events
% x no.test cases(time interval in this case)
%lambda=poisson ratio

poisson_ratio=pop_percent.*rate_normaliser/100;
a=poisson_ratio(1);
b=poisson_ratio(2);
c=poisson_ratio(3);
d=poisson_ratio(4);
answer=double(P(7,1,a)*P(3,1,b)*P(2,1,c)*P(1,1,d))+double(P(6,1,a)*P(4,1,b)*P(2,1,c)*P(1,1,d))+double(P(5,1,a)*P(4,1,b)*P(3,1,c)*P(1,1,d));

%question
fprintf("In a city X, there is a 24/7 vaccination center where the arrival of people follows a poison distribution.");
fprintf('Assume a typical demographic distribution of \n')
fprintf('\n     Number     Age Group\n\t%d :-\t0-18 \n\t%d :-\t18-45 \n\t%d :-\t45-60 \n\t%d :-\tabove 60\n\n',pop_percent)
fprintf('The arrival rate of each age group at the centre is proportional to their population percentage, and the sum of arrival rates is proportional to %d.\n',rate_normaliser)
fprintf("Given that vaccines are delivered at the rate of 13/hour , find the probability that in the duration of 1 hour, the more people from the older population get vaccinated than the younger ones.\n\n");
fprintf("Options:\n");

%answergenerator
random_answer_matrix=[answer,answer+0.155,answer+0.355,answer+0.1];
tags=['A','B','C','D'];
ordered_matrix=random_answer_matrix(randperm(4));

%answer output
for i=1:length(tags)
    fprintf('%s. %.3f\n',tags(i),ordered_matrix(i))
    if ordered_matrix(i)==answer
        number=i;
    end
end

fprintf('\nAnswer:%s \n',tags(number))
fprintf('Explanation:\n\n');
%explanation
fprintf('Probablity of k possibilities in a time limit of x with a poisson ratio of lambda is')
probability=P(k,x,lambda)
fprintf('For a total of 13 vaccines per hour the possible permutations are:-    ')
fprintf('(in the descending order of age groups)')
permutations=[7,3,2,1;6,4,2,1;5,4,3,1]
fprintf('The total probability is the sum of all these possibilities\n=%.3f\n',answer)

%generator function

function pop_percent=randomgenerator(input_matrix)
    pop_percent=input_matrix(randi(4),:);
end
