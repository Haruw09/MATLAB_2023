vector = (1:10);
average_value = mean(vector);
standard_deviation = std(vector);

matrix_1 = rand(110);
sum_main_diag = sum(diag(matrix_1));
sum_side_diag = 0;
for i = 110:-1:1
    for j = 1:110
        sum_side_diag = sum_side_diag + matrix_1(i, j);
    end
end
matrix_2 = matrix_1;
for i = 110:-1:1
    for j = 1:110
        matrix_2(i, i) = matrix_2(i, j);
    end
end
original_matrix = rand(11);
new_matrix = zeros(11);
for i = 1:11
    for j = 1:11
        help_matrix = zeros(10);
        for a = 1:10
            for b = 1:10
                if (a < i) && (b < j)
                    help_matrix(a, b) = original_matrix(a, b);
                end
                if (a < i) && (b > j)
                    help_matrix(a, b) = original_matrix(a, b + 1);
                end
                if (a > i) && (b < j)
                    help_matrix(a, b) = original_matrix(a + 1, b);
                end
                if (a > i) && (b > j)
                    help_matrix(a, b) = original_matrix(a + 1, b + 1);
                end
            end
        end
        new_matrix(i, j) = det(help_matrix);
    end
end
if (det(original_matrix) > det(new_matrix))
    fprintf('Original matrix determinant is larger');
elseif (det(original_matrix) < det(new_matrix))
    fprintf('Original matrix determinant is smaller');
else fprintf('Matrices are equal');
end

fibonacci_sequence = (1:20);
for i = 1:20
    if (i < 3)
        fibonacci_sequence(i) = i - 1;
    else fibonacci_sequence(i) = fibonacci_sequence(i - 2) + fibonacci_sequence(i - 1);
    end
end
disp(fibonacci_sequence);

x = -pi / 2 : pi / 999 : pi / 2;
y = ((sin(0.1 * x). / x).*(sin(20 * x)./sin(x))).^2; %точки нужны для почленного использования операций
plot(x, y);
