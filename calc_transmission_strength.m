clear();
select_engine();
geometry_calc_trans();
%% Подготовка
T2 = M_out * 1000; % N mm
b_w = 4;
n = [n_out * u, n_out];
psi_ba = round(b_w / a_w, 1);
psi_bd = round(psi_ba * (u + 1) / 2, 1);
L = 6000;
g_0 = 4.7;
v = pi * d(2) * n(2) / 6e+4;
%% Контактная прочность
% рассчетное контактное напряжение
F_tH = 2 * T2 / d(2);
Z_E = 190;
Z_H = 2.5;
Z_eps = 0.95;
Z_bet = 1;
K_A = 1;
K_Halp = 1;

if (H_HB <= 339)
    del_H = 0.06;
else
    del_H = 0.14;
end
omeg_Hv = del_H * g_0 * v * sqrt(a_w / u);
K_Hv = 1 + omeg_Hv * b_w / (F_tH * K_A);

LuT = [
    0.2, 0.3, 0.4, 0.5;
    1.08, 1.15, 1.19, 1.23];
i = (1:4)';
K_Hbet = LuT(2, i(LuT(1,:) == psi_bd));
sig_H = Z_E * Z_H * Z_eps * Z_bet * sqrt(...
    F_tH * (u + 1) * K_A * K_Hv * K_Hbet * K_Halp /...
    (b_w * d(1) * u));
% допускаемое контактное напряжение 
sig_Hlimb = 2 * H_HB + 70;
S_Hmin = 1.1;
Z_R = 1;
N_Hlim = 30 * H_HB^2.4;
N_K = 60 * n * L;
Z_N = (N_Hlim ./ N_K).^(1/6);
Z_N(N_K > N_Hlim) = 1;
Z_N(Z_N > 2.6) = 2.6;
Z_oth = 1;

sig_HP = min(sig_Hlimb * Z_N * Z_R * Z_oth / S_Hmin);
%% Изгибная прочность
F_tF = 2 * T2 / d(2);
K_A = 1;

del_F = 0.16;
omeg_Fv = del_F * g_0 * v * sqrt(a_w / u);
K_Fv = 1 + omeg_Fv * b_w / (F_tF * K_A);

LuT = [
    0.2, 0.3, 0.4, 0.5;
    1.17, 1.25, 1.38, 1.47];
i = (1:4)';
K_Fbet = LuT(2, i(LuT(1,:) == psi_bd));
K_Falp = 1;
K_F = K_A * K_Fv * K_Fbet * K_Falp;

Y_FS = 3.47 + 13.2 ./ z - 29.7 * x ./ z + 0.092 * x.^2;
Y_bet = 1;
Y_eps = 1;

sig_F = F_tF * K_F * Y_FS * Y_bet * Y_eps / b_w / m;

sig_Flimb = 1.75 * H_HB;
S_Fmin = 2.2;
Y_A = 1;
N_Flim = 4e+6;
N_K = 60 * n * L;
Y_N = (N_Flim ./ N_K).^(1/6);
Y_N(N_K > N_Flim) = 1;
Y_N(Y_N > 4) = 4;
if m <= 1
    Y_del = 1;
else
    Y_del = 1.082 - 0.172 * log10(m);
end
Y_oth = 1;

sig_FP = sig_Flimb * Y_N * Y_A * Y_del * Y_oth / S_Fmin;