function [ angle ] = Alig2( data, dt, B, L, H )
%UNTITLED Summary of this function goes here
% input
%   data -- [accX, accY, accZ, gyroX, gyroY, gyroZ]
%     dt -- interval, s
%      B -- latitude, degree
%      L -- longitude, degree
%      H -- height, m
% output
%  angle -- [ psai, fai, theta ]
% '�����yaw','������pitch', '������roll'

% ׼������
deg2arc = pi/180;
data = data/dt;
B = B*deg2arc;
L = L*deg2arc;
% �������ٶ�(m/s^2)��������ת���ٶ�(rad/h)
g = 9.780325*(1 + 0.00530240*sin(B)*sin(B) - 0.00000582*sin(2*B)*sin(2*B));
g = g - 3.08e-6 * H;
omega_e = 7.292e-5;

% ����ϵ[������]�������淶��ʸ��
Cb = [-tan(B)/g,  1/(omega_e*cos(B)), 0;
              0,                   0, -1/(g*omega_e*cos(B));
              -1/g,                0, 0];
% ����ϵ�������淶��ʸ��
%g_b = orth([data(4), data(5), data(6)]');
%omega_b = orth([data(1), data(2), data(3)]' * 3600);
%vb1 = orth(g_b);
g_b = [data(4), data(5), data(6)];
omega_b = [data(1), data(2), data(3)];
vb3 = cross(g_b, omega_b);

% �����̬��
Abn = Cb * [g_b; omega_b; vb3];

%Anb*Abn
% psai, fai, theta
angle(1) = atan(Abn(2,1)/Abn(1,1)) / deg2arc;
angle(3) = atan(Abn(3,2)/Abn(3,3)) / deg2arc;
angle(2) = asin(-Abn(3,1)) / deg2arc;

end
