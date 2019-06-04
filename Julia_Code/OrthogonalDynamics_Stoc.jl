include("LJChain.jl")
include("CGStats.jl")

using Main.LJChain,Main.CGStats,Plots,Statistics

######################################################################################
# Set up simulation parameters

# to change the number of samples to compute, i.e. OrthoSamples Value
# Oin = Int(1e3);
# Ofin = Int(1e6);
OrthoSamplesTot = [exp10(x) for x in 1:3];

# to change the gap between samples, i.e. OrthoSteps value
Os = Int(1);

# to change the number of FullSteps to compute full dynamics
Fs = Int(1e5);

#######################################################################################

# C = Chain();
C = Chain(Beta=100,Gamma=1e5);

S = Simulator();
# S = Simulator(OrthoSamples=Oin,OrthoSteps=Os,FullSteps=Fs);

# Initial condition
P0 = zeros(C.NPart);
Q0 = Vector(1.0:1.0:30.0);

(Pstore,Qstore,Fstore,Kmean,Hmean) = LangevinFullTraj(P0,Q0,C,S);
Portho = Pstore[:,end];
Qortho = Qstore[:,end];

# to compute the distance between centres of mass of beads
R = CGDists(Qortho,C);
l = length(R);
RR = reshape(R[:,:],l);
i = sortperm(RR);
RR = RR[i];


println("Computing orthogonal dynamics through Langevin constraint dynamics ...");

# OrthoSamplesTot = Vector(Oin:Oin:Ofin);
diff = circshift(circshift(OrthoSamplesTot,-1)-OrthoSamplesTot,1);
diff[1] = OrthoSamplesTot[1];
StressMoments = zeros(length(OrthoSamplesTot),2);
VarStress     = zeros(length(OrthoSamplesTot));

for i = 1:length(OrthoSamplesTot)

	S = Simulator(OrthoSamples=diff[i],OrthoSteps=Os,FullSteps=Fs);
	(StressMoments[i,:],Portho,Qortho) = ConstrSampleLangDyn(Portho,Qortho,C,S);
	VarStress[i,1]  = (1/i)*sum(StressMoments[1:i,2])-((1/i)*sum(StressMoments[1:i,1]))^2;

	global Portho = Portho;
	global Qortho = Qortho;
end

println("  ... done!");
println("Distance between centre of mass of beads, RR = ", RR;

s1 = scatter(OrthoSamplesTot,StressMoments[i,1],
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
         title  = "First stress moment vs OrthoSamples
		 (constraint Langevin dynamics)",
		 titlefontsize = 7);

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
