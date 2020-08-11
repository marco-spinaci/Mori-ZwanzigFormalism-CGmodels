# MarcoMasterProject
Marco Spinaci's Masters project

- [MarcoMasterProject](#marcomasterproject)
  * [Introduction](#introduction)
  * [Compiler Requirements](#compiler-requirements)
    + [Parameters of `LJChain.jl` Module and `CGStats.jl` Module](#parameters-of-ljchainjl-module-and-cgstatsjl-module)
  * [Scripts to Compute the Trajectories](#scripts-to-compute-the-trajectories)
    + [Effective Potential and Look-Up Table of Mean Force and Fluctuating Force](#effective-potential-and-look-up-table-of-mean-force-and-fluctuating-force)
    + [How to Use Look-Up Tables in Trajectory Scripts](#how-to-use-look-up-tables-in-trajectory-scripts)
  * [Scripts to Analyse the Trajectories](#scripts-to-analyse-the-trajectories)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Introduction
The code in the folder `Julia_Code` allows to implement Molecular Dynamics simulations (both atomistic and Coarse-Grained) and to analyze the results.
We have implemented **four different dynamics** in **(NVE) ensemble** and **(NVT) ensemble**:
* the **Fine-Grained Dynamics (FGD)** or the All-Atom Dynamics
* the **Orthogonal Dynamics (OD)** or the Constrained Dynamics, where the constraints are given by the mapping operators of the Coarse-Grained system
* the **Coarse-Grained Dynamics (CGD)**
* the **Markovian Mori-Zwanzig Dynamics (MMZD)**

## Compiler Requirements

Additional used packages: `Parameters`, `StatsBase`, `Plots`, `PyPlot`. Install them explicitly via the julia REPL:

```
julia> import Pkg 

julia> Pkg.add("NAME_PACKAGE")
```

The modules to be loaded to determine and analyze the trajectories are 
* [LJChain.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/LJChain.jl), this module providing the physics functions and a parameter object for a 1D periodic chain of 2 species of particles, which differ in mass and bond stiffness. The particles are arranged in a repeating pattern, and the Coarse-Grained (CG) model is obtained by combining the single repeated units into CG interaction site (called beads). The CG variables are given by the center of mass of each bead and by the corresponding momenta. The inter-atomic potential is a simple 12-6 Lennard-Jones potential and the interaction between two different species of particles is set by the so-called Lorentz-Berthelot mixing rule. 
* [CGStats.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/CGStats.jl), in this module there are all the functions needed to determine the various dynamics and to determine the autocorrelation functions 

### Parameters of `LJChain.jl` Module and `CGStats.jl` Module
The default values of the parameters in the LJChain.jl module are

```julia
Patt::Array{Int,1}     = [0,1,0] # Pattern of particles
NBeads::Int            = 10      # Number of beads
ConstrainedBeads::Int  = 2       # Number of beads to constrain
SM::Float64            = 10.0    # Mass of 0 particles
LM::Float64            = 1.0     # Mass of 1 particles
SEps::Float64          = 1.0     # Scaling of LJ potential for 0 particles
LEps::Float64          = 100.0   # Scaling of LJ potential for 1 particles
Dist::Float64          = 1.0     # Equilibrium distance for all LJ potentials
Beta::Float64          = 1.0     # Inverse temperature
Gamma::Float64         = 1.0     # Friction parameter
```
where `SEps` and `LEps` are the depths of the potential well that can be varied to analyse the effect of the stiffness of the interactions.

These values can be modified in a generic script `*.jl` by 

```julia
C = Chain(SM=1, LM=1, Beta=1)
```

Instead, the default values of the parameters in the CGStats.jl module are

```julia
dt::Float64         = 1e-4
Stochdt::Float64    = 1e-4
FullSteps::Int      = Int(1e5)
OrthoSteps::Int     = 1
ApproxSteps::Int    = Int(1e5)
LagStep             = 400       # spacing of lag times for autocorrelation
NumLags             = 30        # number of lag times to compute
MacroSamples::Int   = 50        # number of values in the look-up tables of the Mean Force and Fluctuating Force
OrthoSamples::Int   = Int(1e5)
Moments::Int        = 2
check::Int          = Int(5e3)  # to print the number of iteration in a loop

# NB: the below coeffcients must be checked and entered every time a new look-up table of Mean and Fluctuating Force is generated.
# NB: the following values were generated for the look-up tables in the folder Julia_Code/Store_Trajectory for the system C (M-m-M) with masses M=10 and M=1
#     consisting of 30 particles.

# Coeff. of line (y = m*x + q) in the ApproxMeanStresses/ApproxFlucStep function
m_MF::Float64       = 537.59;   # gradient of the line
q_MF::Float64       = -1567.1;  # y-intercept of the line

m_FF::Float64       = -135.21;  # gradient of the line
q_FF::Float64       = 403.79;   # y-intercept of the line

# Coeff. of exponential function (y = A*exp(-B*x)) in the ApproxMeanStresses/ApproxFlucStep function
coeffEXP_MF_A::Float64 = 4.0552e5;
coeffEXP_MF_B::Float64 = 3.8192;

coeffEXP_FF_A::Float64 = 3.3199e6;
coeffEXP_FF_B::Float64 = 4.8887;
```

They can be modified in a generic script `*.jl` by 

```julia
S = Simulator(dt=1e-3, Stochdt=1e-3, FullSteps=Int(1e7), ApproxSteps=Int(1e7))
```

## Scripts to Compute the Trajectories
The scripts to compute the trajectories in the (NVT) ensemble can be found in the folder `Julia_Code/Store_Trajectory` and they are
* [Store_Trajectory/compareTraj_FGD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/Store_Trajectory/compareTraj_FGD.jl)
* [Store_Trajectory/compareTraj_DCGD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/Store_Trajectory/compareTraj_DCGD.jl)
* [Store_Trajectory/compareTraj_MMZD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/Store_Trajectory/compareTraj_MMZD.jl)

These scripts are divided into four parts, for example see [Store_Trajectory/compareTraj_FGD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/Store_Trajectory/compareTraj_FGD.jl):
1. In the first part, we load the necessary packages and modules:

```julia
include("../LJChain.jl")
include("../CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles
```

2. In the second part, we can set up the parameters for the simulation present in the loaded modules `LJChain.jl` and `CGStats.jl`:

```julia
C = Chain(SM=1, LM=1, Beta=1);
S = Simulator(dt=1e-3, Stochdt=1e-3, FullSteps=Int(1e7), ApproxSteps=Int(1e7));
```

3. In the third part, we call the functions of module `CGStats.jl` (or `LJChain.jl`) to determine the trajectories of the Fine-grained (or atomistic) system 

```julia
# Generate initial data

(P0, Q0, F0, H0, P0CG, Q0CG) = InitConds(C);

# Generate a random trajectory, using data-generated potentials

(PFull, QFull, FFull, Kmean, Hmean) = LangFullTraj_NVT(P0, Q0, C, S);
```

4. Finally, we save the data to files

```julia
open("Store_Trajectory/Outcomes/P_FGD_M1m1_1e7_B1.csv", "w+") do x
    writedlm(x, (C.Phi*PFull)');
end
open("Store_Trajectory/Outcomes/Q_FGD_M1m1_1e7_B1.csv", "w+") do x
    writedlm(x, (C.Psi*QFull)');
end
open("Store_Trajectory/Outcomes/F_FGD_M1m1_1e7_B1.csv", "w+") do x
    writedlm(x, (C.PhiF*FFull)');
end
```

where `C.Phi` and `C.Psi` are the mapping operators of the CG system and, `C.PhiF` is the projection operator of the Forces in the CG system. We are projecting the obtained data so that we can easily compare them with those obtained from CGD and MMZD.

To determine CGD and MMZD, the scripts have an additional part where we can insert the look-up tables to determine the Effective potential and, the thermal bath in the case of MMZD. 

### Effective Potential and Look-Up Table of Mean Force and Fluctuating Force
The **Effective Potential** is determined via a **bottom-up approach**, _i.e._ through Fine-Grained (or atomistic) simulations. More specifically, it is determined through the integration of the **Mean Force** with respect to the distance between the CG particles.

The **look-up table of the Mean Force and Fluctuating Force** with respect to the distance between the CG particles in the (NVT) ensemble are computed by the script: [ABCD_Systems/CoarseGrainingLangDyn_sABCD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/ABCD_Systems/CoarseGrainingLangDyn_sABCD.jl) by means of the function

```julia
(RR,PP,Veff,Fmean,Fstd,FdataMF,FdataFF) = VEffConstrainedLangDyn_NVT(C,S)
```

where 
* `RR` is the distance between the CG particles
* `PP` is the momenta of the CG particles
* `Veff` is the Effective Potential
* `Fmean` is the Mean Force
* `Fstd` is the Fluctuating Force
* `FdataMF` and `FdataFF` are the coefficients for the cubic spline interpolation. These coefficients are	generated from kriging interpolation data and, they are generated separately to eliminate noise from the original Mean Force and Fluctuating	Force data.

### How to Use Look-Up Tables in Trajectory Scripts
As we said, the scripts [Store_Trajectory/compareTraj_DCGD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/Store_Trajectory/compareTraj_DCGD.jl) and [Store_Trajectory/compareTraj_MMZD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/Store_Trajectory/compareTraj_MMZD.jl) need look-up tables to determine the Mean Force and also to determine the thermal bath in the case of the second script.

Looking at the second script, there are two ways:
1. use the raw data if equally spaced or data obtained from a polynomial regression of the raw data and determine from these data the coefficients for cubic spline interpolation

```julia
# to generate the coefficients for the cubic spline interpolation for mean force and fluctuating force
# NB: the grid points *must* be equally spaced
force_data = readdlm("Store_Trajectory/force_1_1_Beta1.dat", Float64);

RR = force_data[:, 1];
dx = RR[2] - RR[1];

Fm = force_data[:, 2] ./ C.Beta;
FmINT_D = (circshift(Fm,-1) - circshift(Fm,1)) ./(2*dx);
Fmean = Fm[2:end-1];
Fmean_d = FmINT_D[2:end-1];

Fmean_coeff1 = (2. * (Fmean - circshift(Fmean, -1)) + (Fmean_d + circshift(Fmean_d, -1)) * dx) / dx;
Fmean_coeff2 = circshift(Fmean, -1) - Fmean + (-Fmean_d - Fmean_coeff1) * dx;

FdataMF = zeros(length(Fmean) - 1, 5);
FdataMF[:, 1] = RR[2:end - 2];
FdataMF[:, 2] = Fmean[1:end - 1];
FdataMF[:, 3] = Fmean_d[1:end - 1];
FdataMF[:, 4] = Fmean_coeff1[1:end - 1];
FdataMF[:, 5] = Fmean_coeff2[1:end - 1];


flucts_data = readdlm("Store_Trajectory/flucts_1_1_Beta1.dat", Float64);

RR = flucts_data[:, 1];
dx = RR[2] - RR[1];

Fluct = flucts_data[:, 2];
FluctINT_D = (circshift(Fluct,-1) - circshift(Fluct,1)) ./(2*dx);
FF = Fluct[2:end-1];
FF_d = FluctINT_D[2:end-1];

FF_coeff1 = (2. * (FF - circshift(FF, -1)) + (FF_d + circshift(FF_d, -1)) * dx) / dx;
FF_coeff2 = circshift(FF, -1) - FF + (-FF_d - FF_coeff1) * dx;

FdataFF = zeros(length(FF) - 1, 5);
FdataFF[:, 1] = RR[2:end - 2];
FdataFF[:, 2] = FF[1:end - 1];
FdataFF[:, 3] = FF_d[1:end - 1];
FdataFF[:, 4] = FF_coeff1[1:end - 1];
FdataFF[:, 5] = FF_coeff2[1:end - 1];
```

2. use the data `FdataMF` and `FdataFF` obtained from the script [ABCD_Systems/CoarseGrainingLangDyn_sABCD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/ABCD_Systems/CoarseGrainingLangDyn_sABCD.jl) (see previous section)

```julia
FdataMF = readdlm("ABCD_Systems/Outcomes/Coeff_MF_SplineI_sC_M1m1.csv", Float64);
FdataFF = readdlm("ABCD_Systems/Outcomes/Coeff_FF_SplineI_sC_M1m1.csv", Float64);
```

## Scripts to Analyse the Trajectories
