function [T05] = myfkine(Angle_T)
%运动学正解
theta1 = Angle_T(1, 1);
theta2 = Angle_T(1, 2);
theta3 = Angle_T(1, 3);
theta4 = Angle_T(1, 4);
theta5 = Angle_T(1, 5);
theta23 = theta2 + theta3;
a2 = 135; a3 = 147; a4 = 61; d5 = 131;
T01 = [cos(theta1) -sin(theta1) 0 0;
       sin(theta1) cos(theta1)  0 0;
       0           0            1 0;
       0           0            0 1];
T14 = [1 0  0 cos(theta23) * a3 + cos(theta2) * a2;
       0 0  1 0;
       0 -1 0 -sin(theta23) * a3 - sin(theta2) * a2;
       0 0  0 1];
T45 = [cos(theta5)  -sin(theta5) 0 a4;
       0            0            1 d5;
       -sin(theta5) -cos(theta5) 0 0;
       0            0            0 1];
T05 = T01 * T14 * T45;
