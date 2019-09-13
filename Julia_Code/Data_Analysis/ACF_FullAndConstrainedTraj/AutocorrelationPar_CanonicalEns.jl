# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,SharedArrays,Parameters,Statistics,LinearAlgebra,StatsBase,DelimitedFiles # add Pyplot if necessary


# Set up simulation parameters.
C = Chain();     # system C ≣ [Patt=[0,1,0],NBeads=10,ConstrainedBeads=2,SEps=1,LEps=100,SM=10,LM=1,Dist=1,Beta=1,Gamma=1]

S = Simulator(dt=1e-3,Stochdt=1e-4,FullSteps=Int(1e4),OrthoSamples=Int(1e3),LagStep=10,NumLags=100,MacroSamples=4);
# [dt=1e-4,Stochdt= 1e-4,FullSteps=Int(1e5),OrthoSteps=1,ApproxSteps=Int(1e5),OrthoSamples=Int(1e5),MacroSamples=50,LagStep=400,NumLags=30]

# LagStep = spacing of lag times for autocorrelation
# NumLags = number of lag times to compute


# Generate data
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);


# Compute autocorrelation stats for FULL dynamics
(StressAutocorr,MomAutocorr) = FullAutocorrLangDynPar(C,S,RR,Fmean*0);

# Use PyPlot to plot autocorrelation of momenta
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP1.csv","w+") do x
    # writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
end
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],MomAutocorr);
# savefig("./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/FullcorrP.svg");

# Use PyPlot to plot autocorrelation of forces
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrF1.csv","w+") do x
    # writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
end
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/FullcorrF.svg");



# Compute autocorrelation stats for CONSTRAINED dynamics
# (StressAutocorr,MomAutocorr) = ConstrainedAutocorrLangDynPar(C,S);

# NB: Don't plot autocorrelation of momenta (as it's not well-defined)
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/OrthocorrP1.csv","w+") do x
    # writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
end

# Use PyPlot to plot autocorrelation of forces
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/OrthocorrF1.csv","w+") do x
    # writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
end
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/OrthocorrF.svg");



# Compute autocorrelation stats for APPROXIMATE dynamics
# (StressAutocorr,MomAutocorr) = ApproximateAutocorrPar(C,S,RR,Fmean,Fstd*0.5);

# Use PyPlot to plot autocorrelation of momenta
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/ApproximatecorrP.csv","w+") do x
    # writedlm(x,[ S.Stochdt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
end
# plot(S.Stochdt*S.LagStep*[0:S.NumLags-1;],MomAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/ApproximatecorrP.svg");

# Use PyPlot to plot autocorrelation of forces
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/ApproximatecorrF.csv","w+") do x
    # writedlm(x,[ S.Stochdt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
end
# plot(S.Stochdt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/ApproximatecorrF.svg");
