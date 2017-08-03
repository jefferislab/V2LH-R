c11.mcfo=readRDS("PD2a1-b1mcfo.rds")

c11.mcfo2 = c11.mcfo[!names(c11.mcfo) %in% c(
  "cell1_GMR_37G11_AE_01-20140618_19_B6-Aligned63xScale_c0.swc",
  "cell1_JRC_SS04956-20151125_20_B4-Aligned63xScale_c0.swc",
  "cell1_JRC_SS04956-20151125_20_B7-Aligned63xScale_c0.swc"
)]

shortnames=sub('-Aligned.*',"",names(c11.mcfo))

mbcaln=c(4,10,12,18)

c11.mcfo2[,'type']='PD2a1'
c11.mcfo2[mbcaln,'type']='PD2b1'

c11.mcfo2.dps=dotprops(c11.mcfo2, resample=1, k=5)

aba=nblast_allbyall(c11.mcfo2.dps)
hc=nhclust(scoremat = aba)
plot(hc, labels=c11.mcfo2[,'type'])

# try removing primary neurite 
library(catnat)
pn=primary.neurite(c11.mcfo2, resample=F)

# works, but there are some mini branches that complicate this
c11.mcfo2.pruned=nlapply(c11.mcfo2, function(x) {
  rp=rootpoints(x)
  sx=as.seglist(x)
  seg_with_root=sapply(sx, function(s) any(s==rp))
  primary_neurite_verts=unlist(sx[seg_with_root])
  prune_vertices(x, primary_neurite_verts)
})

# Try strahler order
# but this only works for single tree neurons
c11.mcfo2.tree1=nlapply(c11.mcfo2, function(x) prune_vertices(x, unique(unlist(x$SegList)), invert = T))

plot(c11.mcfo2.tree1[[9]], col=strahler_order(c11.mcfo2.tree1[[9]])$segments)
