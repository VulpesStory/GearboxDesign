clear; clc;
geometry_calc_trans();
shaft_data();
%%
%----------------------------
% Кинематический мертвый ход
%----------------------------

% Наименьшие дополнительные смещения исходного контура
% 7-F, d = [14.4, 32.2] из УП ППМ прил. 1 табл 23
E_HS = [24 32];
% Допуск на смещение исходного контура
% Вид сопряжения F, F_r = [22 26] из УП ППМ прил. 1 табл 24
T_H = [42 50];
% Предельные отклонения межосевого расстояния 
% Степень точности 7 a_w = 23.55 из УП ППМ прил. 1 табл 14
f_a = 25; % мкм

% Зазор в посадке колеса на вал
% Равен среднему зазору посадки ЗК-Вал 6 H7/k6
e_P = [1 1]; % мкм
% Допуск на радиальное биение посадочной ступени вала под зубчатое колеса
% из УП ППМ прил. 1 табл. 19
e_V = [0 0]; % мкм
% Допуск на радиальнео биение внутренних колес собранных подшипников
% из УП ППМ прил. 1 табл 18
K_ia = [6 6];
% Геометрия
l = U;
b = [0, 20; 10, 10; 10, 10] + 3.5/2 - 4/2;
b(1) = 0;
a = b + l;
a(1) = 0;
G_r = tan(alp) / cos(beta) * (F_r + e_P + e_V + K_ia .* (a + b) / l)

j_tmax = 0.7 * sum(E_HS) + sqrt(0.5 * sum(T_H.^2) + 2 * f_a^2 + sum(G_r.^2, 2))

j_phimax = 7.32 * j_tmax / d(2) % угл. минуты

j_phisum = sum(j_phimax ./ [u^2; u; 1]) % угл. минуты