# MarcoMasterProject
Marco Spinaci's Masters project

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

## Scripts to compute the trajectories
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

### Parameters of `LJChain.jl` and `CGStats.jl` modules
The settable parameters of the LJChain.jl module are

```julia
Patt::Array{Int,1} 	   = [0,1,0] # Pattern of particles
NBeads::Int			       = 10	     # Number of beads
ConstrainedBeads::Int  = 2	  	 # Number of beads to constrain
SM::Float64 			     = 10.0	   # Mass of 0 particles
LM::Float64 			     = 1.0	   # Mass of 1 particles
SEps::Float64			     = 1.0     # Scaling of LJ potential for 0 particles
LEps::Float64 		     = 100.0   # Scaling of LJ potential for 1 particles
Dist::Float64 		     = 1.0     # Equilibrium distance for all LJ potentials
Beta::Float64 		     = 1.0	   # Inverse temperature
Gamma::Float64         = 1.0     # Friction parameter
```

