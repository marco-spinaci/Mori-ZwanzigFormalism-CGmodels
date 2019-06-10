using Distributed

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")

using Main.LJChain,Main.CGStats,SharedArrays,Parameters,Statistics,LinearAlgebra,StatsBase


C = Chain();
S = Simulator(); # dt=1e-4, FullSteps=Int(1e5),  OrthoSteps=1, OrthoSamples=Int(1e5)


####################################################################################################

# (P0,Q0,F0,H0,PCG0,QCG0) = InitConds(C);
#
# (Pstore,Qstore,Fstore) = FullTraj(P0,Q0,C,S);
#
# Pi = Pstore[:,end];
# Qi = Qstore[:,end];
#
# PCG = C.PhiConstr*Pi;
# QCG = C.PsiConstr*Qi;
#
# (StressMoments,Pf,Qf) = ConstrainedSample(Pi,Qi,C,S);

#####################################################################################################

P0 = zeros(C.NPart);
Q0 = Vector(1.0:1.0:30.0);

(Pstore,Qstore,Fstore,Kmean,Hmean) = LangevinFullTraj(P0,Q0,C,S);

Pi = Pstore[:,end];
Qi = Qstore[:,end];

PCG = C.PhiConstr*Pi;
QCG = C.PsiConstr*Qi;

println("Computing orthogonal dynamics through constrained Langevin dynamics ...");

@time begin
    S = Simulator();
    (StressMoments,Pf,Qf) = ConstrSampleLangDyn(Pi,Qi,C,S);
    println("  dt, time step size = ",S.dt," seconds.");
    println("  Total simulation time = ",S.dt*S.OrthoSamples," seconds.");
end;

@time begin
    S = Simulator();
    (StressMoments,Pf,Qf) = ConstrSampleLangDyn(Pi,Qi,C,S);
    println("  dt, time step size = ",S.dt," seconds.");
    println("  Total simulation time = ",S.dt*S.OrthoSteps*S.OrthoSamples," seconds.");
end;

#####################################################################################################
#
# PhiConstr = kron(Diagonal(ones(C.NBeads))[1:C.ConstrainedBeads,:],ones(Float64,length(C.Patt))');
# PsiConstr = kron(Diagonal(ones(C.NBeads))[1:C.ConstrainedBeads,:],C.MassPatt'./C.BeadMass);
# ZetaConstr = Diagonal(ones(C.NPart))-PsiConstr'PhiConstr;
#
# #########################################################################################################
#
# P0,Q0,F0 = InitConds(C);
#
# (StressMoments,Portho,Qortho) = ConstrSampleLangDyn(P0,Q0,C,S);
#
# MomentSamples = SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1,S.Moments);
# ii=1;
# p=1;
# MomentSamples[ii,:,:] = remotecall_fetch(ConstrSampleLangDyn,p,P0,Q0,C,S,0)[1];
# # NB:ConstrSampleLangDyn returns a Tuple and remotecall_fetch()[1] returns the first value of this Tuple
#
# ############################################################################################################
#
# EpsPatt = (sqrt.(C.LEps)*C.LTotPatt+sqrt.(C.SEps)*C.STotPatt).*circshift(sqrt.(C.LEps)*C.LTotPatt+sqrt.(C.SEps)*C.STotPatt,-1)
