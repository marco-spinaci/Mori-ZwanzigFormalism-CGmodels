include("LJChain.jl")
include("CGStats.jl")

using Main.LJChain,Main.CGStats,Plots,Statistics

######################################################################################
# Set up simulation parameters

# to change the number of samples to compute, i.e. OrthoSamples Value
# Oin = Int(1e3);
# Ofin = Int(1e6);
OrthoSamplesTot = [exp10(x) for x in 1:7];

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
Portho = Pstore[:,end];
Qortho = Qstore[:,end];

println("Computing orthogonal dynamics through constraint dynamics ...");

# OrthoSamplesTot = Vector(Oin:Oin:Ofin);
diff = circshift(circshift(OrthoSamplesTot,-1)-OrthoSamplesTot,1);
diff[1] = OrthoSamplesTot[1];
StressMoments   = zeros(length(OrthoSamplesTot),2);
VarStress       = zeros(length(OrthoSamplesTot));

for i = 1:length(OrthoSamplesTot)

	S = Simulator(OrthoSamples=diff[i],OrthoSteps=Os,FullSteps=Fs);
	(StressMoments[i,:],Portho,Qortho) = ConstrainedSample(Portho,Qortho,C,S);
	VarStress[i,1]  = (1/i)*sum(StressMoments[1:i,2])-((1/i)*sum(StressMoments[1:i,1]))^2;

	global Portho = Portho;
	global Qortho = Qortho;
end

println("  ... VarStress done!");

s1 = scatter(OrthoSamplesTot,VarStress,
         legend = false,
         markershape = :auto,
         markercolor = :red,
         markersize = 2.5,
		 tickfontsize = 5,
		 guidefontsize = 8,
         xscale = :log10,
         xlabel = "OrthoSamples",
         yscale = :log10,
         ylabel = "VarStress",
         title  = "VarStress vs OrthoSamples
		 (constraint dynamics)",
		 titlefontsize = 7);
# savefig("plotVarStressVSOrthoSamples.pdf");

################################################################################################
# to compute the orthogonal dynamics with the Langevin constraint dynamics

C = Chain();
S = Simulator();
# S = Simulator(OrthoSamples=Oin,OrthoSteps=Os,FullSteps=Fs);

(P0,Q0,F0,H0,PCG0,QCG0) = InitConds(C);

(Pstore,Qstore,Fstore,Kmean,Hmean) = LangevinFullTraj(P0,Q0,C,S);
Portho = Pstore[:,end];
Qortho = Qstore[:,end];

println("Computing orthogonal dynamics through Langevin constraint dynamics ...");

# OrthoSamplesTot = Vector(Oin:Oin:Ofin);
diff = circshift(circshift(OrthoSamplesTot,-1)-OrthoSamplesTot,1);
diff[1] = OrthoSamplesTot[1];
StressMoments   = zeros(length(OrthoSamplesTot),2);
VarStress       = zeros(length(OrthoSamplesTot));

for i = 1:length(OrthoSamplesTot)

	S = Simulator(OrthoSamples=diff[i],OrthoSteps=Os,FullSteps=Fs);
	(StressMoments[i,:],Portho,Qortho) = ConstrSampleLangDyn(Portho,Qortho,C,S);
	VarStress[i,1]  = (1/i)*sum(StressMoments[1:i,2])-((1/i)*sum(StressMoments[1:i,1]))^2;

	global Portho = Portho;
	global Qortho = Qortho;
end

println("  ... VarStress done!");

s2 = scatter(OrthoSamplesTot,VarStress,
         legend = false,
         markershape = :auto,
         markercolor = :red,
         markersize = 2.5,
		 tickfontsize = 5,
		 guidefontsize = 8,
         xscale = :log10,
         xlabel = "OrthoSamples",
         yscale = :log10,
         ylabel = "VarStress",
         title  = "VarStress vs OrthoSamples
		 (constraint Langevin dynamics)",
		 titlefontsize = 7);
# savefig("plotVarStressLANGDYN_VS_OrthoSamples.pdf");

################################################################################################
# to plot the two graphs together

l = @layout [a b];
plot(s1, s2, layout = l);
savefig("plotVarStress_VS_OrthoSamples.pdf");

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
