# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

@time begin

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles,SharedArrays,Plots

##########################################################################################################################################
# System C ([0,1,0], SM (mass of 0 particles)=10, LM (mass of 1 particles)=1, γ=1, β=1)
##########################################################################################################################################

S = Simulator(OrthoSamples=Int(1e6),MacroSamples=100);

################################################################################
### 2 Constrained Beads

C = Chain();

(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("./C_System_2and10cb/R_sC_2cb.csv","w+") do x
    writedlm(x,RR);
end
open("./C_System_2and10cb/Fmean_sC_2cb.csv","w+") do x
    writedlm(x,Fmean);
end
open("./C_System_2and10cb//Veff_sC_2cb.csv","w+") do x
   writedlm(x,Veff);
end

################################################################################
### 10 Constrained Beads (all Beads)

C = Chain(ConstrainedBeads=10);

(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("./C_System_2and10cb/R_sC_10cb.csv","w+") do x
   writedlm(x,RR);
end
open("./C_System_2and10cb/Fmean_sC_10cb.csv","w+") do x
   writedlm(x,Fmean);
end


end # @time
