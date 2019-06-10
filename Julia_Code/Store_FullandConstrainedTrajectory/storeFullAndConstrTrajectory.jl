include("../LJChain.jl")
include("../CGStats.jl")

using Main.LJChain,Main.CGStats,SharedArrays,Parameters,Statistics,LinearAlgebra,StatsBase

###########################################################################################################

C = Chain();      # System C ([0,1,0], SM (mass of 0 particles)=10, LM (mass of 1 particles)=1, γ=1, β=1)
S = Simulator();  # dt=1e-4, FullSteps=Int(1e5),  OrthoSteps=1, OrthoSamples=Int(1e5)

nsamples = 1;

P0 = zeros(C.NPart);
Q0 = Vector(1.0:1.0:30.0);

############################################################################################################


Pstore_DET = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);
Qstore_DET = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);
Fstore_DET = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);

Pstore_STOC = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);
Qstore_STOC = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);
Fstore_STOC = SharedArray{Float64}(C.NPart,S.FullSteps,nsamples);

for i in 1:nsamples
    (Pstore_DET[:,:,i],Qstore_DET[:,:,i],Fstore_DET[:,:,i],Kmean,Hmean) = LangevinFullTraj(P0,Q0,C,S);
    (Pstore_STOC[:,:,i],Qstore_STOC[:,:,i],Fstore_STOC[:,:,i]) = LangConstrainedTraj(Pstore_DET[:,end,i],Qstore_DET[:,end,i],C,S);
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
