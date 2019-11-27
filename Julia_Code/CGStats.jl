################################################################################
# Module CGStats
################################################################################
module CGStats

# Include relevant modules
using Main.LJChain, Distributed, SharedArrays, Parameters, Statistics, Dates, SparseArrays, LinearAlgebra, Printf

# Parameter object
export Simulator
# Functions to output raw trajectory data
export FullTraj, LangevinFullTraj, ConstrainedTraj, LangConstrainedTraj, ApproximateTraj, DetCGCanEnsTraj
# High-level function to extract data
export VEffConstrained, VEffConstrainedLangDyn, ConstrainedAutocorr, ConstrainedAutocorrLangDyn, FullAutocorr, FullAutocorrLangDyn, ApproximateAutocorr,
  ConstrainedAutocorrPar, ConstrainedAutocorrLangDynPar, FullAutocorrPar, FullAutocorrLangDynPar, ApproximateAutocorrPar
# Orthogonal dynamics sampling
export ConstrainedSample, ConstrSampleLangDyn
# Functions to extract approximate dynamics
export ApproxMeanForce, ApproxMeanForce_NEW, ApproxMeanStresses, ApproxMeanStresses_NEW, ApproxFlucStep, ComputeVEff

#######################################
# Simulator type, encoding parameters #
#######################################
@with_kw struct Simulator
  dt::Float64		  = 1e-4
  Stochdt::Float64	  = 1e-4
  FullSteps::Int	  = Int(1e5)
  OrthoSteps::Int 	  = 1
  ApproxSteps::Int	  = Int(1e5)
  FullTime::Float64	  = FullSteps*dt
  ApproxTime::Float64 = ApproxSteps*Stochdt
  LagStep			  = 400
  NumLags			  = 30
  MacroSamples::Int	  = 50
  OrthoSamples::Int	  = Int(1e5)
  Moments::Int		  = 2
  check::Int          = Int(5e3) # to print the number of iteration in a loop
end

#############################################
# Functions to generate raw trajectory data #
#############################################
"""
    (Pstore,Qstore,Fstore) = FullTraj(P0,Q0,C::Chain,S::Simulator)

    Outputs full trajectory data in matrices (Pstore,Qstore,Fstore).
"""
function FullTraj(P0,Q0,C::Chain,S::Simulator)
  # Report to user.
  println(Dates.now());
  println("Running full simulation and storing trajectory.");
  println("  NPart, number of particles simulated = ",C.NPart);
  println("  dt, time step size = ",S.dt," seconds.");
  println("  Total simulation time = ",S.FullTime," seconds.");

  # Set up.
  P = P0; Q = Q0; F = Forces(Q,C);
  Pstore = zeros(Float64,C.NPart,S.FullSteps);
  Qstore = zeros(Float64,C.NPart,S.FullSteps);
  Fstore = zeros(Float64,C.NPart,S.FullSteps);
  Pstore[:,1] = P0;
  Qstore[:,1] = Q0;
  Fstore[:,1] = F;

  # Do simulation.
  for i = 2:S.FullSteps
    (P,Q,F) = LeapfrogStep(P,Q,F,C,S.dt);
    Pstore[:,i] = P;
    Qstore[:,i] = Q;
    Fstore[:,i] = F;
  end

  return Pstore,Qstore,Fstore
end

"""
    (Pstore,Qstore,Fstore,Kmean,Hmean) = LangevinFullTraj(P0,Q0,C::Chain,S::Simulator)

    Outputs full trajectory data in matrices (Pstore,Qstore,Fstore) and the mean values of
	the kinetic energy and the total energy.
"""
function LangevinFullTraj(P0,Q0,C::Chain,S::Simulator)
  # Report to user.
  println(Dates.now());
  println("Running full simulation of Langevin dynamics, storing trajectory and computing");
  println("the mean values per particle of the kinetic energy and the total energy.");
  println("  NPart, number of particles simulated = ",C.NPart);
  println("  Beta, temperature parameter = ",C.Beta);
  println("  Gamma, friction coefficient = ",C.Gamma);
  println("  dt, time step size = ",S.dt);
  println("  Total simulation time = ",S.FullTime);

  # Set up.
  P = P0; Q = Q0; F = Forces(Q,C);
  K = KineticEnergy(P,C); H = Potential(Q,C) + K;

  r = Int(S.FullSteps/100) + 1;
  Pstore = zeros(Float64,C.NPart,r);
  Qstore = zeros(Float64,C.NPart,r);
  Fstore = zeros(Float64,C.NPart,r);
  Pstore[:,1] = P0;
  Qstore[:,1] = Q0;
  Fstore[:,1] = F;

  # Do simulation.
  j = 2;
  for i = 2:S.FullSteps
	  if i % S.check == 0
		  @printf "    ITERATION %0.3e OF %0.3e\n" i S.FullSteps
	  end
	  (P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt);
	  if i % 100 == 0
		  Pstore[:,j] = P;
	      Qstore[:,j] = Q;
	      Fstore[:,j] = F;
		  j += 1;
	  end
	  K += KineticEnergy(P,C);
	  H += Potential(Q,C) + K;
  end

  K /= S.FullSteps;
  H /= S.FullSteps;
  Kmean = sum(K)/C.NPart;
  Hmean = sum(H)/C.NPart;

  return Pstore,Qstore,Fstore,Kmean,Hmean
end

"""
    (Pstore,Qstore,Fstore) = ConstrainedTraj(P0,Q0,C::Chain,S::Simulator)

    Outputs full trajectory data in matrices (Pstore,Qstore,Fstore).
"""
function ConstrainedTraj(P0,Q0,C::Chain,S::Simulator)
  # Report to user.
  println(now());
  println("Running full simulation and storing trajectory.");
  println("  NPart, number of particles simulated = ",C.NPart);
  println("  dt, time step size = ",S.dt," seconds.");
  println("  Total simulation time = ",S.FullTime," seconds.");

  # Set up.
  P = P0; Q = Q0; F = Forces(Q,C);
  Pstore = zeros(Float64,C.NPart,S.FullSteps);
  Qstore = zeros(Float64,C.NPart,S.FullSteps);
  Fstore = zeros(Float64,C.NPart,S.FullSteps);
  Pstore[:,1] = P0;
  Qstore[:,1] = Q0;
  Fstore[:,1] = F;

  # Do simulation.
  for i = 2:S.FullSteps
    (P,Q,F) = ConstrainedStep(P,Q,F,C,S.dt);
    Pstore[:,i] = P;
    Qstore[:,i] = Q;
    Fstore[:,i] = F;
  end

  return Pstore,Qstore,Fstore
end

"""
    (Pstore,Qstore,Fstore) = LangConstrainedTraj(P0,Q0,C::Chain,S::Simulator)

    Outputs full trajectory data in matrices (Pstore,Qstore,Fstore).
"""
function LangConstrainedTraj(P0,Q0,C::Chain,S::Simulator)
  # Report to user.
  println(Dates.now());
  println("Running full simulation of constrained Langevin dynamics and storing trajectory");
  println("  NPart, number of particles simulated = ",C.NPart);
  println("  Beta, temperature parameter = ",C.Beta);
  println("  Gamma, friction coefficient = ",C.Gamma);
  println("  dt, time step size = ",S.dt," seconds.");
  println("  Total simulation time = ",S.FullTime," seconds.");

  # Set up.
  P = C.MomProj*P0; Q = Q0; F = Forces(Q,C);

  r = Int(S.FullSteps/100) + 1;
  Pstore = zeros(Float64,C.NPart,r);
  Qstore = zeros(Float64,C.NPart,r);
  Fstore = zeros(Float64,C.NPart,r);
  Pstore[:,1] = P;
  Qstore[:,1] = Q;
  Fstore[:,1] = F;

  # Do simulation.
  j = 2;
  for i = 2:S.FullSteps
	  if i % S.check == 0
		  @printf "    ITERATION %0.3e OF %0.3e\n" i S.FullSteps
	  end
	  (P,Q,F) = LangDynConstrainedStep(P,Q,F,C,S.dt);
	  if i % 100 == 0
		  Pstore[:,j] = P;
		  Qstore[:,j] = Q;
		  Fstore[:,j] = F;
		  j += 1;
	  end
  end

  return Pstore,Qstore,Fstore
end

"""
    (Pstore,Qstore,Fstore) = ApproximateTraj(P0,Q0,dQData,FmeanData,FstdData,
    							S::Simulator,C::Chain)

    Outputs full trajectory data for approximate Langevin dynamics, using
    approximate potentials generated from data encoded in 3 vectors
    (dQData,FmeanData,FstdData).
"""
function ApproximateTraj(P0,Q0,dQData::Array{Float64,1},FmeanData::Array{Float64,1},FstdData::Array{Float64,1},C::Chain,S::Simulator)
 # Report to user.
 println(Dates.now());
 if sum(FstdData) == 0
	 println("Running full simulation of DCGD in NVE ensemble and storing trajectory.");
 else
	 println("Running full simulation of MMZD and storing trajectory.");
 end
 println("  NPart, number of particles simulated = ",C.NPart);
 println("  Beta, temperature parameter = ",C.Beta);
 println("  Gamma, friction coefficient = ",C.Gamma);
 println("  dt, time step size = ",S.Stochdt);
 println("  Total simulation time = ",S.ApproxTime);

  # Set up initial conditions
  P = P0; Q = Q0;

  # Generate mean force function
  MeanForce = X -> ApproxMeanForce(X,dQData,FmeanData,C)[1];
  F = MeanForce(Q0);

  # Set up approximate fluctuation generator
  FlucStep = (X,Y) -> ApproxFlucStep(X,Y,dQData,FstdData,C,S.Stochdt)[1];

  # Set up storage
  r = Int(S.ApproxSteps/100) + 1;
  Pstore = zeros(r,length(P0));
  Qstore = zeros(r,length(P0));
  Fstore = zeros(r,length(P0));
  Pstore[1,:] = P;
  Qstore[1,:] = Q;
  Fstore[1,:] = F;

  # Do simulation.
  j =2;
  for i = 2:S.ApproxSteps
	if i % S.check == 0
		@printf "    ITERATION %0.3e OF %0.3e\n" i S.ApproxSteps
	end
    (P,Q,F) = ApproxDynStep(P,Q,F,MeanForce,FlucStep,C,S.Stochdt);
	if i % 100 == 0
		Pstore[j,:] = P;
	    Qstore[j,:] = Q;
	    Fstore[j,:] = F;
		j += 1;
	end
  end

  return Pstore,Qstore,Fstore
end

"""
    (Pstore,Qstore,Fstore) = DetCGCanEnsTraj(P0,Q0,FmeanData,C::Chain,S::Simulator)

    Outputs full trajectory data for Deterministi CG dynamics in the canonical ensemble, using approximate potential generated
    by the data encoded in FmeanData. Where Fmeandata are the coefficients for the cubic spline interpolation. These coefficients
	are generated from kriging interpolation data, generated separately to eliminate noise from the original Mean Force data.
	(Kriging interpolation is done in the folder Julia_Code/Code_Tests/Interpolation by the script TestMeanForce_weights.jl)
	We do all this to speed up the DCGD, because the cubic spline interpolation is much faster than the Kriging interpolation.
"""
function DetCGCanEnsTraj(P0,Q0,FmeanData::Array{Float64,2},C::Chain,S::Simulator)
 # Report to user.
 println(Dates.now());
 println("Running full simulation of DCGD in NVT ensemble and storing trajectory.");
 println("  NPart, number of particles simulated = ",C.NPart);
 println("  Beta, temperature parameter = ",C.Beta);
 println("  Gamma, friction coefficient = ",C.Gamma);
 println("  dt, time step size = ",S.dt);
 println("  Total simulation time = ",S.FullTime);

  # Set up initial conditions
  P = P0; Q = Q0;

  # Generate mean force function
  MeanForce = X -> ApproxMeanForce_NEW(X,FmeanData,C)[1];
  F = MeanForce(Q0);

  # Set up storage
  r = Int(S.FullSteps/100) + 1
  Pstore = zeros(r,length(P0));
  Qstore = zeros(r,length(P0));
  Fstore = zeros(r,length(P0));
  Pstore[1,:] = P;
  Qstore[1,:] = Q;
  Fstore[1,:] = F;

  # Do simulation.
  j = 2;
  for i = 2:S.FullSteps
	  if i % S.check == 0
		  @printf "    ITERATION %0.2e OF %0.2e\n" i S.FullSteps
	  end
	  (P,Q,F) = DetCGDynNVTStep(P,Q,F,MeanForce,C,S.dt);
	  if i % 100 == 0
		  Pstore[j,:] = P;
		  Qstore[j,:] = Q;
		  Fstore[j,:] = F;
		  j += 1;
	  end
  end

  return Pstore,Qstore,Fstore
end

################################
# Orthogonal dynamics sampling #
################################
function ConstrainedSample(P::Array{Float64,1},Q::Array{Float64,1},C::Chain,S::Simulator,Obs=(P,Q,C) -> 0)

  # Mean Forces
  StressMoments = zeros(C.ConstrainedBeads-1,S.Moments);

  #PCG = C.PhiConstr*P;
  #QCG = C.PsiConstr*Q;
  #E0  = Potential(Q,C);
  F   = Forces(Q,C);
  #H0  = E0 + KineticEnergy(P,C);

  s = 0;
  ObsMean = 0;
  while s < S.OrthoSamples
    # Run simulation to generate point with same QCG. (Constrained dynamics)
    for i = 1:S.OrthoSteps
      (P,Q,F) = ConstrainedStep(P,Q,F,C,S.dt);
    end

    # Record successful sample.
    s+=1;
    SigmaCG = C.PhiFConstr*Stresses(Q,C);
    for j = 1:S.Moments
      StressMoments[:,j] += SigmaCG.^j;
    end
    # ObsMean += Obs(P,Q,C); ## TODO FIX THIS CALL
  end

  # ObsMean /= S.OrthoSamples;
  # Efinal = Potential(Q,C);
  # Hfinal = Efinal + KineticEnergy(P,C);

  #println("        Error in momentum constraint = ",maximum(abs.(PCG-C.PhiConstr*P)));
  #println("        Error in position constraint = ",maximum(abs.(QCG-C.PsiConstr*Q)));
  #println("        Relative error in energy     = ",abs(Hfinal/H0-1));
  #if Obs!=0
  #  println("        Value of observable          = ",ObsMean);
  #end

  StressMoments ./= S.OrthoSamples
  return StressMoments,P,Q
end

function ConstrSampleLangDyn(P::Array{Float64,1},Q::Array{Float64,1},C::Chain,S::Simulator,Obs=(P,Q,C) -> 0)

  # Mean Forces
  StressMoments = zeros(C.ConstrainedBeads-1,S.Moments);

  #PCG = C.PhiConstr*P;
  #QCG = C.PsiConstr*Q;
  #E0  = Potential(Q,C);
  F   = Forces(Q,C);
  #H0  = E0 + KineticEnergy(P,C);

  s = 0;
  ObsMean = 0;
  while s < S.OrthoSamples
    # Run simulation to generate point with same QCG. (Constrained dynamics)
    for i = 1:S.OrthoSteps
      (P,Q,F) = LangDynConstrainedStep(P,Q,F,C,S.dt);
    end

    # Record successful sample.
    s+=1;
    SigmaCG = C.PhiFConstr*Stresses(Q,C);
    for j = 1:S.Moments
      StressMoments[:,j] += SigmaCG.^j;
    end
    # ObsMean += Obs(P,Q,C); ## TODO FIX THIS CALL
  end

  # ObsMean /= S.OrthoSamples;
  # Efinal = Potential(Q,C);
  # Hfinal = Efinal + KineticEnergy(P,C);

  # println("        Error in momentum constraint = ",maximum(abs.(PCG-C.PhiConstr*P)));
  # println("        Error in position constraint = ",maximum(abs.(QCG-C.PsiConstr*Q)));
  # println("        Relative error in energy     = ",abs(Hfinal/H0-1));
  # if Obs!=0
   # println("        Value of observable          = ",ObsMean);
  # end

  StressMoments ./= S.OrthoSamples
  return StressMoments,P,Q
end

function ConstrainedAutocorr(P::Array{Float64,1},Q::Array{Float64,1},C::Chain,S::Simulator)

  # Mean Forces
  StressStats 	= zeros(S.NumLags,C.ConstrainedBeads-1);
  StressStorage = zeros(S.NumLags,C.ConstrainedBeads-1);
  StressMean   	= zeros(C.ConstrainedBeads-1);
  StressSqMean 	= zeros(C.ConstrainedBeads-1);
  MomStats    	= zeros(S.NumLags,C.ConstrainedBeads);
  MomStorage 	= zeros(S.NumLags,C.ConstrainedBeads);
  MomMean	    = zeros(C.ConstrainedBeads);
  MomSqMean 	= zeros(C.ConstrainedBeads);

  E0  = Potential(Q,C);
  F   = Forces(Q,C);
  H0  = E0 + KineticEnergy(P,C);

  # first run the dynamics for one window
    m = 0;
    while m < S.NumLags
        for i = 1:S.LagStep
          (P,Q,F) = ConstrainedStep(P,Q,F,C,S.dt);
        end

        m+=1;

        SigmaCG = C.PhiFConstr*Stresses(Q,C);
        StressStorage = circshift(StressStorage,(1,0));
        StressStorage[1,:] = SigmaCG;

        PCG = C.PhiConstr*P;
        MomStorage = circshift(MomStorage,(1,0));
        MomStorage[1,:] = PCG;
    end

  # Now start sampling
  s=0;

  while s < S.OrthoSamples
    # Advance to next sample time
    for i = 1:S.LagStep
      (P,Q,F) = ConstrainedStep(P,Q,F,C,S.dt);
    end

    # Record successful sample.
    s+=1;

    # Update stress storage
    SigmaCG = C.PhiFConstr*Stresses(Q,C);
    StressStorage = circshift(StressStorage,(1,0));
    StressStorage[1,:] = SigmaCG;

    # Update moment estimators
    StressMean += SigmaCG;
    StressSqMean += SigmaCG.^2;

    # Update momentum storage
    PCG = C.PhiConstr*P;
    MomStorage = circshift(MomStorage,(1,0));
    MomStorage[1,:] = PCG;

    # Update moment estimators
    MomMean += PCG;
    MomSqMean += PCG.^2;

    # Add to estimator of expectation of product
    StressStats += StressStorage.*kron(SigmaCG',ones(S.NumLags));
    MomStats += MomStorage.*kron(PCG',ones(S.NumLags));
  end

  StressMean /= S.OrthoSamples;
  StressSqMean /= S.OrthoSamples;
  MomMean /= S.OrthoSamples;
  MomSqMean /= S.OrthoSamples;

  StressStats /= S.OrthoSamples;
  MomStats /= S.OrthoSamples;

  # Efinal = Potential(Q,C);
  # Hfinal = Efinal + KineticEnergy(P,C);

  # println("        Error in momentum constraint = ",maximum(abs(PCG-C.PhiConstr*P)));
  # println("        Error in position constraint = ",maximum(abs(QCG-C.PsiConstr*Q)));
  # println("        Relative error in energy     = ",abs(Hfinal/H0-1));
  # if Obs!=0
   # println("        Value of observable          = ",ObsMean);
  # end

  return StressStats,StressMean,StressSqMean,MomStats,MomMean,MomSqMean
end

function ConstrainedAutocorrLangDyn(P::Array{Float64,1},Q::Array{Float64,1},C::Chain,S::Simulator)

  # Mean Forces
  StressStats 	= zeros(S.NumLags,C.ConstrainedBeads-1);
  StressStorage = zeros(S.NumLags,C.ConstrainedBeads-1);
  StressMean   	= zeros(C.ConstrainedBeads-1);
  StressSqMean 	= zeros(C.ConstrainedBeads-1);
  MomStats    	= zeros(S.NumLags,C.ConstrainedBeads);
  MomStorage 	= zeros(S.NumLags,C.ConstrainedBeads);
  MomMean	    = zeros(C.ConstrainedBeads);
  MomSqMean 	= zeros(C.ConstrainedBeads);

  # E0  = Potential(Q,C);
  F   = Forces(Q,C);
  # H0  = E0 + KineticEnergy(P,C);

  # first run the dynamics for one window
    m = 0;
    while m < S.NumLags
        for i = 1:S.LagStep
          (P,Q,F) = LangDynConstrainedStep(P,Q,F,C,S.dt);
        end

        m+=1;

        SigmaCG = C.PhiFConstr*Stresses(Q,C);
        StressStorage = circshift(StressStorage,(1,0));
        StressStorage[1,:] = SigmaCG;

        PCG = C.PhiConstr*P;
        MomStorage = circshift(MomStorage,(1,0));
        MomStorage[1,:] = PCG;
    end

  # Now start sampling
  s=0;

  while s < S.OrthoSamples
    # Advance to next sample time
    for i = 1:S.LagStep
      (P,Q,F) = LangDynConstrainedStep(P,Q,F,C,S.dt);
    end

    # Record successful sample.
    s+=1;

    # Update stress storage
    SigmaCG = C.PhiFConstr*Stresses(Q,C);
    StressStorage = circshift(StressStorage,(1,0));
    StressStorage[1,:] = SigmaCG;

    # Update moment estimators
    StressMean += SigmaCG;
    StressSqMean += SigmaCG.^2;

    # Update momentum storage
    PCG = C.PhiConstr*P;
    MomStorage = circshift(MomStorage,(1,0));
    MomStorage[1,:] = PCG;

    # Update moment estimators
    MomMean += PCG;
    MomSqMean += PCG.^2;

    # Add to estimator of expectation of product
    StressStats += StressStorage.*kron(SigmaCG',ones(S.NumLags));
    MomStats += MomStorage.*kron(PCG',ones(S.NumLags));
  end

  StressMean /= S.OrthoSamples;
  StressSqMean /= S.OrthoSamples;
  MomMean /= S.OrthoSamples;
  MomSqMean /= S.OrthoSamples;

  StressStats /= S.OrthoSamples;
  MomStats /= S.OrthoSamples;

  # Efinal = Potential(Q,C);
  # Hfinal = Efinal + KineticEnergy(P,C);

  # println("        Error in momentum constraint = ",maximum(abs(PCG-C.PhiConstr*P)));
  # println("        Error in position constraint = ",maximum(abs(QCG-C.PsiConstr*Q)));
  # println("        Relative error in energy     = ",abs(Hfinal/H0-1));
  # if Obs!=0
   # println("        Value of observable          = ",ObsMean);
  # end

  return StressStats,StressMean,StressSqMean,MomStats,MomMean,MomSqMean
end

###################################
# Full Trajectory Autocorrelation #
###################################
function FullAutocorr(P::Array{Float64,1},Q::Array{Float64,1},C::Chain,S::Simulator,MeanForce)

  # Mean Forces
  StressStats 	= zeros(S.NumLags,C.NBeads);
  StressStorage = zeros(S.NumLags,C.NBeads);
  StressMean   	= zeros(C.NBeads);
  StressSqMean 	= zeros(C.NBeads);
  MomStats    	= zeros(S.NumLags,C.NBeads);
  MomStorage 	= zeros(S.NumLags,C.NBeads);
  MomMean	= zeros(C.NBeads);
  MomSqMean = zeros(C.NBeads);

  E0  = Potential(Q,C);
  F   = Forces(Q,C);
  H0  = E0 + KineticEnergy(P,C);

  # first run the dynamics for one window
    m = 0;
    while m < S.NumLags
        for i = 1:S.LagStep
          (P,Q,F) = LeapfrogStep(P,Q,F,C,S.dt);
        end

        m+=1;

        FCG = MeanForce(C.Psi*Q);
	    SigmaCG = C.PhiF*Stresses(Q,C)-FCG;
	    StressStorage = circshift(StressStorage,(1,0));
        StressStorage[1,:] = SigmaCG;

        PCG = C.Phi*P;
        MomStorage = circshift(MomStorage,(1,0));
        MomStorage[1,:] = PCG;
    end


    # Now start sampling
    s=0;

    while s < S.OrthoSamples
      # Advance to next sample time
      for i = 1:S.LagStep
        (P,Q,F) = LeapfrogStep(P,Q,F,C,S.dt);
      end

      # Record successful sample.
      s+=1;

      # Update stress storage
      FCG = MeanForce(C.Psi*Q);
      SigmaCG = C.PhiF*Stresses(Q,C)-FCG;
      StressStorage = circshift(StressStorage,(1,0));
      StressStorage[1,:] = SigmaCG;

      # Update stress estimators
      StressMean += SigmaCG;
      StressSqMean += SigmaCG.^2

      # Update momentum storage
      PCG = C.Phi*P;
      MomStorage = circshift(MomStorage,(1,0));
      MomStorage[1,:] = PCG;

      # Update moment estimators
      MomMean += PCG;
      MomSqMean += PCG.^2

      # Add to estimator of expectation of product
      StressStats += StressStorage.*kron(SigmaCG',ones(S.NumLags));
      MomStats += MomStorage.*kron(PCG',ones(S.NumLags));
    end

    StressMean /= S.OrthoSamples;
    StressSqMean /= S.OrthoSamples;
    MomMean /= S.OrthoSamples;
    MomSqMean /= S.OrthoSamples;

    StressStats /= S.OrthoSamples;
    MomStats /= S.OrthoSamples;

    # Efinal = Potential(Q,C);
    # Hfinal = Efinal + KineticEnergy(P,C);

    # println("        Error in momentum constraint = ",maximum(abs(PCG-C.PhiConstr*P)));
    # println("        Error in position constraint = ",maximum(abs(QCG-C.PsiConstr*Q)));
    # println("        Relative error in energy     = ",abs(Hfinal/H0-1));
    # if Obs!=0
     # println("        Value of observable          = ",ObsMean);
    # end

    return StressStats,StressMean,StressSqMean,MomStats,MomMean,MomSqMean
end

function FullAutocorrLangDyn(P::Array{Float64,1},Q::Array{Float64,1},C::Chain,S::Simulator,MeanForce)

  # Mean Forces
  StressStats 	= zeros(S.NumLags,C.NBeads);
  StressStorage = zeros(S.NumLags,C.NBeads);
  StressMean   	= zeros(C.NBeads);
  StressSqMean 	= zeros(C.NBeads);
  MomStats    	= zeros(S.NumLags,C.NBeads);
  MomStorage 	= zeros(S.NumLags,C.NBeads);
  MomMean	= zeros(C.NBeads);
  MomSqMean = zeros(C.NBeads);

  # E0  = Potential(Q,C);
  F   = Forces(Q,C);
  # H0  = E0 + KineticEnergy(P,C);

  # first run the dynamics for one window
    m = 0;
    while m < S.NumLags
        for i = 1:S.LagStep
          (P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt);
        end

        m+=1;

        FCG = MeanForce(C.Psi*Q);
        SigmaCG = C.PhiF*Stresses(Q,C)-FCG;
		# SigmaCG = C.PhiF*Stresses(Q,C);
        StressStorage = circshift(StressStorage,(1,0));
        StressStorage[1,:] = SigmaCG;

        PCG = C.Phi*P;
        MomStorage = circshift(MomStorage,(1,0));
        MomStorage[1,:] = PCG;
    end


    ### Now start sampling
    s=0;

    while s < S.OrthoSamples
      # Advance to next sample time
      for i = 1:S.LagStep
        (P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt);
      end

      # Record successful sample.
      s+=1;

      # Update STRESS storage
      FCG = MeanForce(C.Psi*Q);
      SigmaCG = C.PhiF*Stresses(Q,C)-FCG;
	  # SigmaCG = C.PhiF*Stresses(Q,C);
      StressStorage = circshift(StressStorage,(1,0));
      StressStorage[1,:] = SigmaCG;

      # Update STRESS estimators
      StressMean += SigmaCG;
      StressSqMean += SigmaCG.^2;

      # Update MOMENTUM storage
      PCG = C.Phi*P;
      MomStorage = circshift(MomStorage,(1,0));
      MomStorage[1,:] = PCG;

      # Update MOMENTUM estimators
      MomMean += PCG;
      MomSqMean += PCG.^2;

      # Add to estimator of expectation of product
      StressStats += StressStorage.*kron(SigmaCG',ones(S.NumLags));
      MomStats += MomStorage.*kron(PCG',ones(S.NumLags));
    end

    StressMean /= S.OrthoSamples;
    StressSqMean /= S.OrthoSamples;
    MomMean /= S.OrthoSamples;
    MomSqMean /= S.OrthoSamples;

    StressStats /= S.OrthoSamples;
    MomStats /= S.OrthoSamples;

    # Efinal = Potential(Q,C);
    # Hfinal = Efinal + KineticEnergy(P,C);

    # println("        Error in momentum constraint = ",maximum(abs(PCG-C.PhiConstr*P)));
    # println("        Error in position constraint = ",maximum(abs(QCG-C.PsiConstr*Q)));
    # println("        Relative error in energy     = ",abs(Hfinal/H0-1));
    # if Obs!=0
     # println("        Value of observable          = ",ObsMean);
    # end

    return StressStats,StressMean,StressSqMean,MomStats,MomMean,MomSqMean
end

function ApproximateAutocorr(P::Array{Float64,1},Q::Array{Float64,1},
							C::Chain,S::Simulator,dQData::Array{Float64,1},FmeanData::Array{Float64,1},FstdData::Array{Float64,1})
  # Generate mean force function
  MeanForce = X -> ApproxMeanForce(X,dQData,FmeanData,C)[1];
  F = MeanForce(Q);

  # Set up approximate fluctuation generator
  FlucStep = (X,Y) -> ApproxFlucStep(X,Y,dQData,FstdData,C,S.Stochdt)[1];

  # Mean Forces
  StressStats 	= zeros(S.NumLags,C.NBeads);
  StressStorage = zeros(S.NumLags,C.NBeads);
  StressMean   	= zeros(C.NBeads);
  StressSqMean 	= zeros(C.NBeads);
  MomStats    	= zeros(S.NumLags,C.NBeads);
  MomStorage 	= zeros(S.NumLags,C.NBeads);
  MomMean       = zeros(C.NBeads);
  MomSqMean 	= zeros(C.NBeads);



  # first run the dynamics for one window
    m = 0;
    while m < S.NumLags
        for i = 1:S.LagStep
          (P,Q,F) = ApproxDynStep(P,Q,F,MeanForce,FlucStep,C,S.Stochdt);
        end

        m+=1;

        SigmaCG = circshift(F,-1)-F;
        StressStorage = circshift(StressStorage,(1,0));
        StressStorage[1,:] = SigmaCG;

        PCG = P;
        MomStorage = circshift(MomStorage,(1,0));
        MomStorage[1,:] = PCG;
    end

  # Now start sampling
  s=0;

  while s < S.OrthoSamples
    # Advance to next sample time
    for i = 1:S.LagStep
      (P,Q,F) = ApproxDynStep(P,Q,F,MeanForce,FlucStep,C,S.Stochdt);
    end

    # Record successful sample.
    s+=1;

    # Update stress storage
    SigmaCG = circshift(F,-1)-F;
    StressStorage = circshift(StressStorage,(1,0));
    StressStorage[1,:] = SigmaCG;

    # Update moment estimators
    StressMean += SigmaCG;
    StressSqMean += SigmaCG.^2;

    # Update momentum storage
    PCG = P;
    MomStorage = circshift(MomStorage,(1,0));
    MomStorage[1,:] = PCG;

    # Update moment estimators
    MomMean += PCG;
    MomSqMean += PCG.^2

    # Add to estimator of expectation of product
    StressStats += StressStorage.*kron(SigmaCG',ones(S.NumLags));
    MomStats += MomStorage.*kron(PCG',ones(S.NumLags));
  end

  StressMean /= S.OrthoSamples;
  StressSqMean /= S.OrthoSamples;
  MomMean /= S.OrthoSamples;
  MomSqMean /= S.OrthoSamples;

  StressStats /= S.OrthoSamples;
  MomStats /= S.OrthoSamples;

  # Efinal = Potential(Q,C);
  # Hfinal = Efinal + KineticEnergy(P,C);

  # println("        Error in momentum constraint = ",maximum(abs(PCG-C.PhiConstr*P)));
  # println("        Error in position constraint = ",maximum(abs(QCG-C.PsiConstr*Q)));
  # println("        Relative error in energy     = ",abs(Hfinal/H0-1));
  # if Obs!=0
	  # println("        Value of observable          = ",ObsMean);
  # end

  return StressStats,StressMean,StressSqMean,MomStats,MomMean,MomSqMean
end

####################################
# Functions to compute observables #
####################################
"""
    Observables(P,Q,C::Chain)


"""
function Observables(P,Q,C::Chain)

  Obs = (circshift(Q,-1) - Q) - C.Dist;
  Obs[end] += C.Period;

  return [mean(Obs),dot(Obs,Obs)/C.NPart]
end

"""
    CGObservables(P,Q,C::Chain)


"""
function CGObservables(P,Q,C::Chain)

  Obs = (circshift(C.Psi*Q,-1) - C.Psi*Q) - C.BeadsDist;
  Obs[end] += C.Period;

  return [mean(Obs),dot(Obs,Obs)/C.NBeads]
end

###################################
# High-level simulation functions #
###################################
function VEffConstrained(C::Chain,S::Simulator)
  println("Computing coarse graining through constrained dynamics ...");
  if S.dt > 0.1*sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt));
    warn("Timestep = ",S.dt,
      " not ≪  shortest timescale = ",sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt)));
  end

  # Generate initial condition
  (P,Q,F,H,PCG,QCG) = InitConds(C);

  # Set up storage
  RSamples 	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1);
  PSamples 	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1);
  MomentSamples = SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1,S.Moments);

  # Perform sampling
  np = nprocs();
  ss = 0;

  @sync begin
    while ss < S.MacroSamples
      for p=1:np
        if p != myid() || np == 1
          if ss == S.MacroSamples
            break;
          end
          println("    Starting macrosample ", ss+1);
          for i = 1:S.FullSteps
            (P,Q,F) = LeapfrogStep(P,Q,F,C,S.dt);
          end

          ss+=1;

          @async begin
            ii = ss;
            PP = P;
            QQ = Q;
            # Get distances between CG particles
            println("      Sample ",ii,"  over fine-grained variables...");
            RSamples[ii,:] = CGDists(QQ,C);
            PSamples[ii,:] = C.PsiFConstr*PP;
            # Print max: if it gets too large, the integrator becomes unstable.
            println("        Maximum distance = ",maximum(RSamples[ii,:]));
            MomentSamples[ii,:,:] = remotecall_fetch(ConstrainedSample,p,PP,QQ,C,S,CGStats.Observables)[1];
			# NB:the function "ConstrainedSample" returns a Tuple and "remotecall_fetch()[1]" returns the first value of this Tuple.
            println("      Sample ",ii," complete!");
          end
        end
      end
    end
  end
  println(" ...ComputeVEff done!");

  return ComputeVEff(RSamples,PSamples,MomentSamples)
end

function VEffConstrainedLangDyn(C::Chain,S::Simulator)
  println("Computing coarse graining through constrained Langevin dynamics ...")
  if S.dt > 0.1*sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt));
    warn("Timestep = ",S.dt,
      " not ≪  shortest timescale = ",sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt)));
  end

  # Generate initial condition
  (P,Q,F,H,PCG,QCG) = InitConds(C);

  # Set up storage
  RSamples 	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1);
  PSamples 	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1);
  MomentSamples = SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1,S.Moments);

  # Perform sampling
  np = nprocs();
  ss = 0;

  @sync begin
    while ss < S.MacroSamples
      for p=1:np
        if p != myid() || np == 1
          if ss == S.MacroSamples
            break
          end
          println("    Starting macrosample ", ss+1);
          for i = 1:S.FullSteps
			  if i % S.check == 0
				  @printf "      ITERATION %0.3e OF %0.3e\n" i S.FullSteps
			  end
			  (P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt);
          end

          ss+=1;

          @async begin
            ii = ss;
            PP = P;
            QQ = Q;
            # Get distances between CG particles
            println("      Sample ",ii,"  over fine-grained variables...");
            RSamples[ii,:] = CGDists(QQ,C);
            PSamples[ii,:] = C.PsiFConstr*PP;
            # Print max: if it gets too large, the integrator becomes unstable.
            println("        Maximum distance = ",maximum(RSamples[ii,:]));
            MomentSamples[ii,:,:] = remotecall_fetch(ConstrSampleLangDyn,p,PP,QQ,C,S,CGStats.Observables)[1];
			# NB:the function "ConstrSampleLangDyn" returns a Tuple and "remotecall_fetch()[1]" returns the first value of this Tuple.
            println("      Sample ",ii," complete!");
          end
        end
      end
    end
  end
  println(" ...ComputeVEff done!")

  return ComputeVEff(RSamples,PSamples,MomentSamples)
end


function ConstrainedAutocorrPar(C::Chain,S::Simulator)
  if S.dt > 0.1*sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt));
    warn("Timestep = ",S.dt,
      " not ≪  shortest timescale = ",sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt)));
  end

  # Generate initial condition
  (P,Q,F,H,PCG,QCG) = InitConds(C);

  println("Equilibration ");
  # Run in to equilibrate
  for i = 1:S.FullSteps
    P,Q,F = LeapfrogStep(P,Q,F,C,S.dt)
  end
  println("Equilibration done");


  # Set up storage
  StressStats 	= SharedArray{Float64}(S.MacroSamples,S.NumLags,C.ConstrainedBeads-1);
  StressMean   	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1);
  StressSqMean 	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1);
  MomStats  = SharedArray{Float64}(S.MacroSamples,S.NumLags,C.ConstrainedBeads);
  MomMean	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads);
  MomSqMean = SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads);


  # Perform sampling
  np = nprocs()
  ss = 0

  println("Macrosampling ");
  @sync begin
    while ss < S.MacroSamples
      for p=1:np
        if p != myid() || np == 1
          if ss == S.MacroSamples
            break
          end
          println("    Starting macrosample ", ss+1);
          for i = 1:S.FullSteps
            (P,Q,F) = LeapfrogStep(P,Q,F,C,S.dt)
          end

          ss+=1;

          @async begin
            ii = ss;
            PP = P;
            QQ = Q;
            # Get distances between CG particles
            println("      Sample ",ii,"  over fine-grained variables...");
            # RSamples[ii,:] = CGDists(QQ,C);
            # PSamples[ii,:] = C.PsiFConstr*PP;
            # Print max: if it gets too large, the integrator becomes unstable.
            # println("        Maximum distance = ",maximum(RSamples[ii,:]));
            (StressStats[ii,:,:],StressMean[ii,:],StressSqMean[ii,:],MomStats[ii,:,:],MomMean[ii,:,:],MomSqMean[ii,:]) = remotecall_fetch(ConstrainedAutocorr,p,PP,
            					    QQ,C,S);
            println("      Sample ",ii," complete!");
          end
        end
      end
    end
  end

  # Now compute autocorrelations
  StressAutocorr = zeros(S.MacroSamples,S.NumLags,C.ConstrainedBeads-1)
  for i=1:S.NumLags
      StressAutocorr[:,i,:] = (StressStats[:,i,:].-StressMean[:,:].^2)./(StressSqMean[:,:].-StressMean[:,:].^2);
  end
  StressAutocorr = mean(mean(StressAutocorr,dims=1),dims=3);
  StressAutocorr = reshape(StressAutocorr,length(StressAutocorr));

  MomAutocorr = zeros(S.MacroSamples,S.NumLags,C.ConstrainedBeads)
  for i=1:S.NumLags
      MomAutocorr[:,i,:] = (MomStats[:,i,:].-MomMean[:,:].^2)./(MomSqMean[:,:].-MomMean[:,:].^2);
  end
  MomAutocorr = mean(mean(MomAutocorr,dims=1),dims=3);
  MomAutocorr = reshape(MomAutocorr,length(MomAutocorr));

  println(" ConstrainedAutocorrPar Done!")

  return StressAutocorr, MomAutocorr
end

function ConstrainedAutocorrLangDynPar(C::Chain,S::Simulator)
  if S.dt > 0.1*sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt));
    warn("Timestep = ",S.dt,
      " not ≪ shortest timescale = ",sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt)));
  end

  # Generate initial condition
  (P,Q,F,H,PCG,QCG) = InitConds(C);

  println("Equilibration ");
  # Run in to equilibrate
  for i = 1:S.FullSteps
    (P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt)
  end
  println("Equilibration done");


  # Set up storage
  StressStats 	= SharedArray{Float64}(S.MacroSamples,S.NumLags,C.ConstrainedBeads-1);
  StressMean   	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1);
  StressSqMean 	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads-1);
  MomStats  = SharedArray{Float64}(S.MacroSamples,S.NumLags,C.ConstrainedBeads);
  MomMean	= SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads);
  MomSqMean = SharedArray{Float64}(S.MacroSamples,C.ConstrainedBeads);


  # Perform sampling
  np = nprocs()
  ss = 0

  println("Macrosampling ");
  @sync begin
    while ss < S.MacroSamples
      for p=1:np
        if p != myid() || np == 1
          if ss == S.MacroSamples
            break
          end
          println("    Starting macrosample ", ss+1);
          for i = 1:S.FullSteps
            (P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt)
          end

          ss+=1;

          @async begin
            ii = ss;
            PP = P;
            QQ = Q;
            # Get distances between CG particles
            println("      Sample ",ii,"  over fine-grained variables...");
            # RSamples[ii,:] = CGDists(QQ,C);
            # PSamples[ii,:] = C.PsiFConstr*PP;
            # Print max: if it gets too large, the integrator becomes unstable.
            # println("        Maximum distance = ",maximum(RSamples[ii,:]));
            (StressStats[ii,:,:],StressMean[ii,:],StressSqMean[ii,:],MomStats[ii,:,:],MomMean[ii,:,:],MomSqMean[ii,:]) =
			              remotecall_fetch(ConstrainedAutocorrLangDyn,p,PP,QQ,C,S);
            println("      Sample ",ii," complete!");
          end
        end
      end
    end
  end

  # Now compute autocorrelations
  StressAutocorr = zeros(S.MacroSamples,S.NumLags,C.ConstrainedBeads-1)
  for i=1:S.NumLags
      StressAutocorr[:,i,:] = (StressStats[:,i,:].-StressMean[:,:].^2)./(StressSqMean[:,:].-StressMean[:,:].^2);
  end
  StressAutocorr = mean(mean(StressAutocorr,dims=1),dims=3);
  StressAutocorr = reshape(StressAutocorr,length(StressAutocorr));

  MomAutocorr = zeros(S.MacroSamples,S.NumLags,C.ConstrainedBeads)
  for i=1:S.NumLags
      MomAutocorr[:,i,:] = (MomStats[:,i,:].-MomMean[:,:].^2)./(MomSqMean[:,:].-MomMean[:,:].^2);
  end
  MomAutocorr = mean(mean(MomAutocorr,dims=1),dims=3);
  MomAutocorr = reshape(MomAutocorr,length(MomAutocorr));

  println(" ConstrainedAutocorrParLangDyn Done!")

  return StressAutocorr, MomAutocorr
end

function FullAutocorrPar(C::Chain,S::Simulator,dQData::Array{Float64,1},FmeanData::Array{Float64,1})
  if S.dt > 0.1*sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt));
    warn("Timestep = ",S.dt,
      " not ≪  shortest timescale = ",sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt)));
  end

  # Generate initial condition
  (P,Q,F,H,PCG,QCG) = InitConds(C);

  # Generate mean force function
  MeanForce = X -> ApproxMeanStresses(X,dQData,FmeanData,C)[1];

  println("Equilibration ");
  # Run in to equilibrate
  for i = 1:S.FullSteps
    P,Q,F = LeapfrogStep(P,Q,F,C,S.dt)
  end
  println("Equilibration done");


  # Set up storage
  StressStats 	= SharedArray{Float64}(S.MacroSamples,S.NumLags,C.NBeads);
  StressMean   	= SharedArray{Float64}(S.MacroSamples,C.NBeads);
  StressSqMean  = SharedArray{Float64}(S.MacroSamples,C.NBeads);
  MomStats    	= SharedArray{Float64}(S.MacroSamples,S.NumLags,C.NBeads);
  MomMean	= SharedArray{Float64}(S.MacroSamples,C.NBeads);
  MomSqMean	= SharedArray{Float64}(S.MacroSamples,C.NBeads);


  # Perform sampling
  np = nprocs()
  ss = 0

  println("Macrosampling ");
  @sync begin
    while ss < S.MacroSamples
      for p=1:np
        if p != myid() || np == 1
          if ss == S.MacroSamples
            break
          end
          println("    Starting macrosample ", ss+1);
          for i = 1:S.FullSteps
            (P,Q,F) = LeapfrogStep(P,Q,F,C,S.dt)
          end

          ss+=1;

          @async begin
            ii = ss;
            PP = P;
            QQ = Q;
            # Get distances between CG particles
            println("      Sample ",ii,"  over fine-grained variables...");
            # RSamples[ii,:] = CGDists(QQ,C);
            # PSamples[ii,:] = C.PsiFConstr*PP;
            # Print max: if it gets too large, the integrator becomes unstable.
            # println("        Maximum distance = ",maximum(RSamples[ii,:]));
            (StressStats[ii,:,:],StressMean[ii,:],StressSqMean[ii,:],MomStats[ii,:,:],MomMean[ii,:],MomSqMean[ii,:]) = remotecall_fetch(FullAutocorr,p,PP,QQ,C,S,MeanForce);
            println("      Sample ",ii," complete!");
          end
        end
      end
    end
  end


  # Compute autocorrelations
  StressAutocorr = zeros(S.MacroSamples,S.NumLags,C.NBeads)
  for i=1:S.NumLags
      StressAutocorr[:,i,:] = (StressStats[:,i,:].-StressMean[:,:].^2)./(StressSqMean[:,:].-StressMean[:,:].^2);
  end
  StressAutocorr = mean(mean(StressAutocorr,dims=1),dims=3);
  StressAutocorr = reshape(StressAutocorr,length(StressAutocorr));

  MomAutocorr = zeros(S.MacroSamples,S.NumLags,C.NBeads)
  for i=1:S.NumLags
      MomAutocorr[:,i,:] = (MomStats[:,i,:].-MomMean[:,:].^2)./(MomSqMean[:,:].-MomMean[:,:].^2);
  end
  MomAutocorr = mean(mean(MomAutocorr,dims=1),dims=3);
  MomAutocorr = reshape(MomAutocorr,length(MomAutocorr));

  println(" FullAutocorrPar Done!")

  return StressAutocorr, MomAutocorr
end

# function FullAutocorrLangDynPar(C::Chain,S::Simulator,dQData::Array{Float64,1},FmeanData::Array{Float64,1})
function FullAutocorrLangDynPar(C::Chain,S::Simulator,FmeanData::Array{Float64,2})
  if S.dt > 0.1*sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt));
    warn("Timestep = ",S.dt,
      " not ≪ shortest timescale = ",sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt)));
  end

  # Generate initial condition
  (P,Q,F,H,PCG,QCG) = InitConds(C);

  # Generate mean force function
  # MeanForce = X -> ApproxMeanStresses(X,dQData,FmeanData,C)[1];
  MeanForce = X -> ApproxMeanStresses_NEW(X,FmeanData,C)[1];

  println("Equilibration ");
  # Run in to equilibrate
  for i = 1:S.FullSteps
    (P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt)
  end
  println("Equilibration done");


  # Set up storage
  StressStats 	= SharedArray{Float64}(S.MacroSamples,S.NumLags,C.NBeads);
  StressMean   	= SharedArray{Float64}(S.MacroSamples,C.NBeads);
  StressSqMean  = SharedArray{Float64}(S.MacroSamples,C.NBeads);
  MomStats    	= SharedArray{Float64}(S.MacroSamples,S.NumLags,C.NBeads);
  MomMean	= SharedArray{Float64}(S.MacroSamples,C.NBeads);
  MomSqMean	= SharedArray{Float64}(S.MacroSamples,C.NBeads);


  # Perform sampling
  np = nprocs()
  ss = 0

  println("Macrosampling ");
  @sync begin
    while ss < S.MacroSamples
      for p=1:np
        if p != myid() || np == 1
          if ss == S.MacroSamples
            break
          end
          println("    Starting macrosample ", ss+1);
          for i = 1:S.FullSteps
            (P,Q,F) = LangDynIntegrators(P,Q,F,C,S.dt)
          end

          ss+=1;

          @async begin
            ii = ss;
            PP = P;
            QQ = Q;
            # Get distances between CG particles
            println("      Sample ",ii,"  over fine-grained variables...");
            # RSamples[ii,:] = CGDists(QQ,C);
            # PSamples[ii,:] = C.PsiFConstr*PP;
            # Print max: if it gets too large, the integrator becomes unstable.
            # println("        Maximum distance = ",maximum(RSamples[ii,:]));
            (StressStats[ii,:,:],StressMean[ii,:],StressSqMean[ii,:],MomStats[ii,:,:],MomMean[ii,:],MomSqMean[ii,:]) =
			                                                                         remotecall_fetch(FullAutocorrLangDyn,p,PP,QQ,C,S,MeanForce);
            println("      Sample ",ii," complete!");
          end
        end
      end
    end
  end


  # Compute autocorrelations
  StressAutocorr = zeros(S.MacroSamples,S.NumLags,C.NBeads)
  for i=1:S.NumLags
      StressAutocorr[:,i,:] = (StressStats[:,i,:].-StressMean[:,:].^2)./(StressSqMean[:,:].-StressMean[:,:].^2);
  end
  StressAutocorr = mean(mean(StressAutocorr,dims=1),dims=3);
  StressAutocorr = reshape(StressAutocorr,length(StressAutocorr));

  MomAutocorr = zeros(S.MacroSamples,S.NumLags,C.NBeads)
  for i=1:S.NumLags
      MomAutocorr[:,i,:] = (MomStats[:,i,:].-MomMean[:,:].^2)./(MomSqMean[:,:].-MomMean[:,:].^2);
  end
  MomAutocorr = mean(mean(MomAutocorr,dims=1),dims=3);
  MomAutocorr = reshape(MomAutocorr,length(MomAutocorr));

  println(" FullAutocorrParLangDyn Done!")



  return StressAutocorr, MomAutocorr
end

function ApproximateAutocorrPar(C::Chain,S::Simulator,dQData::Array{Float64,1},FmeanData::Array{Float64,1},FstdData::Array{Float64,1})
  if S.dt > 0.1*sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt));
    warn("Timestep = ",S.dt,
      " not ≪  shortest timescale = ",sqrt.(minimum(C.MassPatt)/maximum(C.EpsPatt)));
  end

  # Set up storage
  StressStats 	= SharedArray{Float64}(S.MacroSamples,S.NumLags,C.NBeads);
  StressMean   	= SharedArray{Float64}(S.MacroSamples,C.NBeads);
  StressSqMean  = SharedArray{Float64}(S.MacroSamples,C.NBeads);
  MomStats    	= SharedArray{Float64}(S.MacroSamples,S.NumLags,C.NBeads);
  MomMean	= SharedArray{Float64}(S.MacroSamples,C.NBeads);
  MomSqMean	= SharedArray{Float64}(S.MacroSamples,C.NBeads);


  # Perform sampling
  np = nprocs()
  ss = 0

  println("Macrosampling ");
  @sync begin
    while ss < S.MacroSamples
      for p=1:np
        if p != myid() || np == 1
          if ss == S.MacroSamples
            break
          end
          println("    Starting macrosample ", ss+1);
          # Generate initial condition
          P = randn(C.NBeads);
          Q = [0.0:C.BeadsDist:C.BeadsDist*(C.NBeads-1);];
          ss+=1;

          @async begin
            ii = ss;
            PP = P;
            QQ = Q;
            # Get distances between CG particles
            println("      Sample ",ii,"  over fine-grained variables...");
            (StressStats[ii,:,:],StressMean[ii,:],StressSqMean[ii,:],MomStats[ii,:,:],MomMean[ii,:],MomSqMean[ii,:]) = remotecall_fetch(ApproximateAutocorr,p,PP,QQ,C,S,dQData,FmeanData,FstdData);
            println("      Sample ",ii," complete!");
          end
        end
      end
    end
  end


  # Compute autocorrelations
  StressAutocorr = zeros(S.MacroSamples,S.NumLags,C.NBeads)
  for i=1:S.NumLags
      StressAutocorr[:,i,:] = (StressStats[:,i,:].-StressMean[:,:].^2)./(StressSqMean[:,:].-StressMean[:,:].^2);
  end
  StressAutocorr = mean(mean(StressAutocorr,dims=1),dims=3);
  StressAutocorr = reshape(StressAutocorr,length(StressAutocorr));

  MomAutocorr = zeros(S.MacroSamples,S.NumLags,C.NBeads)
  for i=1:S.NumLags
      MomAutocorr[:,i,:] = (MomStats[:,i,:].-MomMean[:,:].^2)./(MomSqMean[:,:].-MomMean[:,:].^2);
  end
  MomAutocorr = mean(mean(MomAutocorr,dims=1),dims=3);
  MomAutocorr = reshape(MomAutocorr,length(MomAutocorr));

  println(" ApproximateAutocorrPar Done!")

  return StressAutocorr, MomAutocorr
end

###################
# Data processing #
###################
function ComputeVEff(R,P,M)
  l = length(R)

  RR = reshape(R[:,:],l)
  i = sortperm(RR)
  RR = RR[i];
  dR = circshift(RR,-1)-RR;

  PP = reshape(P[:,:],l)
  PP = PP[i];

  Fm = reshape(M[:,:,1],l);
  Fm = Fm[i];

  V = cumsum(0.5*(Fm+circshift(Fm,-1)).*dR);
  V = circshift(V,1);
  V[1] = 0.0;

  Fstd = reshape(sqrt.(M[:,:,2]-M[:,:,1].^2),l)
  Fstd = Fstd[i];
  return RR,PP,V,Fm,Fstd
end

##################################
# Potential generation functions #
##################################
"""
    F = ApproxMeanStresses(Q::Array{Float64,1},dQvals::Array{Float64,1},Fvals::Array{Float64,1},C::Chain)

	Generates approximate mean stresses based on precomputed data dQvals, Fvals and Chain parameters.
"""
function ApproxMeanStresses(Q::Array{Float64,1},dQvals::Array{Float64,1},Fvals::Array{Float64,1},C::Chain,σ::Float64=0.1,N::Int=2)

  Sigma = zeros(size(Q));

  ### First compute inter-bead distances.
  dQ = circshift(Q, -1) - Q;
  dQ[C.NBeads] += C.Period;
  # println("");
  # println("       INTER-BEAD DISTANCES COMPUTED IN ApproxMeanStresses");
  # println("       dQ = ",dQ);
  # println("");

  ### Next, for each inter-bead distance, compute the stress
  for i=1:length(dQ)
	  if dQ[i] < 0.9
		  m = (- 9620.78 + 11462.61) / (1.09-0.95);
		  q = -9620.78 - m * 1.09;

		  Sigma[i] = m * dQ[i] + q;
	  elseif dQ[i] > 3.78
		  ### Define (diagonal) weight matrix
		  # W = spdiagm(0 => exp.(-(dQvals .- 3.78) .^2 ./ σ^2));

		  ### Form Jacobian matrix
		  # J = ones(N+1, length(dQvals));
		  # for j = 1:N
			  # J[j+1, :] = (3.78 .- dQvals).^j;
		  # end

		  # K = J * W;
		  # c = (K * J') \ (K * Fvals);

		  Sigma[i] = 0; #c[1];
	  else
		  ### Define (diagonal) weight matrix
		  W = spdiagm(0 => exp.(-(dQvals .- dQ[i]) .^2 ./ σ^2));
		  # println(" ITERATION =",i," ; dQ = ",dQ[i]);
		  # println(" dQvals =",dQvals);
	  	  # println(" EXP = ",exp.(-(dQvals .- dQ[i]).^2 ./ σ^2));

	      ### Form Jacobian matrix
      	  J = ones(N+1, length(dQvals));
      	  for j = 1:N
			  J[j+1, :] = (dQ[i] .- dQvals).^j;
		  end

		  # println("       JACOBIAN MATRIX IN 	ApproxMeanStresses");
	  	  # println("       J = ",J);
	      K = J * W;
	  	  c = (K * J') \ (K * Fvals);

	      Sigma[i] = c[1];
	  end
  end

  return Sigma, dQ
end

function ApproxMeanStresses_NEW(Q::Array{Float64,1},Fdata::Array{Float64,2},C::Chain,σ::Float64=0.1,N::Int=2)

  Sigma = zeros(size(Q));

  ### First compute inter-bead distances.
  dQ = circshift(Q, -1) - Q;
  dQ[C.NBeads] += C.Period;

  Rmin = Fdata[1, 1];
  Rmax = Fdata[end, 1];
  dx = Fdata[2, 1] - Fdata[1, 1];
  inv_sqr_delta = 1. / (dx * dx);

  ### Next, for each inter-bead distance, compute the stress
  for i=1:length(dQ)
    if dQ[i] < Rmin
        m = 537.59;
        q = -1567.1;
        Sigma[i] = m * dQ[i] + q;
    elseif dQ[i] > Rmax
        Sigma[i] = 0.;
    else
        index = trunc(Int, (dQ[i] - Rmin) / dx) + 1;
        distance = dQ[i] - (Rmin + (index - 1) * dx);
        Sigma[i] = Fdata[index, 2] + distance * (Fdata[index, 3] + distance * (Fdata[index, 5] + distance * Fdata[index, 4]) * inv_sqr_delta);
    end
  end

  return Sigma, dQ
end

"""
    F, Sigma, dQ = ApproxMeanForce(Q::Array{Float64,1},dQvals::Array{Float64,1},Fvals::Array{Float64,1},C::Chain)

	Generates approximate mean forces F based on precomputed data dQvals, Fvals and Chain parameters.
"""
function ApproxMeanForce(Q::Array{Float64,1},dQvals::Array{Float64,1},Fvals::Array{Float64,1},C::Chain,σ::Float64=0.1,N::Int=2)

  F = zeros(size(Q));
  (Sigma, dQ) = ApproxMeanStresses(Q, dQvals, Fvals, C, σ, N);
  F = Sigma - circshift(Sigma, 1);

  return F, Sigma, dQ
end

function ApproxMeanForce_NEW(Q::Array{Float64,1},Fvals::Array{Float64,2},C::Chain,σ::Float64=0.1,N::Int=2)

  F = zeros(size(Q));
  (Sigma, dQ) = ApproxMeanStresses_NEW(Q, Fvals, C, σ, N);
  F = Sigma - circshift(Sigma, 1);

  return F, Sigma, dQ
end

function ApproxFlucStep(P::Array{Float64,1},Q::Array{Float64,1},dQvals::Array{Float64,1},
	StressSqvals::Array{Float64,1},C::Chain,dt::Float64,σ::Float64=0.1,N::Int=2)

  if sum(StressSqvals) == 0
	  ### Set up storage for diffusivity
	  Gvec = zeros(size(Q,1));
	  ### Compute inter-bead distances
	  dQ = circshift(Q, -1) - Q;
	  dQ[C.NBeads] += C.Period;

	  return zeros(size(P,1)), Gvec, dQ
  else
	  ### Set up storage for diffusivity
      Gvec = zeros(size(Q,1));

      ### Compute inter-bead distances
      dQ = circshift(Q, -1) - Q;
      dQ[C.NBeads] += C.Period;
      # println("");
      # println("       INTER-BEAD DISTANCES COMPUTED IN ApproxFlucStep");
      # println("       dQ = ",dQ);

      ### For each inter-bead distance, compute diffusivity
      for i=1:length(dQ)
	      if dQ[i] < 0.9
		      m = (6464.26 - 8859.34) / (1.2-0.90);
		      q = 8859.34 - m * 0.90;
		      Gvec[i] = m * dQ[i] + q;
	      elseif dQ[i] > 3.78
		      ### Define (diagonal) weight matrix
		      # W = spdiagm(0 => exp.(-(dQvals .- 3.78) .^2 ./ σ^2));

		      ### Form Jacobian matrix
		      # J = ones(N+1, length(dQvals));
		      # for j = 1:N
			  #    J[j+1, :] = (3.78 .- dQvals).^j;
		      # end

		      ### Least squares approximation of interpolant coefficients
		      # K = J * W;
		      # coeffs = (K * J') \ (K * StressSqvals);

		      ### Extract value of interpolant
		      Gvec[i] = 0; #coeffs[1];
	      else
		      ### Define (diagonal) weight matrix
	          W = spdiagm(0 => exp.(-(dQvals .- dQ[i]).^2/σ^2));

			  ### Form Jacobian matrix
        	  J = ones(N+1, length(dQvals));
    		  for j = 1:N
				  J[j+1,:] = (dQ[i] .- dQvals).^j;
			  end

			  ### Least squares approximation of interpolant coefficients
			  K = J * W;
			  # println("       Product between Jacobian matrix and diagonal weight matrix");
			  # println("       K = ",K);
			  coeffs = (K * J') \ (K * StressSqvals);

			  ### Extract value of interpolant
			  Gvec[i] = coeffs[1];
		  end
	  end

  	  ### Set diffusivity to zero if negative.
      Gvec = max.(Gvec, 0); #This function return the maximum of the arguments.

  	  ### Form memory matrix (that is a tridiagonal matrix)
      Gamma = diagm(0 => Gvec) - circshift(diagm(0 => Gvec), -1);
  	  Gamma = (Gamma - circshift(Gamma,1));
	  # println("GAMMA = ", Gamma)

      ### Perform eigenvalue decomposition
  	  F = eigen(Gamma); # Computes the eigenvalue decomposition, returning an Eigen factorization object F
	                    # which contains the eigenvalues in F.values and the eigenvectors in the columns of the matrix F.vectors.
	  # println("EIGENVALUES = ", F.values)
	  # println("EIGENVECTOR = ", F.vectors)
      F.values[1] = 0;

  	  ### Calculate exact Ornstein-Uhlenbeck step using decomposition
      c1 = exp.(-F.values / (2 * C.BeadMass) * dt);
	  # c1 = F.vectors * exp.(-F.values / (2 * C.BeadMass) * dt) .* F.vectors';
	  # c3 = sqrt(C.BeadMass) * sqrt.(abs.(1.0 .- c1^2)) * randn(C.NBeads);
	  c3 = sqrt(C.BeadMass) * sqrt.(1.0 .- c1.^2) .* randn(C.NBeads);

      ### Generate new momenta and return
	  # println("PNext = ", c1 * P + c3 )
	  # return c1 * P + c3, Gvec, dQ
      return F.vectors * (c1 .* (F.vectors' * P) + c3), Gvec, dQ
  end
end

end # module CGStats
