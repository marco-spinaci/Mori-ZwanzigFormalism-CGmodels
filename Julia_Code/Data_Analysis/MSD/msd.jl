include("../../LJChain.jl")
include("../../CGStats.jl")
# include("LJChain.jl")
# include("CGStats.jl")

using Main.LJChain,Main.CGStats,Statistics,DelimitedFiles

C = Chain();
S = Simulator();

################################################################################

# Q_FGD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/Q_FGD.csv", Float64);
Q_FGD = readdlm("Store_Trajectory/Outcomes/Q_FGD.csv", Float64);
l = size(Q_FGD,1);
# dQ1 = zeros(l, C.NBeads);
# for i in 1:l
#     dQ1[i, :] = circshift(Q_FGD[i, :], -1) - Q_FGD[i, :];
#     dQ1[i, C.NBeads] += C.Period;
# end

r = Int(l / 2) + 1;
msd1 = zeros(r, 1);
msd1[1] = 0;
for i in 2:r
    # msd1[i] = var(dQ1 - circshift(dQ1, i));
    msd1[i] = sum( (Q_FGD - circshift(Q_FGD, i) ).^2 )/1e5;
end

open("Data_Analysis/MSD/Outcomes/msd_FGD.csv", "w+") do x
    writedlm(x, [ S.dt*[0:Int(l/2);] msd1 ]);
end
