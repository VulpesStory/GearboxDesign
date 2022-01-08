clear();
base_data();
T2 = 1000 * M_out;
% ------------------------
% Расчет фрикционной муфты
% ------------------------
%% Расчет усилия в фрикционном соединении
% параметры контакта сталь-текстолит
f = 0.15; % коэффициент трения
p_lim = 0.9 % MPa, допускаемое давление
% геометрические размеры полумуфт
r_max = 15; % mm
r_min = 13; % mm
r_av = (r_max + r_min) / 2;
F_ring = pi * (r_max^2 - r_min^2);
% прижимная сила
k = 1.3;
F2 = k * T2 / 2 / f / r_av
% проверка давления
p = F2 / F_ring

% %% Предварительный расчет пружины
% F3 = 1.2 * F2;
% i_sp_pre = 6;
% D_sp = 12; % mm
% d_sp_pre = D_sp / i_sp_pre
% 
% %% Проверочный расчет пружины
% d_sp = 2.4; % mm
% i_sp = D_sp / d_sp;
% k_sp = (4 * i_sp - 1) / (4 * i_sp - 4) + 0.615 / i_sp;
% tau_sp_lim = 0.32 * 1670; % MPa
% d_sp_min = 1.6 * sqrt(F3 * i_sp * k_sp / tau_sp_lim)
% 
% %% Геометрический расчет пружины
% G = 81000; % MPa
% S2 = 5; % mm
% n_sp = round(G * S2 * d_sp^4 / 8 / F2 / D_sp^3)
% S2 = 8 * F2 * n_sp * D_sp^3 / G / d_sp^4
% L = d_sp * (n_sp + 1)
% C = F2 / S2

%% Расчет пружины на ЭВМ
spring_data();
D_sp_0 = 10; % mm
F3 = 1.2 * F2;
i_sp = D_sp_0 ./ d_sp + 1;
k_sp = (4 * i_sp - 1) ./ (4 * i_sp - 4) + 0.615 ./ i_sp;
tau_sp = 0.32 * sig_B_sp;
d_sp_min = 1.6 * sqrt(F3 * i_sp .* k_sp ./ tau_sp);
d_sp_min(d_sp >= d_sp_min)
d_sp_cor = d_sp(d_sp >= d_sp_min)
D_sp = D_sp_0 + d_sp_cor

G = 81000; % MPa
S2 = 5; % mm
n_sp = round(G * S2 * d_sp_cor.^4 / 8 / F2 ./ D_sp.^3)
S2 = 8 * F2 * n_sp .* D_sp.^3 ./ G ./ d_sp_cor.^4
L = d_sp_cor .* (n_sp + 1)
C = F2 ./ S2