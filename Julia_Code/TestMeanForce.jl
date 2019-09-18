# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,SharedArrays,Parameters,Statistics,LinearAlgebra,StatsBase,DelimitedFiles # add Pyplot if necessary


C = Chain();
S = Simulator(dt=1e-3,Stochdt=1e-4,FullSteps=Int(1e4),OrthoSamples=Int(1e5),ApproxSteps=Int(1e5),LagStep=10,NumLags=100,MacroSamples=50);

CG = readdlm("ABCD_Systems/Outcomes/sC_100.csv",Float64);
RR = CG[:,1];
Fmean = CG[:,4];
Fstd = CG[:,5];

(P,Q,F,H,PCG,QCG) = InitConds(C);

N = 100;
FM = zeros(N,2);
for i in 1:N
    FM[i,1] = CGDists(Q,C)[1];
    QCG = C.Psi*Q;
    FM[i,2] = ApproxMeanForce(QCG,RR,Fmean,C)[2];
    for i = 1:100
      global(P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt);
    end
end

l = length(FM[:,1])
RR = reshape(FM[:,1],l)
i = sortperm(RR)
RR = RR[i];

Fm = reshape(FM[:,2],l);
Fm = Fm[i];
