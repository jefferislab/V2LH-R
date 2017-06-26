# Set up flycircuit data
# see https://gist.github.com/jefferis/bbaf5d53353b3944c090
# for details
devtools::source_gist("bbaf5d53353b3944c090", filename = "FlyCircuitStartupNat.R")

# all 
vm4ish=fc_glom()[grepl("VM4", fc_glom())]
table(vm4ish)
nn=names(vm4ish)
hc=hclustfc(nn)
plot(hc, labels = vm4ish)

library(dendroextras)
hc2=hc
hc2$labels=vm4ish
hcd=colour_clusters(hc2, k=3)
plot(hcd)

clear3d()
plot3d(hc, k=3, soma=T)
