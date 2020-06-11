function [xopt, fopt, numiter, gnorm, dx] = graddescent(varargin)
    if nargin==0
        %starting point
        x0= [3 3]';
    elseif nargin==1
        x0= varargin{1};
    else
        error(' incorrect number of input arguments ')
    end
    termtolerance = 1e-6;
    maxiter = 10;
    minperturb = 1e-6;
    alpha = 0.1;
    gnorm = inf;
    x=x0;
    numiter = 0;
    dx = inf;
    %defining the objective function
    f= @(x1, x2) 6*(x1.^2 + x2).^2 - 5;
    %plotting
    figure(1);
    clf;
    fcontour(f);
    f2 = @(x) f(x(1),x(2));
    %gradient descent algorithm
    while and (gnorm>=termtolerance, and(numiter <=maxiter, dx>=minperturb))
        g = grad(x) ;
        gnorm = norm(g) ;
        %step
        xnew = x-alpha*g;
        %check the step
        if ~isfinite(xnew)
            display(['number of iterations:' num2str(numiter)] )
           
        end
        %plotting the current point
        plot([x(1) xnew(1)],[x(2) xnew(2)],'ko-')
        refresh
        %termination metrics
        numiter = numiter + 1;
        dx = norm(xnew-x) ;
        x = xnew;
    end 
    xopt = x;
    fopt = f2(xopt) ;
    numiter = numiter - 1;
    
    %defining the gradient of the objective function 
     %function g=grad(x)
     %g = [2*x(1) + x(2)
       % x(1) + 6*x(2)];
    
    function g=grad(x) 
      g = 6*(x(1).^2+5*x(2) ).^2-5 ;