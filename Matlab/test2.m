% Modified DH ��ģdobot
clear, clc, close all;

%����������ģ��
%           �ؽڽ�   �ؽ�ƫ��  ���˳���   ����ת��   ��ת�ؽ�   ƫ��
%           theta    d        a         alpha     sigma      offset
L(1) = Link([0       0        0         0         0          0], 'modified');
L(2) = Link([0       0        0         -pi / 2   0          0], 'modified');
L(3) = Link([0       0        135       0         0          0], 'modified');
L(4) = Link([0       0        147       0         0          0], 'modified');
L(5) = Link([0       131      61        -pi / 2   0          0], 'modified');

%��������
robot = SerialLink(L, 'name', 'Dobot');

angle1 = [-pi / 6, -pi / 6, pi / 3, -pi / 6, pi / 4];
angle2 = [pi / 3, -pi / 60, pi / 30, -pi / 60, -pi / 4];

%�˶�ѧ����
fk1 = myfkine(angle1); %���⺯��
fk2 = robot.fkine(angle1);%���������⺯��
%fk1 = myfkine(angle2); %���⺯��
%fk2 = robot.fkine(angle2);%���������⺯��

%�˶�ѧ���
ik1 = myikine(fk1);%��⺯��
%ʵ����robot.ikine������������
%ik2 = robot.ikine(fk1);%��������⺯��
degik1 = rad2deg(ik1);

%�ٴ��˶�ѧ����
ik1_fk = myfkine(ik1(1, :));
