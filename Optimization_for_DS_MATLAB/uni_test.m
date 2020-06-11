syms a b c s
eqns = [a+2*b+3*c<=1,
            5*a+c<=1,
            4*b+c<=1,
            a+b+c==1];

S=solve(eqns,[a,b,c],'ReturnConditions',true)        
S.a
        

        
        %[A,b] = equationsToMatrix(eqns)

        %A*s==b

        %S=solve(b,s)