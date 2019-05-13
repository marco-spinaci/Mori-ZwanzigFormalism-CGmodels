@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")

using Main.LJChain,Main.CGStats

# Initial conditions
C = Chain();
S = Simulator();

(RR,PP,Veff,Fmean,Fstd) = VEffConstrLangDyn(C,S);
