function t3(a,b,c)
    arguments
        a = [ 1 1  1]; 
        b = [-1 1 -1];
        c = [-1 -1 1];
    end

    % define the size of the grid as n
    n = 2;

    % create a 3D grid of size 
    [x, y, z] = ndgrid(-1:1);
    grid_points = [x(:), y(:), z(:)] * [a;b;c];

    % find the index of the cell containing the origin
    [~, cell_idx] = min(sum(grid_points.^2, 2));

    % compute the Voronoi diagram for the vertices of the cell
    [v, ce] = voronoin(grid_points(ce{cell_idx}, :));

    % shift vertices to origin
    vertices = v - mean(v, 1);

    % compute the Delaunay triangulation of the shifted vertices
    tri = delaunay(vertices(:,1), vertices(:,2), vertices(:,3));

    % plot the result
    hold on;
    patch('Faces', tri, 'Vertices', vertices, 'FaceColor', 'blue', 'FaceAlpha', 0.1);
    patch('Faces', convhulln(grid_points), 'Vertices', grid_points, 'FaceColor', 'red', 'FaceAlpha', 0.1);
    scatter3(vertices(:,1), vertices(:,2), vertices(:,3), 'b')
    scatter3(grid_points(:,1), grid_points(:,2), grid_points(:,3), 'r')
    plot3([0,a(1)],[0,a(2)],[0,a(3)],'-r','LineWidth',2);
    plot3([0,b(1)],[0,b(2)],[0,b(3)],'-g','LineWidth',2);
    plot3([0,c(1)],[0,c(2)],[0,c(3)],'-b','LineWidth',2);
    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    axis equal
end
