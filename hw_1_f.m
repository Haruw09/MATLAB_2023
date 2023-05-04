S = 0:0.20:399;
S = sort([-sqrt(S), sqrt(S)]); % сортирует одномерный массив в возрастающем порядке
x = fresnelc(S);
y = fresnels(S);
figure; 
hold on; 
grid on; 
plot(x, y);
