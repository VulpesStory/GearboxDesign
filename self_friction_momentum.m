clear();
calc_shaft_torque();
shaft_data();
%% Собственный момент трения механизма
% Оценка тормозящего момента двигателя
I0 = 0.2;
I1 = 3;
torque = 14.5;
M_frI = I0 * torque / (I1 - I0);
% Суммарный момент трения
M_froth = 0.03 * d_sh^2;
M_frS = M_frI;
for k = 1:3
    M_frS = M_frS + M_froth / u^k / prod(eta(1:k));
end