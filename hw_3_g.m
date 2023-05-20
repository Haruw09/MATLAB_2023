function W = g(mesh)

nNodes = size(mesh.X,1);
nElements = size(mesh.T,1);

I = zeros(3*nElements,1);
J = zeros(3*nElements,1);
S = zeros(3*nElements,1);
k = 0;

D = pdist2(mesh.X,mesh.X);

for i = 1:nElements
    vertices = mesh.T(i,:);
    for j = 1:3
        k = k + 1;
        I(k) = vertices(j);
        J(k) = vertices;
        S(k) = 1./D(vertices(j),vertices);
    end
end

W = sparse(I,J,S,nNodes,nNodes);

boundaryNodes = unique([mesh.freeBoundary; mesh.holes]); % Номера граничных вершин
W(boundaryNodes,:) = 0;
W = W - diag(sum(W,2));
end
