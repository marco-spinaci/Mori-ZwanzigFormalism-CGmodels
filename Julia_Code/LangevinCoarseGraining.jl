# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

@time begin

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles,Plots

##################################################################################################################
# to generate data to plot for the system C as Gamma and Beta change

#S = Simulator(OrthoSamples=Int(1e2),MacroSamples=50);
#C = Chain();
#
## to change the values of the Gamma parameter
#GammaSamples = [exp10(x) for x in 4:5];
#nsamples = length(GammaSamples);
#
#RR = zeros(S.MacroSamples,nsamples);
#Fmean = zeros(S.MacroSamples,nsamples);
#for i = 1:nsamples
#    println("Start the Gamma sample ",i,", Gamma=",GammaSamples[i,1]);
#    C = Chain(Gamma=Int(GammaSamples[i,1]),Beta=Int(10000));
#    (RR[:,i],PP,Veff,Fmean[:,i],Fstd) = VEffConstrainedLangDyn(C,S);
#    println(" ...Fmean computed!");
#end
#
#RF = zeros(S.MacroSamples,nsamples*2);
#RF[:,1:nsamples] = RR;
#RF[:,nsamples+1:end] = Fmean;
#open("../Outcomes/C_System_GammaBeta/FvsR_sC_Gamma_b10000_2.csv","w+") do x
#    writedlm(x,RF);
#end
#
#end
#
###################################################################################################################
# to generate data to plot the mean force for the system C ([0,1,0], SM(particle 0)=10, LM(particle 1)=1, γ=1, β=1)

S = Simulator(OrthoSamples=Int(1e2),MacroSamples=50);

# 2 Constrained Beads
C = Chain(Gamma=1e4,Beta=100);
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/C_System_2and10cb/R_sC_2cb_B100.csv","w+") do x
    writedlm(x,RR);
end
open("../Outcomes/C_System_2and10cb/Fmean_sC_2cb_B100.csv","w+") do x
    writedlm(x,Fmean);
end

# 10 Constrained Beads (all Beads)
C = Chain(Gamma=1e4,Beta=100,ConstrainedBeads=10);
(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);

# Write data to file
open("../Outcomes/C_System_2and10cb/R_sC_10cb_B100.csv","w+") do x
    writedlm(x,RR);
end
open("../Outcomes/C_System_2and10cb/Fmean_sC_10cb_B100.csv","w+") do x
    writedlm(x,Fmean);
end

end

#########################################################################################################################
# to generate data to plot mean force, the fluctuating part of the force and the effective potential for the four system
#
#S = Simulator(OrthoSamples=Int(1e2),MacroSamples=1000);
#
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
#
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
#
## system C
#C = Chain();
#(RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);
#
## Write data to file
#open("../Outcomes/ABCD_Systems/R_sC.csv","w+") do x
#    writedlm(x,RR);
#end
#open("../Outcomes/ABCD_Systems/P_sC.csv","w+") do x
#    writedlm(x,PP);
#end
#open("../Outcomes/ABCD_Systems/Veff_sC.csv","w+") do x
#    writedlm(x,Veff);
#end
#open("../Outcomes/ABCD_Systems/Fmean_sC.csv","w+") do x
#    writedlm(x,Fmean);
#end
#open("../Outcomes/ABCD_Systems/Fstd_sC.csv","w+") do x
#    writedlm(x,Fstd);
#end
#
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
#
#end
