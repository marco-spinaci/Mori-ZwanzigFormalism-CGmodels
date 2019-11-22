include("../../LJChain.jl")
include("../../CGStats.jl")

using Main.LJChain,Main.CGStats,StatsBase,DelimitedFiles

C = Chain();
S = Simulator();

################################################################################

# Q_FGD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/Q_FGD.csv", Float64);
Q_FGD = readdlm("Store_Trajectory/Outcomes/Q_FGD.csv", Float64);
l = size(Q_FGD,1);
dQ1 = zeros(l, C.NBeads);
Sum1 = zeros(l,1);
for i in 1:l
    dQ1[i, :] = circshift(Q_FGD[i, :], -1) - Q_FGD[i, :];
    dQ1[i, C.NBeads] += C.Period;
    Sum1[i,1] = sum((dQ1[i, :] - dQ1[1, :]).^2);
end

msd1 = Sum1 ./ C.NBeads;

open("Data_Analysis/PDF/Outcomes/msd_FGD.csv", "w+") do x
    writedlm(x, msd1);
end

Q_DCGD = readdlm("Store_Trajectory/Outcomes/QApprox_DCGD.csv", Float64);
ld = size(Q_DCGD,1);
dQ2 = zeros(ld, C.NBeads);
Sum2 = zeros(ld,1);
for i in 1:ld
    dQ2[i, :] = circshift(Q_DCGD[i, :], -1) - Q_DCGD[i, :];
    dQ2[i, C.NBeads] += C.Period;
    Sum2[i,1] = sum((dQ2[i, :] - dQ2[1, :]).^2);
end

msd2 = Sum2 ./ C.NBeads;

open("Data_Analysis/PDF/Outcomes/msd_FGD.csv", "w+") do x
    writedlm(x, msd2);
end

Q_MMZDD = readdlm("Store_Trajectory/Outcomes/QApprox_MMZD.csv", Float64);
lm = size(Q_MMZD,1);
dQ3 = zeros(lm, C.NBeads);
Sum3 = zeros(lm,1);
for i in 1:lm
    dQ3[i, :] = circshift(Q_MMZD[i, :], -1) - Q_MMZD[i, :];
    dQ3[i, C.NBeads] += C.Period;
    Sum3[i,1] = sum((dQ3[i, :] - dQ3[1, :]).^2);
end

msd3 = Sum3 ./ C.NBeads;

open("Data_Analysis/PDF/Outcomes/msd_FGD.csv", "w+") do x
    writedlm(x, msd3);
end
