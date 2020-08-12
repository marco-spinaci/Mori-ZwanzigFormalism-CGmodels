include("LJChain.jl")
include("CGStats.jl")

using Main.LJChain, Main.CGStats, Plots

C = Chain();
S = Simulator();

P0,Q0,F0,H0,PCG0,QCG0 = InitConds(C);
Pstore,Qstore,Fstore = FullTraj(P0,Q0,C,S);

using Plots
pyplot();
plot(Pstore[1,:],Qstore[1,:])
