# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles,Plots

#################################################################################################################
# Generic system

# C = Chain();
# S = Simulator(MacroSamples=2);
# (RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

#################################################################################################################
# Generate data to plot the mean force for the system C ([0,1,0], SM(particle 0)=10, LM(particle 1)=1, γ=1, β=1)

S = Simulator();

# 2 Constrained Beads
C1 = Chain(LEps=10);
(RR1,PP,Veff,Fmean1,Fstd) = VEffConstrainedLangDyn(C1,S);

# Write data to file
open("./Outcomes/R_sC_2cb.csv","w+") do x1
    writedlm(x1,RR1);
end
open("./Outcomes/Fmean_sC_2cb.csv","w+") do f1
    writedlm(f1,Fmean1);
end

# 10 Constrained Beads (all Beads)
C2 = Chain(ConstrainedBeads=10,LEps=10);
(RR2,PP,Veff,Fmean2,Fstd) = VEffConstrainedLangDyn(C2,S);

# Write data to file
open("./Outcomes/R_sC_10cb.csv","w+") do x2
    writedlm(x2,RR2);
end
open("./Outcomes/Fmean_sC_10cb.csv","w+") do f2
    writedlm(f2,Fmean2);
end


# plot([RR1 RR2],[Fmean1 Fmean2],
#     legend = false,
#     seriestype = [:line :scatter],
#     xlabel = "R",
#     ylabel = "Mean Force");
# savefig("MeanForceSystemC.pdf");

#################################################################################################################
