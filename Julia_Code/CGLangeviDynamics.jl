# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats

########################################################################################################
# Set up simulation parameters.

C=Chain();
# C=Chain(NBeads=10,SEps=1,LEps=100,SM=1,LM=10,Beta=1,ConstrainedBeads=2)
# C=Chain(NBeads=10,SEps=100,LEps=.01,SM=.1,LM=10)

S=Simulator(MacroSamples=2);
# S=Simulator(FullSteps=Int(1e4),ApproxSteps=Int(5e4),dt=1e-3,OrthoSamples=1e5,MacroSamples=10)
# S=Simulator(FullSteps=Int(1e4),dt=1e-6,OrthoSamples=1e4,MacroSamples=2)

########################################################################################################
# Generate data

(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);
