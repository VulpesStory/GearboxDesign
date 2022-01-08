function J = angmas_ring(rho, b, D, d)
  J = rho * b * pi / 32 * (D^4 - d^4);
end