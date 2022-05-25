function [Angle_T] = myikine(T05)
%逆解程序
a2 = 135; a3 = 147; a4 = 61; d5 = 131;
%T05按找n o a p的格式定义
nx = T05(1, 1); ny = T05(2, 1); nz = T05(3, 1);
ox = T05(1, 2); oy = T05(2, 2); oz = T05(3, 2);
ax = T05(1, 3); ay = T05(2, 3); az = T05(3, 3);
px = T05(1, 4); py = T05(2, 4); pz = T05(3, 4);

%theta1
theta1 = atan2(py, px);
%theta3
temp1 = px^2 + py^2 + pz^2 - 2 * a4 * (cos(theta1) * px + sin(theta1) * py) + 2 * pz * d5 + a4^2 + d5^2 - a2^2 - a3^2;
temp2 = 2 * a2 * a3;
test_theta3 = acos(temp1 / temp2);
if test_theta3 >= deg2rad(-10.001) && test_theta3 <= deg2rad(10.001)
    t3_2 = true;
    theta3_1 = acos(temp1 / temp2);
    theta3_2 = -acos(temp1 / temp2);
else
    t3_2 = false;
    theta3 = acos(temp1 / temp2);
end

%theta2
temp1 =- (pz + d5);
if t3_2 == true
    temp2_1 = ((cos(theta3_1) * a3 + a2)^2 + (sin(theta3_1) * a3)^2)^0.5;
    temp2_2 = ((cos(theta3_2) * a3 + a2)^2 + (sin(theta3_2) * a3)^2)^0.5;
    temp3_1 = sin(theta3_1) * a3;
    temp3_2 = sin(theta3_2) * a3;
    temp4_1 = cos(theta3_1) * a3 + a2;
    temp4_2 = cos(theta3_2) * a3 + a2;
    theta2_1 = asin(temp1 / temp2_1) - atan2(temp3_1, temp4_1);
    theta2_2 = asin(temp1 / temp2_2) - atan2(temp3_2, temp4_2);
    %筛选theta2
    if theta2_1 >= deg2rad(-85) && theta2_1 <= deg2rad(0)
        theta2 = theta2_1;
    else
        theta2 = theta2_2;
    end
else
    temp2 = ((cos(theta3) * a3 + a2)^2 + (sin(theta3) * a3)^2)^0.5;
    temp3 = sin(theta3) * a3;
    temp4 = cos(theta3) * a3 + a2;
    theta2 = asin(temp1 / temp2) - atan2(temp3, temp4);
end

%theta4
if t3_2 == true
    theta4_1 = -theta2 - theta3_1;
    theta4_2 = -theta2 - theta3_2;
    if abs(theta3_1) > abs(theta4_1)
        theta4 = theta4_1;
    else
        theta4 = theta4_2;
    end
else
    theta4 = -theta2 - theta3;
end

%theta5
theta5_1 = theta1 - atan2(ny, nx);
theta5_2 =- (theta1 - atan2(ny, nx));
if t3_2 == true
    if theta5_1 == theta5_2 % 检测theta5是否为0，防止输出角度重复
        Angle_T = [theta1, theta2, theta3_1, theta4, theta5_1;
                   theta1, theta2, theta3_2, theta4, theta5_1;];
    else
        Angle_T = [theta1, theta2, theta3_1, theta4, theta5_1;
                   theta1, theta2, theta3_2, theta4, theta5_1;
                   theta1, theta2, theta3_1, theta4, theta5_2;
                   theta1, theta2, theta3_2, theta4, theta5_2];
    end
else
    if theta5_1 == theta5_2 % 检测theta5是否为0，防止输出角度重复
        Angle_T = [theta1, theta2, theta3, theta4, theta5_1;];
    else
        Angle_T = [theta1, theta2, theta3, theta4, theta5_1;
                   theta1, theta2, theta3, theta4, theta5_2];
    end
end
