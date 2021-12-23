clear();
shaft_data();
%% Расчет валов на усталостную прочность
sig_0 = 0.6 * sig_B_sh;
tau_0 = 0.32 * sig_B_sh;
sig_sym = 0.6 * sig_B_sh;
tau_sym = 0.32 * sig_B_sh;

K_M = 0.9;
K_T = 1;

n1 = 1.3;
n2 = 1.05;
n3 = 1.5;
n_sig = n1 * n2 * n3;
n_tau = n_sig;

K_sig = 1.90;
K_tau = 1.75;

sig_perm = sig_0 * K_M / K_sig / K_T / n_sig;
tau_perm = tau_0 * K_M / K_tau / K_T / n_tau;