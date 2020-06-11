%sample1 - linear least squares Fourier example
f = @(t) ((pi-t)./2).^2;
T = linspace(0,2*pi,1000);
y = f(T);
J = ones(1000,7);
for j=1:1000
    for i=1:3
        J(j,2*i) = cos(i*T(j));
        J(j,2*i+1) = sin(i*T(j));
    end
end
x = linear_LSq(J,y');
g = @(t) x(1)+x(2)*cos(t)+x(3)*sin(t)+x(4)*cos(2*t)+x(5)*sin(2*t)+x(6)*cos(3*t)+x(7)*sin(3*t);
y2 = g(T);
plot(T,y,'x',T,y2);

%sample2 - linear least squares polynomial example
f = @(t) t.^3-t.^2+3*t+2;
T = linspace(-5,5,1000);
y = f(T);
y = y+randn(1,1000);
J = ones(1000,4);
for j=1:1000
    for i=2:4
        J(j,i) = T(j)^(i-1);
    end
end
x = linear_LSq(J,y');
y2 = polyval(flip(x),T);
plot(T,y,'o',T,y2);

%sample3 - nonlinear least squares wave fitting
g = @(t) 3.*sin(pi.*t+1);
T = linspace(0,5,1000);
Y = g(T);
Y = Y+randn(1,1000)/5;
plot(T,Y,'o');
xk = Gauss_Newton(T,Y,[1;1;1],30);
sol = @(t) xk(1).*sin(xk(2).*t+xk(3));
plot(T,Y,'o', T,sol(T));