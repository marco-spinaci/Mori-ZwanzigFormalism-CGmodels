# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles,Plots

##################################################################################################################
# Generic system

# C = Chain();
# S = Simulator(MacroSamples=2);
# (RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

###################################################################################################################
# to generate data to plot the mean force for the system C ([0,1,0], SM(particle 0)=10, LM(particle 1)=1, γ=1, β=1)

S = Simulator();

# 2 Constrained Beads
C2 = Chain();
(RR2,PP,Veff,Fmean2,Fstd) = VEffConstrainedLangDyn(C2,S);

# Write data to file
open("./Outcomes/R_sC_2cb.csv","w+") do x2
    writedlm(x2,RR2);
end
open("./Outcomes/Fmean_sC_2cb.csv","w+") do f2
    writedlm(f2,Fmean2);
end

# 10 Constrained Beads (all Beads)
C10 = Chain(ConstrainedBeads=10);
(RR10,PP,Veff,Fmean10,Fstd) = VEffConstrainedLangDyn(C10,S);

# Write data to file
open("./Outcomes/R_sC_10cb.csv","w+") do x10
    writedlm(x10,RR10);
end
open("./Outcomes/Fmean_sC_10cb.csv","w+") do f10
    writedlm(f10,Fmean10);
end


#########################################################################################################################
# to generate data to plot mean force, the fluctuating part of the force and the effective potential for the four system

S = Simulator();

# system A
C = Chain(SM=1,LM=10);
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("./Outcomes/R_sA.csv","w+") do x
    writedlm(x,RR);
end
open("./Outcomes/P_sA.csv","w+") do x
    writedlm(x,PP);
end
open("./Outcomes/Veff_sA.csv","w+") do x
    writedlm(x,Veff);
end
open("./Outcomes/Fmean_sA.csv","w+") do x
    writedlm(x,Fmean);
end
open("./Outcomes/Fstd_sA.csv","w+") do x
    writedlm(x,Fstd);
end

# system B
C = Chain(SM=1,LM=10,SEps=10,LEps=.1);
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("./Outcomes/R_sB.csv","w+") do x
    writedlm(x,RR);
end
open("./Outcomes/P_sB.csv","w+") do x
    writedlm(x,PP);
end
open("./Outcomes/Veff_sB.csv","w+") do x
    writedlm(x,Veff);
end
open("./Outcomes/Fmean_sB.csv","w+") do x
    writedlm(x,Fmean);
end
open("./Outcomes/Fstd_sB.csv","w+") do x
    writedlm(x,Fstd);
end

# system C
C = Chain();
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("./Outcomes/R_sC.csv","w+") do x
    writedlm(x,RR);
end
open("./Outcomes/P_sC.csv","w+") do x
    writedlm(x,PP);
end
open("./Outcomes/Veff_sC.csv","w+") do x
    writedlm(x,Veff);
end
open("./Outcomes/Fmean_sC.csv","w+") do x
    writedlm(x,Fmean);
end
open("./Outcomes/Fstd_sC.csv","w+") do x
    writedlm(x,Fstd);
end

# system D
C = Chain(SEps=10,LEps=.1);
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("./Outcomes/R_sD.csv","w+") do x
    writedlm(x,RR);
end
open("./Outcomes/P_sD.csv","w+") do x
    writedlm(x,PP);
end
open("./Outcomes/Veff_sD.csv","w+") do x
    writedlm(x,Veff);
end
open("./Outcomes/Fmean_sD.csv","w+") do x
    writedlm(x,Fmean);
end
open("./Outcomes/Fstd_sD.csv","w+") do x
    writedlm(x,Fstd);
end
