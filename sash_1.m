n=15;
fprintf("Q2. You are the regional manager of a famous paper selling company, and make sales over a period of %d days. The profits for each day automatically gets parsed to a specific software. The corporate expects you to have made profits in an increasing order.Unfortunately, the sort function in that software is faulty and doesn't always yield the right answer.\n",n);
fprintf("The sort function in this software performs %d sequential operations of the type [D_i ,P_i], which means that the list from indices [1,D_i] would be sorted with a probability of P_i , or would remain the same with a probability of 1-P_i .\n",n);
profit=get_profit(n);
fprintf("\nGiven, profits during the given period:   [");
for i = 1:n
    cur=round(profit(i),1);
    fprintf("%d ",cur);
end
fprintf("]\n\nFind the probability that the profits' list would be sorted after performing ALL of the below operations.\n")
fprintf("Sequential operations: (in pairs of D_i , P_i)\n");
store=get_store(n);
for i = 1:n
    cur=round(store(i,1));
    fprintf("[ %d , %.4f ]\n",cur,store(i,2));
end
fprintf("\nOptions\n");
Id=["A.","B.","C.","D."];
options=solve(profit,store);
for i = 1:4
	cur=round(options(i),4);
    fprintf("%s  %f \n",Id(i),cur);
end
fprintf("\nANSWER: D\n");
fprintf("Explanation:\n\t");
fprintf("Firstly, we make the actual sorted profits array and compare it with the given array.Consider 'idx' as the largest index such that profits[idx] != sorted_profits[idx] holds (Which in this case is %d ). So, we are not interested in the operations with D_i less than idx, since the array will still be unsorted.Now, let us look at the case where we *never* get a sorted array. The probability for that to happen is product of all (1-P_i)'s for every i>=idx .The final answer is 1 - (the above result) , that is, 1 - (product of all (1-P_i)'s') for every i >= idx\n",options(5));
fprintf("So, the probability will be :\n\n1 - ");
for i = options(5):n
	fprintf("(1-%f)",store(i,2));
	if i ~= n
		fprintf(" * ");
	end
end
fprintf("\n= %f \n",options(4));
% Function to generate profits array, such that idx is some value not equal to n
function a=get_profit(n)
    a=zeros(1,n);
    for i = 1:n
        a(i)=randi(999);
    end
    idx=3+randi(2);
    a=sort(a);
    tmp=zeros(0,0);
    for i = n-idx+1:n
        tmp(i-n+idx)=a(i);
    end
    for i = n-idx+1:n
        a(end)=[];
    end
    shuffle_index=randperm(length(a));
    b=a;
    for i = 1:length(a)
        a(i)=b(shuffle_index(i));
    end
    a=[a tmp];
end
% Function to generate operations array for days numbered 1 to n
function a=get_store(n)
    a=zeros(n,2);
    for i = 1:n
        a(i,1)=i;
    end
    for i = 1:n
        r=randi(999);
        r=min(r,1000-r);
        a(i,2)=round(r/1000,4);
    end
end
% Solver function
function res=solve(profit,store)
    n=length(profit);
    b=sort(profit);
    for i = n:-1:1
        if profit(i) ~= b(i)
            idx=i;
            break;
        end
    end
    p=1;
    for i = idx:n
        p=p*(1-store(i,2));
    end
    p=1-p;
    p=round(p,5);
    random_numbers=randperm(round(p,3)*1000-1);
    random_numbers=random_numbers(1:4);
    res=zeros(1,4);
    for i = 1:3
        res(i)=random_numbers(i)/1000;
    end
    res(4)=p;
	res(5)=idx;
end
