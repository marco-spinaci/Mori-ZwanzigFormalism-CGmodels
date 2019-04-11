include("LJChain.jl")
include("CGStats.jl")

using Main.LJChain,Main.CGStats

C = Chain();
S = Simulator();

# Initial condition
P0 = zeros(C.NPart);
Q0 = Vector(1.0:1.0:30.0);


PLFull,QLFull,FLFull = LangevinFullTraj(P0,Q0,C,S);
