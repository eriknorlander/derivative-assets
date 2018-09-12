% Works on the binomial model tree-principle following the algorithm
% presented in Björk Prop 2.24. 
function root = BinAlgo(S0, K, qu, qd, u, d, R, i, o, type)
s = @(x1,x2) (1/(1+R))*(x1*qu+x2*qd);
phi = @(k,n) S0*u^(n+1-k)*d^(k-1);

valueMaturity = Strike(i);

    function value = Strike(n)
        value = zeros(1,n+1);
        if(o == 'c')
            for k = 1:n+1
                value(k) = max(phi(k,n)-K,0);
            end
        elseif(o == 'p')
            for k = 1:n+1
                value(k) = max(K-phi(k,n),0);
            end
        end
   end

    function branch = Trav(A)
        if length(A) < 2
            branch = A(1);
        else
            level = zeros(1,length(A)-1);
            if type == 'eu'
                for j = 1:length(A)-1
                    level(j) = s(A(j), A(j+1));
                end
            elseif type == 'am'
                valueLocal = Strike(length(A)-2);
                for j = 1:length(A)-1
                   level(j) = max(s(A(j), A(j+1)), valueLocal(j)); 
                end
            end
            branch = Trav(level);
        end
    end

root = Trav(valueMaturity);
end


