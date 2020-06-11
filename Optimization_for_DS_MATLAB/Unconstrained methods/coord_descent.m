function [ x ] = coord_descent(f,~,~,x0,iter)
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