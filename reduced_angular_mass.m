calc_transmission_strength();
shaft_data();
% ------------------------------------
% Приведенный момент инерции редуктора
% ------------------------------------
% для оценки момента инерции двигателя
% представим, что 80% его массы - ротор, который
% представим в виде однородного цилиндра с радиусом в 80% радиуса корпуса
% двигателя
eng_m = 0.8 * 0.175;
eng_r = 0.8 * 34 / 2;
J_eng = round(eng_m * eng_r^2 / 2);
% Механические константы
rho_st = 7.85e-6; % kg / mm^3
rho_tl = 1.6e-6; % kg / mm^3
% Кольцо установочное
J_ring = angmas_ring(rho_st, 5, 11, d_sh)
% Шестерня 1
J_1 =...
  angmas_ring(rho_st, 1, 9, d_sh) +... ступенька
  angmas_ring(rho_st, b_w, d(1), d_sh) +... венец
  angmas_ring(rho_st, 2, 10, d_sh) % ступица
% Шестерня 2, 4
J_2 =...
  angmas_ring(rho_st, b_w, d(2), d_sh) +... венец
  angmas_ring(rho_st, 6, 10, d_sh) % ступица
J_4 = J_2;  
% Шестерня 3, 5
J_3 =...
  angmas_ring(rho_st, b_w, d(1), d_sh) +... венец
  angmas_ring(rho_st, 6, 10, d_sh) % ступица
J_5 = J_3;
% Шестерня 6
D_pad = 2;
J_6 =...
  angmas_ring(rho_st, b_w, d(2), D_pad) +... венец
  angmas_ring(rho_st, b_w, D_pad, d_sh) % прокладка
% Фрикционная полумуфта
J_frcl = angmas_ring(rho_tl, 2, (26 + 30) / 2, 10)
% Ступица
J_hub =...
  angmas_ring(rho_st, 2, 10, d_sh) +... ступенька
  angmas_ring(rho_st, 7, 10, d_sh) +... основа
  angmas_ring(rho_st, 2, 22, d_sh) % венец
% Втулка прижимная
J_b =...
  angmas_ring(rho_st, 2, 10, d_sh) +... ступенька
  angmas_ring(rho_st, 5, 15, d_sh) % упор
% Полумуфта двухпальцевая
J_cl =...
  angmas_ring(rho_st, 7, 10, d_sh) +... ступица
  angmas_ring(rho_st, 2, 30, d_sh) % венец
% Пружина
m_sp = 0.008116;
d_sp = 2.2;
D1_sp = 10 + d_sp * 2;
J_sp = m_sp * (3/4 * d_sp^2 + D1_sp^2) / 4
  
J_red = zeros(1, 4);
J_sh = rho_st * pi * l_sh * d_sh^4 / 32
% 1-й вал
% Кольцо установочное, шестерня 1, двигатель
J_red(1) = J_eng + J_ring + J_1;
% 2-й вал
% шестерня 2, 3
J_red(2) = J_2 + J_3;
% 3-й вал
% Кольцо установочное, шестерня 4, 5
J_red(3) = J_ring + J_4 + J_5;
% 4-й вал
% 2 фрикционные полумуфты, 2 ступицы, пружина, 
% втулка прижимная, полумуфта двухпальцевая, шестерня 6
J_red(4) = 2 * J_frcl + 2 * J_hub + J_b + J_cl + J_sp + J_6;
% моменты инерции на валах, включая валы
J_red = J_red + J_sh
% момент инерции редуктора приведенный к валу двигателя
J_red1 = sum(J_red .* [1, u^-2, u^-4, u^-6])