clear; clc; close all;
N = 100000; %�㼯����
a2 = 135; a3 = 147; a4 = 61; d5 = 131;
%�������
px1 = zeros(N, 1);
px2 = zeros(N, 1);
py = zeros(N, 1);
pz = zeros(N, 1);
%����Ƕȷ�Χ
limmin1 = -90.0;
limmax1 = 90.0;
limmin2 = -85.0;
limmax2 = 0.0;
limmin23 = -10.0;
limmax23 = 95.0;
%��������Ƕ�����
theta1_1 = zeros(N, 1);
theta1_2 = (limmin1 + (limmax1 - limmin1) * rand(N, 1)) * pi / 180;
theta2 = (limmin2 + (limmax2 - limmin2) * rand(N, 1)) * pi / 180;
theta23 = (limmin23 + (limmax23 - limmin23) * rand(N, 1)) * pi / 180;

%�Ƕ�λ�˾���
for i = 1:N
    px1(i, 1) = cos(theta1_1(i)) * (cos(theta23(i)) * a3 + cos(theta2(i)) * a2 + a4);
    px2(i, 1) = cos(theta1_2(i)) * (cos(theta23(i)) * a3 + cos(theta2(i)) * a2 + a4);
    py(i, 1) = sin(theta1_2(i)) * (cos(theta23(i)) * a3 + cos(theta2(i)) * a2 + a4);
    pz(i, 1) =- (d5 + sin(theta23(i)) * a3 + sin(theta2(i)) * a2);
end

%�����ռ�ͼ
figure(1);
plot3(px2, py, pz, 'b.', 'MarkerSize', 4);
title('�����ռ�ͼ');
xlabel('X��');
ylabel('Y��');
zlabel('Z��');
grid on;

%XYƽ���ͼ
figure(2);
plot(px2, py, 'b.', 'MarkerSize', 1.0);
title('XYƽ���ͼ');
xlabel('X��');
ylabel('Y��');
grid on;

%XZƽ���ͼ
figure(3);
plot(px1, pz, 'b.', 'MarkerSize', 1.0);
title('XZƽ���ͼ');
xlabel('X��');
ylabel('Z��');
grid on;
