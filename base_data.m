%% Базовые данные
% первичные
n_out = 140; % rev / min
eps_out = 250; % s^-2
M_S = 0.36; % N m
J = 2e-5; % kg m^2
% вторичные
omeg_out = pi * n_out / 30;
M_out = M_S + J * eps_out;
% Сталь 40, нормализованная
sig_T = 340; % MPa
H_HB = 180; % MPa