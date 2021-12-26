clear();
shaft_data();
%% Расчет валов на усталостную прочность
sig_0 = 0.6 * sig_B_sh;
tau_0 = 0.32 * sig_B_sh;
sig_sym = 0.43 * sig_B_sh;
tau_sym = 0.22 * sig_B_sh;

K_M = 1;
K_T = 1;

n1 = 1.1;
n2 = 1.1;
n3 = 1;
n_sig = n1 * n2 * n3;
n_tau = n_sig;

K_sig = 1.90;
K_tau = 1.75;

sig_0_lim = sig_0 * K_M / K_sig / K_T / n_sig
tau_0_lim = tau_0 * K_M / K_tau / K_T / n_tau

sig_sym_lim = sig_sym * K_M / K_sig / K_T / n_sig
tau_sym_lim = tau_sym * K_M / K_tau / K_T / n_tau