function [q, qd, qdd, t] = quintic_traj(theta, V, A, T, step)
%五次多项式
q = zeros(step, 5); %角度
qd = zeros(step, 5); %角速度
qdd = zeros(step, 5); %角加速度
t = reshape(linspace(T(1), T(2), step), step, 1);
tf = T(2) - T(1);
a0 = theta(1, :);
a1 = V(1, :);
a2 = A(1, :) / 2;
a3 = (-20 * theta(1, :) + 20 * theta(2, :) - 12 * V(1, :) * tf - 8 * V(2, :) * tf - 3 * A(1, :) * tf^2 + A(2, :) * tf^2) / (2 * tf^3);
a4 = (30 * theta(1, :) - 30 * theta(2, :) + 16 * V(1, :) * tf + 14 * V(2, :) * tf + 3 * A(1, :) * tf^2 - 2 * A(2, :) * tf^2) / (2 * tf^4);
a5 = (-12 * theta(1, :) + 12 * theta(2, :) - 6 * V(1, :) * tf - 6 * V(2, :) * tf - A(1, :) * tf^2 + A(2, :) * tf^2) / (2 * tf^5);
for i = 1:5
    if i == 4
        q(:, i) =- (q(:, 3) + q(:, 2));
    else
        q(:, i) = a0(i) + a1(i) * (t - t(1)) + a2(i) * ((t - t(1)).^2) + a3(i) * ((t - t(1)).^3) + a4(i) * ((t - t(1)).^4) + a5(i) * ((t - t(1)).^5);
    end
    qd(:, i) = a1(i) + 2 * a2(i) * (t - t(1)) + 3 * a3(i) * ((t - t(1)).^2) + 4 * a4(i) * ((t - t(1)).^3) + 5 * a5(i) * ((t - t(1)).^4);
    qdd(:, i) = 2 * a2(i) + 6 * a3(i) * (t - t(1)) + 12 * a4(i) * ((t - t(1)).^2) + 20 * a5(i) * ((t - t(1)).^3);
end
