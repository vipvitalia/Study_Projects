function [ x ] = conj_dir2D(f,~,~,x0,iter)
% f: R^2->R objective
% x0: starting point
% iter: number of iterations

    eps = 1e-10;
    
    x = x0;
    f0 = f(x0);
    for k=1:iter
        found_decrease = false;
        p = [0;1];
        if f(x+eps*p)>f0
            if f(x-eps*p)<f0
                p=-p;
                found_decrease = true;
            end
        else
            found_decrease = true;
        end
        if found_decrease
            fdir=@(t) f(x+t*p);
            tmax=eps;
            while fdir(tmax)<fdir(tmax/2)
                tmax=2*tmax;
            end
            gamma=zero_unimodal(fdir,0,0,0,0,tmax,2*log(eps/tmax)/log(2/3));
            x = x+gamma*p;
        end
        z = coord_descent(f,0,0,x,1);
        p = z-x;
        if norm(p) < eps
            break;
        end
        p = p/norm(p);
        f0 = f(x);
        found_decrease = false;
        if f(x+eps*p)>f0
            if f(x-eps*p)<f0
                p=-p;
                found_decrease = true;
            end
        else
            found_decrease = true;
        end
        if found_decrease
            fdir=@(t) f(x+t*p);
            tmax=eps;
            while fdir(tmax)<fdir(tmax/2)
                tmax=2*tmax;
            end
            gamma=zero_unimodal(fdir,0,0,0,0,tmax,2*log(eps/tmax)/log(2/3));
            x = x+gamma*p;
            f0 = f(x);
        end
    end
end