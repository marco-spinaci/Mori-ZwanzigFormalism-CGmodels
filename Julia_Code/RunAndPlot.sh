###########################################################################
# LangevinFullTraj_TestAndAutocorP

fold="../LangevinFullTraj_TestAndAutocor"

julia $fold/LangevinFullTraj_TestAndAutocor.jl
~/Desktop/julia-1.1.1/bin/julia $fold/LangevinFullTraj_TestAndAutocor.jl    # to run on a remote pc (pmams3@gercphd)

gnuplot $fold/plot_KmeanAndAutocorP.gp
mv $fold/plotKmeanAndAutocorP.pdf $fold/plotKmeanAndAutocorP_1e-5_1e5.pdf
mv $fold/AutocorGAMMA.csv $fold/AutocorGAMMA_1e-5_1e5.csv

############################################################################
# OrthogonalDynamimcs_DetAndStoc

# fold="../Outcomes/OrthogonalDynamics_DetAndStoc"
# # to run the same simulation two times
# for i in 1 2
# do
#   # julia OrthogonalDynamics_DetAndStoc.jl
#
#   # #################################################
#   # uncomment to run on a remote pc (pmams3@gercphd)
#
#   ~/Desktop/julia-1.1.1/bin/julia OrthogonalDynamics_DetAndStoc.jl
#   mv $fold/data_sC_DET.csv $fold/${i}_data_sC_DET.csv
#   mv $fold/data_sC_STOC.csv $fold/${i}_data_sC_STOC.csv
#
#   # # then on your pc decomment the following lines
#   # mv $fold/${i}_data_sC_DET.csv $fold/data_sC_DET.csv
#   # mv $fold/${i}_data_sC_STOC.csv $fold/data_sC_STOC.csv
#   #
#   # ####################################################
#   #
#   # gnuplot $fold/plotData.gp
#   # mv $fold/plotData_sC_DET.pdf $fold/${i}_plotData_sC_DET_10_1e7_dt10-3_dt1e-5.pdf
#   # mv $fold/plotData_sC_STOC.pdf $fold/${i}_plotData_sC_STOC_10_1e7_dt10-3_dt1e-5.pdf
#   # mv $fold/data_sC_DET.csv $fold/${i}_data_sC_DET_10_1e7_dt10-3_dt1e-5.csv
#   # mv $fold/data_sC_STOC.csv $fold/${i}_data_sC_STOC_10_1e7_dt10-3_dt1e-5.csv
# done

###############################################################################
# LangevinCoarseGraining_sC_GammaBeta
