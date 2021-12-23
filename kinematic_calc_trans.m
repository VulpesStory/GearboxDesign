clear();
select_engine();
%% Кинематический расчет зубчатой передачи
% передаточное число
i_calc = n_eng / n_out;
n_opt = 3 * log10(i_calc);
n = round(n_opt);
u = round(i_calc^(1/n), 2);
% числа зубьев
z = [24, 24 * u];
% проверка передаточного числа
i_real = (z(2) / z(1))^n;
del_i = abs(i_real - i_calc) / i_calc * 100;
n_out = round(n_eng / i_real, 2);
