clear();
select_engine();
check_output_shaft_strength();
%% Расчет шарикоподшипника на динамическую грузоподъемность
C_lim = 884;
L_h = 6000;
K_safe = 1;
K_T = 1;
V = 1;
F_r = max([R_A, R_B]);
P = V * F_r * K_safe * K_T; 
C_calc = 10^-2 * P * (60 * L_h * n_out)^(1/3);