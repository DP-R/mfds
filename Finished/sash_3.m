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
fprintf("\n\tV \t\t\t\tL\t\t\t\tU\n\n");
for i = 1:n
	var=0;
	if i == 2
		var=1;
	end
	print(V,n,i,var);
	print(L,n,i,0);
	print(U,n,i,0);
	fprintf("\n");
end
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
