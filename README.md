# MarcoMasterProject
Marco Spinaci's Masters project

- [MarcoMasterProject](#marcomasterproject)
  * [Introduction](#introduction)
  * [Compiler Requirements](#compiler-requirements)
  * [Scripts to Compute the Trajectories](#scripts-to-compute-the-trajectories)
    + [Parameters of `LJChain.jl` and `CGStats.jl` Modules](#parameters-of--ljchainjl--and--cgstatsjl--modules)
    + [Effective Potential and Look-Up Table of Mean and Fluctuating Force](#effective-potential-and-look-up-table-of-mean-and-fluctuating-force)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Introduction
The code in the folder `Julia_Code` allows to implement Molecular Dynamics simulations (both atomistic and Coarse-Grained) and to analyze the results.
We have implemented **four different dynamics** in **(NVE) ensemble** and **(NVT) ensemble**:
* the **Fine-Grained Dynamics** or the All-Atom Dynamics
* the **Orthogonal Dynamics** or the Constrained Dynamics, where the constraints are given by the mapping operators of the Coarse-Grained Dynamics
* the **Coarse-Grained Dynamics**
* the **Markovian Mori-Zwanzig Dynamics**

## Compiler Requirements

Additional used packages: `Parameters`, `StatsBase`, `Plots`, `PyPlot`. Install them explicitly via the julia REPL:

```
julia> import Pkg 

julia> Pkg.add("NAME_PACKAGE")
```

The modules to be loaded to determine and analyze the trajectories are 
* [LJChain.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/LJChain.jl), this module providing physics functions and a parameter object for a 1D chain of 2 species of particle
* [CGStats.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/CGStats.jl), in this module there are all the functions needed to determine the various dynamics and to determine the autocorrelation functions 

## Scripts to Compute the Trajectories
The scripts to determine or to analyze trajectories are divided into four parts, for example see [Store_Trajectory/compareTraj_FGD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/Store_Trajectory/compareTraj_FGD.jl):
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

3. In the third part, we call the functions of module `CGStats.jl` (or `LJChain.jl`) to determine the trajectories of the atomistic system 

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

### Parameters of `LJChain.jl` and `CGStats.jl` Modules
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

They can be modified in a generic script `*.jl` by 

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
MacroSamples::Int   = 50
OrthoSamples::Int   = Int(1e5)
Moments::Int        = 2
check::Int          = Int(5e3)  # to print the number of iteration in a loop

# NB: the below coeffcients must be checked and entered every time a new look-up table of Mean and Fluctuating Force is generated.
# NB: the following values were generated for the look-up tables in the folder Julia_Code/Store_Trajectory for the system C (M-m-M) with masses M=10 and M=1
#     consisting of 30 particles.

# Coeff. of line (y = m*x + q) in the ApproxMeanStresses function
m_MF::Float64       = 537.59;   # gradient of the line
q_MF::Float64       = -1567.1;  #  y-intercept of the line

# Coeff. of line (y = m*x + q) in the ApproxFlucStep function
m_FF::Float64       = -135.21;  # gradient of the line
q_FF::Float64       = 403.79;   #  y-intercept of the line

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

### Effective Potential and Look-Up Table of Mean and Fluctuating Force
In this work the **Effective Potential** to compute the CG and MMZD dynamics is determined via a **bottom-up approach**, i.e. through Fine-Grained (or atomistic) simulations. More specifically, it is determined through the integration of the **Mean Force** with respect to the distance between the CG particles.

The **look-up table of the Mean Force and Fluctuating Force** with respect to the distance between the CG particles in the (NVT) ensemble are computed by the script: [ABCD_Systems/CoarseGrainingLangDyn_sABCD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/ABCD_Systems/CoarseGrainingLangDyn_sABCD.jl).


