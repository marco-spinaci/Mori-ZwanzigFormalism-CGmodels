# NB: to run this script from the terminal is not necessary to give the following command "julia -p n scritpt.jl"
#     because I explicitly added in the script the command-line option "-p n".

using Distributed

# Set up parallel computing
addprocs(Sys.CPU_THREADS);

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")
using Main.LJChain,Main.CGStats,Plots,SharedArrays,StatsBase

C = Chain();
S = Simulator();

# Initial condition
P0 = zeros(C.NPart);
Q0 = Vector(1.0:1.0:30.0);

################################################################################################
# to checks if the function "LangevinFullTraj" works properly
#
# # to change the values of the BETA parameter
# BetaSamples = Vector(200:200:1000);
# # BetaSamples = [exp10(x) for x in -3:3];
# nsamples = length(BetaSamples);
#
# # K = zeros(nsamples);
# # for i = 1:length(BetaSamples)
# #     C = Chain(Beta=BetaSamples[i,1]);
# #     # PFull,QFull,FFull,Kmean,Hmean = LangevinFullTraj(P0,Q0,C,S);
# #     # K[i,1] = Kmean;
# #     K[i,1] = LangevinFullTraj(P0,Q0,C,S)[4];
# # end
#
# i=0;
# j=0;
# np = nprocs();
# K = SharedArray{Float64}(nsamples);
#
# @sync begin
#     while j < nsamples
#         for p in 1:np
#             if p != myid() || np == 1
#                 if j >= nsamples
#                     break;
#                 end
#                 global j += 1;
#                 println("Start the Beta sample ",j);
#                 pp = p;
#                 jj = j;
#                 @async begin
#                     println(" CPU_THREADS ",pp-1,", Worker ",pp,", Beta=",BetaSamples[jj,1]);
#                     C = Chain(Beta=BetaSamples[jj,1]);
#                     K[jj,1] = remotecall_fetch(LangevinFullTraj,pp,P0,Q0,C,S)[4];
#                 end
#             end
#         end
#     end
# end
#
# println("  ... Kmean computed!");
#
# p1 = plot(1 ./BetaSamples,K,
#        legend = false,
#        legendfontsize = 5,
#        tickfontsize = 5,
#        guidefontsize = 8,
#        xscale = :log10,
#        xlabel = "T",
#        yscale = :log10,
#        ylabel = "<Kmean>",
#        title = "<Kmean> per particle vs T",
#        titlefontsize = 7);
# savefig("./Outcomes/Plots/plotKmeanVST.pdf");


###################################################################################################
# to compute the autocorrealtion function at varying of the GAMMA parameter

# to change the values of the Beta parameter
GammaSamples = [exp10(x) for x in -5:5];
nsamples = length(GammaSamples);

# to change the number of ACF to compute
nlags = 4000;
lags = Vector(0:1:nlags);


# Autocor = zeros(length(lags),length(GammaSamples));
# for i = 1:length(GammaSamples)
#     C = Chain(Gamma=GammaSamples[i,1]);
#     PFull = LangevinFullTraj(P0,Q0,C,S)[1];
#     Autocor[:,i] = autocor(PFull[1,:],lags);
# end


i=0;
j=0;
np = nprocs();
PFull = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);
Autocor = SharedArray{Float64}(length(lags),nsamples);

@sync begin
    while j < nsamples
        for p in 1:np
            if p != myid() || np == 1
                if j >= nsamples
                    break;
                end
                global j += 1;
                println("Start the Gammma sample ",j);
                pp = p;
                jj = j;
                @async begin
                    println(" CPU_THREADS ",pp-1,", Worker ",pp,", Gamma=",GammaSamples[jj,1]);
                    C = Chain(Gamma=GammaSamples[jj,1]);
                    PFull[:,:,jj] = remotecall_fetch(LangevinFullTraj,pp,P0,Q0,C,S)[1];
                    Autocor[:,jj] = remotecall_fetch(autocor,pp,PFull[1,:,jj],lags);
                end
            end
        end
    end
end

println("  ... Autocorrelation computed!");

p2 = plot(lags*S.dt,Autocor,
       legend = :topright,
       legendfontsize = 5,
       tickfontsize = 5,
       guidefontsize = 8,
       label = ["Gamma = 1e-5","Gamma = 1e-4","Gamma = 1e-3","Gamma = 1e-2","Gamma = 1e-1","Gamma = 1","Gamma = 1e1","Gamma = 1e2",
		"Gamma = 1e3","Gamma = 1e4","Gamma = 1e5"],
       xlabel = "t",
       ylabel = "Autocorrelation",
       title = "Autocorrelation of the momentum",
       titlefontsize = 7);
savefig("./Outcomes/Plots/plotAutocorP(1).pdf");


###################################################################################################
# to plot the two graphs together

# l = @layout [a b];
# plot(p1, p2, layout = l);
# savefig("./Outcomes/Plots/plotFullTraj(Test&Autocor)(1).pdf");
