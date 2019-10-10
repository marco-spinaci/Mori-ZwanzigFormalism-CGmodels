# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

@time begin

# Set up parallel computing
# addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,
      Main.CGStats,
      SharedArrays,
      Parameters,
      Statistics,
      LinearAlgebra,
      StatsBase,
      SparseArrays,
      DelimitedFiles # add Pyplot if necessary


C = Chain();
S = Simulator(
    dt = 1e-3,
    Stochdt = 1e-4,
    FullSteps = Int(1e6),
    OrthoSamples = Int(1e6),
    ApproxSteps = Int(1e5),
    LagStep = 10,
    NumLags = 100,
    MacroSamples = 50,
);

CG = readdlm("./ABCD_Systems/Outcomes/sC_2000.csv", Float64);
RR = CG[:, 1];
Fmean = CG[:, 4];
Fstd = CG[:, 5];

###############################################################

# (P, Q, F, H, PCG, QCG) = InitConds(C);

# N = Int(1e4);
# R = zeros(N, 1);
# I = zeros(N, C.NBeads);
# dQ = zeros(N, C.NBeads);
# Sigma = zeros(N, C.NBeads);
# dQff = zeros(N, C.NBeads);
# Iff = zeros(N, C.NBeads);
# for i = 1:N
#     R[i, 1] = CGDists(Q, C)[1];      # NB: CGDist() return an array of 1 element
#     QCG = C.Psi * Q;
#     PCG = C.Phi * P;
#     (I[i, :], Sigma[i, :], dQ[i, :]) = ApproxMeanForce(QCG, RR, Fmean, C);
#     (Flucstep, Iff[i, :], dQff[i, :]) = ApproxFlucStep(PCG, QCG, RR, Fstd, C, S.Stochdt, 0.1, 2);
#     for i = 1:1000
#         global (P, Q, F) = LangDynIntegrators(P, Q, F, C, S.dt);
#     end
#     println("Iteration = ", i);
#     # println("R = ", R[i, 1]);
#     # println("R1 = ", QCG[2] - QCG[1]);
#     # println("Fm = ", I[i, :]);
#     # println("dQ = ", dQ[i, :]);
#     # println("Sigma = ", Sigma[i, :]);
# end
#
# l = length(R[:, 1]);
# RB = reshape(R[:, 1], l);
# i = sortperm(RB);
# RB = RB[i];
#
# Fm = reshape(I[:, 2], l);
# Fm = Fm[i];
#
# ####
#
# l1 = length(dQ[:, 1]);
# RB1 = reshape(dQ[:, 1], l1);
# i1 = sortperm(RB1);
# RB1 = RB1[i1];
#
# Sigma1 = reshape(Sigma[:, 1], l1);
# Sigma1 = Sigma1[i1];
#
# ####
#
# l2 = length(dQff[:, 1]);
# RB2 = reshape(dQff[:, 1], l2);
# i2 = sortperm(RB2);
# RB2 = RB2[i2];
#
# FF = reshape(Iff[:, 1], l);
# FF = FF[i2];
#
# open("./TestInterpolation/Outcomes/RRFmean_1e4.csv", "w+") do x
#     writedlm(x, [RB Fm RB1 Sigma1])
# end
#
# open("./TestInterpolation/Outcomes/RRFF_1e4.csv", "w+") do x
#     writedlm(x, [RB2 FF])
# end

#################################################################################

N = 1000;
σ = 0.1;
Rmin = -1;
Rmax = 8;

dQ = Rmin .+ rand(Float64, N) .* (Rmax - Rmin);
# dQ = [5,6,6.11,6.13,6.14,6.15,6.17,6.18,6.19,6.3];

# Mean Force
Sigma = zeros(size(dQ));
for i in 1:length(dQ)
    if dQ[i] < 0.9
        m = (- 9620.78 + 11462.61) / (1.09-0.95);
        q = -9620.78 - m * 1.09;
        Sigma[i] = m * dQ[i] + q;
        continue
    elseif dQ[i] > 3.78
        W = spdiagm(0 => exp.(-(RR .- 3.78) .^2 ./ σ^2));
        J = ones(3, length(RR));
        for j = 1:2
            J[j+1, :] = (3.78 .- RR).^j;
        end
        K = J * W;
        c = (K * J') \ (K * Fmean);
        Sigma[i] = c[1];
        continue;
    else
        W = spdiagm(0 => exp.(-(RR .- dQ[i]) .^2 ./ σ^2));
    end
    J = ones(3, length(RR));
    for j = 1:2
        J[j+1, :] = (dQ[i] .- RR).^j;
    end
    K = J * W;
    c = (K * J') \ (K * Fmean);
    Sigma[i] = c[1];
end

# Fluctuating Force
Gvec = zeros(size(dQ,1));
for i=1:length(dQ)
    if dQ[i] < 0.9
        m = (7237.78 - 8523.99) / (1.09-0.94);
        q = 7237.78 - m * 1.09;
        Gvec[i] = m * dQ[i] + q;
        continue
    elseif dQ[i] > 3.78
        W = spdiagm(0 => exp.(-(RR .- 3.78) .^2 ./ σ^2));
        J = ones(3, length(RR));
        for j = 1:2
            J[j+1, :] = (3.78 .- RR).^j;
        end
        K = J * W;
        coeffs = (K * J') \ (K * Fstd);
        Gvec[i] = coeffs[1];
        continue
    else
        W = spdiagm(0 => exp.(-(RR .- dQ[i]) .^2 ./ σ^2));
    end
    J = ones(3, length(RR));
    for j=1:2
        J[j+1,:] = (dQ[i] .- RR).^j;
    end
    K = J * W;
    coeffs = (K * J') \ (K * Fstd);
    Gvec[i] = coeffs[1];
end

l = length(dQ[:, 1]);
RB = reshape(dQ[:, 1], l);
i = sortperm(RB);
RB = RB[i];
# println("R =", RB);

Sigma1 = reshape(Sigma, l);
Sigma1 = Sigma1[i];
# println("Sigma = ", Sigma1);

Gvec1 = reshape(Gvec, l);
Gvec1 = Gvec1[i];
# println("FF = ", Gvec1);

open("./Test_Scripts/TestInterpolation/Outcomes/RFmean_algInt_test.csv", "w+") do x
    writedlm(x, [RB Sigma1])
end

open("./Test_Scripts/TestInterpolation/Outcomes/RFF_algInt_test.csv", "w+") do x
    writedlm(x, [RB Gvec1])
end

######################################################################

end # @time
