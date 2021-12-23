clear();
geometry_calc_trans();
base_data();
%% Расчет вращательных моментов на валах
Z = [z, z, z];
i = 2.25;
f = 0.08;
M_rot = zeros(1, 4, "double");
eta = zeros(1, 3, "double");
M_rot(4) = M_out;
for j = 4:-1:2
   k = (j - 1) * 2;
   F_n = 2 * M_rot(j) / m / Z(k) / cos(alp_t);
   C = (F_n + 3) / (F_n + 0.2);
   eta(j-1) = 1 - C * f * pi * (1 / Z(k-1) + 1 / Z(k));
   M_rot(j-1) = M_rot(j) / eta(j-1) / i;
end