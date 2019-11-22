include("../../LJChain.jl")
include("../../CGStats.jl")

using Main.LJChain,Main.CGStats,StatsBase,DelimitedFiles

C = Chain();
S = Simulator();

######################### pdf(P) ###############################################

# P = readdlm("/home/pmams3/Desktop/PFull.csv", Float64);
#P_FGD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/P_FGD.csv", Float64);
P_DCGD = readdlm("Outcomes/PApprox_DCGD_test.csv", Float64);
# P_MMZD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/PApprox_MMZD.csv", Float64);

#h1 = fit(Histogram, P_FGD[:, 1]);
h2 = fit(Histogram, P_DCGD[:, 1]);
# h3 = fit(Histogram, P_MMZD[:, 1]);

#x01 = Vector(h1.edges[1]);
x02 = Vector(h2.edges[1]);
# x03 = Vector(h3.edges[1]);

#H1 = zeros(length(h1.weights), 2);
#H1[:, 1] = (x01[2:end] + x01[1:end-1]) / 2;
#H1[:, 2] = h1.weights ./ length(P_FGD[:, 1]);
#open("Data_Analysis/PDF/Outcomes/HistP_FGD.csv", "w+") do x
#    writedlm(x, H1);
#end

H2 = zeros(length(h2.weights), 2);
H2[:, 1] = (x02[2:end] + x02[1:end-1]) / 2;
H2[:, 2] = h2.weights ./ length(P_DCGD[:, 1]);
open("../Data_Analysis/PDF/Outcomes/HistP_DCGD_test.csv", "w+") do x
    writedlm(x, H2);
end

# H3 = zeros(length(h3.weights), 2);
# H3[:, 1] = (x03[2:end] + x03[1:end-1]) / 2;
# H3[:, 2] = h3.weights ./ length(P_MMZD[:, 1]);
# open("Data_Analysis/PDF/Outcomes/HistP_MMZD.csv", "w+") do x
#     writedlm(x, H3);
# end


######################### pdf(R) ###############################################

# Q = readdlm("/home/pmams3/Desktop/QFull.csv", Float64);

# Q_FGD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/Q_FGD.csv", Float64);
# lf = size(Q_FGD,1);
# dQ4 = zeros(lf, C.NBeads);
# for i in 1:lf
#     dQ4[i, :] = circshift(Q_FGD[i, :], -1) - Q_FGD[i, :];
#     dQ4[i, C.NBeads] += C.Period;
# end

Q_DCGD = readdlm("Outcomes/QApprox_DCGD_test.csv", Float64);
ld = size(Q_DCGD,1);
dQ5 = zeros(ld, C.NBeads);
for i in 1:ld
    dQ5[i, :] = circshift(Q_DCGD[i, :], -1) - Q_DCGD[i, :];
    dQ5[i, C.NBeads] += C.Period;
end

# Q_MMZD = readdlm("/home/mspino/MarcoMasterProject/Julia_Code/Store_Trajectory/Outcomes/QApprox_MMZD.csv", Float64);
# lm = size(Q_MMZD,1);
# dQ6 = zeros(lm, C.NBeads);
# for i in 1:lm
#     dQ6[i, :] = circshift(Q_MMZD[i, :], -1) - Q_MMZD[i, :];
#     dQ6[i, C.NBeads] += C.Period;
# end

#h4 = fit(Histogram, dQ4[:, 1]);
h5 = fit(Histogram, dQ5[:, 1]);
# h6 = fit(Histogram, dQ6[:, 1]);

#x04 = Vector(h4.edges[1]);
x05 = Vector(h5.edges[1]);
# x06 = Vector(h6.edges[1]);

# H4 = zeros(length(h4.weights), 2);
# H4[:, 1] = (x04[2:end] +  x04[1:end-1]) / 2;
# H4[:, 2] = h4.weights ./ length(dQ4[:, 1]);
# open("Data_Analysis/PDF/Outcomes/HistQ_FGD.csv", "w+") do x
#     writedlm(x, H4);
# end

H5 = zeros(length(h5.weights), 2);
H5[:, 1] = (x05[2:end] +  x05[1:end-1]) / 2;
H5[:, 2] = h5.weights ./ length(dQ5[:, 1]);
open("../Data_Analysis/PDF/Outcomes/HistQ_DCGD_test.csv", "w+") do x
    writedlm(x, H5);
end

# H6 = zeros(length(h6.weights), 2);
# H6[:, 1] = (x06[2:end] +  x06[1:end-1]) / 2;
# H6[:, 2] = h6.weights ./ length(dQ6[:, 1]);
# open("Data_Analysis/PDF/Outcomes/HistQ_MMZD.csv", "w+") do x
#     writedlm(x, H6);
# end
