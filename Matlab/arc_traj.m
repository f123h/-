function [q, t] = arc_traj(points, theta5, T, step)
%圆弧规划
q = zeros(2 * step, 5); %角度
t = zeros(2 * step, 1); %时间
% 求圆心和半径
syms x0 y0 z0
p1 = points(1, :);
p2 = points(2, :);
p3 = points(3, :);
x1 = p1(1); y1 = p1(2); z1 = p1(3);
x2 = p2(1); y2 = p2(2); z2 = p2(3);
x3 = p3(1); y3 = p3(2); z3 = p3(3);
a = (y2 - y1) * (z3 - z1) - (y3 - y1) * (z2 - z1);
b = (x3 - x1) * (z2 - z1) - (x2 - x1) * (z3 - z1);
c = (x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1);
d = a * x1 + b * y1 + c * z1;
eq(1) = a * x0 + b * y0 + c * z0 == d;
eq(2) = (x0 - 0.5 * (x1 + x2)) * (x2 - x1) + (y0 - 0.5 * (y1 + y2)) * (y2 - y1) + (z0 - 0.5 * (z1 + z2)) * (z2 - z1) == 0;
eq(3) = (x0 - 0.5 * (x2 + x3)) * (x3 - x2) + (y0 - 0.5 * (y2 + y3)) * (y3 - y2) + (z0 - 0.5 * (z2 + z3)) * (z3 - z2) == 0;
[x0, y0, z0] = solve(eq, x0, y0, z0);
p0 = double([x0, y0, z0]);
R = double(sqrt((x1 - x0).^2 + (y1 - y0).^2 + (z1 - z0).^2));
%求齐次变换矩阵
W = [a, b, c] / sqrt(a^2 + b^2 + c^2);
U = (p1 - p0) / R;
V = cross(W, U);
transT = [U', V', W', p0'; 0, 0, 0, 1];
%计算轨迹并转换
point1 = inv(transT) * [p1, 1]';
point2 = inv(transT) * [p2, 1]';
point3 = inv(transT) * [p3, 1]';
%求圆心角
if point3(2) < 0
    theta13 = atan2(point3(2), point3(1)) + 2 * pi;
else
    theta13 = atan2(point3(2), point3(1));
end
%转换到空间圆弧
j = 1;
for i = 0:theta13 / (2 * step - 1):theta13
    pointT(j, :) = transT * [R * cos(i), R * sin(i), 0, 1]';
    j = j + 1;
end
pointT = pointT(:, 1:3);
%% 角度变化
q(1:step, :) = myikine2(pointT(1:step, :), theta5(1:2), step);
q(step + 1:2 * step, :) = myikine2(pointT(step + 1:2 * step, :), theta5(2:3), step);
t(1:step) = reshape(linspace(T(1), T(2), step), step, 1);
t(step + 1:2 * step) = reshape(linspace(T(2), T(3), step), step, 1);
