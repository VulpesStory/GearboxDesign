clear; clc;
calc_shaft_torque();
shaft_data();
%%
%---------------------
% Упругий мертвый ход
%---------------------

% Полярный момент
Jp = pi * d_sh^4 / 32;
% Длина, на которой находится крутящий момент (равен длине вала, кроме последнего) 
l = [15.5 55 50 36.5+3.5/2-2];
% Модуль упргости второго рода из УП ППМ табл 4.9 (среднее значение)
G = 0.805*10e5;

jphimaxi = 10800/pi .* M_rot .* l / Jp ./ G;

jphisum = jphimaxi(1) ./ u^3 + jphimaxi(2) ./u^2 + jphimaxi(3) ./ u + jphimaxi(4); 