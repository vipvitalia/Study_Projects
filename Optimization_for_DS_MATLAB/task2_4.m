function [x] = task2_4(f,df,x0,p)
    
%size of p, n=m
    [~,n] = size(p);

    x = zeros(n,n+1);
    z = zeros(n,n+1);
    
    alpha = Armijo(f, df, p(:,n), x0);
    
    %Compute the minimizer x1 of f along x0+alpha*p_n
    x1 = fminsearch(f,x0+alpha*p(:,n));
    k=1;
    
    while norm(x(:,k)-x(:,k+1)) > 0.0000001     
        z(:,1) = x1;
        for j = 1:n
            alpha = Armijo(f, df, p(:,j), z(:,j));
            z(:,j+1) = z(:,j) + alpha*p(:,j);
        end
        p(:,n-1) = p(:,n);
        p(:,n) = z(:,n+1) - z(:,1);
        alpha_n = Armijo(f, df, p(:,n), z(:,n+1));
        x(:,k) =  z(:,n+1) + alpha_n*p(:,n);
        k = k+1;
    end 
end

function [ alpha ] = Armijo(f, df, p, x)
% f: vector->scalar function -- the objective
% df: gradient function
% p: search direction
% x: starting point
% alpha: initial step length
% rho: step lenght multiplier
% c: condition multiplier
   
    rho=0.5;
    c=0.2;
    alph=1;
    
    f0 = f(x);
    g0 = df(x);
    x0 = x;
    x = x0 + alph * p;
    fk = f(x);
    
    % repeat until the Armijo condition is satisfied
    while fk > f0 + c * alph * (g0'*p)
      alpha = rho * alph;
      x = x0 + alph * p;
      fk = f(x);
    end
end