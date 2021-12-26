% ---------------------------------------
% Геометрический расчет зубчатой передачи
% ---------------------------------------
z = [24 54];
m = 0.6;
beta = 0; 
alp = deg2rad(20);
h_a_star = 1;
c = 0.35;
h_l = 2;
u = z(2) / z(1);
d = m * z / cos(beta);
alp_t = atan(tan(alp) / cos(beta));
a = m * sum(z) / (2 * cos(beta));
del_a = 0.15;
a_w = a + del_a;
alp_tw = acos(a / a_w * cos(alp_t));
x_sum = sum(z) * (evol(alp_tw) - evol(alp_t)) / 2 / tan(alp);
x = zeros(1,2,'double');
x(1) = sround(0.5 * x_sum, 1);
x(2) = x(1);
h_f = m * (h_a_star + c - x);
y = (a_w - a) / m;
del_y = sum(x) - y;
h_a = m * (h_a_star + x - del_y);
d_f = d - 2 * h_f;
d_a = d + 2 * h_a;
z_min = 2 * (h_l - h_a_star - x) * cos(beta) / sin(alp_t)^2;
x_min = h_l - h_a_star - z * sin(alp_t)^2 / 2 / cos(beta);
LuT = [
    0.5,    0.6,    0.8,    1.0;
    0.866,  1.023,  1.432   1.732];
D = LuT(2, LuT(1,:) == m);
alp_D = aevol( ...
    D / m / cos(alp) ./ z + ...
    evol(alp_t) - pi / 2 ./ z + ...
    2 * x ./ z * tan(alp));
M = m * z * cos(alp_t) ./ cos(alp_D) + D;

%% Отклонение для размеров по роликам М 
% F_r = [22 26]; %табл 15
E_Wms_1 = -[16 22];% I слагаемое табл. 25
F_r = [22, 26]; % Допуск на радиальное биение зубчатого венца, табл. 15
E_Wms_2 = -[5 7]; % II слагаемое табл. 26
E_Wms = E_Wms_1 + E_Wms_2; 
T_Wm = [16 19]; % табл 27

beta_b = asin(sin(beta) * cos(alp));
E_Ms = -round(E_Wms ./ sin(alp_D) / cos(beta_b));
T_M = round(T_Wm ./ sin(alp_D) / cos(beta_b));
E_Mi = E_Ms - T_M;