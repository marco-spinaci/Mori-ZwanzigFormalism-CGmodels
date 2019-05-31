include("LJChain.jl")
include("CGStats.jl")

using Main.LJChain,Main.CGStats,Plots,Statistics

######################################################################################

# to change the number of samples to compute, i.e. OrthoSamples Value

# Oin = Int(1e3);
# Ofin = Int(1e6);
OrthoSamplesTot = [exp10(x) for x in 1:9];

# to change the gap between samples, i.e. OrthoSteps value

Os = Int(1);

# to change the number of FullSteps to compute full dynamics

Fs = Int(1e5);

######################################################################################
# to compute the orthogonal dynamics with the constraint dynamics

C = Chain();
S = Simulator();
# S = Simulator(OrthoSamples=Oin,OrthoSteps=Os,FullSteps=Fs);

(P0,Q0,F0,H0,PCG0,QCG0) = InitConds(C);

(Pstore,Qstore,Fstore) = FullTraj(P0,Q0,C,S);

# OrthoSamplesTot = Vector(Oin:Oin:Ofin);
StressMoments   = zeros(length(OrthoSamplesTot),2);
VarStress       = zeros(length(OrthoSamplesTot));

Portho = Pstore[:,end];
Qortho = Qstore[:,end];

for i = 1:length(OrthoSamplesTot)

	S = Simulator(OrthoSamples=Int(OrthoSamplesTot[i]),OrthoSteps=Os,FullSteps=Fs);
	(StressMoments[i,:],Portho,Qortho) = ConstrainedSample(Portho,Qortho,C,S);
	VarStress[i,1]  = (1/i)*sum(StressMoments[1:i,2])-((1/i)*sum(StressMoments[1:i,1]))^2;

	global Portho = Portho;
	global Qortho = Qortho;
end

plot(OrthoSamplesTot,VarStress,
    legend = false,
	linestyle = :dot;
    xlabel = "OrthoSamples",
    ylabel = "VarStress",
    title  = "VarStress vs OrthoSamples");
savefig("plotVarStressVSOrthoSamples.pdf");

################################################################################################
# to compute the orthogonal dynamics with the Langevin constraint dynamics

# C = Chain();
# S = Simulator();
# # S = Simulator(OrthoSamples=Oin,OrthoSteps=Os,FullSteps=Fs);
#
# (P0,Q0,F0,H0,PCG0,QCG0) = InitConds(C);
#
# (Pstore,Qstore,Fstore) = FullTraj(P0,Q0,C,S);
#
# # OrthoSamplesTot = Vector(Oin:Oin:Ofin);
# StressMoments   = zeros(length(OrthoSamplesTot),2);
# VarStress       = zeros(length(OrthoSamplesTot));
#
# Portho = Pstore[:,end];
# Qortho = Qstore[:,end];
#
# for i = 1:length(OrthoSamplesTot)
#
# 	S = Simulator(OrthoSamples=Int(OrthoSamplesTot[i]),OrthoSteps=Os,FullSteps=Fs);
# 	(StressMoments[i,:],Portho,Qortho) = ConstrSampleLangDyn(Portho,Qortho,C,S);
# 	VarStress[i,1]  = (1/i)*sum(StressMoments[1:i,2])-((1/i)*sum(StressMoments[1:i,1]))^2;
#
# 	global Portho = Portho;
# 	global Qortho = Qortho;
# end
#
# plot(OrthoSamplesTot,VarStress,
#     legend = false,
#     linestyle = :dot;
#     xlabel = "OrthoSamples",
#     ylabel = "VarStress",
#     title  = "VarStress vs OrthoSamples (constraint Langevin dynamics)");
# savefig("plotVarStressLANGDYN_VS_OrthoSamples.pdf");


################################################################################################

# Autocorrelation analysis to compute the autocorrelation function and the
# corrisponding integrated autocorrelation time τ

# Kmax = 600;                             # index autocorrelation function
# n    = length(OrthoSamplesTot);
# M    = zeros(2,1);
# P    = zeros(n-1,1);
# C    = zeros(Kmax,2);
# tau  = zeros(Kmax,2);
#
# for i in 1:2
# 	M[i,1] = (1/length(OrthoSamplesTot))*sum(StressMoments[1:end,i]);
#     for k in 1:Kmax
#         for r in 1:n-k
#             P[r,1] = (StressMoments[r+k,i]-M[i,1])*(StressMoments[r,i]-M[i,1]);
#         end
#         C[k,i] = sum(P[:,1])/(n-k);
#         tau[k,i] = (1/2)+(sum(C[1:k,i])/var(StressMoments[:,i]));
#     end
# end
#
# plot(1:1:Kmax,C[:,1]);   # plot the autocorrelation of the StressMoments[:,i] where i=1,2
# plot(1:1:Kmax,C[:,2]);
# plot(1:1:Kmax,tau[:,1]); # plot the autocorrelation time of the StressMoments[:,i] where i=1,2
# plot(1:1:Kmax,tau[:,2]);
