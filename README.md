# Computational Macroeconomics - Group 8
### *How do hand-to-mouth households change fiscal multipliers?*

A simple two-household-type model: Ricardian households and hand-to-mouth households, with a common labour market and simple fiscal policy.

Compare government-spending impulse responses when the share of hand-to-mouth households is low versus high. Focus on aggregate consumption and output.

### Running the model
- **Software used for verification:** GNU Octave 11.3.0 and Dynare 7.2. These versions are not pinned in the model files.
- **File to run:** `main.mod`. From the repository root in Octave, run `dynare main.mod`.
- **Results:** computes the steady state and first-order stochastic simulations, including 40-period impulse responses for consumption (aggregate and by household type), output, capital, labor, wages, taxes, bonds, and government spending. It also includes a robustness test with $\phi_G = 1$.
- **Output:** generated figures are saved in `figures/`. No external data or other project files are required; the model and its inputs are defined in `main.mod`.

### Our Parameters
- Discount Factor:                                 $\beta = 0.96$ *annualised; based on Dong, Liu & Wang (2023), and Galí, López-Salido & Vallés (2007)*
- Depreciation of Capital:                         $\delta = 0.1$ *annualised; based on Dong, Liu & Wang (2023), and Galí, López-Salido & Vallés (2007)*
- Capital Share of Output:                         $\alpha = 1/3$ *based on Galí, López-Salido & Vallés (2007)*
- Share of Hand-to-Mouth Households:               $v = 0.35 \text{ or } 0.51$ *based on Bilbiie, Meier, and Müller (2006)*
- Disutility of Labor:                             $\chi = 10.625$ *calibrated so that N = 1/3 and G/Y = 0.2 at v = 0 (targets from Class Slides, matching US  historical data)*
- Curvature of Labor Disutility:                   $\eta = 1$ *from class (Sessions 5 & 6)*
- Steady State Government Spending:                $\bar{G} = 0.1023$ *calibrated so that G/Y = 0.2 at v = 0 (target from Class Slides, matching US historical data)*
- Steady State Taxes:                              $\bar{T} = \bar{G} + (1-\beta)\bar{B} = 0.1023$ *set so the government budget balances in steady state*
- Steady State Bonds:                              $\bar{B} = 0$ *based on Galí, López-Salido & Vallés (2007)*
- Speed of Tax Adjustment to Debt:                 $\phi_T = 0.8$ *Galí, López-Salido & Vallés (2007): $\phi_b = 0.33$ quarterly, converted to annual*
- Share of Extra Spending Financed by Taxes:       $\phi_G = 0.1$ *based on Galí, López-Salido & Vallés (2007)*
- Persistence of TFP Shock:                        $\rho_A = 0.9$ *from class (Sessions 5 & 6)*
- Persistence of Government Spending Shock:        $\rho_G = 0.66$ *Galí, López-Salido & Vallés (2007): 0.9 quarterly, $0.9^4 \approx 0.66$ annual*
- Standard Deviation of TFP Shock:                 $\sigma_A = 0.01$ *from class (Sessions 5 & 6)*
- Standard Deviation of Government Spending Shock: $\sigma_G = 0.01$ *from class (Sessions 5 & 6)*
- Standard Deviation of Tax Shock:                 $\sigma_{\tau} = 0.003$ *based on Leeper, Plante & Traum (2009)*

### Sources
| Paper | Author | Date |
| -------- | -------- | ------ |
| *What accounts for the changes in U.S. fiscal policy transmission?* | **Florin Bilbiie, André Meier & Gernot J. Müller** | 2006 |
| *Consumption, Income, and Interest Rates: Reinterpreting the Time Series Evidence* | **John Y. Campbell and N. Gregory Mankiw** | 1989 |
| *Understanding the Effects of Government Spending on Consumption* | **Jordi Galí, J. David López-Salido & Javier Vallés** | 2007 |
| *Dynamics of Fiscal Financing in the United States* | **Eric M. Leeper, Michael Plante & Nora Traum** | July 2009 |
| *Clearing Up the Fiscal Multiplier Morass* | **Eric M. Leeper, Nora Traum & Todd B. Walker** | March 2017 |
| *Turbulent Business Cycles* | **Ding Dong, Zheng Liu & Pengfei Wang** | February 2023 |

### Declaration of Contribution
All listed group members (Pablo Campana, Nicholas Pellechi, Abdullah Khuzai, Nicholás Sánchez, Mark Aren Sangha and Charles Vasseur) confirm that each member made a meaningful and broadly equal contribution to the research, writing and preparation of this policy brief.

### Declaration of AI
We used Claude (Anthropic) and GitHub Copilot in VS Code to support the project. AI tools helped us to check our Dynare code against the assignment brief, verify the steady-state solution, explain MATLAB/Octave and Dynare syntax, debug errors, and write code to calculate and plot impulse responses and spending and tax multipliers. They also helped explore modelling choices and verify our explanations of the economic mechanisms behind the results.

AI was used as a supporting tool, not as a substitute for the group's modelling, simulations, verification, or economic analysis.

### Reproducibility
To reproduce the results, install Octave and Dynare, then run `dynare main.mod` from the project root. Generated figures are saved in `figures/`. No external data or additional project files are needed.
