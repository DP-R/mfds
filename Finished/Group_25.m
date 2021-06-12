clc;
clear all;
fprintf("CH5019 - Project \nGroup no. - 25");
for i = 1:5
    q1(1,i);
end

for i = 1:5
    q2(2,i);
end

for i = 1:5
    q3(3,i);
end

for i = 1:5
    q4(4,i);
end

for i = 1:5
    q5(5,i);
end

for i = 1:5
    q6(6,i);
end

function variant(x,y)
    fprintf("\n-------------------------------------------------------------------------------------------------\n\n");
    if y == 1
        fprintf("Q %d. - Type: Numerical\n",x);
    end
    fprintf("<Q. %d, V. %d>\n\n",x,y);
end

function q1(ques,vari)
    variant(ques,vari);
    %random input population data
    input_matrix=[31 33 17 19;27 32 22 19;24 30 32 14;26 27 29 18];
    %selection of one row
    pop_percent=randomgenerator(input_matrix);
    %random normaliser for rate constant
    rate_normaliser=randi([8,15]);
    % poisson dist.
    x=0;
    P=0;
    k=0;
    lambda=0;
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
    fprintf('The total probability is the sum of all these possibilities\n= %.3f\n',answer)

        %generator function
        function pop_percent=randomgenerator(input_matrix)
            pop_percent=input_matrix(randi(4),:);
        end
end

function q2(ques,vari)
    variant(ques,vari);
    n=15;
    fprintf("You are the regional manager of a famous paper selling company, and make sales over a period of %d days. The profits for each day automatically gets parsed to a specific software. The corporate expects you to have made profits in an increasing order.Unfortunately, the sort function in that software is faulty and doesn't always yield the right answer.\n",n);
    fprintf("The sort function in this software performs sequential operations of the type [D_i ,P_i], which means that the profits-list from indices (days) [1,D_i] would be sorted with a probability of P_i , or would remain the same with a probability of 1-P_i .\n");
    profit=get_profit(n);
    fprintf("\nGiven, profits during the given period:   [");
    for i = 1:n
        cur=round(profit(i),1);
        fprintf("%d ",cur);
    end
    fprintf("]\n\nFind the probability that the profits' list would be sorted after performing ALL of the below operations.\n")
    fprintf("Sequential operations: (of the form [D_i , P_i])\n");
    store=get_store(n);
    for i = 1:n
        cur=round(store(i,1));
        fprintf("[ %2d , %.4f ]\n",cur,store(i,2));
    end
    fprintf("\nOptions\n");
    Id=["A.","B.","C.","D."];
    options=solve(profit,store);
    for i = 1:4
        cur=round(options(i),4);
        fprintf("%s  %.4f \n",Id(i),cur);
    end
    fprintf("\nAnswer: D\n");
    fprintf("Explanation:\n");
    fprintf("Firstly, we make the actual sorted profits array and compare it with the given array.\n\n\tConsider 'idx' as the largest index such that profits[idx] != sorted_profits[idx] holds. (which in this case is %d).\n\nSo, we are not interested in the operations with D_i less than idx, since the array will still be unsorted. Now, let us look at the case where we *never* get a sorted array. The probability for that to happen is product of all (1-P_i)'s for every i>=idx .\n\nThe final answer is 1 - (the above result) , that is, 1 - (product of all (1-P_i)'s') for every i >= idx\n",options(5));
    fprintf("So, the probability will be :\n\n= 1 - ");
    for i = options(5):n
        fprintf("(1 - %f)",store(i,2));
        if i ~= n
            fprintf("*");
        end
    end
    fprintf("\n= %.4f \n",options(4));
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
end

function q3(ques,vari)
    variant(ques,vari);
    initial=zeros(1,3);
    for i = 1:3
        initial(i)=-10+randi(20);
    end
    angle_degs=15*(randi(11));
    angle=angle_degs*pi/180;
    final=zeros(1,3);
    for i = 1:3
        final(i)=-10+randi(20);
    end
    fprintf("A housefly in a room, travels to the point (%d, %d, %d), and disorients its path by an angle of %d degrees with respect to the positive X-axis, and finally reaches the point P(%d, %d, %d) with respect to this new frame.\n",initial(1),initial(2),initial(3),angle_degs,final(1),final(2),final(3));
    fprintf("Let this final coordinate, when read by the initial coordinate frame, be Q(x,y,z). ");
    fprintf("Which of the following matrices has eigenvalues equal to the coordinates of Q?\n")
    fprintf("(Consider the starting point of the housefly as the origin in the initial frame)\n\n");
    fprintf("\n\tOptions:\n");
    Id=["A.","B.","C.","D."];

    rot=get_rot(angle);
    trans=get_trans(initial);
    AB=get_AB(rot,trans);
    result=get_result(AB,final);

    for i = 1:4
        now=zeros(1,3);
        for j = 1:3
            now(j)=-5+randi(10)+randi(9999)/10000;
        end
        if i == 4
            now=result;
        end
        now_diag=diag(now);
        r=rand(3); %random_matrix
        % option matrix = inv(r)*diag(eig_values)*r
        final=inv(r)*now_diag*r;
        fprintf("%s\n",Id(i));
        disp(final);
    end
    fprintf("\nAnswer: D.\nExplanation:\n\n");
    fprintf("Let us name the initial frame as A, and the final frame (after translation and rotation) as B.\n");
    fprintf("Firstly we formulate the rotation matrix.\nIt is given as: (for an angle 'x' , wrt Positive X-axis)\n\n");
    fprintf("\t1     0     0     0  \n");
    fprintf("\t1  cos(x) -sin(x) 0  \n");
    fprintf("\t1  sin(x)  cos(x) 0  \n");
    fprintf("\t0     0     0     1\n\n");
    fprintf('Now, for translation by a vector "T(x,y,z)":\ntranslation matrix:\n\n');
    fprintf("\t1   0   0   T(x) \n");
    fprintf("\t0   1   0   T(y) \n");
    fprintf("\t0   0   1   T(z) \n");
    fprintf("\t0   0   0    1 \n\n");
    fprintf("We now form the matrix A/B (denoted here as 'AB') by multiplying the rotation and translation matrices, which is: \n");
    AB
    fprintf("\nSo, the new position (P) in old frame(A) can be expressed as:\n\t (P in A) = (A/B) * (P in B)\n");
    fprintf("Where , P in B :- coordinates of final point in the new frame, represented as a 4*1 matrix :-\n");
    p_in_b=zeros(4,1);
    for i = 1:3
        p_in_b(i,1)=final(i);
    end
    p_in_b(4,1)=1;
    p_in_b
    fprintf("\nUpon multiplying AB and p_in_b, we get a 4*1 matrix, and our answer is first three elements\n");
    result
    fprintf("Out of the given options, Option-D is a matrix that has these same eigenvalues.\n");

    % Functions used while solving:
    function rot = get_rot(angle)
        rot=zeros(4,4);
        rot(1,1)=1;
        rot(4,4)=1;
        rot(2,2)=cos(angle);
        rot(3,3)=cos(angle);
        rot(2,3)=-sin(angle);
        rot(3,2)=sin(angle);
    end
    function trans = get_trans(initial)
        trans=eye(4);
        for i = 1:3
            trans(i,4)=initial(i);
        end
    end 
    function AB = get_AB(rot,trans)
        AB=zeros(4,4);
        AB=rot*trans;
    end
    function res = get_result(AB,final)
        next=zeros(4,1);
        next(4,1)=1;
        for i = 1:3
            next(i,1)=final(i);
        end
        AB=AB*next;
        res=zeros(1,3);
        for i = 1:3
            res(i)=AB(i,1);
        end
    end
end

function q4(ques,vari)
    variant(ques,vari);
    n=4;
    A=rand(n,n);
    for i = 1:n
        for j = 1:n
            A(i,j)=A(i,j)-5+randi(10);
        end
    end
    [W,S,V_dash]=svd(A);
    V=V_dash';
    [L,U,f]=lu(V);
    fprintf("You are given a matrix");
    A
    fprintf("The singular value decomposition of A is given by A = W S V'.\n");
    fprintf("The LU Decomposition of V is represented as V = LU , where : \n");
    fprintf("\t L := Lower triangular matrix\n\t U := Upper triangular matrix\n\n");
    fprintf("Which of the following matrices have the eigen-values same as the matrix U.\n");
    fprintf("Options:\n\n");
    eigs_of_u=eigs(U);
    Id=["A.","B.","C.","D."];
    for i = 1:4
        now=rand(1,n);
        for j = 1:n
            now(j)=now(j)-0.5+rand(1);
        end
        if i==4
            now=eigs_of_u;
        end
        fprintf("%s \n",Id(i));
        r=rand(n);
        now_diag=diag(now);
        opt=inv(r)*now_diag*r;
        disp(opt);
    end
    fprintf("Answer: D\nExplanation:\n\n");
    fprintf("For the given matrix A, we express the unique singular value decomposition (SVD) as:\n");
    fprintf("\n\tA\t\t\t\t    W\t\t\t\tS\t\t\t\tV_dash\n\n");
	fprintf("\n\t A  =  W * S * V_dash\nAs: \n");
	W
	S
	V_dash
    for i = 1:n
        var=0;
        if i == 2
            var=1;
        end
        print(A,n,i,var);
        print(W,n,i,0);
        print(S,n,i,0);
        print(V_dash,n,i,0);
        fprintf("\n");
    end
    fprintf("\nHere, we have the last matrix as V' (transpose of V). So, we revert it back to V.");
    V
    fprintf("We now express V as the linear decomposition of 2 matrices L,U - lower, and upper triangular matrices respectively.\n");
    fprintf("\n\t V = L * U\nAs\n");
	L
	U
    fprintf("\nThe eigen values of the matrix U are : ");
    eigs_of_u
    fprintf("Out of the given matrices, Option D. has the same eigen values as that of U.\n");

    % Function to print matrices inline
    function print(X,n,i,var)
        for j = 1:n
            if X(i,j) < 0 || X(i,j) >= 10
                fprintf('');
            else
                fprintf(' ');
            end
            fprintf("%.3f ",X(i,j));
        end
        if i == 2 && var == 1
            fprintf("  =  ");
        else
            fprintf("\t ");
        end
    end
end

function q5(ques,vari)
    variant(ques,vari);
    C= rand(1,1);
    D= rand(1,1);
    e= rand(1,1);
    f= rand(1,1);
    g= rand(1,1);
    h= rand(1,1);

    fprintf( "The energy of a particle in the 2D coordinate system is defined as \n\t E = %.2f*(x(2) - x(1)^2)^2 + (%.2f - x(1))^2 Joules.\n\n",C,D);
    fprintf( "It is defined in the region such that: \n   x(1) + %.2f*x(2) <= %.2f \n   %.2f*x(1) + x(2) = %.2f \n   x(1) >= 0, x(2) >= 0\n\n",e,f,g,h);
    fprintf( "Find the position of minimum energy of the particle.\n");
    fun = @(x) C*(x(2)-x(1)^2)^2 + (D-x(1))^2;
        
    % constraints are written in the below form
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

    fprintf("\n Explanation:\n");
    fprintf(" The energy of particle in 2D coordinate system is given as \n\t E = %.2f*(q - x(1)^2)^2 + (%.2f - x(1))^2 Joules.\n\n",C,D);
    fprintf(" After writing constraints in the form: \n")
    fprintf(" c(x) <=0 \n")
    fprintf(" ceq(x) = 0\n")
    fprintf(" A.x <=b \n")
    fprintf(" Aeq.x = beq \n")
    fprintf(" lb <= x <= ub \n")
    fprintf(" \n we get: \n")
    x0
    A
    b
    Aeq
    beq
    lb
    fprintf(" Solving this using the function 'fmincon' gives \n")
    x
end

function q6(ques,vari)
    variant(ques,vari);
    a= randi([1,6],1,1);
    b= randi([1,5],1,1);
    step_size = 0.01* randi([1,7],1,1);
    iterations = 50*randi([2,6],1,1);
    fprintf( "You are stuck at a high altitude on a snow mountain while skewing.\n" )
    fprintf( "There is a drone, which can capture the topography of the region around you and converts it into a mathematical expression:\n\n");
    fprintf("\tf(x,y) = (x - %.2f)^2 + (%.2f - xy)^2.\n\n",a,b);
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
        fprintf("%s ",Id(i));
        var=-1+randi(2)+rand(1);
        if var == optimum_value
            var=var+rand(1);
        end
        fprintf("%f  \n",var);
    end
    fprintf("%s  %f \n",Id(4), optimum_value);
    fprintf("Answer: D\n");
    fprintf("\nExplanation:\n");
    fprintf("Partial derivative of 'f' at (x,y) w.r.t x & y is calculated as: \n")
    dfdx=diff(f,x)
    dfdy=diff(f,y)
    fprintf(" Starting guess is taken as [2,1]\n");
    fprintf(" For each iteration a new (x,y) is calculated using the step size And the formula [x(i+1),y(i+1)]=[x(i),y(i)]- step_size*grad(f)@(x(i),y(i)).\n")
    fprintf(" After the given number of iterations, 'optimum_value' and 'optimum_point' is calculated from the value of function at each step \n")
    optimum_value 
    optimal_point
end
