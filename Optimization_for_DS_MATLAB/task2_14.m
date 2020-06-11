%test function
%f = @(x,y,z) (x.^2)/5+2*y.^(2)+2*z.^(2)-7

function [vectors] = task2_14(f,x0)

    % define an array of values for x y and z
    % The region will depend on the function
    %x = -10:0.1:10; 
    %y = -10:0.1:10; 
    %z = -10:0.1:10; 

    % create a meshgrid
    %meshgrid(x,y,z);
    
    %set a number of iterations HERE
    iter = 10;
    
    vectors = coord_descent(f,x0,iter);
    
    hold on
    
    for k=1:iter
        vectarrow(vectors(:,k),vectors(:,k+1));
        scatter3(vectors(1,k),vectors(2,k),vectors(3,k), 'MarkerFaceColor',[0 .75 .75]);
    end    
    hold off;
end

function [ x ] = coord_descent(f,x0,iter)
% f: R^n->R objective
% x0: starting point
% iter: number of iterations

    eps = 1e-10;
    n=size(x0,1);
    I = eye(n);
    
    x = x0;
    f0 = f(x0);
    for k=1:iter
        found_decrease = false;
        for i=1:n
            p = I(:,i);
            if f(x+eps*p)>f0
                if f(x-eps*p)>f0
                    continue;
                else
                    p=-p;
                    found_decrease = true;
                end
            else
                found_decrease = true;
            end
            fdir=@(t) f(x+t*p);
            tmax=eps;
            while fdir(tmax)<fdir(tmax/2)
                tmax=2*tmax;
            end
            gamma=zero_unimodal(fdir,0,0,0,0,tmax,2*log(eps/tmax)/log(2/3));
            x = x+gamma*p;
            f0 = f(x+gamma*p);
        end
        if ~found_decrease
            break;
        end
    end
end