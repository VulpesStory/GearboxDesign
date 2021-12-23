base_data()
%% Расчет двигателя двигателя
k = 2;
% суммарная нагрузка
N = M_out * omeg_out;
% мощность двигателя
N_eng = k * N;
%% Выбор двигателя
% Polulu "4747"
N_nom = 12; % W
M_start = 294; % N mm
M_nom = 48; % N mm
n_eng = 1600; % rev / min