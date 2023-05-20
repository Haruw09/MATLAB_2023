function [P, sgP] = LinApproximator(y, r, funcs)
    N = size(y, 2);
    M = size(funcs, 1);
    
    g = zeros(N, M);
    for jj = 1:M
        f = funcs(jj);
        g(:, jj) = f(r);
    end

    Y = y * g;
    G = g' * g;

    a = G \ Y';
    P = a;

    Err_0 = sqrsum(y - g * a) / N;

    Gkk = trace(G);
    Delta_a = sqrt(Err_0 / (2 * Gkk));
    sgP = Delta_a;
end

function sum = sqrsum(x)
    sum = sum(x.^2);
end
