function A = fast_NCA(X,C,D,T,dt)
    A = randn(D,size(X,2));
    for t = 1:T
        disp(t);
        Y = X*A';       
        for i = 1:size(X,1)
            sum_p_i = 0.0;
            sum_p_Ci = 0.0;
            
            dG_p_i = zeros([size(X,2),size(X,2)]);
            dG_p_Ci = zeros([size(X,2),size(X,2)]);
            
            for j = 1:size(X,1)
                aux = X(i,:)-X(j,:);
                p_i = 0.0;
                if i ~= j
                    p_i = exp(-norm(Y(i,:)-Y(j,:)).^2);
                    dG_p_i = dG_p_i + p_i*(aux'*aux);
                    sum_p_i = sum_p_i + p_i;
                end
                if C(i) == C(j) && i ~= j
                    dG_p_Ci = dG_p_Ci + p_i*(aux'*aux);
                    sum_p_Ci = sum_p_Ci + p_i;
                end
            end
            dG_p_i = dG_p_i / sum_p_i;
            dG_p_Ci = dG_p_Ci / sum_p_Ci;
            A = A + dt*2.0*A*(dG_p_i-dG_p_Ci);
        end
    end
end