function[x] = task7(f,a,b)
    %a,b - boundaries of a line search
    eps = 1e-3;
    %number of array elements
    k = (b-a)/eps;
    %Fibonacci array fib(n)
    f1 = 1;
    f2 = 1;
    s= f1 + f2;
    n = 2;
    %
    while (s<=k)
        s = f1 + f2;
        f1 = f2;
        f2 = s;
        n = n+1;
    end
    %
    fib = zeros(1,n);
    fib(1) = 1;
    fib(2) = 1;
    %
    for i= 3:1:n
        fib(i) = fib(i-2) + fib(i-1);
    end
    %
    d = b-a;
    %
    d = d * fib(n-1)/fib(n);
    %
    x1 = b-d;
    x2 = a+d;
    %
    %iteration index
    k = 1;
    %
    while (n>2)
        f1 = f(x1);
        f2 = f(x2);
        k = k+1;
        d = d* fib(n-k)/fib(n-k+1);
         
        if (f1<f2)
            b = x2;
            x2 = x1;
            x1 = b-d;
         
        else
            a = x1;
            x1 = x2;
            x2 = a+d;
            
        
        n = n-1;
        end
        
       
    end
   %
   xMin = (a+b)/2;
   yMin = f(xMin);
   %
   xMin;
   yMin;
            