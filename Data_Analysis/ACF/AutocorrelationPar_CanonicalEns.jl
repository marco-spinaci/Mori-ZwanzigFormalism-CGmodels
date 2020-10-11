## NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#      because I explicitly added in the script the command-line option "-p n".

using Distributed, Printf

@time begin

## Set up parallel computing
addprocs(Sys.CPU_THREADS);
# addprocs(4);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain, Main.CGStats, SharedArrays, Parameters, Statistics, LinearAlgebra, StatsBase, DelimitedFiles # add PyPlot if necessary

#############################################################################################
## Set up simulation parameters.

# C = Chain(SM=1,LM=10);                    ## system A ≣ [Patt=[0,1,0], SM(mass of particles 0), LM(mass of particles 1), SEps=1.0, LEps=100.0, γ=1, β=1]
# C = Chain(SM=1,LM=10,SEps=10,LEps=.1);    ## system B ≣ [Patt=[0,1,0], SM(mass of particles 0), LM(mass of particles 1), γ=1, β=1]
C = Chain(SM=1, LM=1, Beta=1);            ## system C ≣ [Patt=[0,1,0], NBeads=10, ConstrainedBeads=2, SEps=1, LEps=100, SM=10, LM=1, Dist=1, γ=1, β=1]
# C = Chain(SEps=10,LEps=.1);               ## system D ≣ [Patt=[0,1,0], SM=10, LM= 1, γ=1, β=1]

S = Simulator(dt=1e-4, Stochdt=1e-4, FullSteps=Int(1e5), ApproxSteps=Int(1e5),
              OrthoSamples=Int(1e6), MacroSamples=100, LagStep=100, NumLags=Int(1e4),
              m_MF=481.77, q_MF=-1408.6,
              m_FF=-304.49, q_FF=880.6,
              coeffEXP_MF_A=15177, coeffEXP_MF_B=2.7507,
              coeffEXP_FF_A=6.8121e13, coeffEXP_FF_B=10.103); # NB: force_1_1_Beta1.dat and flucts_1_1_Beta1.dat


    # LagStep = spacing of lag times for autocorrelation
    # NumLags = number of lag times to compute
    # NB: play with MacroSamples and OrthoSamples

#############################################################################################

if isdir("Outcomes/M$(C.SM)_m$(C.LM)/ACF") == 0
    mkdir("Outcomes/M$(C.SM)_m$(C.LM)/ACF");
end

#############################################################################################
## Generate data for Mean and Fluctuating Force

# ## NB: thesis data

# (RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# CG = readdlm("./Eff_Potential/Outcomes/sB_2000.csv",Float64);
# RR = CG[:,1];
# Fmean = CG[:,4];
# Fstd = CG[:,5];

# ## data extracted from the Kriging interpolation of the original Mean Force data
# ## Mean Force

# force_data = readdlm("Data_Analysis/ACF/Flucs_Force_to_interpolate/force_to_interpolate.dat", Float64);

# # we generate the coefficients for the cubic spline interpolation
# # NB: the grid points *must* be equally spaced
# RR = force_data[:, 1];
# dx = RR[2] - RR[1];
#
# Fmean = force_data[:, 2];
# Fmean_d = force_data[:, 3];
#
# Fmean_coeff1 = (2. * (Fmean - circshift(Fmean, -1)) + (Fmean_d + circshift(Fmean_d, -1)) * dx) / dx;
# Fmean_coeff2 = circshift(Fmean, -1) - Fmean + (-Fmean_d - Fmean_coeff1) * dx;
#
# FdataMF = zeros(length(Fmean) - 1, 5);
# FdataMF[:, 1] = RR[1:end - 1];
# FdataMF[:, 2] = Fmean[1:end - 1];
# FdataMF[:, 3] = Fmean_d[1:end - 1];
# FdataMF[:, 4] = Fmean_coeff1[1:end - 1];
# FdataMF[:, 5] = Fmean_coeff2[1:end - 1];
#
# ## Fluctuating Force

# flucts_data = readdlm("Data_Analysis/ACF/Flucs_Force_to_interpolate/flucts_to_interpolate.dat", Float64);
#
# # i punti della griglia *devono* essere equispaziati
# RR = flucts_data[:, 1];
# dx = RR[2] - RR[1];
#
# FF = flucts_data[:, 2];
# FF_d = flucts_data[:, 3];
#
# FF_coeff1 = (2. * (FF - circshift(FF, -1)) + (FF_d + circshift(FF_d, -1)) * dx) / dx;
# FF_coeff2 = circshift(FF, -1) - FF + (-FF_d - FF_coeff1) * dx;
#
# FdataFF = zeros(length(FF) - 1, 5);
# FdataFF[:, 1] = RR[1:end - 1];
# FdataFF[:, 2] = FF[1:end - 1];
# FdataFF[:, 3] = FF_d[1:end - 1];
# FdataFF[:, 4] = FF_coeff1[1:end - 1];
# FdataFF[:, 5] = FF_coeff2[1:end - 1];

## NB: paper data
# FdataMF = readdlm("Eff_Potential/Outcomes/Coeff_MF_SplineI_sC_M100m1.csv", Float64);
# FdataFF = readdlm("Eff_Potential/Outcomes/Coeff_FF_SplineI_sC_M100m1.csv", Float64);

force_data = readdlm("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/MF_M$(C.SM)_m$(C.LM)_dt$(@sprintf "%0.1e" S.dt).dat", Float64);

RR = force_data[:, 1];
dx = RR[2] - RR[1];

Fm = force_data[:, 2];
FmINT_D = (circshift(Fm,-1) - circshift(Fm,1)) ./(2*dx);
Fmean = Fm[2:end-1];
Fmean_d = FmINT_D[2:end-1];

Fmean_coeff1 = (2. * (Fmean - circshift(Fmean, -1)) + (Fmean_d + circshift(Fmean_d, -1)) * dx) / dx;
Fmean_coeff2 = circshift(Fmean, -1) - Fmean + (-Fmean_d - Fmean_coeff1) * dx;

FdataMF = zeros(length(Fmean) - 1, 5);
FdataMF[:, 1] = RR[2:end - 2];
FdataMF[:, 2] = Fmean[1:end - 1];
FdataMF[:, 3] = Fmean_d[1:end - 1];
FdataMF[:, 4] = Fmean_coeff1[1:end - 1];
FdataMF[:, 5] = Fmean_coeff2[1:end - 1];


# flucts_data = readdlm("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/MF_M$(C.SM)_m$(C.LM)_dt$(@sprintf "%0.1e" S.dt).dat", Float64);
#
# RR = flucts_data[:, 1];
# dx = RR[2] - RR[1];
#
# Fluct = flucts_data[:, 2];
# FluctINT_D = (circshift(Fluct,-1) - circshift(Fluct,1)) ./(2*dx);
# FF = Fluct[2:end-1];
# FF_d = FluctINT_D[2:end-1];
#
# FF_coeff1 = (2. * (FF - circshift(FF, -1)) + (FF_d + circshift(FF_d, -1)) * dx) / dx;
# FF_coeff2 = circshift(FF, -1) - FF + (-FF_d - FF_coeff1) * dx;
#
# FdataFF = zeros(length(FF) - 1, 5);
# FdataFF[:, 1] = RR[2:end - 2];
# FdataFF[:, 2] = FF[1:end - 1];
# FdataFF[:, 3] = FF_d[1:end - 1];
# FdataFF[:, 4] = FF_coeff1[1:end - 1];
# FdataFF[:, 5] = FF_coeff2[1:end - 1];
#

#####################################################################################
## Compute autocorrelation stats for FULL DYNAMICS

# (StressAutocorr,MomAutocorr) = FullAutocorrLangDynPar(C,S,RR,Fmean*0);
# (StressAutocorr,MomAutocorr) = FullAutocorrLangDynPar(C,S,FdataMF*0);
#
# open("Outcomes/M$(C.SM)_m$(C.LM)/ACF/sC_M$(C.SM)m$(C.LM)_FullcorrP_B$(C.Beta).csv","w+") do x
#    writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
# end
#
# open("Outcomes/M$(C.SM)_m$(C.LM)/ACF/sC_M$(C.SM)m$(C.LM)_FullcorrF_B$(C.Beta).csv","w+") do x
#    writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
# end



## Compute autocorrelation stats for FULL DYNAMICS (ORTHOGONAL COMPONENT)

# (StressAutocorr,MomAutocorr) = FullAutocorrLangDynPar(C,S,RR,Fmean);
(StressAutocorr,MomAutocorr) = FullAutocorrLangDynPar(C,S,FdataMF);

open("Outcomes/M$(C.SM)_m$(C.LM)/ACF/sC_M$(C.SM)m$(C.LM)_FullcorrP_OC_B$(C.Beta).csv","w+") do x
   writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
end

open("Outcomes/M$(C.SM)_m$(C.LM)/ACF/sC_M$(C.SM)m$(C.LM)_FullcorrF_OC_B$(C.Beta).csv","w+") do x
   writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
end


# Use PyPlot to plot autocorrelation
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],MomAutocorr);
# savefig("./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/FullcorrP.svg");
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/ACF_FullAndConstrainedTraj/Plots/FullcorrF.svg");



## Compute autocorrelation stats for CONSTRAINED DYNAMICS

# (StressAutocorr,MomAutocorr) = ConstrainedAutocorrLangDynPar(C,S);
#
# open("Outcomes/M$(C.SM)_m$(C.LM)/ACF/sC_M$(C.SM)m$(C.LM)_OrthocorrP_B$(C.Beta).csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
# end
#
# open("Outcomes/M$(C.SM)_m$(C.LM)/ACF/sC_M$(C.SM)m$(C.LM)_OrthocorrF_B$(C.Beta).csv","w+") do x
#     writedlm(x,[ S.dt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
# end

# NB: Don't plot autocorrelation of momenta (as it's not well-defined)
# Use PyPlot to plot autocorrelation
# plot(S.dt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/OrthocorrF.svg");



## Compute autocorrelation stats for APPROXIMATE DYNAMICS

# (StressAutocorr,MomAutocorr) = ApproximateAutocorrPar(C,S,FdataMF,FdataFF);
#
# open("Outcomes/M$(C.SM)_m$(C.LM)/ACF/sC_M$(C.SM)m$(C.LM)_ApproximatecorrP_B$(C.Beta).csv","w+") do x
#     writedlm(x,[ S.Stochdt*S.LagStep*[0:S.NumLags-1;] MomAutocorr ] );
# end
#
# open("Outcomes/M$(C.SM)_m$(C.LM)/ACF/sC_M$(C.SM)m$(C.LM)_ApproximatecorrF_B$(C.Beta).csv","w+") do x
#     writedlm(x,[ S.Stochdt*S.LagStep*[0:S.NumLags-1;] StressAutocorr ] );
# end

# Use PyPlot to plot autocorrelation
# plot(S.Stochdt*S.LagStep*[0:S.NumLags-1;],MomAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/ApproximatecorrP.svg");
# plot(S.Stochdt*S.LagStep*[0:S.NumLags-1;],StressAutocorr);
# savefig("./Data_Analysis/AC_FullAndConstrainedTraj/Plots/ApproximatecorrF.svg");

#################################################################################
end # @time
