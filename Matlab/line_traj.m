function [q, t] = line_traj(points, theta5, T, step)
%直线规划
q = zeros(step, 5); %角度
pointT = zeros(step, 3);
%% 角度变化
pointT(:, 1) = reshape(linspace(points(1, 1), points(2, 1), step), step, 1); %px
pointT(:, 2) = reshape(linspace(points(1, 2), points(2, 2), step), step, 1); %py
pointT(:, 3) = reshape(linspace(points(1, 3), points(2, 3), step), step, 1); %pz
q(1:step, :) = myikine2(pointT, theta5, step);
t = reshape(linspace(T(1), T(2), step), step, 1);
