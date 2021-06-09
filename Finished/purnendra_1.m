%random input population data
input_matrix=[31 33 17 19;27 32 22 19;24 30 32 14;26 27 29 18]

%selection of one row
pop_percent=randomgenerator(input_matrix)

%random normaliser for rate constant
rate_normaliser=randi([8,15])

% poisson dist.
syms x  P k lambda
% probability of k events occuring at a given time interval x
P(k,x,lambda)=exp(-lambda*x)*(lambda*x)^k/factorial(k)
% k no. of events
% x no.test cases(time interval in this case)
%lambda=poisson ratio

poisson_ratio=pop_percent.*rate_normaliser/100
a=poisson_ratio(1)
b=poisson_ratio(2)
c=poisson_ratio(3)
d=poisson_ratio(4)

answer=double(P(7,1,a)*P(3,1,b)*P(2,1,c)*P(1,1,d))+double(P(6,1,a)*P(4,1,b)*P(2,1,c)*P(1,1,d))+double(P(5,1,a)*P(4,1,b)*P(3,1,c)*P(1,1,d))

%question
fprintf('Assume that the arrival of people at a 24/7 vaccination centre follows a poisson distribution. Assume a typical demographic distribution of \n')
fprintf('0/0 group(age)\n %d 0-18 \n %d 18-45 \n %d 45-60 \n %d above 60',pop_percent)
fprintf('Also the arrival rate of each age group at the centre is proportional to their population percentage. and the sum of arrival rates is proportional to %d',rate_normaliser)
fprintf('\nProbability that in the duration of 1 hr the older population get more vaccines than their younger ones .The number of vaccines delivered in an hour are only 13')

%answergenerator
random_answer_matrix=[answer,answer+0.155,answer+0.355,answer+0.1]
tags=['A','B','C','D'];
ordered_matrix=random_answer_matrix(randperm(4));

%answer output
for i=1:length(tags)
    fprintf('%s. %f\n',tags(i),ordered_matrix(i))
    if ordered_matrix(i)==answer
        number=i;
    end
end

fprintf('answer:%s',tags(number))

%explanation
fprintf('probablity of k possibilities in a time limit of x with a poisson ratio of lambda is\n')
P(k,x,lambda)
fprintf('For a total of 13 vaccines per hour the possible permutations are \n')
[7,3,2,1;6,4,2,1;5,4,3,1]
fprintf('in the descending order of age groups')
fprintf('the total probability is the sum of all these possibilities')

%generator function

function pop_percent=randomgenerator(input_matrix)
    pop_percent=input_matrix(randi(4),:);
end

