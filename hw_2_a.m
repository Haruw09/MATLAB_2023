function [triangulation, boundary_vertices] = a(points)
    % Выполняем триангуляцию точек
    tri = delaunayTriangulation(points');

    % Получаем индексы граничных ребер
    boundary_edges = tri.convexHull();

    % Извлекаем граничные вершины в порядке обхода против часовой стрелки
    boundary_vertices = points(:, boundary_edges(:));
    boundary_vertices = [boundary_vertices, points(:, boundary_edges(1))]; % Добавляем первую вершину в конце

    % Рисуем триангуляцию
    triplot(tri);
    hold on;
    plot(points(1, :), points(2, :), 'ro');

    % Отображаем граничные ребра с красным цветом, внутренние ребра - синим цветом
    edges = tri.edges;
    for i = 1:size(edges, 1)
        if any(ismember(edges(i, :), boundary_edges))
            plot(points(1, edges(i, :)), points(2, edges(i, :)), 'r-');
        else
            plot(points(1, edges(i, :)), points(2, edges(i, :)), 'b-');
        end
    end
