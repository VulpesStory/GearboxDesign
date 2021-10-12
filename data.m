clear;
%% Геометрический расчет ЗП
z = [24 54];
m = 0.6;
beta = 0; 
alpha = deg2rad(20);
h_alp = 1;
c = 0.35;
h_l = 2;
i = 2.25;
d = m*z/cos(beta);
alp_t = atan(tan(alpha)/cos(beta));
a = m*sum(z)/(2*cos(beta));
del_a = 0.15;
a_w = a + del_a;
alp_tw = acos(a/a_w*cos(alp_t));
x_sum = sum(z)*(evol(alp_tw)-evol(alp_t))/2/tan(alpha);
x = zeros(1,2,'double');
x(1) = round(0.5*x_sum,1);
x(2) = x(1);
h_f = m*(h_alp + c - x);
y = (a_w - a)/m;
del_y = sum(x) - y;
h_alp_col = m*(h_alp + x - del_y);
d_f = d - 2*h_f;
d_a = d + 2*h_alp_col;
z_min = 2*(h_l - h_alp - x)*cos(beta)/sin(alp_t)^2;
x_min = h_l - h_alp - z*sin(alp_t)^2/2/cos(beta);
D = 1.023;
alp_D = zeros(1,2,'double');
alp_D(1) = aevol(D/m/z(1)/cos(alpha) + evol(alp_t) - pi/2/z(1) + 2*x(1)/z(1)*tan(alpha));
alp_D(2) = aevol(D/m/z(2)/cos(alpha) + evol(alp_t) - pi/2/z(2) + 2*x(2)/z(2)*tan(alpha));
M = zeros(1,2,'double');
M(1) = m*z(1)*cos(alp_t)/cos(alp_D(1)) + D;
M(2) = m*z(2)*cos(alp_t)/cos(alp_D(2)) + D;

%% Отклонение для размеров по роликам М 
% F_r = [22 26]; %табл 15
E_Wms_1 = -[16 22];% I слагаемое табл 25
E_Wms_2 = -[5 7]; % II слагаемое табл 26
E_Wms = E_Wms_1 + E_Wms_2; 
T_Wm = [16 19]; % табл 27

beta_b = asin(sin(beta) * cos(alpha));
E_Ms = E_Wms ./ sin(alp_D) / cos(beta_b);
T_M = T_Wm ./ sin(alp_D) / cos(beta_b);

% из таблицы 28
E_Ms = [42 60];
T_M = [38 50];
%% Расчет вращательные моменты на валах
M_st = 0.36;
J_l = 0.2 * 10^-4;
eps_out = 250;
M_out = M_st + J_l * eps_out;
z = [24 54 24 54 24 54];
i = 2.25;
f = 0.08;
M_rot = zeros(1, 4, "double");
M_rot(4) = M_out;
for j = 4:-1:2
   k = (j - 1) * 2;
   F_n = 2 * M_rot(j) / m / z(k) / cos(alp_t);
   C = (F_n + 3) / (F_n + 0.2);
   eta = 1 - C * f * pi * (1 / z(k-1) + 1 / z(k));
   M_rot(j-1) = M_rot(j) / eta / i;
end

%% Расчет валов на статическую прочность
m2mm = 1000;
sig_T = 340; % МПа
S_1 = 4;
tau_av = sig_T / S_1;
d_min = zeros(1, 2, 'double');
d_min(1) = (M_out * m2mm/0.2/tau_av)^(1/3);
theta_av = 10^-4; % рад/мм
G = 0.8 * 10^5; % МПа
d_min(2) = (32 * M_out * m2mm/ G / pi / theta_av)^(1/4);
L = 10 * ceil(min(d_min));
delta_f = 1.7 * 10^-3;
delta_f_u = L * delta_f;
E = 2 * 10^5;
P = 150 + 10 * S_1;
d_min(3) = (1.3 * P * L^3 / E / pi / delta_f_u)^(1/4);
d_sh = ceil(max(d_min));
% 4-й вал - 5 мм, тогда по Ra20:
% 3-й вал - 4.5 мм,
% 2-й вал - 4.0 мм,
% 1-й вал - 3.6 мм.
%% Выбор посадок
% зубчатое колесо - вал: H7k6
%