using Distributed

@everywhere include("LJChain.jl")
@everywhere include("CGStats.jl")

using Main.LJChain,Main.CGStats,SharedArrays,Parameters,Statistics,LinearAlgebra

# Initial conditions
C = Chain();
S = Simulator();

#########################################################################################################

PhiConstr = kron(Diagonal(ones(C.NBeads))[1:C.ConstrainedBeads,:],ones(Float64,length(C.Patt))');
PsiConstr = kron(Diagonal(ones(C.NBeads))[1:C.ConstrainedBeads,:],C.MassPatt'./C.BeadMass);
ZetaConstr = Diagonal(ones(C.NPart))-PsiConstr'PhiConstr;

#########################################################################################################

P0,Q0,F0 = InitConds(C);

(StressMoments,Portho,Qortho) = ConstrSampleLangDyn(P0,Q0,C,S);

MomentSamples = SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1,S.Moments);
ii=1;
p=1;
MomentSamples[ii,:,:] = remotecall_fetch(ConstrSampleLangDyn,p,P0,Q0,C,S,0)[1];
# NB:ConstrSampleLangDyn returns a Tuple and remotecall_fetch()[1] returns the first value of this Tuple

############################################################################################################

EpsPatt = (sqrt.(C.LEps)*C.LTotPatt+sqrt.(C.SEps)*C.STotPatt).*circshift(sqrt.(C.LEps)*C.LTotPatt+sqrt.(C.SEps)*C.STotPatt,-1)
