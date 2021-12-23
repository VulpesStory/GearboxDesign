calc_transmission_strength();
shaft_data();
% ------------------------------------
% Приведенный момент инерции редуктора
% ------------------------------------
rho = 7.85e-6; % kg / mm^3
% для оценки момента инерции двигателя
% представим, что 80% его массы - ротор, который
% представим в виде однородного цилиндра с радиусом в 80% радиуса корпуса
% двигателя
eng_m = 0.8 * 0.175;
eng_r = 0.8 * 34 / 2;
J_eng = eng_m * eng_r^2 / 2;
% геометрические параметры ступицы
l_hub = 6;
d_hub = 10;
% оценка момента инерции двухпальцевой полумуфты
cl_B = 9;
cl_b = 2;
cl_D = 30;
cl_D1 = 10;
cl_m = 0.25 * rho * pi * ( ...
    cl_b * (cl_D^2 - d_sh^2) + ...
    (cl_B - cl_b) * (cl_D1^2 - d_sh^2));
J_cl = cl_m * (cl_D/2)^2 / 2;
% приведенный момент колес
m_g = 0.25 * rho * pi * ( ...
    b_w * (d.^2 - d_sh^2) + ...
    l_hub * (d_hub^2 - d_sh^2));
r_a = d_a / 2;
J_g = m_g .* r_a.^2 / 2;
% суммарный приведенный момент редуктора
J_red = J_eng + J_g(1) + 2 * sum(J_g) / u^2 + (J_g(2) + J_cl) / u^2;  