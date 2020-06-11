function [ x ] = penalty_path(f,df,~,~,~,~,h,dh,~,x0,iter)
% f: R^n->R objective
% df, ddf: gradient and Hessian
% NOT IMPLEMENTED g: R^n->R^k inequality constraints, g_i(x)<=0 must be satisfied
% h: R^n->R^m equality constraints, h_i(x)==0 must be satisfied
% NOT IMPLEMENTED dg: R^{nxk} matrix containing the gradients of g_i-s as rows
% dh: R^{mxn} derivative matrix containing the gradients of h_i-s as rows
% x0: arbitrary starting point
% iter: number of iterations

    rho = 1;
    mul = 2;
    internal_limit = 25;
    
    x = x0;
    for l=1:iter
        frho = @(x) f(x)+rho*sq_penalty(h,x);
        dfrho = @(x) df(x)+rho*sq_penalty_grad(h,dh,x);
        ddfrho = @(x) fHesse(dfrho,x);
        x = Newton(frho,dfrho,ddfrho,x,internal_limit);
        rho = rho*mul;
    end
end

function [ hx ] = sq_penalty(h,x)
% returns the eval of the square penalty at point x
    hx = 0.5*sum(h(x).^2);
end

function [ dhx ] = sq_penalty_grad(h,dh,x)
% returns the gradient of the Carrol-type barrier at point x
    dhx = dh(x)'*h(x);
end