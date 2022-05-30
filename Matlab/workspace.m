clear; clc; close all;
N = 100000; %点集个数
a2 = 135; a3 = 147; a4 = 61; d5 = 131;
%定义矩阵
px1 = zeros(N, 1);
px2 = zeros(N, 1);
py = zeros(N, 1);
pz = zeros(N, 1);
%定义角度范围
limmin1 = -90.0;
limmax1 = 90.0;
limmin2 = -85.0;
limmax2 = 0.0;
limmin23 = -10.0;
limmax23 = 95.0;
%生成随机角度序列
theta1_1 = zeros(N, 1);
theta1_2 = (limmin1 + (limmax1 - limmin1) * rand(N, 1)) * pi / 180;
theta2 = (limmin2 + (limmax2 - limmin2) * rand(N, 1)) * pi / 180;
theta23 = (limmin23 + (limmax23 - limmin23) * rand(N, 1)) * pi / 180;

%角度位姿矩阵
for i = 1:N
    px1(i, 1) = cos(theta1_1(i)) * (cos(theta23(i)) * a3 + cos(theta2(i)) * a2 + a4);
    px2(i, 1) = cos(theta1_2(i)) * (cos(theta23(i)) * a3 + cos(theta2(i)) * a2 + a4);
    py(i, 1) = sin(theta1_2(i)) * (cos(theta23(i)) * a3 + cos(theta2(i)) * a2 + a4);
    pz(i, 1) =- (d5 + sin(theta23(i)) * a3 + sin(theta2(i)) * a2);
end

%工作空间图
figure(1);
plot3(px2, py, pz, 'b.', 'MarkerSize', 4);
title('工作空间图');
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
grid on;

%XY平面截图
figure(2);
plot(px2, py, 'b.', 'MarkerSize', 1.0);
title('XY平面截图');
xlabel('X轴');
ylabel('Y轴');
grid on;

%XZ平面截图
figure(3);
plot(px1, pz, 'b.', 'MarkerSize', 1.0);
title('XZ平面截图');
xlabel('X轴');
ylabel('Z轴');
grid on;
