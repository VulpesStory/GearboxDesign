clear; clc;
calc_shaft_torque();
shaft_data();
%%
%---------------------
% Упругий мертвый ход
%---------------------
m2mm = 1e3;
% Полярный момент
J_p = pi * d_sh^4 / 32;
% Модуль упргости второго рода из УП ППМ табл 4.9 (среднее значение)
G = 0.805e5;
% fl - упругий
j_phiflmax = 10800/pi * m2mm * M_rot .* l_sh / J_p / G

j_phiflsum = sum(j_phiflmax ./ [u^3, u^2, u, 1])