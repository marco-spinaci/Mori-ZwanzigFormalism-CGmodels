using Printf

@time begin

include("../LJChain.jl")
include("../CGStats.jl")
using Main.LJChain, Main.CGStats, DelimitedFiles, Random

#####################################################################################################################
## Set up simulation parameters.

C = Chain(SM=1, LM=1, Beta=1); # system C ≣ [Patt=[0,1,0],NBeads=10,ConstrainedBeads=2,SEps=1,LEps=100,SM=10,LM=1,Dist=1,Beta=1,Gamma=1]

# S = Simulator(); # [dt=1e-4,Stochdt=1e-4,FullSteps=Int(1e5),OrthoSteps=1,ApproxStep=Int(1e5),OrthoSamples=Int(1e5),MacroSamples=50,LagStep=400,NumLags=30]
S = Simulator(dt=1e-4, FullSteps=Int(1e7),
              m_MF=481.77, q_MF=-1408.6,
              coeffEXP_MF_A=15177, coeffEXP_MF_B=2.7507);    # NB: force_1_1_Beta1.dat


              # m_MF=317.3, q_MF=-935.21,
              # coeffEXP_MF_A=18096, coeffEXP_MF_B=2.8001);  # NB: force_0.1_1.dat


              # m_MF=486.11, q_MF=-1420.4,
              # coeffEXP_MF_A=7794.6, coeffEXP_MF_B=2.5456); # NB: force_1_1_new.dat

# Random.seed!(2134)
# Random.seed!(121)

##########################################################################################
## Generate initial data

(P0, Q0, F0, H0, P0CG, Q0CG) = InitConds(C);

#########################################################################################
## Generate effective potential data

## NB: thesis data
# data extracted from the Kriging interpolation of the original Mean Force data

# force_data = readdlm("Store_Trajectory/force_to_interpolate.dat", Float64);
#
# # to generate the coefficients for the cubic spline interpolation
# # NB: the grid points *must* be equally spaced
# RR = force_data[:, 1];
# dx = RR[2] - RR[1];
#
# Fmean = force_data[:, 2];
# Fmean_d = force_data[:, 3];
#
# Fmean_coeff1 = (2. * (Fmean - circshift(Fmean, -1)) + (Fmean_d + circshift(Fmean_d, -1)) * dx) / dx;
# Fmean_coeff2 = circshift(Fmean, -1) - Fmean + (-Fmean_d - Fmean_coeff1) * dx;
#
# Fdata = zeros(length(Fmean) - 1, 5);
# Fdata[:, 1] = RR[1:end - 1];
# Fdata[:, 2] = Fmean[1:end - 1];
# Fdata[:, 3] = Fmean_d[1:end - 1];
# Fdata[:, 4] = Fmean_coeff1[1:end - 1];
# Fdata[:, 5] = Fmean_coeff2[1:end - 1];

## NB: paper data
# Fdata = readdlm("Eff_Potential/Outcomes/Coeff_MF_SplineI_sC_M1m1.csv", Float64);

# force_data = readdlm("Store_Trajectory/force_1_1_Beta1.dat", Float64);
force_data = readdlm("Store_Trajectory/MF_A1_B1_DT0.0001.dat", Float64);

# i punti della griglia *devono* essere equispaziati
RR = force_data[:, 1];
dx = RR[2] - RR[1];

#
Fm = force_data[:, 2];
FmINT_D = (circshift(Fm,-1) - circshift(Fm,1)) ./(2*dx);
Fmean = Fm[2:end-1];
Fmean_d = FmINT_D[2:end-1];
#
Fmean_coeff1 = (2. * (Fmean - circshift(Fmean, -1)) + (Fmean_d + circshift(Fmean_d, -1)) * dx) / dx;
Fmean_coeff2 = circshift(Fmean, -1) - Fmean + (-Fmean_d - Fmean_coeff1) * dx;
#
Fdata = zeros(length(Fmean) - 1, 5);
Fdata[:, 1] = RR[2:end - 2];
Fdata[:, 2] = Fmean[1:end - 1];
Fdata[:, 3] = Fmean_d[1:end - 1];
Fdata[:, 4] = Fmean_coeff1[1:end - 1];
Fdata[:, 5] = Fmean_coeff2[1:end - 1];


########################################################################################
## Generate a random trajectory, using data-generated potentials

(PApprox2, QApprox2, FApprox2) = DetCGTraj_NVT(P0CG, Q0CG, Fdata, C, S);

#########################################################################################
## Write data to file

if isdir("Outcomes/M$(C.SM)_m$(C.LM)") == 0
    mkpath("Outcomes/M$(C.SM)_m$(C.LM)");
end

open("Outcomes/M$(C.SM)_m$(C.LM)/P_DCGD_M$(C.SM)m$(C.LM)_$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", "w+") do x
    writedlm(x, PApprox2);
end
open("Outcomes/M$(C.SM)_m$(C.LM)/Q_DCGD_M$(C.SM)m$(C.LM)_$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", "w+") do x
    writedlm(x, QApprox2);
end
open("Outcomes/M$(C.SM)_m$(C.LM)/F_DCGD_M$(C.SM)m$(C.LM)_$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", "w+") do x
    writedlm(x, FApprox2);
end


#################################################################################
end # @time
