fold="../../"
for i in {0,1,2,3,4,5,6,7,8,9}
  do julia Orthogonal.jl
  gnuplot $fold/plot.gp
  mv Det.pdf $fold/$i_Det.pdf
  mv Stoc.pdf $i_Sto.pdf
done


