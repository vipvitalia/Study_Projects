function [ alpha ] = Armijo_LS(f, df, ~, ~, ~, ~, ~)
% f: vector->scalar function -- the objective
% df: gradient function
% p: search direction
% x: starting point
% alpha: initial step length
% rho: step lenght multiplier
% c: condition multiplier
    x=[0;0];
    rho=0.5;
    c=0.2;
    alpha=1;
    p=0.2;
    
    f0 = f(x);
    g0 = df(x);
    x0 = x;
    x = x0 + alpha * p;
    fk = f(x);
    
    % repeat until the Armijo condition is satisfied
    while fk > f0 + c * alpha * (g0'*p)
      alpha = rho * alpha;
      x = x0 + alpha * p;
      fk = f(x);
    end
end
