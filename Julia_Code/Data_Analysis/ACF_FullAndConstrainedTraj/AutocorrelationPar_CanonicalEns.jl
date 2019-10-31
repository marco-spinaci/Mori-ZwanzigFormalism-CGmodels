## NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
##     because I explicitly added in the script the command-line option "-p n".

using Distributed

@time begin

## Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,SharedArrays,Parameters,Statistics,LinearAlgebra,StatsBase,DelimitedFiles # add Pyplot if necessary


## Set up simulation parameters.
C = Chain();     ## system C ≣ [Patt=[0,1,0],NBeads=10,ConstrainedBeads=2,SEps=1,LEps=100,SM=10,LM=1,Dist=1,Beta=1,Gamma=1]

S = Simulator(dt=1e-3, Stochdt=1e-4, FullSteps=Int(1e6), OrthoSamples=Int(1e4), MacroSamples=10, LagStep=10, NumLags=Int(1e3));
## [dt=1e-4,Stochdt=1e-4,FullSteps=Int(1e5),OrthoSteps=1,ApproxSteps=Int(1e5),OrthoSamples=Int(1e5),MacroSamples=50,LagStep=400,NumLags=30]

## LagStep = spacing of lag times for autocorrelation
## NumLags = number of lag times to compute
## NB: play with MacroSamples and OrthoSamples

## Generate data
# (RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);
CG = readdlm("./ABCD_Systems/Outcomes/sC_2000.csv",Float64);
RR = CG[:,1];
Fmean = CG[:,4];
Fstd = CG[:,5];


## Compute autocorrelation stats for FULL DYNAMICS
# (StressAutocorr,MomAutocorr) = FullAutocorrLangDynPar(C,S,RR,Fmean*0);
#
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP_test.csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
# end
#
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrF_test.csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
# end



## Compute autocorrelation stats for FULL DYNAMICS (ORTHOGONAL COMPONENT)
# (StressAutocorr,MomAutocorr) = FullAutocorrLangDynPar(C,S,RR,Fmean);
#
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrP_testOC.csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
# end
#
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/FullcorrF_testOC.csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
# end

## Use PyPlot to plot autocorrelation
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],MomAutocorr);
# savefig("./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/FullcorrP.svg");
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/FullcorrF.svg");



## Compute autocorrelation stats for CONSTRAINED DYNAMICS
# (StressAutocorr,MomAutocorr) = ConstrainedAutocorrLangDynPar(C,S);
#
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/OrthocorrP_test.csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
# end
#
# open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/OrthocorrF_test.csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
# end

## NB: Don't plot autocorrelation of momenta (as it's not well-defined)
## Use PyPlot to plot autocorrelation
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/OrthocorrF.svg");



## Compute autocorrelation stats for APPROXIMATE DYNAMICS
(StressAutocorr,MomAutocorr) = ApproximateAutocorrPar(C,S,RR,Fmean,Fstd); #Fstd*0.5

open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/ApproximatecorrP_test.csv","w+") do x
    writedlm(x,[ S.Stochdt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
end

open("./Data_Analysis/ACF_FullAndConstrainedTraj/Outcomes/ApproximatecorrF_test.csv","w+") do x
    writedlm(x,[ S.Stochdt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
end

## Use PyPlot to plot autocorrelation
# plot(S.Stochdt*S.LagStep*[0:S.NumLags-1;],MomAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/ApproximatecorrP.svg");
# plot(S.Stochdt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/ApproximatecorrF.svg");

#################################################################################
end # @time
