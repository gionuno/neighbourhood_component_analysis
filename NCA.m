function A = NCA(X,C,K,T,dt)
    A = randn(K,size(X,1));
    for t = 1:T
        disp(t);
        AX = A*X;
        dG = zeros([size(X,1),size(X,1)]);
        p_i  = zeros(size(X,2));
        p_Ci = zeros(size(X,2));
        for i = 1:size(X,2)
            for j = 1:size(X,2)
                if i ~= j
                    p_i(j) = exp(-norm(AX(:,i)-AX(:,j)));
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
            p_Ci = p_Ci/sum(p_Ci);
            X_i = repmat(X(:,i),[1,size(X,2)])-X;
            p = p_i - p_Ci;
            dG = dG + X_i*diag(p)*X_i';
        end
        A = A + dt*2.0*A*dG;
    end
end
