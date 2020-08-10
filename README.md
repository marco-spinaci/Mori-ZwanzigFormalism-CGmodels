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
> import Pkg 

> Pkg.add("NAME_PACKAGE")

The modules to be loaded to determine and analyze the trajectories are 
* `LJchain.jl`, this module providing physics functions and a parameter object for a 1D chain of 2 species of particle
* `CGStats.jl`, in this module there are all the functions needed to determine the various dynamics and to determine the autocorrelation functions 

## Scripts to compute the trajectories
The scripts to determine or to analyze trajectories are divided into four parts (four example see [Store_Trajectory/compareTraj_FGD.jl](https://github.com/thudso/MarcoMasterProject/blob/Marco_JobsAndNotes/Julia_Code/Store_Trajectory/compareTraj_FGD.jl)):
1. In the first part we load the necessary packages and modules:
```julia
include("../LJChain.jl")
include("../CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles
```
2. In the second part we can set up the parameters for the simulation present in the loaded modules `LJChain.jl` and `CGStats.jl`:
```julia
C = Chain(SM=1, LM=1, Beta=1);
S = Simulator(dt=1e-3, Stochdt=1e-3, FullSteps=Int(1e7), ApproxSteps=Int(1e7));
```
