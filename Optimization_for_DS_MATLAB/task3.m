function [ x ] = task3()
    %containings of each fruit
    %abble = 0*f+1*g+1*i+5*h;
    %balala = 4*f+2*g+2*i+0*h;
    %caranbola = 1*f+1*h+3*g+3*i;
    %
    %weights of each fruit
    %1 = a+b+c;
    %
    %one pound of coctail each day
    %abble * a + balala * b + caranbola * c = 1;
    %
    %after simplification: a+2b+3c = 5a+c = 4b+c
    %
    %each amount of vitamins should be equal 
    % a+2b+3c = 5a+c <=> 4a-2b-2c = 0
    % a+2b+3c = 4b+c <=> a -2b+2c = 0
    % 5a+c = 4b+c    <=> 5a-4b+0c = 0
    %
    %Therefore, we can form a matrix A:
    syms a b c s
    eqns = [4*a-2*b-2*c == 0,
            a-2*b+2*c == 0,
            5*a-4*b == 0,
            a+b+c == 1];
    %
    S=solve(eqns,[a,b,c],'ReturnConditions',true);
    S.a
    S.b
    S.c
    
    %I would recommend gaussian normal equation or
    %gradient descent to solve this problem.