#fold=(../Outocomes)
#for i in {0,1,2,3,4,5,6,7,8,9}
#  do julia Orthogonal.jl
#  gnuplot $fold/plot.gp
#  mv Det.pdf $fold/$i_Det.pdf
#  mv Stoc.pdf $i_Sto.pdf
#done

###########################################################################
# LangevinFullTraj_TestAndAutocorP

fold=(../Outcomes/LangevinFullTraj_TestAndAutocor)
# julia LangevinFullTraj_TestAndAutocor.jl
gnuplot $fold/plot_KmeanAndAutocorP.gp
mv $fold/plotKmeanAndAutocorP.pdf $fold/plotKmeanAndAutocorP_1e-5_1e5.pdf
mv $fold/AutocorGAMMA.csv $fold/AutocorGAMMA_1e-5_1e5.csv

############################################################################
#OrthogonalDynamimcs_DetAndStoc

#gnuplot $fold/OrthogonalDynamimcs_DetAndStoc/plotDataOD_DetAndStoc.gp
