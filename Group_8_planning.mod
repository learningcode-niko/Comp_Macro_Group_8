// This is planning for the group work assignment. 

// Model Setup: 
// H = Hand-to-Mouth Households
// R = Ricardian Households

// Declare variables (This is all from class and needs to be adjusted)
var
C_H // Consumption of Hand-to-Mouth Households
C_R // Consumption of Ricardian Households
C // Total Consumption
Y // Output
I // Investment 
N_H // Labor of Hand-to-Mouth Households
N_R // Labor of Ricardian Households
N // Total Labor
K // Capital
G // Government spending
T // Taxes
Profits // Profits
Lambda_H // Lagrange multiplier for HTM households
Lambda_R // Lagrange multiplier for Ricardian households
B // Bonds
W // wage 
A // Total factor productivity
q // price of bonds
;

// Shocks
varexo 
eps_A // Shock to TFP
eps_G // Shock to government spending 
eps_tau // Shock Tax (through bonds)
;

// declare parameters
parameters
beta // time discount
delta // depreciation rate
alpha // capital share in production
v // share of HTM households
chi // disutility of labor
eta // elasticity of labor to consumption
G_bar // steady state government spending
rho_A // persistence of TFP shock
rho_G // persistence of government spending shock
sigma_A // standard deviation of TFP shock
sigma_G // standard deviation of government spending shock
sigma_tau // standard deviation of Tax shock
phi_T // quickness to adjust taxes to debt
B_bar // steady state bonds
T_bar // steady state taxes
;

// Calibration (placeholders where marked)
beta    = 0.96;
delta   = 0.08;
alpha   = 1/3;
v       = 0;      // start at 0 to test the plain RBC case
chi     = 10.3;   // placeholder: will be chosen to hit a target for hours
eta     = 1;
G_bar   = 0.11;    // placeholder: will be tied to G/Y later
B_bar   = 0;      // placeholder: debt target comes later
phi_T   = 0.1;    // placeholder: must satisfy 1-q < phi < 1+q
rho_A   = 0.9;
rho_G   = 0.9;
sigma_A = 0.01;
sigma_G = 0.01;
sigma_tau = 0.01;

//Model Equations

// HTM HH Block 
// FOC w.r.t.C
C_H = 1/Lambda_H; 

// FOC w.r.t.N
chi*N_H^eta = W*Lambda_H;

// BC of HTM HH:  
C_H = W*N_H - T;

// R HH Block 
// FOC w.r.t.C
C_R = 1/Lambda_R; 

// FOC w.r.t.N
chi*N_R^eta = W*Lambda_R;

// FOC w.r.t. B(+1)
q = beta*Lambda_R(+1)/Lambda_R;

// BC of R HH:
C_R + q*B/(1-v)= W*N_R + Profits/(1-v) + B(-1)/(1-v) - T;

// Total Consumption 
C = v*C_H + (1-v)*C_R;

// Firm Block 

// Production function
Y = A*K(-1)^alpha*N^(1-alpha);

// Labor
N = v*N_H + (1-v)*N_R;

// Capital accumulation equation
K = (1-delta)*K(-1) + I;

// FOC w.r.t. K
Lambda_R = beta*Lambda_R(+1)*(alpha*A(+1)*K(+1)^(alpha-1)*N(+1)^(1-alpha) + 1-delta);

// FOC w.r.t. N
W = (1-alpha)*Y/N;

// Profits 
Profits = Y - W*N - I;

// Exogenous processes
log(A) = rho_A*log(A(-1)) + eps_A;

log(G/G_bar) = rho_G*log(G(-1)/G_bar) + eps_G;

T = T_bar + phi_T*(B(-1)-B_bar) + eps_tau;
// Government Block 

//Government BC
G + B(-1) = T + q*B;

end;



// Now Steady State Block

steady_state_model;
  [C_H,C_R,C,Y,I,N,N_H,N_R,K,G,T,Profits,Lambda_H,Lambda_R,B,W,A,q,mew,sigma] = get_ss_1(beta,delta,alpha,chi,eta,G_bar);
end;

initval; 

end; 


// Now solve the policy function

// solve SS 
steady; 
// checking residuals
resid; 
// cheecking the modal consistency 
check; 

shocks;
  var eps_A; stderr sigma_A;
  var eps_G; stderr sigma_G;
  var eps_tau; stderr sigma_tau;
end;

stoch_simul(periods=200,irf=40) C C_H C_R Y I K N N_H N_R Lambda_R Lambda_H Profits A G T q W;
