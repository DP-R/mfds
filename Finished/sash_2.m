clc;
clear all;
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
