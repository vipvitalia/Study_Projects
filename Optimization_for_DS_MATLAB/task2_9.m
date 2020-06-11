function [x] = task2_9(J,y)
% J is the linear least squares coefficient matrix
% y  is the expected value of Jx
% x is the unique minimizer of norm(Jx-y), or its approximation for an ill-conditioned problem
% Q is the orthogonality matrix
% R is the upper triangle matrix
% P is the permutation matrix
[Q,R,P] = qr(J);

%First s columns and rows
s = size(J,2);
Q = Q(:,1:s);  
R = R(1:s,:); 

%R*zeros = Q'*y;
zero = zeros(s,1);
vector = Q' * y; 

for i = s:-1:1
    if abs(R(i,i)) < 0.00000001  %the value can be changed
        disp(strcat("Wrong condition in the column ", num2str(i)));
    end
    
    zero(i) = vector(i)/R(i,i);
    vector(1:i-1) = vector(1:i-1)-R(1:i-1,i)*zero(i);
end

%transform back the solution
x = P*zero;
end