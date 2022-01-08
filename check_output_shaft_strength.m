clear();
base_data();
shaft_data();
geometry_calc_trans();
T2 = M_out * 1000;
%% Определение опорных реакций
% сила со стороны колеса
F_n = 2 * T2 / (m * z(2) * cos(alp_tw));

A = [-1 1; 0 U];
B = [-F_n; S * F_n];
X = linsolve(A, B);
R_A = X(1);
R_B = X(2);

%% Определение внутренних силовых факторов
dZ = (S + U + V) / 1000;
% Q_1 = F_n, M_1 = F_n * z1
Z1 = 0:dZ:S;
Q1 = ones(1, numel(Z1)) * F_n;
M1 = F_n * Z1;
% Q_2 = F_n - R_A, M_1 = F_n * z2 - R_A * (z2 - S)
Z2 = S:dZ:(S + U);
Q2 = ones(1, numel(Z2)) * (F_n - R_A);
M2 = F_n * Z2 - R_A * (Z2 - S);
% Q_3 = 0, M_1 = F_n * z3 - R_A * (z3 - S) + R_b * (z3 - S - U)
Z3 = (S + U):dZ:(S + U + V);
Q3 = ones(1, numel(Z3)) * (F_n - R_A + R_B);
M3 = F_n * Z3 - R_A * (Z3 - S) + R_B * (Z3 - S - U);
##% Перерезывающая сила
##Q1(end) = Q2(1);
##Q2(end) = Q3(1);
##Q3(end) = 0;
##h = figure();
##plot(Z1, Q1, Z2, Q2, Z3, Q3, "LineWidth", 3);
##grid on;
##% Изгибающий момент
##h = figure();
##plot(Z1, M1, Z2, M2, Z3, M3, "LineWidth", 3);
##grid on;

%% Проверка прочности в опасном сечении
M_dan = max(abs([M1, M2, M3]));

Wp = pi * d_sh^3 / 16; % mm^3
W = Wp / 2;
sig_3eq = 1 / W * sqrt(M_dan^2 + T2^2); % MPa

S1 = 4;
sig_lim = sig_T_sh / S1;