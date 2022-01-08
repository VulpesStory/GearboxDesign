reduced_angular_mass();
select_engine();
% --------------------------------
% Расчет времени разгона двигателя
% --------------------------------
omeg_eng = (pi/30) * n_eng
K = (M_start - M_nom) / omeg_eng
T = J_red1 / K
t = 3 * T