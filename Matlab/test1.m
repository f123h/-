% Modified DH ��ģdobot
clear, clc, close all;

%����������ģ��
%           �ؽڽ�   �ؽ�ƫ��  ���˳���   ����ת��   ��ת�ؽ�   ƫ��
%            theta   d        a         alpha     sigma      offset
L(1) = Link([0       0        0         0         0          0], 'modified');
L(2) = Link([0       0        0         -pi / 2   0          0], 'modified');
L(3) = Link([0       0        135       0         0          0], 'modified');
L(4) = Link([0       0        147       0         0          0], 'modified');
L(5) = Link([0       131      61        -pi / 2   0          0], 'modified');

%����ؽ����ƽǶ�
L(1).qlim = [-90, 90] * pi / 180;
L(2).qlim = [-85, 0] * pi / 180;
L(3).qlim = [-10, 95] * pi / 180;
L(4).qlim = [-95, 95] * pi / 180;
L(5).qlim = [-90, 90] * pi / 180;

%��������
robot = SerialLink(L, 'name', 'Dobot');
robot.plot([0,-pi/4,pi/2,-pi/4,0]);%���������ģ�ͣ�����Ĳ���Ϊ���ʱ��theta��̬
%robot.display;%��ӡ��DH��
%robot.teach;%չʾ������ģ��

