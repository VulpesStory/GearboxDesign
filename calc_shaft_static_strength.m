clear();
base_data();
shaft_data();
%% Расчет валов на статическую прочность
% Статическая прочность на кручение
m2mm = 1000;
S_1 = 4;
tau_av = sig_T_sh / S_1;
d_sh_min = zeros(1, 2, 'double');
d_sh_min(1) = round(M_out * m2mm / 0.2 / tau_av)^(1/3);
% Крутильная жесткость
theta_av = 10^-4; % рад/мм
G = 0.8 * 10^5; % МПа
d_sh_min(2) = (32 * M_out * m2mm / G / pi / theta_av)^(1/4);
% Резание на станке
P = 150 + 10 * S_1;
L = 10 * ceil(min(d_sh_min));
delta_f = 1.7 * 10^-3;
delta_f_u = L * delta_f;
E = 2 * 10^5;
d_sh_min(3) = (1.3 * P * L^3 / E / pi / delta_f_u)^(1/4);
d_sh = ceil(max(d_sh_min));
d_sh_min = sround(d_sh_min, 1);
% 4-й вал - 6 мм,
% 3-й вал - 6 мм,
% 2-й вал - 6 мм,
% 1-й вал - 6 мм = вал двигателя