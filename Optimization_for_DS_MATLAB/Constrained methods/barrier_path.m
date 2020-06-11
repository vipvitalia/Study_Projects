function [ x ] = barrier_path(f,df,~,g,dg,~,~,~,~,x0,iter)
% f: R^n->R objective
% df, ddf: gradient and Hessian
% g: R^n->R^k inequality constraints, g_i(x)<=0 must be satisfied
% dg: R^{kxn} matrix, the derivative of g, containing the gradients of g_i-s as rows
% x0: interior(!) starting point, i.e. g_i(x0)<0 must hold
% iter: number of iterations

    rho = 1;
    mul = 2;
    internal_limit = 25; %Usual choice is 20-50 for Newton subroutine
    
    x = x0;
    for l=1:iter
        frho = @(x) f(x)+1/rho*Carrol_barrier(g,x);
        dfrho = @(x) df(x)+1/rho*Carrol_barrier_grad(g,dg,x);
        ddfrho = @(x) fHesse(dfrho,x);
        x = Newton_barrier(frho,dfrho,ddfrho,x,internal_limit,g);
        rho = rho*mul;
    end
end

function [ gx ] = Carrol_barrier(g,x)
% returns the eval of the Carrol-type barrier at point x
    gx = -sum(1./g(x));
end

function [ dgx ] = Carrol_barrier_grad(g,dg,x)
% returns the gradient of the Carrol-type barrier at point x
    dgx = dg(x)'*(1./(g(x).^2));
end

function [ x ] = Newton_barrier(f,df,ddf,x0,iter,g)
    rho=0.5; %For the Armijo LS; usually 0.5 or 0.9
    c=0.2; %For the Armijo LS; usually 0.01 or 0.2
    
    delta = 0.00000001; %Correction constant to ensure p is a descent direction

    x=x0;
    for k=1:iter
        H = ddf(x);
        % Required to check if finite differencing the Hessian, to make sure
        % not stepping out
        if sum(isinf(H)) > 0
            break;
        end
        % ----------------------------------------------------
        [Q,D] = eig(H);
        for i=1:size(D(:,1))
            if D(i,i)<delta
                D(i,i)=1/delta;
            else
                D(i,i)=1/D(i,i);
            end
        end
        p = -Q*D*Q'*df(x);
        alpha = norm(p);
        p = p/norm(p);
        if sum(isnan(p)) > 0
            break;
        end
        %Have to ensure we are searching in int G !!
        while ~all(g(x+alpha*p)<0)
            alpha = alpha*rho;
        end
        %-------------------------------------------
        gamma = Armijo_LS(f,df,p,x,alpha,rho,c);
        x = x+gamma*p;
    end
end