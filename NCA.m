function A = NCA(X,C,D,T,dt)
    A = 1e-1*randn(size(X,2),D);
    sA = zeros(size(A));
    dA = zeros(size(A));
    
    for t = 1:T
        disp(t);
        AX = X*A;
        dG = zeros([size(X,2),size(X,2)]);
        p_i  = zeros([size(X,1),1]);
        p_Ci = zeros([size(X,1),1]);
        F = 0.0;
        for i = 1:size(X,1)
            for j = 1:size(X,1)
                if i ~= j
                    p_i(j) = exp(-norm(AX(i,:)-AX(j,:)).^2);
                else
                    p_i(j) = 0.0;
                end
                if C(i) == C(j) && i ~= j
                    p_Ci(j) = p_i(j);
                else
                    p_Ci(j) = 0.0;
                end
            end
            p_i = p_i/sum(p_i);
            F = ((i-1)*F+sum(p_Ci))/i; 
            p_Ci = p_Ci / sum(p_Ci);
            X_i = repmat(X(i,:),[size(X,1),1])-X;
            p = p_i - p_Ci;
            dG = dG + X_i'*diag(p)*X_i;
        end
        disp(F);
        dG = dG*A;
        beta = sum(sum(dG.^2))/(sum(sum(dA.^2))+1e-2);
        sA = dG + beta*sA;
        dA = dG;
        A = A + dt*sA;
    end
end
