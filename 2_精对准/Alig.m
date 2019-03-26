function [ dangle ] = Alig( dV, B, H, Cbn )
%UNTITLED Summary of this function goes here
% input
%     dV -- [VN, VE]
%      B -- latitude, degree
%      L -- longitude, degree
%      H -- height, m
%  angle -- [ psai, fai, theta ]
% output
% dangle -- d[ E, N, U]
% '�����yaw','������pitch', '������roll'

% ׼������
T = 0.01;
nt = 12000;
deg2arc = pi/180;
B = B*deg2arc;
% �������ٶ�(m/s^2)��������ת���ٶ�(rad/h)
g = get_gravity(B, H);
omega_e = 7.292e-5;
omega_N = omega_e * cos(B);
omega_U = omega_e * sin(B);

% �����˲�
X =  [0 0 0 0 0 0 0]';
F = [      0,  omega_U, -omega_N, 0, 0,  0,  0;
    -omega_U,        0,        0, 0, 0, -1,  0;
     omega_N,        0,        0, 0, 0,  0, -1;
           0,       -g,        0, 0, 0,  0,  0;
           g,        0,        0, 0, 0,  0,  0;
           0,        0,        0, 0, 0,  0,  0;
           0,        0,        0, 0, 0,  0,  0;];
H = [0, 0, 0, 1, 0, 0 ,0;
     0, 0, 0, 0, 1, 0, 0];
% �����ĳ�ʼ����
D0 = diag([(0.02/180*pi)^2, (0.02/180*pi)^2, (0.02/180*pi)^2, 0.1^2, 0.1^2 , ...
    (0.3/180*pi)^2, (0.5/180*pi)^2]);
% �۲�����
Dep = diag([0.1^2, 0.1^2]);
% ��������������ʱ��ʧ�ȣ���С�����˲�
Q = diag([(0.1/180*pi)^2, (0.1/180*pi)^2, (0.1/180*pi)^2, 0.0005^2, 0.0005^2 , ...
    (0.1/180*pi)^2, (0.1/180*pi)^2]);
Z = [0 0]';
Y = zeros(nt, 2);
for i = 2:nt
    Z(1) = dV(i, 2);
    Z(2) = dV(i, 1);
    X = X + F * T * X + F*F*T*T/2 * X;
    D01 = F * D0 * F' + Q;
    K = D01 * H' / (H * D01 * H' + Dep);  
    V = Z - H * X;
    X1 = X + K * V;
    D1 = (eye(7) - K * H) * D01;
    % parameter update
    D0 = D1;
    X = X1;
    Y(i, :) = H * X1;
    Y(i, :) = X(1:2);
    display(D0(1,1));
end
plot(Y);
dangle = X(1:3);
display(X);


