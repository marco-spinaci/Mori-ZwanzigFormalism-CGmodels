using StatsBase,DelimitedFiles

### pdf(P) FULL DYNAMICS

P=readdlm("Store_Trajectory/Outcomes/PFull.csv",Float64);

h1 = fit(Histogram,P[:,1]);

x01 = Vector(h1.edges[1]);

H1 = zeros(length(h1.weights),2);
H1[:,1] = (x01[2:end]+x01[1:end-1])/2;
H1[:,2] = h1.weights./length(P[:,1]);

open("Data_Analysis/PDF/Outcomes/HistP.csv","w+") do x
    writedlm(x,H1);
end
