#############################################################################################################################
#############################################################################################################################
############            Script bash to run the simulation and plot the outocomes                   ##########################
#############################################################################################################################
#############################################################################################################################

#############################################################################################################################
#### Autocorrelation Full and Ortho Orthogonal Dynamics

fold="./Data_Analysis/ACF_FullAndConstrainedTraj" 

julia $fold/AutocorrelationPar_CanonicalEns.jl &

# nohup julia ./Data_Analysis/ACF_FullAndConstrainedTraj/AutocorrelationPar_CanonicalEns.jl &




#############################################################################################################################
#### LangevinFullTraj_TestAndAutocorP

# fold="./LangevinFullTraj_TestAndAutocor"

# julia $fold/LangevinFullTraj_TestAndAutocor.jl
# ~/Desktop/julia-1.1.1/bin/julia $fold/LangevinFullTraj_TestAndAutocor.jl  # NB: to run the scritpt on a remote pc (pmams3@gercphd)

# gnuplot $fold/plot_KmeanAndAutocorP.gp

# mv $fold/plotKmean_T.pdf $fold/2.2_plotKmean_T.pdf
# mv $fold/plotAutocorGamma.pdf $fold/1_plotAutocorGamma.pdf

# mv $fold/Kmean_T.csv $fold/2.2_Kmean_T.csv
# mv $fold/AutocorGAMMA.csv $fold/1_AutocorGAMMA.csv

#############################################################################################################################
#### Maxwell-Boltzmann distribution

# julia Store_FullandConstrainedTrajectory/storeFullAndConstrTrajectory.jl

# julia Data_Analysis/Maxwell-Boltzmann_distribution/MBd.jl

# gnuplot Data_Analysis/Maxwell-Boltzmann_distribution/plot_MBd.gp


##############################################################################################################################
#### OrthogonalDynamimcs_DetAndStoc

# fold="./OrthogonalDynamics_DetAndStoc"
# # to run the same simulation two times
# for i in 1 2
# do
#   #
#   # julia $fold/OrthogonalDynamics_DetAndStoc.jl
#   # gnuplot $fold/plotData.gp
#   # mv $fold/plot_data_sC_DET.pdf $fold/${i}_plot_data_sC_DET.pdf
#   # mv $fold/plot_data_sC_STOC.pdf $fold/${i}_plot_data_sC_STOC.pdf
#   # mv $fold/data_sC_DET.csv $fold/${i}_data_sC_DET.csv
#   # mv $fold/data_sC_STOC.csv $fold/${i}_data_sC_STOC.csv
#
#   ##################################################
#   ### NB: uncomment to run on a remote pc (pmams3@gercphd)
#   #
#   # ~/Desktop/julia-1.1.1/bin/julia $fold/OrthogonalDynamics_DetAndStoc.jl
#   # mv $fold/data_sC_DET.csv $fold/${i}_data_sC_DET.csv
#   # mv $fold/data_sC_STOC.csv $fold/${i}_data_sC_STOC.csv
#
#   ### NB: then on your pc decomment the following lines
#
#   # mv $fold/${i}_data_sC_DET.csv $fold/data_sC_DET.csv
#   # mv $fold/${i}_data_sC_STOC.csv $fold/data_sC_STOC.csv
#   # gnuplot $fold/plotData.gp
#   # mv $fold/plot_data_sC_DET.pdf $fold/${i}_plot_data_sC_DET.pdf
#   # mv $fold/plot_data_sC_STOC.pdf $fold/${i}_plot_data_sC_STOC.pdf
#   # mv $fold/data_sC_DET.csv $fold/${i}_data_sC_DET.csv
#   # mv $fold/data_sC_STOC.csv $fold/${i}_data_sC_STOC.csv
#  ###################################################
#
# done

##################################################################################################################################
#### C_System_2and10cb

# fold="./C_System_2and10cb"

# julia $fold/LangevinCoarseGraining_sC_2and10cb.jl
# ~/Desktop/julia-1.1.1/bin/julia $fold/LangevinCoarseGraining_sC_2and10cb.jl  # NB: to run the scritpt on a remote pc (pmams3@gercphd)
#
# paste $fold/R_sC_2cb.csv $fold/Fmean_sC_2cb.csv $fold/Veff_sC_2cb.csv > $fold/C_2cb.csv
# paste $fold/R_sC_10cb.csv $fold/Fmean_sC_10cb.csv > $fold/C_10cb.csv

# gnuplot $fold/plotFvsR_sC_2and10cb.gp
#
# mv $fold/plotFvsR_sC_2and10cb.pdf $fold/1_plotFvsR_sC_2and10cb.pdf
#
# mv $fold/C_2cb.csv $fold/1_C_2cb.csv
# mv $fold/C_10cb.csv $fold/1_C_10cb.csv
#
# mv $fold/R_sC_2cb.csv $fold/1_R_sC_2cb.csv
# mv $fold/Fmean_sC_2cb.csv $fold/1_Fmean_sC_2cb.csv
# mv $fold/Veff_sC_2cb.csv $fold/1_Veff_sC_2cb.csv
#
# mv $fold/R_sC_10cb.csv $fold/1_R_sC_10cb.csv
# mv $fold/Fmean_sC_10cb.csv $fold/1_Fmean_sC_10cb.csv

######################################################################################################################################
