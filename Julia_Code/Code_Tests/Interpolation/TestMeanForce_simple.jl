    # NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

@time begin

# Set up parallel computing
# addprocs(Sys.CPU_THREADS);

@everywhere include("../../LJChain.jl")
@everywhere include("../../CGStats.jl")
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

force_data = readdlm("force_to_interpolate.dat", Float64);
RR = force_data[:, 1];
# i punti della griglia *devono* essere equispaziati
dx = RR[2] - RR[1];
inv_sqr_delta = 1. / (dx * dx);

Fmean = force_data[:, 2];
Fmean_d = force_data[:, 3];

Fmean_coeff1 = (2. * (Fmean - circshift(Fmean, -1)) + (Fmean_d + circshift(Fmean_d, -1)) * dx) / dx;
Fmean_coeff2 = circshift(Fmean, -1) - Fmean + (-Fmean_d - Fmean_coeff1) * dx;

RR = RR[1:end - 1];
Fmean = Fmean[1:end - 1];
Fmean_d = Fmean_d[1:end - 1];
Fmean_coeff1 = Fmean_coeff1[1:end - 1];
Fmean_coeff2 = Fmean_coeff2[1:end - 1];

N = 500;
Rmin = RR[1];
Rmax = RR[end];
range = Rmax - Rmin;
delta = range / N

dQ = [Rmin-1:delta:Rmax+1;]

### Mean Force
Sigma = zeros(size(dQ));
for i in 1:length(dQ)
    if dQ[i] < Rmin
        m = 537.59;
        q = -1567.1;
        Sigma[i] = m * dQ[i] + q;
    elseif dQ[i] > Rmax
        Sigma[i] = 0.;
    else
        index = trunc(Int, (dQ[i] - Rmin) / dx) + 1;
        distance = dQ[i] - (Rmin + (index - 1) * dx);
        Sigma[i] = Fmean[index] + distance * (Fmean_d[index] + distance * (Fmean_coeff2[index] + distance * Fmean_coeff1[index]) * inv_sqr_delta);
    end
end

#Sigma1 = reshape(Sigma, l);
#Sigma1 = Sigma1[i];
# println("Sigma = ", Sigma1);

#open("./Code_Tests/Interpolation/Outcomes/RFmean_algInt_test.csv", "w+") do x
open("force.dat", "w+") do x
    writedlm(x, [dQ Sigma])
end

### Fluctuating Force

Fstd_data = readdlm("flucts_to_interpolate.dat", Float64);
Fstd = Fstd_data[:, 2];

Gvec = zeros(size(dQ,1));
for i=1:length(dQ)
    if dQ[i] < 0.9
        m = (6464.26 - 8859.34) / (1.2-0.90);
        q = 8859.34 - m * 0.90;
        Gvec[i] = m * dQ[i] + q;
    elseif dQ[i] > 3.78
        W = spdiagm(0 => exp.(-(RR .- 3.78) .^2 ./ σ^2));
        J = ones(3, length(RR));
        for j = 1:2
            J[j+1, :] = (3.78 .- RR).^j;
        end
        K = J * W;
        coeffs = (K * J') \ (K * Fstd);
        Gvec[i] = coeffs[1];
    else
        W = spdiagm(0 => exp.(-(RR .- dQ[i]) .^2 ./ σ^2));
        
        J = ones(3, length(RR));
        for j=1:2
            J[j+1,:] = (dQ[i] .- RR).^j;
        end
        K = J * W;
        coeffs = (K * J') \ (K * Fstd);
        Gvec[i] = coeffs[1];
    end
end

###

l = length(dQ[:, 1]);
RB = reshape(dQ[:, 1], l);
i = sortperm(RB);
RB = RB[i];
# println("R =", RB);



Gvec1 = reshape(Gvec, l);
Gvec1 = Gvec1[i];
# println("FF = ", Gvec1);

open("flucts.dat", "w+") do x
    writedlm(x, [RB Gvec1])
end

######################################################################

end # @time
