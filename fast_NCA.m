function [A,E] = fast_NCA(X,C,D,T,B,dt)
    A = 1e-1*randn(size(X,2),D);
    sA = zeros(size(A));
    dA = zeros(size(A));
    E = zeros(T+1);
    for t = 0:T
        i = mod(t,size(X,1))+1;
        idxs = [(1:(i-1))';((i+1):size(X,1))'];
        rper = randperm(size(idxs,1));
        idxs = idxs(rper(1:B));
        disp(t);
        X_i = repmat(X(i,:),[size(idxs,1),1])-X(idxs,:);
        AX = X_i*A;
        dG = zeros([size(X,2),size(X,2)]);
        p_i  = zeros([size(X_i,1),1]);
        p_Ci = zeros([size(X_i,1),1]);
        for j = 1:size(idxs,1)
            p_i(j) = exp(-norm(AX(j,:)).^2)+1e-20;
            if C(i) == C(idxs(j))
                p_Ci(j) = p_i(j);
            else
                p_Ci(j) = 1e-20;
            end
        end
        p_i = p_i/sum(p_i);
        E(t+1) = sum(p_Ci)/B;
        p_Ci = p_Ci / sum(p_Ci);
        p = p_i - p_Ci;
        dG = dG + X_i'*diag(p)*X_i;
        disp(E(t+1));
        dG = dG*A/B;
        beta = sum(sum(dG.^2))/(sum(sum(dA.^2))+1e-4);
        sA = dG + beta*sA;
        dA = dG;
        A = A + dt*sA;
    end
end