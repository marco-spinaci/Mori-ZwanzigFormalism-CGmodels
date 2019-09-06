# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,SharedArrays,Parameters,Statistics,LinearAlgebra,StatsBase,DelimitedFiles,PyPlot


# Set up simulation parameters.
C = Chain();     # system C ≣ [Patt=[0,1,0],NBeads=10,ConstrainedBeads=2,SEps=1,LEps=100,SM=10,LM=1,Dist=1,Beta=1,Gamma=1]

# S=Simulator(FullSteps=Int(1e4),ApproxSteps=Int(1e4),dt=1e-3,OrthoSamples=10000,MacroSamples=1000,LagStep=10,NumLags=1000)
S = Simulator(dt=1e-3,FullSteps=Int(1e4),OrthoSamples=Int(1e2),LagStep=10,NumLags=100);
# [dt=1e-4,Stochdt= 1e-4,FullSteps=Int(1e5),OrthoSteps=1,ApproxSteps=Int(1e5),OrthoSamples=Int(1e5),MacroSamples=50,LagStep=400,NumLags=30]

# LagStep = spacing of lag times for autocorrelation
# NumLags = number of lag times to compute


### Generate IC
(P,Q,F,H,PCG,QCG) = InitConds(C);

println("Equilibrate ...")
# Run in to equilibrate
for i = 1:S.FullSteps
 global(P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt);
end
println("... done")

Pfull=P;
Qfull=Q;


# Compute autocorrelation stats
(StressStats,StressMean,StressSqMean,MomStats,MomMean,MomSqMean) = ConstrainedAutocorrLangDyn(P,Q,C,S);


# Use PyPlot to plot autocorrelation of momenta
A = MomStats.-kron((MomMean.^2)',ones(S.NumLags));

plot(S.dt*S.LagStep*[0:S.NumLags-1;],A./A[1]);
savefig("./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/OrthoCorrP.svg");

open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/OrthoCorrP.csv","w+") do x
    writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] A./A[1] ] );
end

# Use PyPlot to plot autocorrelation of forces
# A=StressStats.-kron((StressMean.^2)',ones(S.NumLags));
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],A./A[1])
# savefig("OrthocorrF.svg")
# open("./F.csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] A./A[1] ] );
# end


# Compute autocorrelation stats
(StressStats,StressMean,StressSqMean,MomStats,MomMean,MomSqMean) = FullAutocorrLangDyn(Pfull,Qfull,C,S);


# Use PyPlot to plot autocorrelation of momenta
A=MomStats.-kron((MomMean.^2)',ones(S.NumLags));

plot(S.dt*S.LagStep*[0:S.NumLags-1;],A./A[1]);
savefig("./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/FullCorrP.svg");

open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullCorrP.csv","w+") do x
    writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] A./A[1] ] );
end

# Use PyPlot to plot autocorrelation of forces
# A=StressStats.-kron((StressMean.^2)',ones(S.NumLags));
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],A./A[1])
# savefig("FullcorrF.svg")
# open("./FFull.csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] A./A[1] ] );
# end
