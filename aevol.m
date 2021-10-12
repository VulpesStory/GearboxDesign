function v = aevol(u)
a = deg2rad(90-eps);
step = -a / 2;
l = u - evol(a);
for i = 1:1:100000
    a = a + step;
    e = u - evol(a);
    if e * l < 0
        step = step * -1;
    end
    step = step / 2;
    l = e;
end
v = a;
end