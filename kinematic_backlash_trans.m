clear; clc;
geometry_calc_trans();
shaft_data();
%%
%----------------------------
% Кинематический мертвый ход
%----------------------------

% Допуски:
% На кинематическую погрещность для зубчатых колес
% Степень точности 7 модуль 0.6 из УП ППМ прил. 1 табл 1
Fr = [22 26]; % мкм

% На радиальное биение для гладких валов
eV = [0 0]; % мкм

% Зазор в посадке колеса на вал
% Равен среднему зазору посадки ЗК-Вал 6 H7/k6
eP = [1 1]; % мкм

% Предельны отклонения межосевого расстояния 
% Степень точности 7 aw = 23.55 из УП ППМ прил. 1 табл 14
fa = 25; % мкм 

% Наименьшие дополнительные смещения исходного контура
% 7-F, d = [32 14] из УП ППМ прил. 1 табл 23
EHS = [24 32];

% Допуск на смещение исходного контура
% Вид сопряжения F, Fr = [22 26] из УП ППМ прил. 1 табл 24
TH = [42 50];

%Радиальное биение внутреннего кольца
% собранного подшипника
% УП ППМ прил. 1 табл 18
Kia = [6 6];


l = U;
b = [0 16 6 6 6 6] + 3.5/2 + 4 / 2;
b(1) = 0;
a = b+l;
a(1) = 0;

Fr = repmat(Fr,1,3);
eV = repmat(eV,1,3);
eP = repmat(eP,1,3);
EHS = repmat(EHS,1,3);
TH = repmat(TH,1,3);
Kia = repmat(Kia,1,3);
% Монтажное радиальное биение зубчатых колес
Gr = tan(alp) / cos(beta) .* (Fr + eP + eV + Kia.*(a+b) / l);
jtmax = [];
for num=1:2:6
    jtmax =[jtmax 0.7*sum(EHS(num:num+1)) + sqrt(0.5*sum(TH(num:num+1).^2) ...
        + 2*fa^2 + sum(Gr(num:num+1).^2))];
end

jphimax = 7.32*jtmax ./ d(2);

jphisum = jphimax(1)/u^2 + jphimax(2)/u + jphimax(end);
