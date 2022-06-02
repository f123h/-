function [q, qd, qdd, t] = cubic_traj(theta, V, T, step)
%三次多项式
q = zeros(step, 5); %角度
qd = zeros(step, 5); %角速度
qdd = zeros(step, 5); %角加速度
t = reshape(linspace(T(1), T(2), step), step, 1);
tf = T(2) - T(1);
a0 = theta(1, :);
a1 = V(1, :);
a2 = (-3 * theta(1, :) + 3 * theta(2, :) - 2 * V(1, :) * tf - V(2, :) * tf) / tf^2;
a3 = (2 * theta(1, :) - 2 * theta(2, :) + V(1, :) * tf + V(2, :) * tf) / tf^3;
for i = 1:5
    if i == 4
        q(:, i) =- (q(:, 3) + q(:, 2));
    else
        q(:, i) = a0(i) + a1(i) * (t - t(1)) + a2(i) * ((t - t(1)).^2) + a3(i) * ((t - t(1)).^3);
    end
    qd(:, i) = a1(i) + 2 * a2(i) * (t - t(1)) + 3 * a3(i) * ((t - t(1)).^2);
    qdd(:, i) = 2 * a2(i) + 6 * a3(i) * (t - t(1));
end
