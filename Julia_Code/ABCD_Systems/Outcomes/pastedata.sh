# paste RR_sA.csv PP_sA.csv Veff_sA.csv Fmean_sA.csv Fstd_sA.csv > sA_50_300p.csv
# rm RR_sA.csv PP_sA.csv Veff_sA.csv Fmean_sA.csv Fstd_sA.csv

# paste RR_sB.csv PP_sB.csv Veff_sB.csv Fmean_sB.csv Fstd_sB.csv > sB_M20.csv
# rm RR_sB.csv PP_sB.csv Veff_sB.csv Fmean_sB.csv Fstd_sB.csv

paste RR_sC.csv PP_sC.csv Veff_sC.csv Fmean_sC.csv Fstd_sC.csv > sC_M0.1m1.csv
rm RR_sC.csv PP_sC.csv Veff_sC.csv Fmean_sC.csv Fstd_sC.csv

# paste RR_sC_B1.csv PP_sC_B1.csv Veff_sC_B1.csv Fmean_sC_B1.csv Fstd_sC_B1.csv > sC_B1.csv
# rm RR_sC_B1.csv PP_sC_B1.csv Veff_sC_B1.csv Fmean_sC_B1.csv Fstd_sC_B1.csv

# paste RR_sD.csv PP_sD.csv Veff_sD.csv Fmean_sD.csv Fstd_sD.csv > sD_M20.csv
# rm RR_sD.csv PP_sD.csv Veff_sD.csv Fmean_sD.csv Fstd_sD.csv


# awk -F " " '{ print $1 " " $4*(-1) }' sB_2000.csv > MeanForce_sB_M10.dat
# awk -F " " '{ print $1 " " $4*(-1) }' sD_2000.csv > MeanForce_sD_M10.dat
