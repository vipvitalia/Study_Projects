function [ x ] = task4(Armijo_LS,f,df,testpts,startpt,a,b,c,d,res)
% G: optimization method to test; required signature: (f,df,ddf,x0,iter)
% f: R^2->R objective
% df: gradient
% ddf: Hessian
% testpts: number of iterations for G
% startpt: starting point
% a,b,c,d: rectangular region to plot = [a,b] x [c,d]
% res: plot resolution = res x res
% x: output after each iteration

    X = linspace(a,b,res);
    Y = linspace(c,d,res);
    Z = zeros(res,res);
    for i=1:res
        for j=1:res
            Z(i,j)=f([X(i);Y(j)]);
        end
    end

    x = zeros(testpts,2);
    x(1,:) = startpt;
    for k=2:testpts
        x(k,:) = Armijo_LS(f,df,[x(1,1);x(1,2)],k-1);
    end
    contourf(X,Y,Z',200); hold on
    
    %objective function
    fcontour(f(x), 'y');
    
    %line corresponding to c
    plot([a b], [c c], 'g');
    
    %show the effect of c and rho
    %to show it i'll implement armijo ls when c=rho=1
    s = zeros(testpts,2);
    s(1,:) = startpt;
    for k=2:testpts
        s(k,:) = Armijo_LS_1(f,df,[s(1,1);s(1,2)],k-1);
    end
    fcontour(f(s), 'm');
    
    %points
    scatter(x(:,1),x(:,2),'r','filled');
    
    %nice test functions!!!!
    
    %f=@(x) sqrt(1+x.^2);
    %df=@(x) x/sqrt(1+x.^2);
    
    %f=@(x) log(x.^(-1));
    %df=@(x) (-1)(x.^(-1));
    
    %f=@(x) exp(5*x+2);
    %df=@(x) 5*exp(5*x+2);
    
    %f=@(x) tan(x-1);
    %df=@(x) sec(x-1).^2;
    
    
    hold off;
end

function [ alpha ] = Armijo_LS(f, df, ~, ~, ~, ~, ~)
% f: vector->scalar function -- the objective
% df: gradient function
% p: search direction
% x: starting point
% alpha: initial step length
% rho: step lenght multiplier
% c: condition multiplier
    x=0;
    rho=0.5;
    c=0.2;
    alpha=0.9;
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

function [ alpha ] = Armijo_LS_1(f, df, ~, ~, ~, ~, ~)
% f: vector->scalar function -- the objective
% df: gradient function
% p: search direction
% x: starting point
% alpha: initial step length
% rho: step lenght multiplier
% c: condition multiplier
    x=0;
    rho=1;
    c=1;
    alpha=0.9;
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

