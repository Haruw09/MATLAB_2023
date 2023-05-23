function [W, Ws, sg] = cosmo_solver(XYZ, Q, P, S, e_in)
    % Obtaining a matrix of mutual distances between grid vertices
    RDist = rev_dist(P, XYZ);
    QRDist = rev_dist(XYZ, XYZ);
    SRDist = rev_dist(P, P);

    % Getting matrix A and vector b
    A = SRDist .* S';
    b = -1 / e_in * RDist' * Q;
    sg = A \ b;

    % Obtaining vector q and vector Ws
    q = sg .* S;
    Ws = 1/2 * Q' * RDist * (sg .* S);

    % Obtaining the vector Wq and the total potential
    Wq = Q' * QRDist * Q / 2;
    W = Ws + Wq;
end

function M = rev_dist(A, B)
    diff = permute(B, [3, 2, 1]) - permute(A, [2, 3, 1]);
    dists = vecnorm(diff, 2, 2);
    M = 1 ./ dists;
    M(isnan(M)) = 0;
end
