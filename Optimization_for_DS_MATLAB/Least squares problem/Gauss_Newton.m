function [ xk ] = Gauss_Newton(T,Y,x0,iter)
% T,Y: paramteres for functions r and J, i.e. T: sampling points, Y: sample values
% r: R^n->R^m is the residual function of r_j entries
% J: R^n->R^{mxn} is the derivative of r, i.e. its rows are the gradients of r_j-s
% x is a local minimizer of the sum of r_j^2 -s.

    rho=0.5; %For the Armijo LS; usually 0.5 or 0.9
    c=0.2; %For the Armijo LS; usually 0.01 or 0.2

    xk=x0;
    f = @(x) 0.5*sum(r(x,T,Y).^2);
    df = @(x) J(x,T)'*r(x,T,Y);
    for k=1:iter
        H = J(xk,T);
        b = -r(xk,T,Y);
        p = linear_LSq(H,b);
        alpha = norm(p);
        p = p/norm(p);
        if sum(isnan(p)) > 0
            break;
        end
        gamma = Armijo_LS(f,df,p,xk,alpha,rho,c);
        xk = xk+gamma*p;
    end
end

% example of r and J
function [ rx ] = r(x,T,Y)
    rx = x(1).*sin(x(2).*T'+x(3))-Y';
end

function [ Jx ] = J(x,T)
    Jx = zeros(size(T,2),size(x,1));
    for j=1:size(T,2)
        Jx(j,:) = [sin(x(2)*T(j)+x(3)) x(1)*cos(x(2)*T(j)+x(3))*T(j) x(1)*cos(x(2)*T(j)+x(3))];
    end
end