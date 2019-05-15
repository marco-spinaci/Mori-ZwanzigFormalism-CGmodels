using Distributed

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")

using Main.LJChain,Main.CGStats,Plots,SharedArrays,StatsBase

C = Chain();
S = Simulator();

# Initial condition
P0 = zeros(C.NPart);
Q0 = Vector(1.0:1.0:30.0);

################################################################################
# to checks if the function "LangevinFullTraj" works properly

# to change the values of the Beta parameter
BetaSamples = Vector(200:200:1000);
# BetaSamples = [exp10(x) for x in -3:0];


K = zeros(length(BetaSamples));
for i = 1:length(BetaSamples)
    C = Chain(Beta=BetaSamples[i,1]);
    # PFull,QFull,FFull,Kmean,Hmean = LangevinFullTraj(P0,Q0,C,S);
    # K[i,1] = Kmean;
    K[i,1] = LangevinFullTraj(P0,Q0,C,S)[4];
end

plot(1 ./BetaSamples,K,
    legend = false,
    xlabel = "T",
    ylabel = "<Kmean>",
    title = "<Kmean> per particle vs T");
savefig("plotKmeanVST.pdf");

################################################################################

# BetaSamples = Vector(200:200:1000);     # to change the values of the Beta parameter
#
# K = SharedArray{Float64}(length(BetaSamples));
#
# # Perform sampling
# addprocs(Sys.CPU_THREADS);
# np = nprocs();
#
# @distributed (+) for i = 1:length(BetaSamples)
#     s=i;
#     @everywhere C = Chain(Beta=BetaSamples[s,1]);
#     PFull,QFull,FFull,Kmean,Hmean = LangevinFullTraj(P0,Q0,C,S);
#     K[s,1] = Kmean;
# end

# i=0
# @sync begin
#     while i < length(BetaSamples)
#         i+=1;
#         C = Chain(Beta=BetaSamples[i,1]);
#         for p in 1:np
#             if p != myid() || np == 1
#                 @async begin
#                     PFull,QFull,FFull,Kmean,Hmean = remotecall_fetch(LangevinFullTraj,p,P0,Q0,C,S);
#                     K[i,1] = Kmean;
#                 end
#             end
#         end
#     end
# end


################################################################################

# to compute the autocorrealtion function at varying of the gamma parameter

# to change the values of the Beta parameter
GammaSamples = [exp10(x) for x in -5:5:5];
# to change the number of ACF to compute
nlags = 4000;

lags = Vector(0:1:nlags);
Autocor = zeros(length(lags),length(GammaSamples));
for i = 1:length(GammaSamples)
    C = Chain(Gamma=GammaSamples[i,1]);
    PFull = LangevinFullTraj(P0,Q0,C,S)[1];
    Autocor[:,i] = autocor(PFull[1,:],lags);
end

plot(lags*S.dt,Autocor,
    legend = :topright,
    label = ["Gamma = 1e-5","Gamma = 1","Gamma = 1e5"],
    xlabel = "t",
    ylabel = "Autocorrelation",
    title = "Autocorrelation of the momentum");
savefig("plotAutocorP.pdf");
