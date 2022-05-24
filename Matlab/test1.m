% Modified DH 建模dobot
clear, clc, close all;

%建立机器人模型
%           关节角   关节偏距  连杆长度   连杆转角   旋转关节   偏差
%            theta   d        a         alpha     sigma      offset
L(1) = Link([0       0        0         0         0          0], 'modified');
L(2) = Link([0       0        0         -pi / 2   0          0], 'modified');
L(3) = Link([0       0        135       0         0          0], 'modified');
L(4) = Link([0       0        147       0         0          0], 'modified');
L(5) = Link([0       131      61        -pi / 2   0          0], 'modified');

%定义关节限制角度
L(1).qlim = [-90, 90] * pi / 180;
L(2).qlim = [-85, 0] * pi / 180;
L(3).qlim = [-10, 95] * pi / 180;
L(4).qlim = [-95, 95] * pi / 180;
L(5).qlim = [-90, 90] * pi / 180;

%连接连杆
robot = SerialLink(L, 'name', 'Dobot');
robot.plot([0,-pi/4,pi/2,-pi/4,0]);%输出机器人模型，后面的参数为输出时的theta姿态
%robot.display;%打印出DH表
%robot.teach;%展示机器人模型

