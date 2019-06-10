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

S = Simulator(OrthoSamples=Int(1e2),MacroSamples=50);

##########################################################################################################################################
# 2 Constrained Beads
C = Chain(Gamma=1e4,Beta=100);
println("Start Gamma sample ",1," and Beta sample ",1,": Gamma=",C.Gamma,", Beta=",C.Beta,", ConstrainedBeads=",C.ConstrainedBeads,".");
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/C_System_2and10cb/R_sC_2cb_B100_G1e4.csv","w+") do x
    writedlm(x,RR);
end
open("../Outcomes/C_System_2and10cb/Fmean_sC_2cb_B100_G1e4.csv","w+") do x
    writedlm(x,Fmean);
end

# 10 Constrained Beads (all Beads)
C = Chain(Gamma=1e4,Beta=100,ConstrainedBeads=10);
println("Start Gamma sample ",1," and Beta sample ",1,": Gamma=",C.Gamma,", Beta=",C.Beta,", ConstrainedBeads=",C.ConstrainedBeads,".");
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/C_System_2and10cb/R_sC_10cb_B100_G1e4.csv","w+") do x
   writedlm(x,RR);
end
open("../Outcomes/C_System_2and10cb/Fmean_sC_10cb_B100_G1e4.csv","w+") do x
   writedlm(x,Fmean);
end

##########################################################################################################################################
# 2 Constrained Beads
C = Chain(Gamma=1e5,Beta=10);
println("Start Gamma sample ",2," and Beta sample ",2,": Gamma=",C.Gamma,", Beta=",C.Beta,", ConstrainedBeads=",C.ConstrainedBeads,".");
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/C_System_2and10cb/R_sC_2cb_B10_G1e5.csv","w+") do x
    writedlm(x,RR);
end
open("../Outcomes/C_System_2and10cb/Fmean_sC_2cb_B10_G1e5.csv","w+") do x
    writedlm(x,Fmean);
end

# 10 Constrained Beads (all Beads)
C = Chain(Gamma=1e5,Beta=10,ConstrainedBeads=10);
println("Start Gamma sample ",2," and Beta sample ",2,": Gamma=",C.Gamma,", Beta=",C.Beta,", ConstrainedBeads=",C.ConstrainedBeads,".");
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/C_System_2and10cb/R_sC_10cb_B10_G1e5.csv","w+") do x
   writedlm(x,RR);
end
open("../Outcomes/C_System_2and10cb/Fmean_sC_10cb_B10_G1e5.csv","w+") do x
   writedlm(x,Fmean);
end

##########################################################################################################################################
# 2 Constrained Beads
C = Chain(Gamma=1e5,Beta=100);
println("Start Gamma sample ",2," and Beta sample ",3,": Gamma=",C.Gamma,", Beta=",C.Beta,", ConstrainedBeads=",C.ConstrainedBeads,".");
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/C_System_2and10cb/R_sC_2cb_B100_G1e5.csv","w+") do x
    writedlm(x,RR);
end
open("../Outcomes/C_System_2and10cb/Fmean_sC_2cb_B100_G1e5.csv","w+") do x
    writedlm(x,Fmean);
end

# 10 Constrained Beads (all Beads)
C = Chain(Gamma=1e5,Beta=100,ConstrainedBeads=10);
println("Start Gamma sample ",2," and Beta sample ",3,": Gamma=",C.Gamma,", Beta=",C.Beta,", ConstrainedBeads=",C.ConstrainedBeads,".");
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/C_System_2and10cb/R_sC_10cb_B100_G1e5.csv","w+") do x
   writedlm(x,RR);
end
open("../Outcomes/C_System_2and10cb/Fmean_sC_10cb_B100_G1e5.csv","w+") do x
   writedlm(x,Fmean);
end

end # @time
