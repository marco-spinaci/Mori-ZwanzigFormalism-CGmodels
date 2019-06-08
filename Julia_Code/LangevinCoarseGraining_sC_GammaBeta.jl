# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

@time begin

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles,SharedArrays,Plots

##########################################################################################################################
# System C ([0,1,0], SM (mass of 0 particles)=10, LM (mass of 1 particles)=1, γ=1, β=1)
##########################################################################################################################

# to change the values of the Gamma parameter
GammaSamples = [exp10(x) for x in -5:5]; # NB: check the files that are needed to save the data
nGsamples = length(GammaSamples);

# to change the values of the Beta parameter
BetaSamples = [exp10(x) for x in 0:3];
nBsamples = length(BetaSamples);

##########################################################################################################################
S = Simulator(OrthoSamples=Int(1e2),MacroSamples=50);

C = Chain();
RR = SharedArray{Float64}(S.MacroSamples,nBsamples,nGsamples);
Fmean = SharedArray{Float64}(S.MacroSamples,nBsamples,nGsamples);

for i = 1:nGsamples
   for j = 1:nBsamples
      println("Start Gamma sample ",i," and Beta sample ",j,": Gamma=",GammaSamples[i,1],", Beta=",BetaSamples[j,1],".");
      C = Chain(Gamma=GammaSamples[i,1],Beta=BetaSamples[j,1]);
      (RR[:,j,i],PP,Veff,Fmean[:,j,i],Fstd) = VEffConstrainedLangDyn(C,S);
   end
end

RF = SharedArray{Float64}(S.MacroSamples,nBsamples*2,nGsamples);
for k = 1:nGsamples
   RF[:,1:nBsamples,k] = RR[:,:,k];
   RF[:,nBsamples+1:end,k] = Fmean[:,:,k];
end
open("../Outcomes/C_System_GammaBeta/FvsR_sC_BETA_G1e-5.csv","w+") do x
   writedlm(x,RF[:,:,1]);
end
open("../Outcomes/C_System_GammaBeta/FvsR_sC_BETA_G1e-4.csv","w+") do x
   writedlm(x,RF[:,:,2]);
end
open("../Outcomes/C_System_GammaBeta/FvsR_sC_BETA_G1e-3.csv","w+") do x
   writedlm(x,RF[:,:,3]);
end
open("../Outcomes/C_System_GammaBeta/FvsR_sC_BETA_G1e-2.csv","w+") do x
   writedlm(x,RF[:,:,4]);
end
open("../Outcomes/C_System_GammaBeta/FvsR_sC_BETA_G1e-1.csv","w+") do x
   writedlm(x,RF[:,:,5]);
end
open("../Outcomes/C_System_GammaBeta/FvsR_sC_BETA_G1e5.csv","w+") do x
   writedlm(x,RF[:,:,6]);
end

# RF = zeros(S.MacroSamples,nGsamples*2);
# for k = 1:nGsamples
#    RF[:,k] = RR[:,:,k];
#    RF[:,nGsamples+k] = Fmean[:,:,k];
# end
# open("../Outcomes/C_System_GammaBeta/FvsR_sC_GAMMA_B1000.csv","w+") do x
#    writedlm(x,RF);
# end

end # @time
