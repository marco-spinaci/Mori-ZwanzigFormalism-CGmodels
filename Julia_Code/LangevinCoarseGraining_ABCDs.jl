# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

@time begin

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles,SharedArrays,Plots

#################################################################################
# General system

# C = Chain();
# S = Simulator(OrthoSamples=Int(1e2),MacroSamples=1000);
#
# (RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);


#################################################################################

S = Simulator(OrthoSamples=Int(1e2),MacroSamples=1000);

#################################################################################
## system A
#C = Chain(SM=1,LM=10);
#(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);
#
## Write data to file
#open("../Outcomes/ABCD_Systems/R_sA.csv","w+") do x
#    writedlm(x,RR);
#end
#open("../Outcomes/ABCD_Systems/P_sA.csv","w+") do x
#    writedlm(x,PP);
#end
#open("../Outcomes/ABCD_Systems/Veff_sA.csv","w+") do x
#    writedlm(x,Veff);
#end
#open("../Outcomes/ABCD_Systems/Fmean_sA.csv","w+") do x
#    writedlm(x,Fmean);
#end
#open("../Outcomes/ABCD_Systems/Fstd_sA.csv","w+") do x
#    writedlm(x,Fstd);
#end

#################################################################################
## system B
#C = Chain(SM=1,LM=10,SEps=10,LEps=.1);
#(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);
#
## Write data to file
#open("../Outcomes/ABCD_Systems/R_sB.csv","w+") do x
#    writedlm(x,RR);
#end
#open("../Outcomes/ABCD_Systems/P_sB.csv","w+") do x
#    writedlm(x,PP);
#end
#open("../Outcomes/ABCD_Systems/Veff_sB.csv","w+") do x
#    writedlm(x,Veff);
#end
#open("../Outcomes/ABCD_Systems/Fmean_sB.csv","w+") do x
#    writedlm(x,Fmean);
#end
#open("../Outcomes/ABCD_Systems/Fstd_sB.csv","w+") do x
#    writedlm(x,Fstd);
#end

#################################################################################
# system C
C = Chain(Beta=100,Gamma=1e5);
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/ABCD_Systems/R_sC.csv","w+") do x
   writedlm(x,RR);
end
open("../Outcomes/ABCD_Systems/P_sC.csv","w+") do x
   writedlm(x,PP);
end
open("../Outcomes/ABCD_Systems/Veff_sC.csv","w+") do x
   writedlm(x,Veff);
end
open("../Outcomes/ABCD_Systems/Fmean_sC.csv","w+") do x
   writedlm(x,Fmean);
end
open("../Outcomes/ABCD_Systems/Fstd_sC.csv","w+") do x
   writedlm(x,Fstd);
end

#################################################################################
## system D
#C = Chain(SEps=10,LEps=.1);
#(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);
#
## Write data to file
#open("../Outcomes/ABCD_Systems/R_sD.csv","w+") do x
#    writedlm(x,RR);
#end
#open("../Outcomes/ABCD_Systems/P_sD.csv","w+") do x
#    writedlm(x,PP);
#end
#open("../Outcomes/ABCD_Systems/Veff_sD.csv","w+") do x
#    writedlm(x,Veff);
#end
#open("../Outcomes/ABCD_Systems/Fmean_sD.csv","w+") do x
#    writedlm(x,Fmean);
#end
#open("../Outcomes/ABCD_Systems/Fstd_sD.csv","w+") do x
#    writedlm(x,Fstd);
#end

end # @time
