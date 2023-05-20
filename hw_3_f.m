function [normals] = f(triangles, vertices)

faceNormals = cross(vertices(triangles(:,2),:)-vertices(triangles(:,1),:), ...
    vertices(triangles(:,3),:)-vertices(triangles(:,1),:));
faceNormals = faceNormals./sqrt(sum(faceNormals.^2,2));

normals = zeros(size(vertices));

for i=1:size(triangles,1)
    normals(triangles(i,1),:) = normals(triangles(i,1),:) + faceNormals(i,:);
    normals(triangles(i,2),:) = normals(triangles(i,2),:) + faceNormals(i,:);
    normals(triangles(i,3),:) = normals(triangles(i,3),:) + faceNormals(i,:);
end

normals = normals./sqrt(sum(normals.^2,2));

end
