using Printf

@time begin

include("../../LJChain.jl")
include("../../CGStats.jl")
using Main.LJChain, Main.CGStats, StatsBase, DelimitedFiles, Statistics

################################################################################
## Set up simulation parameters.

C = Chain(SM=1, LM=1, Beta=1);
S = Simulator(dt=1e-4, Stochdt=1e-4, FullSteps=Int(1e7), ApproxSteps=Int(1e7));

################################################################################

if isdir("Outcomes/M$(C.SM)_m$(C.LM)/PDF") == 0
    mkdir("Outcomes/M$(C.SM)_m$(C.LM)/PDF");
end

if isdir("Outcomes/M$(C.SM)_m$(C.LM)/PDF/Plots") == 0
    mkdir("Outcomes/M$(C.SM)_m$(C.LM)/PDF/Plots");
end

################################################ pdf(P) ################################################################

P_FGD = readdlm("Outcomes/M$(C.SM)_m$(C.LM)/P_FGD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", Float64);
P_FGD = P_FGD[:];
h1 = fit(Histogram, P_FGD);

x01 = Vector(h1.edges[1]);
H1 = zeros(length(h1.weights), 2);
H1[:, 1] = (x01[2:end] + x01[1:end-1]) / 2;
bin_size = x01[2] - x01[1];
H1[:, 2] = h1.weights ./ (length(P_FGD[:, 1]) * bin_size)
# open("Data_Analysis/PDF/Outcomes/HistP_FGD_1e7(B1.096)_CORRETTA.csv", "w+") do x
open("Outcomes/M$(C.SM)_m$(C.LM)/PDF/HistP_FGD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", "w+") do x
   writedlm(x, H1);
end


P_DCGD = readdlm("Outcomes/M$(C.SM)_m$(C.LM)/P_DCGD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", Float64);
P_DCGD = P_DCGD[:];
h2 = fit(Histogram, P_DCGD);

x02 = Vector(h2.edges[1]);
H2 = zeros(length(h2.weights), 2);
H2[:, 1] = (x02[2:end] + x02[1:end-1]) / 2;
bin_size = x02[2] - x02[1];
H2[:, 2] = h2.weights ./ (length(P_DCGD[:, 1]) * bin_size);
open("Outcomes/M$(C.SM)_m$(C.LM)/PDF/HistP_DCGD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", "w+") do x
    writedlm(x, H2);
end


P_MMZD = readdlm("Outcomes/M$(C.SM)_m$(C.LM)/P_MMZD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.ApproxSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.Stochdt).csv", Float64);
for i in 1:size(P_MMZD, 1)
    # println(mean(P_MMZD[i, :]));
    P_MMZD[i, :] .-= mean(P_MMZD[i, :]);
end

P_MMZD = P_MMZD[:];
h3 = fit(Histogram, P_MMZD);

x03 = Vector(h3.edges[1]);
H3 = zeros(length(h3.weights), 2);
H3[:, 1] = (x03[2:end] + x03[1:end-1]) / 2;
bin_size = x03[2] - x03[1];
H3[:, 2] = h3.weights ./ (length(P_MMZD[:, 1]) * bin_size);
open("Outcomes/M$(C.SM)_m$(C.LM)/PDF/HistP_MMZD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.ApproxSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.Stochdt).csv", "w+") do x
    writedlm(x, H3);
end


############################################ pdf(R) ###############################################################


Q_FGD = readdlm("Outcomes/M$(C.SM)_m$(C.LM)/Q_FGD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", Float64);
lf = size(Q_FGD,1);
dQ4 = zeros(lf, C.NBeads);
for i in 1:lf
    dQ4[i, :] = circshift(Q_FGD[i, :], -1) - Q_FGD[i, :];
    dQ4[i, C.NBeads] += C.Period;
end

dQ4 = dQ4[:];
h4 = fit(Histogram, dQ4);

x04 = Vector(h4.edges[1]);
H4 = zeros(length(h4.weights), 2);
bin_size = x04[2] - x04[1];
H4[:, 1] = (x04[2:end] +  x04[1:end-1]) / 2;
H4[:, 2] = h4.weights ./ (length(dQ4[:, 1]) * bin_size);
open("Outcomes/M$(C.SM)_m$(C.LM)/PDF/HistQ_FGD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", "w+") do x
    writedlm(x, H4);
end


Q_DCGD = readdlm("Outcomes/M$(C.SM)_m$(C.LM)/Q_DCGD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", Float64);
ld = size(Q_DCGD,1);
dQ5 = zeros(ld, C.NBeads);
for i in 1:ld
    dQ5[i, :] = circshift(Q_DCGD[i, :], -1) - Q_DCGD[i, :];
    dQ5[i, C.NBeads] += C.Period;
end

dQ5 = dQ5[:];
h5 = fit(Histogram, dQ5);

x05 = Vector(h5.edges[1]);
H5 = zeros(length(h5.weights), 2);
bin_size = x05[2] - x05[1];
H5[:, 1] = (x05[2:end] +  x05[1:end-1]) / 2;
H5[:, 2] = h5.weights ./ (length(dQ5[:, 1]) * bin_size);
open("Outcomes/M$(C.SM)_m$(C.LM)/PDF/HistQ_DCGD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.FullSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.dt).csv", "w+") do x
    writedlm(x, H5);
end


Q_MMZD = readdlm("Outcomes/M$(C.SM)_m$(C.LM)/Q_MMZD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.ApproxSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.Stochdt).csv", Float64);
lm = size(Q_MMZD,1);
dQ6 = zeros(lm, C.NBeads);
for i in 1:lm
    dQ6[i, :] = circshift(Q_MMZD[i, :], -1) - Q_MMZD[i, :];
    dQ6[i, C.NBeads] += C.Period;
end

dQ6 = dQ6[:];
h6 = fit(Histogram, dQ6);

x06 = Vector(h6.edges[1]);
H6 = zeros(length(h6.weights), 2);
bin_size = x06[2] - x06[1];
H6[:, 1] = (x06[2:end] +  x06[1:end-1]) / 2;
H6[:, 2] = h6.weights ./ (length(dQ6[:, 1]) * bin_size);
open("Outcomes/M$(C.SM)_m$(C.LM)/PDF/HistQ_MMZD_M$(C.SM)m$(C.LM)_Fs$(@sprintf "%0.1e" S.ApproxSteps)_B$(C.Beta)_dt$(@sprintf "%0.1e" S.Stochdt).csv", "w+") do x
    writedlm(x, H6);
end


#################################################################################
end # @time
