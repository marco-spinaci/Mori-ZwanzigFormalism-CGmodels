#fold=(../Outocomes)
#for i in {0,1,2,3,4,5,6,7,8,9}
#  do julia Orthogonal.jl
#  gnuplot $fold/plot.gp
#  mv Det.pdf $fold/$i_Det.pdf
#  mv Stoc.pdf $i_Sto.pdf
#done

###########################################################################
# LangevinFullTraj_TestAndAutocorP

# fold="../Outcomes/LangevinFullTraj_TestAndAutocor"
# # julia LangevinFullTraj_TestAndAutocor.jl
# gnuplot $fold/plot_KmeanAndAutocorP.gp
# mv $fold/plotKmeanAndAutocorP.pdf $fold/plotKmeanAndAutocorP_1e-5_1e5.pdf
# mv $fold/AutocorGAMMA.csv $fold/AutocorGAMMA_1e-5_1e5.csv

############################################################################
#OrthogonalDynamimcs_DetAndStoc

fold="../Outcomes/OrthogonalDynamics_DetAndStoc"
# to run the same simulation two times
for i in 1 2
do
  # julia OrthogonalDynamics_DetAndStoc.jl

  ~/Desktop/julia-1.1.1/bin/julia OrthogonalDynamics_DetAndStoc.jl
  mv $fold/plotData_sC_DET.pdf $fold/${i}_plotData_sC_DET.pdf
  mv $fold/plotData_sC_STOC.pdf $fold/${i}_plotData_sC_STOC.pdf

  # mv $fold/${i}_plotData_sC_DET.pdf $fold/plotData_sC_DET.pdf
  # mv $fold/${i}_plotData_sC_STOC.pdf $fold/plotData_sC_STOC.pdf

  # gnuplot $fold/plotData.gp
  # mv $fold/plotData_sC_DET.pdf $fold/${i}_plotData_sC_DET_10_1e7.pdf
  # mv $fold/plotData_sC_STOC.pdf $fold/${i}_plotData_sC_STOC_10_1e7.pdf
  # mv $fold/data_sC_DET.csv $fold/${i}_data_sC_DET_10_1e7.csv
  # mv $fold/data_sC_STOC.csv $fold/${i}_data_sC_STOC_10_1e7.csv

done
