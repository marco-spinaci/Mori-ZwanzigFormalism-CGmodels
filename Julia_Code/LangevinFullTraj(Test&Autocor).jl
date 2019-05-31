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

# to change the values of the BETA parameter
BetaSamples = Vector(200:200:1000);
# BetaSamples = [exp10(x) for x in -3:0];
nsamples = length(BetaSamples);

# K = zeros(length(BetaSamples));
# for i = 1:length(BetaSamples)
#     C = Chain(Beta=BetaSamples[i,1]);
#     # PFull,QFull,FFull,Kmean,Hmean = LangevinFullTraj(P0,Q0,C,S);
#     # K[i,1] = Kmean;
#     K[i,1] = LangevinFullTraj(P0,Q0,C,S)[4];
# end

i=0;
j=0;
np = nprocs();
K = SharedArray{Float64}(length(BetaSamples));

@sync begin
    while j < nsamples
        for p in 1:np
            if p != myid() || np == 1
                if j >= nsamples
                    break;
                end
                global j += 1;
                println("Start the sample ",j);
                pp = p;
                jj = j;
                @async begin
                    println(" CPU_THREADS ",pp-1,", Worker ",pp,", Beta=",BetaSamples[jj,1]);
                    C = Chain(Beta=BetaSamples[jj,1]);
                    K[jj,1] = remotecall_fetch(LangevinFullTraj,pp,P0,Q0,C,S)[4];
                end
            end
        end
    end
end


p1 = plot(1 ./BetaSamples,K,
       legend = false,
       legendfontsize = 5,
       tickfontsize = 5,
       guidefontsize = 8,
       xlabel = "T",
       ylabel = "<Kmean>",
       title = "<Kmean> per particle vs T",
       titlefontsize = 7);
# savefig("plotKmeanVST.pdf");


###################################################################################################
# to compute the autocorrealtion function at varying of the GAMMA parameter

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

p2 = plot(lags*S.dt,Autocor,
       legend = :topright,
       legendfontsize = 5,
       tickfontsize = 5,
       guidefontsize = 8,
       label = ["Gamma = 1e-5","Gamma = 1","Gamma = 1e5"],
       xlabel = "t",
       ylabel = "Autocorrelation",
       title = "Autocorrelation of the momentum",
       titlefontsize = 7);
# savefig("plotAutocorP.pdf");


###################################################################################################
# to plot the two graphs together

l = @layout [a b];
plot(p1, p2, layout = l);
savefig("./Outcomes/Plots/plotFullTraj(Test&Autocor).pdf");
