clear, clc, close all;

L(1) = Link([0 0 0 0 0 0], 'modified');
L(2) = Link([0 0 0 -pi / 2 0 0], 'modified');
L(3) = Link([0 0 135 0 0 0], 'modified');
L(4) = Link([0 0 147 0 0 0], 'modified');
L(5) = Link([0 131 61 -pi / 2 0 0], 'modified');
robot = SerialLink(L, 'name', 'Dobot');

angle1 = [-pi / 3, -pi / 9, pi / 3, -2 * pi / 9, 0];
angle2 = [-pi / 9, -pi / 3, pi / 2, -pi / 6, pi / 9];
angle3 = [7 * pi / 36, -pi / 4, 5 * pi / 12, -pi / 6, 2 * pi / 9];
angle4 = [4 * pi / 9, -pi / 9, 7 * pi / 18, -5 * pi / 18, pi / 3];
angleT = [angle1; angle2; angle3];

for i = 1:size(angleT, 1)
    fk = myfkine(angleT(i, :));
    points(i, :) = [fk(1, 4), fk(2, 4), fk(3, 4)];
    theta5(i) = angleT(i, 5);
end
%[q, t] = line_traj(points, theta5, [0, 5], 100);
[q, t] = arc_traj(points, theta5, [0, 5, 10], 40);
qdeg = rad2deg(q);

figure(1);
T = zeros(4, 4, size(q, 1));
for i = 1:size(q, 1)
    T(:, :, i) = myfkine(q(i, :));
end
plot3(squeeze(T(1, 4, :)), squeeze(T(2, 4, :)), squeeze(T(3, 4, :)), 'r-', 'LineWidth', 2);
title('πÏº£Õº');
hold on;
plot3(points(:, 1), points(:, 2), points(:, 3), 'bo', 'MarkerSize', 7, 'LineWidth', 2);
hold on;
robot.plot(q);
grid on;
hold on;

figure(2);
plot(t, qdeg);
title('Ω«∂»Õº');
legend('q_1', 'q_2', 'q_3', 'q_4', 'q_5');
xlabel('t(s)');
ylabel('deg(°„)');
grid on;
hold on;
