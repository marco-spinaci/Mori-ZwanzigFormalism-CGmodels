
@time begin

include("../LJChain.jl")
include("../CGStats.jl")
using Main.LJChain,Main.CGStats,DelimitedFiles

####################################################################################################################
# Set up simulation parameters.

C = Chain(); # system C ≣ [Patt=[0,1,0],NBeads=10,ConstrainedBeads=2,SEps=1,LEps=100,SM=10,LM=1,Dist=1,Beta=1,Gamma=1]

# S = Simulator(); # [dt=1e-4,Stochdt=1e-4,FullSteps=Int(1e5),OrthoSteps=1,ApproxSteps=Int(1e5),OrthoSamples=Int(1e5),MacroSamples=50,LagStep=400,NumLags=30]
S = Simulator(dt=1e-3, Stochdt=1e-4, FullSteps=Int(1e4), ApproxSteps=Int(1e5));

#####################################################################################################################
# Generate initial data

(P0, Q0, F0, H0, P0CG, Q0CG) = InitConds(C);

#####################################################################################################################
# Generate effective potential data

## Mean Force
force_data = readdlm("force_to_interpolate.dat", Float64);

# i punti della griglia *devono* essere equispaziati
RR = force_data[:, 1];
dx = RR[2] - RR[1];

Fmean = force_data[:, 2];
Fmean_d = force_data[:, 3];

Fmean_coeff1 = (2. * (Fmean - circshift(Fmean, -1)) + (Fmean_d + circshift(Fmean_d, -1)) * dx) / dx;
Fmean_coeff2 = circshift(Fmean, -1) - Fmean + (-Fmean_d - Fmean_coeff1) * dx;

FdataMF = zeros(length(Fmean) - 1, 5);
FdataMF[:, 1] = RR[1:end - 1];
FdataMF[:, 2] = Fmean[1:end - 1];
FdataMF[:, 3] = Fmean_d[1:end - 1];
FdataMF[:, 4] = Fmean_coeff1[1:end - 1];
FdataMF[:, 5] = Fmean_coeff2[1:end - 1];

## Fluctuating Force
ff_data = readdlm("flucts_to_interpolate.dat", Float64);

# i punti della griglia *devono* essere equispaziati
RR = force_data[:, 1];
dx = RR[2] - RR[1];

FF = force_data[:, 2];
Fmean_d = force_data[:, 3];

Fmean_coeff1 = (2. * (Fmean - circshift(Fmean, -1)) + (Fmean_d + circshift(Fmean_d, -1)) * dx) / dx;
Fmean_coeff2 = circshift(Fmean, -1) - Fmean + (-Fmean_d - Fmean_coeff1) * dx;

FdataMF = zeros(length(Fmean) - 1, 5);
FdataMF[:, 1] = RR[1:end - 1];
FdataMF[:, 2] = Fmean[1:end - 1];
FdataMF[:, 3] = Fmean_d[1:end - 1];
FdataMF[:, 4] = Fmean_coeff1[1:end - 1];
FdataMF[:, 5] = Fmean_coeff2[1:end - 1];

#########################################################################################
# Generate a random trajectory, using data-generated potentials

(PApprox, QApprox, FApprox) = ApproximateTraj(P0CG, Q0CG, FdataMF, Fstd, C, S);

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
