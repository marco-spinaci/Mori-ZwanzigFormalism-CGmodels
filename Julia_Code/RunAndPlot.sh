#############################################################################################################################
#############################################################################################################################
############            Script bash to run the simulation and plot the outocomes                   ##########################
#############################################################################################################################
#############################################################################################################################
#############################################################################################################################
# LangevinFullTraj_TestAndAutocorP

# fold="./LangevinFullTraj_TestAndAutocor"
#
# julia $fold/LangevinFullTraj_TestAndAutocor.jl
# ~/Desktop/julia-1.1.1/bin/julia $fold/LangevinFullTraj_TestAndAutocor.jl  # NB: to run the scritpt on a remote pc (pmams3@gercphd)
#
# gnuplot $fold/plot_KmeanAndAutocorP.gp
#
# mv $fold/plotKmean_T.pdf $fold/1_plotKmean_T.pdf
# mv $fold/plotAutocorGamma.pdf $fold/1_plotAutocorGamma.pdf
#
# mv $fold/Kmean_T.csv $fold/1_plotKmean_T.csv
# mv $fold/AutocorGamma.csv $fold/1_AutocorGamma.csv

##############################################################################################################################
# OrthogonalDynamimcs_DetAndStoc

fold="./OrthogonalDynamics_DetAndStoc"
# to run the same simulation two times
for i in 1 2
do
  # julia $fold/OrthogonalDynamics_DetAndStoc.jl

  # #################################################
  # uncomment to run on a remote pc (pmams3@gercphd)

  ~/Desktop/julia-1.1.1/bin/julia $fold/OrthogonalDynamics_DetAndStoc.jl
  mv $fold/data_sC_DET.csv $fold/${i}_data_sC_DET.csv
  mv $fold/data_sC_STOC.csv $fold/${i}_data_sC_STOC.csv

  # # then on your pc decomment the following lines
  # mv $fold/${i}_data_sC_DET.csv $fold/data_sC_DET.csv
  # mv $fold/${i}_data_sC_STOC.csv $fold/data_sC_STOC.csv
  #
  # ####################################################
  #
  # gnuplot $fold/plotData.gp
  # mv $fold/plot_data_sC_DET.pdf $fold/${i}_plot_data_sC_DET.pdf
  # mv $fold/plot_data_sC_STOC.pdf $fold/${i}_plot_data_sC_STOC.pdf
  # mv $fold/data_sC_DET.csv $fold/${i}_data_sC_DET.csv
  # mv $fold/data_sC_STOC.csv $fold/${i}_data_sC_STOC.csv

done

###############################################################################
# LangevinCoarseGraining_sC_GammaBeta
