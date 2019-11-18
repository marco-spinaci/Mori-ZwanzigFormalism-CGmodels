
@time begin

include("../LJChain.jl")
include("../CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles

#####################################################################################################################
# Set up simulation parameters.

C = Chain(); # system C ≣ [Patt=[0,1,0],NBeads=10,ConstrainedBeads=2,SEps=1,LEps=100,SM=10,LM=1,Dist=1,Beta=1,Gamma=1]

# S = Simulator(); # [dt=1e-4,Stochdt=1e-4,FullSteps=Int(1e5),OrthoSteps=1,ApproxSteps=Int(1e5),OrthoSamples=Int(1e5),MacroSamples=50,LagStep=400,NumLags=30]
S = Simulator(dt=1e-3, Stochdt=1e-4, FullSteps=Int(1e7), ApproxSteps=Int(1e4));

#################################################################################
# Generate initial data

(P0, Q0, F0, H0, P0CG, Q0CG) = InitConds(C);

#################################################################################
# Generate effective potential data

# (RR,PP,Veff,Fmean,Fstd) = VEffConstrainedLangDyn(C,S);
CG = readdlm("ABCD_Systems/Outcomes/sC_2000.csv", Float64);
RR = CG[:, 1];
Fmean = CG[:, 4];
Fstd = CG[:, 5];

########################################################################################
# Generate a random trajectory, using data-generated potentials

(PApprox, QApprox, FApprox) = ApproximateTraj(P0CG, Q0CG, RR, Fmean, Fstd, C, S);

#########################################################################################
# Write data to file

open("Store_Trajectory/Outcomes/PApprox_MMZD.csv", "w+") do x
    writedlm(x, PApprox);
end
open("Store_Trajectory/Outcomes/QApprox_MMZD.csv", "w+") do x
    writedlm(x, QApprox);
end
open("Store_Trajectory/Outcomes/FApprox_MMZD.csv", "w+") do x
    writedlm(x, FApprox);
end

#################################################################################
end # @time
