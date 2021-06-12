format short g
clc;
clear all;

fprintf("CH5019 - Project\n");
fprintf("Group - 25");
for i = 1:5
    q1(1,i);
end

q2(2,i);

function variant(x,y)
    fprintf("\n\n\n");
    fprintf("<Q. %d, V. %d>\n----------------------------------------------\n",x,y);
end

function q1(ques,vari)
    variant(ques,vari);
    c1 =randi([1,6],1,1);
    c2 = randi([3,7],1,1);

    A11 =randi([1,2],1,1);
    A12 =randi([5,7],1,1);
    A21 =randi([5,6],1,1);
    A22 =randi([1,2],1,1);
    A31 =randi([2,2],1,1);
    A32 =randi([2,2],1,1);

    b1 =100*randi([15,17],1,1);
    b2 =100*randi([10,13],1,1);
    b3 =100*randi([9,12],1,1);

    fprintf( "Solve the LPP using graphical method and find the Optimal Basic Feasible Solution from the graph.\n")
    fprintf( "Objective Function is defined as Maximise %.2f x1 +%.2f x2.\n",c1,c2)
    fprintf( "Constraints are given by %.2f x1 +%.2f x2 <= %.2f , %.2f x1 +%.2f x2 <= %.2f , %.2f x1 +%.2f x2 <= %.2f and x1,x2>=0.\n",A11,A12,b1,A21,A22,b2,A31,A32,b3)

    % Input parameters
    C= [c1,c2];       %cost
    A= [ A11 A12; A21 A22;A31 A32]; % weights of x1, x2 in each constraint
    b = [b1;b2;b3]; % RHS of constraint

    y1 = 0:1: max(b);
    x21 = (b(1)-A(1,1).*y1)./A(1,2);
    x22 = (b(2)-A(2,1).*y1)./A(2,2);
    x23 = (b(3)-A(3,1).*y1)./A(3,2);

    x21 = max(0,x21);
    x22 = max(0,x22);
    x23 = max(0,x23);

    plot(y1, x21, 'r',y1, x22, 'k',y1, x23, 'b') 
    xlabel ('value of x1')
    ylabel ('value of x2')
    title (' x1 vs x2')
    legend ('Line 1' , 'Line 2' , 'Line 3')
    grid on

    % finding corner points on axes
    cx1 = find(y1==0);

    c1 = find (x21==0);
    Line1 = [y1(:,[c1 cx1]) ; x21(:,[c1 cx1])]';

    c2 = find (x22==0);
    Line2 = [y1(:,[c2 cx1]) ; x22(:,[c2 cx1])]';

    c3 = find (x23==0);
    Line3 = [y1(:,[c3 cx1]) ; x23(:,[c3 cx1])]';

    corpt = unique([Line1;Line2;Line3;],'rows');

    % finding corner points
    Corner_Points(3,2) = 0;
    arr= [1,2,3,1];
    for i= 1:3
        A1 = A(arr(i),:);
        b_1 = b(arr(i),:);
        A2 = A(arr(i+1),:);
        b_2 = b(arr(i+1),:);
            Aa = [A1;A2];
            Bb = [b1;b2];
            New_corner_point = Aa\Bb;
        Corner_Points(i,:) = [New_corner_point];
    end
         All_Corner_Points = [Corner_Points; corpt ]
        
    Feasible_Corner_Points = constraint(All_Corner_Points, A11,A12,A21,A22,A31,A32,b1,b2,b3);
    Feasible_Corner_Points = unique (Feasible_Corner_Points, 'rows');

    for i=1: size(Feasible_Corner_Points,1)
        z(i,:) = sum(Feasible_Corner_Points(i,:).*C);
    end

    x1_x2_z = [Feasible_Corner_Points z];

    [z_val, z_index] = max(z);
    optimal_BFS_value = x1_x2_z(z_index,:);

    fprintf("\nOptions\n");
    Id=["A.","B.","C.","D."];

    for i = 1:3        
        fprintf("%s %f %f \n",Id(i),All_Corner_Points(i,:));
    end
        fprintf("%s %f %f \n",Id(4),Feasible_Corner_Points(z_index,:));
     fprintf("\nExplanation:\n");
     fprintf("The graph is generated from the code written above.\n")
     fprintf("the corner points other than on the axes are calculated from the graph. \n")
     Corner_Points
     fprintf("feasibilty of these Corner points are checked. \n")
     fprintf("Optimum value from the feasible corner points including the corner points on the axis is calculated.\n")
     x1_x2_z(z_index,:)
        function out = constraint(X, A11,A12,A21,A22,A31,A32,b1,b2,b3)         
            x1 = X(:,1);
            x2 = X(:,2);
           
            cons1 = A11.*x1+ A12.*x2 - b1;   %< sign
            h1 = find (cons1>0);
            X(h1,:)=[] ;
            
            x1 = X(:,1);
            x2 = X(:,2);
            
            cons2 = A21.*x1+ A22.*x2 - b2;   %< sign
            h2 = find (cons2>0);
            X(h2,:)=[] ;
            
            x1 = X(:,1);
            x2 = X(:,2);
            
            cons3 = A31.*x1+ A32.*x2 - b3;   %< sign
            h3 = find (cons3>0);
            X(h3,:)=[] ;
            
            out =X;
        end
end

function q2(ques,vari)
    variant(ques,vari);
    fprintf('As part of an experiment to determine the efficiency of a vaccine, a test drive is conducted and certain parameters were measured during the drive like gender,age and weight\n')
    fprintf('Determine what kind of data they were?\n')
    answer=['nominal interval ratio'];
    dupe1=['ordinal',' interval', ' ordinal'];
    dupe2=['ratio',' interval', ' ordinal'];
    dupe3=['nominal',' ratio', ' ordinal'];
    fprintf('A: %s\n',answer)
    fprintf('B: %s\n',dupe1)
    fprintf('C: %s\n',dupe2)
    fprintf('D: %s\n',dupe3)
    fprintf("\nAnswer: A\n");
    fprintf('Explanation:\n');
    fprintf('Gender is nominal as it is purely an id label for collection.\n')
    fprintf('Age is interval data as the order and intervals within it are meaningful and used for data segregation.\n')
    fprintf('Weight is a ratio variable as it has the properties of an interval and also zero weight is meaningful and two weight variables can be compared by division.\n')

    

end