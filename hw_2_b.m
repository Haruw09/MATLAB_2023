function [surfaceVertices, surfaceEdges, surfaceTriangles] = b(vertices)
    DT = delaunayTriangulation(vertices);
    % Get the list of tetrahedra
    tetrahedra = DT.ConnectivityList;
    
    % Extract "surface" tetrahedra
    boundaryTetrahedra = freeBoundary(DT);
    
    % Get the list of "surface" vertices
    surfaceVertices = unique(boundaryTetrahedra(:));
    
    % Create lists for "surface" edges and triangles
    surfaceEdges = [];
    surfaceTriangles = [];
    
    % Get the edges of each "surface" tetrahedron
    edges = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
    boundaryEdges = edges(~ismember(edges, boundaryTetrahedra), :);
    surfaceEdges = [surfaceEdges; boundaryEdges];
    
    % Get the triangles connected to each "surface" edge
    connectedTriangles = triangulationNeighbors(DT, boundaryEdges);
    validTriangles = all(connectedTriangles ~= 0, 2);
    surfaceTriangles = [surfaceTriangles; boundaryEdges(validTriangles, :) connectedTriangles(validTriangles, :)];
    
    % Display the results
    trisurf(surfaceTriangles, surfaceVertices(:, 1), surfaceVertices(:, 2), surfaceVertices(:, 3), 'FaceColor', 'r', 'FaceAlpha', 0.3);
    hold on;
    plot3(surfaceVertices(:, 1), surfaceVertices(:, 2), surfaceVertices(:, 3), 'k*');
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
end
