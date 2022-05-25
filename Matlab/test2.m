% Modified DH 建模dobot
clear, clc, close all;

%建立机器人模型
%           关节角   关节偏距  连杆长度   连杆转角   旋转关节   偏差
%           theta    d        a         alpha     sigma      offset
L(1) = Link([0       0        0         0         0          0], 'modified');
L(2) = Link([0       0        0         -pi / 2   0          0], 'modified');
L(3) = Link([0       0        135       0         0          0], 'modified');
L(4) = Link([0       0        147       0         0          0], 'modified');
L(5) = Link([0       131      61        -pi / 2   0          0], 'modified');

%连接连杆
robot = SerialLink(L, 'name', 'Dobot');

angle1 = [-pi / 6, -pi / 6, pi / 3, -pi / 6, pi / 4];
angle2 = [pi / 3, -pi / 60, pi / 30, -pi / 60, -pi / 4];

%运动学正解
fk1 = myfkine(angle1); %正解函数
fk2 = robot.fkine(angle1);%工具箱正解函数
%fk1 = myfkine(angle2); %正解函数
%fk2 = robot.fkine(angle2);%工具箱正解函数

%运动学逆解
ik1 = myikine(fk1);%逆解函数
%实际上robot.ikine函数并不可用
%ik2 = robot.ikine(fk1);%工具箱逆解函数
degik1 = rad2deg(ik1);

%再次运动学正解
ik1_fk = myfkine(ik1(1, :));
