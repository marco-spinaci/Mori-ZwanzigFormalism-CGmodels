using Distributed

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")

using Main.LJChain,Main.CGStats,SharedArrays,Parameters,Statistics,LinearAlgebra,StatsBase

###########################################################################################################

C = Chain();      # System C ([0,1,0], SM (mass of 0 particles)=10, LM (mass of 1 particles)=1, γ=1, β=1)
S = Simulator();  # dt=1e-4, FullSteps=Int(1e5),  OrthoSteps=1, OrthoSamples=Int(1e5)

nsamples = 1;

P0 = zeros(C.NPart);
Q0 = Vector(1.0:1.0:30.0);

############################################################################################################


j=0;
np = nprocs();
Pstore = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);
Qstore = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);
Fstore = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);

@sync begin
    while j < nsamples
        if j >= nsamples
            break;
        end
        global j += 1;
        pp = 2;
        jj = j;
        @async begin
            println(" CPU_THREADS ",pp-1,", Worker ",pp," :");
            (Pstore_DET[:,:,jj],Qstore_DET[:,:,jj],Fstore_DET[:,:,jj],Kmean,Hmean) = remotecall_fetch(LangevinFullTraj,pp,P0,Q0,C,S);
            println(" CPU_THREADS ",pp,", Worker ",pp+1," :");
            (Pstore_STOC[:,:,jj],Qstore_STOC[:,:,jj],Fstore_STOC[:,:,jj]) = remotecall_fetch(LangConstrainedTraj,pp+1,P0,Q0,C,S);
        end
    end
end

# Write data to file
open("1_Qstore_DET.csv","w+") do x
    writedlm(x,Qstore_DET[:,:,1]);
end
open("1_Pstore_DET.csv","w+") do x
    writedlm(x,Pstore_DET[:,:,1]);
end
open("1_Fstore_DET.csv","w+") do x
    writedlm(x,Fstore_DET[:,:,1]);
end

open("1_Qstore_STOC.csv","w+") do x
    writedlm(x,Qstore_STOC[:,:,1]);
end
open("1_Pstore_STOC.csv","w+") do x
    writedlm(x,Pstore_STOC[:,:,1]);
end
open("1_Fstore_STOC.csv","w+") do x
    writedlm(x,Fstore_STOC[:,:,1]);
end
