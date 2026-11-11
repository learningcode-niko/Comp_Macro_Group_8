function [C_H,C_R,C,Y,I,N_H,N_R,N,K,G,T,Profits,Lambda_H,Lambda_R,B,W,A,q] = ...
    get_ss_groupwork_8(beta,delta,alpha,v,chi,eta,G_bar,B_bar,T_bar)

A = 1;
G = G_bar;
B = B_bar;
q = beta;
T = T_bar;

if v < 0 || v >= 1
    error('The steady state requires 0 <= v < 1.');
end

if abs(G + B - T - q*B) > 1e-10
    error('Steady-state parameters violate the government budget constraint.');
end

% The capital Euler equation determines the steady-state capital-labor ratio.
return_on_capital = 1/beta - 1 + delta;
k_ss = (alpha/return_on_capital)^(1/(1-alpha));
k_power = k_ss^alpha;
W = (1-alpha)*k_power;

% Household labor is determined by each household's labor FOC and budget.
htm_labor_condition = @(labor) ...
    chi*labor.^eta.*(W*labor-T)-W;
N_H = fzero(htm_labor_condition,0.5);

profit_per_labor = alpha*k_power-delta*k_ss;
ricardian_labor_condition = @(labor) ...
    chi*labor.^eta.*(W*labor ...
    + profit_per_labor*(v*N_H+(1-v)*labor)/(1-v) ...
    + (1-q)*B/(1-v)-T)-W;
N_R = fzero(ricardian_labor_condition,0.5);

N = v*N_H+(1-v)*N_R;
K = k_ss*N;
Y = A*K^alpha*N^(1-alpha);
I = delta*K;
Profits = Y-W*N-I;
C_H = W*N_H-T;
C_R = W*N_R+Profits/(1-v)+(1-q)*B/(1-v)-T;
C = v*C_H+(1-v)*C_R;
Lambda_H = 1/C_H;
Lambda_R = 1/C_R;

if any([C_H,C_R,C] <= 0)
    error('The steady-state solution implies non-positive consumption.');
end

end
