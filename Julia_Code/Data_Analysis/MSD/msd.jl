include("../../LJChain.jl")
include("../../CGStats.jl")
# include("LJChain.jl")
# include("CGStats.jl")

using Main.LJChain,Main.CGStats,Statistics,DelimitedFiles

C = Chain();
S = Simulator(dt=1e-3, Stochdt=1e-4, FullSteps=Int(1e7), ApproxSteps=Int(1e5));

################################################################################

Q_FGD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/Q_FGD.csv", Float64);
# Q_FGD = readdlm("Store_Trajectory/Outcomes/Q_FGD.csv", Float64);

l = size(Q_FGD,1);
r = Int(l / 2) + 1;
ll = length(Q_FGD);

msd1 = zeros(r, 1);
msd1[1] = 0;
for i in 2:r
    # msd1[i] = var(dQ1 - circshift(dQ1, i));
    msd1[i] = sum( (Q_FGD - circshift(Q_FGD, i) ).^2 ) / ll;
end

open("Data_Analysis/MSD/Outcomes/msd_FGD.csv", "w+") do x
    writedlm(x, [ S.dt*[0:Int(l/2);] msd1 ]);
end

################################################################################

Q_DCGD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/QApprox_DCGD_test.csv", Float64);
# Q_DCGD = readdlm("Store_Trajectory/Outcomes/QApprox_DCGD.csv", Float64);

l = size(Q_DCGD, 1);
r = Int(l / 2) + 1;
ll = length(Q_DCGD);

msd2 = zeros(r, 1);
msd2[1] = 0;
for i in 2:r
    # msd1[i] = var(dQ1 - circshift(dQ1, i));
    msd2[i] = sum( (Q_DCGD - circshift(Q_DCGD, i) ).^2 )/1e5;
end

open("Data_Analysis/MSD/Outcomes/msd_DCGD.csv", "w+") do x
    writedlm(x, [ S.dt*[0:Int(l/2);] msd2 ]);
end

################################################################################

Q_MMZD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/QApprox_MMZD.csv", Float64);
# Q_MMZD = readdlm("Store_Trajectory/Outcomes/QApprox_MMZD.csv", Float64);

l = size(Q_MMZD, 1);
r = Int(l / 2) + 1;
ll = length(Q_MMZD);

msd3 = zeros(r, 1);
msd3[1] = 0;
for i in 2:r
    # msd1[i] = var(dQ1 - circshift(dQ1, i));
    msd3[i] = sum( (Q_MMZD - circshift(Q_MMZD, i) ).^2 ) / ll;
end

open("Data_Analysis/MSD/Outcomes/msd_MMZD.csv", "w+") do x
    writedlm(x, [ S.dt*[0:Int(l/2);] msd3 ]);
end
