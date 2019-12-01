include("../../LJChain.jl")
include("../../CGStats.jl")
# include("LJChain.jl")
# include("CGStats.jl")

using Main.LJChain,Main.CGStats,Statistics,DelimitedFiles,PyPlot

C = Chain();
S = Simulator(dt=1e-3, Stochdt=1e-3, FullSteps=Int(1e7), ApproxSteps=Int(1e7));

################################################################################

Q_FGD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/Q_FGD_1e7.csv", Float64);
# Q_FGD = readdlm("Store_Trajectory/Outcomes/Q_FGD.csv", Float64);

N = size(Q_FGD, 1);
n = N - 1;

msd1 = zeros(n);

i = 1;
sumtot = 0;
while i < N
    for j in 1:(N-i)
        global sumtot += sum((Q_FGD[j+1,:] - Q_FGD[j,:]) .^ 2);
    end
    msd1[i] = sumtot / ((N-i) * C.NBeads);
    global i += 1;
end

open("Data_Analysis/MSD/Outcomes/msd_FGD.csv", "w+") do x
    writedlm(x, [ S.dt*100*[0:n-1;] msd1 ]);
end



################################################################################

Q_DCGD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/QApprox_DCGD_1e7.csv", Float64);
# Q_DCGD = readdlm("Store_Trajectory/Outcomes/QApprox_DCGD_test.csv", Float64);

N = size(Q_DCGD, 1);
n = N - 1;

msd2 = zeros(n);

i = 1;
sumtot = 0;
while i < N
    for j in 1:(N-i)
        global sumtot += sum((Q_DCGD[j+1,:] - Q_DCGD[j,:]) .^ 2);
    end
    msd2[i] = sumtot / ((N-i) * C.NBeads);
    global i += 1;
end

open("Data_Analysis/MSD/Outcomes/msd_DCGD.csv", "w+") do x
    writedlm(x, [ S.dt*100*[0:n-1;] msd2 ]);
end

################################################################################

Q_MMZD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/QApprox_MMZD_1e7.csv", Float64);
# Q_MMZD = readdlm("Store_Trajectory/Outcomes/QApprox_MMZD_1.csv", Float64);

# CdM = Q_MMZD * C.vectorCdM;
# Q_MMZD = Q_MMZD .- CdM;

N = size(Q_MMZD, 1);
n = N - 1;

msd3 = zeros(n);

i = 1;
sumtot = 0;
while i < N
    for j in 1:(N-i)
        global sumtot += sum((Q_MMZD[j+1,:] - Q_MMZD[j,:]) .^ 2);
    end
    msd3[i] = sumtot / ((N-i) * C.NBeads);
    global i += 1;
end

open("Data_Analysis/MSD/Outcomes/msd_MMZD.csv", "w+") do x
    writedlm(x, [ S.dt*100*[0:n-1;] msd3 ]);
end
