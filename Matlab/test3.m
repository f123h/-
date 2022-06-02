clear, clc, close all;

L(1) = Link([0 0 0 0 0 0], 'modified');
L(2) = Link([0 0 0 -pi / 2 0 0], 'modified');
L(3) = Link([0 0 135 0 0 0], 'modified');
L(4) = Link([0 0 147 0 0 0], 'modified');
L(5) = Link([0 131 61 -pi / 2 0 0], 'modified');
robot = SerialLink(L, 'name', 'Dobot');

angle1 = [-pi / 6, -pi / 6, pi / 3, -pi / 6, pi / 4];
angle2 = [pi / 3, -pi / 60, pi / 30, -pi / 60, -pi / 4];
angleT = [angle1; angle2];

VT = [0, 0, 0, 0, 0; 0, 0, 0, 0, 0];
AT = [0, 0, 0, 0, 0; 0, 0, 0, 0, 0];

%[q, qd, qdd, t] = cubic_traj(angleT, VT, [0, 5], 100);
[q, qd, qdd, t] = quintic_traj(angleT, VT, AT, [0, 5], 100);
qdeg=rad2deg(q);
qddeg = rad2deg(qd);
qdddeg = rad2deg(qdd);

figure(1);
T = zeros(4, 4, size(q, 1));
for i = 1:size(q, 1)
    T(:, :, i) = myfkine(q(i, :));
end
plot3(squeeze(T(1, 4, :)), squeeze(T(2, 4, :)), squeeze(T(3, 4, :)), 'r-', 'LineWidth', 2);
title('轨迹图');
hold on;
plot3(squeeze(T(1,4,1)),squeeze(T(2,4,1)),squeeze(T(3,4,1)), 'bo', 'MarkerSize', 7, 'LineWidth', 2);
hold on;
plot3(squeeze(T(1,4,size(q, 1))),squeeze(T(2,4,size(q, 1))),squeeze(T(3,4,size(q, 1))), 'bo', 'MarkerSize', 7, 'LineWidth', 2);
hold on;
robot.plot(q);
grid on;
hold on;

figure(2);
plot(t,qdeg);
title('角度图');
legend('q_1', 'q_2', 'q_3', 'q_4', 'q_5');
xlabel('t(s)');
ylabel('deg(°)');
grid on;
hold on;

figure(3);
plot(t, qddeg);
title('角速度图');
legend('q_1', 'q_2', 'q_3', 'q_4', 'q_5');
xlabel('t(s)');
ylabel('V(°/s)');
grid on;
hold on;

figure(4);
plot(t, qdddeg);
title('角加速度图');
legend('q_1', 'q_2', 'q_3', 'q_4', 'q_5');
xlabel('t(s)');
ylabel('A(°/s^2)');
grid on;
hold on;

