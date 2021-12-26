function Y = sround(X, n)
  offset = 10^n;
  Y = round(X * offset) / offset;
end