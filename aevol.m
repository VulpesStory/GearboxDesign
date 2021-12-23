function x = aevol(i)
    x = 1.441 * i.^(1/3) - 0.374 * i;
    for k = 1:4
        x = x + (i - evol(x)) ./ tan(x).^2;
    end
end