function [ x ] = linear_LSq(J,y)
% J is the linear least squares coefficient matrix
% y is the expected value of Jx
% x is the unique minimizer of norm(Jx-y), or its approximation for an ill-conditioned problem

    sigma_min = 0.00000001;
    [U,D,V] = svd(J);
    x=zeros(size(V,1),1);
    for k=1:size(V,1)
        if D(k,k) < sigma_min
            break;
        end
        x = x + U(:,k)'*y / D(k,k) * V(:,k);
    end
end