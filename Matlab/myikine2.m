function [theta] = myikine2(pointT, q5, step)
a2 = 135; a3 = 147; a4 = 61; d5 = 131;
theta = zeros(step, 5);
for i = 1:step
    px = pointT(i, 1);
    py = pointT(i, 2);
    pz = pointT(i, 3);
    %theta1
    theta1 = atan2(py, px);
    %theta3
    temp1 = px^2 + py^2 + pz^2 - 2 * a4 * (cos(theta1) * px + sin(theta1) * py) + 2 * pz * d5 + a4^2 + d5^2 - a2^2 - a3^2;
    temp2 = 2 * a2 * a3;
    theta3 = acos(temp1 / temp2);
    %theta2
    temp1 =- (pz + d5);
    temp2 = ((cos(theta3) * a3 + a2)^2 + (sin(theta3) * a3)^2)^0.5;
    temp3 = sin(theta3) * a3;
    temp4 = cos(theta3) * a3 + a2;
    theta2 = asin(temp1 / temp2) - atan2(temp3, temp4);
    %theta4
    theta4 = -theta2 - theta3;
    theta(i, (1:4)) = [theta1, theta2, theta3, theta4];
end
theta(:, 5) = reshape(linspace(q5(1), q5(2), step), step, 1);
