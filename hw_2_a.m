function [TR, boundaryPoints, boundaryPointsIndexes] = t1(points_matrix)
    % Выполняем триангуляцию точек
    TR = delaunayTriangulation(points_matrix');

    % Получаем индексы граничных ребер и граничные вершины
    boundaryEdgesIndex = freeBoundary(TR);
    boundaryPointsIndexes = boundaryEdgesIndex(:, 1);
    boundaryPoints = points_matrix(:, boundaryPointsIndexes);

    % Рисуем триангуляцию
    hold off;
    triplot(TR, 'color', 'red');
    hold on;
    plot(points_matrix(1, boundaryPointsIndexes), points_matrix(2, boundaryPointsIndexes), 'b-');
    
    % Находим индекс точки, ближайшей к оси 'x'
    [~, index_min] = min(abs(points_matrix(2, boundaryPointsIndexes)));

    % Сдвигаем граничные точки, чтобы начинать с ближайшей к оси 'x'
    boundaryPointsIndexes = circshift(boundaryPointsIndexes, -index_min+1);
    boundaryPoints = points_matrix(:, boundaryPointsIndexes);
end
