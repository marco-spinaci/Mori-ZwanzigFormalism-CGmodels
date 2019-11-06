include("../../LJChain.jl")
include("../../CGStats.jl")

using Main.LJChain,Main.CGStats,StatsBase,DelimitedFiles

C = Chain();
S = Simulator();

### FULL DYNAMICS

## pdf(P)

P = readdlm("/home/pmams3/Desktop/PFull.csv", Float64);

h1 = fit(Histogram, P[:, 1]);

x01 = Vector(h1.edges[1]);

H1 = zeros(length(h1.weights), 2);
H1[:, 1] = (x01[2:end] + x01[1:end-1]) / 2;
H1[:, 2] = h1.weights ./ length(P[:, 1]);

open("Data_Analysis/PDF/Outcomes/HistPFull.csv", "w+") do x
    writedlm(x, H1);
end

## pdf(Q)

Q = readdlm("/home/pmams3/Desktop/QFull.csv", Float64);
l = size(Q,1);
dQ = zeros(l, C.NBeads);
for i in 1:l
    dQ[i, :] = circshift(Q[i, :], -1) - Q[i, :];
    dQ[i, C.NBeads] += C.Period;
end

h2 = fit(Histogram, dQ[:, 1]);

x02 = Vector(h2.edges[1]);

H2 = zeros(length(h2.weights), 2);
H2[:, 1] = (x02[2:end] +  x02[1:end-1]) / 2;
H2[:, 2] = h2.weights ./ length(dQ[:, 1]);

open("Data_Analysis/PDF/Outcomes/HistQFull.csv", "w+") do x
    writedlm(x, H2);
end
