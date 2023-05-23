function [W, Ws, sg, q_1] = pcm_solver(XYZ, Q, P, N, S, e_in, e_ex)
    RDist = rev_dist(P);
    mutRDist = rev_dist(XYZ);
    M = pcm_matrix(P, N, S, RDist);
    kf = (e_in - e_ex) / (2 * pi * (e_in + e_ex));

    n = length(S);
    m = length(Q);
    R = (P - XYZ') * N' .* (RDist .^ 3);
    b = (kf / e_in) * (R * Q);
    
    A = eye(n) - kf / e_in * M;
    sg = A \ b;
    
    Ws = Q' * RDist * (sg .* S);
    Wq = Q' * mutRDist * Q / 2;
    q_1 = dot(sg, S);
    W = Ws + Wq;
end

function M = pcm_matrix(P, N, S, RDist)
    n = length(S);
    M = zeros(n, n);
    Square = sum(S);
    
    for k = 1:n
        for l = 1:n
            M(k, l) = dot((P(k, :) - P(l, :)), N(k, :)) * S(l) * (RDist(k, l) ^ 3);
        end
    end
    
    M = 2 * pi - M' * S / Square;
    M(1:n+1:end) = M(1:n+1:end) + Square;
end

function M = rev_dist(A)
    m = size(A, 1);
    M = zeros(m, m);
    for k = 1:m-1
        for l = k+1:m 
            M(k, l) = 1 / norm(A(k, :) - A(l, :));
            M(l, k) = M(k, l);
        end
    end
end
