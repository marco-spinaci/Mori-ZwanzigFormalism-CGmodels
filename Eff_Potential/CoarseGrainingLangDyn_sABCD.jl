# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed, Printf, Parameters

@time begin

# Set up parallel computing
addprocs(Sys.CPU_THREADS);
# addprocs(8);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain, Main.CGStats, SharedArrays, Statistics, LinearAlgebra, StatsBase, DelimitedFiles

####################################################################################################


S = Simulator(dt=1e-4, FullSteps=Int(1e7), OrthoSamples=Int(1e6), check=Int(5e4), MacroSamples=100);
# NB: OrthoSamples must be set like this Int(1e6) or larger


######################################################################################################
# system A
# ( [0,1,0], SM (mass of particles 0), LM (mass of particles 1), SEps=1.0, LEps=100.0, γ=1, β=1 )

# C = Chain(SM=1, LM=10, NBeads = 100);
# (RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn_NVT(C,S);
#
#
# ########################################################
#
# if isdir("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential") == 0
#     mkdir("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential");
# end
#
# #########################################################
#
#
# # Write data to file
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/sA_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, [RR PP Veff Fmean Fstd]);
# end
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/Coeff_MF_SplineI_sA_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, FdataMF);
# end
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/Coeff_FF_SplineI_sA_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, FdataFF);
# end

#################################################################################
# system B
# ( [0,1,0], SM (mass of particles 0), LM (mass of particles 1), γ=1, β=1 )

# C = Chain(SM=1, LM=1, SEps=10, LEps=.1, NBeads = 10);
# (RR, PP, Veff, Fmean, Fstd, FdataMF, FdataFF) = VEffConstrainedLangDyn_NVT(C, S);
#
#
# ########################################################
#
# if isdir("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential") == 0
#     mkdir("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential");
# end
#
# #########################################################
#
#
# # Write data to file
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/sB_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, [RR PP Veff Fmean Fstd]);
# end
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/Coeff_MF_SplineI_sB_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, FdataMF);
# end
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/Coeff_FF_SplineI_sB_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, FdataFF);
# end

######################################################################################################
# system C
# ( [0,1,0], SM (mass of particles 0) = 10, LM (mass of particles 1) = 1, SEps=1.0, LEps=100.0, γ=1, β=1.096 )

C = Chain(SM=100, LM=1, Beta=1);
(RR,PP,Veff,Fmean,Fstd,FdataMF,FdataFF) = VEffConstrainedLangDyn_NVT(C,S);

########################################################

if isdir("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential") == 0
    mkdir("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential");
end

#########################################################

# Write data to file
open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/sC_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
   writedlm(x, [RR PP Veff Fmean Fstd]);
end
open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/Coeff_MF_SplineI_sC_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
   writedlm(x, FdataMF);
end
open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/Coeff_FF_SplineI_sC_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
   writedlm(x, FdataFF);
end



#################################################################################
# system D
# ( [0,1,0], SM (mass of particles 0) = 10, LM (mass of particles 1) = 1, γ=1, β=1 )


# C = Chain(SM=20, LM=1, SEps=10, LEps=.1, NBeads = 10);
# (RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn_NVT(C,S);
#
#
# ########################################################
#
# if isdir("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential") == 0
#     mkdir("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential");
# end
#
# #########################################################
#
#
# # Write data to file
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/sD_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, [RR PP Veff Fmean Fstd]);
# end
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/Coeff_MF_SplineI_sD_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, FdataMF);
# end
# open("Outcomes/M$(C.SM)_m$(C.LM)/Eff_Potential/Coeff_FF_SplineI_sD_M$(C.SM)m$(C.LM)_Beta$(C.Beta)_Fs$(@sprintf "%0.1e" S.FullSteps)_dt$(@sprintf "%0.1e" S.dt).csv","w+") do x
#    writedlm(x, FdataFF);
# end

#################################################################################
end # @time
