function [P, sgP] = NonLinApproximator(y, r, fun, P_0)
    N = size(y, 2);
    p_number = length(P_0);

    for iterations = 1:1000
        F = fun(r, P_0);
        J = jacobi(fun, r, p_number, P_0);

        Y = J' * (y' - F');
        G = J' * J;
        P = P_0' + G \ Y;

        if isnan(P)
            break
        end

        if iterations > 1 && max(abs(P_0 - P_previous)) < 1e-10
            break
        end

        P_previous = P;
        P_0 = P';
    end

    sgP = 'bla bla';
end

function J = jacobi(fun, r, p_number, P_0)
    h = 1e-6;
    N = length(r(1, :));

    J = zeros(N, p_number);

    for ii = 1:N
        delta = zeros(1, p_number);
        for jj = 1:p_number
            delta(jj) = h * abs(P_0(jj));
            J(ii, jj) = (fun(r(:, ii), P_0 + delta) - fun(r(:, ii), P_0 - delta)) / (2 * h);
            delta(jj) = 0;
        end
    end
end
