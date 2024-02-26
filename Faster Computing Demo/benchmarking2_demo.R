# Clear workspace and close graphics
rm(list = ls())
graphics.off()

set.seed(1) # for reproducibility

geom_growth_base <- function(N0 = 2,
                            T = 999,
                            lambda = 1.01,
                            sigma = 0.2){
        Nvals <- vector('numeric') # initiate a place to put the values
        Nvals[1] <- N0
    for (t in 1:T){
        Nvals[t+1] <- Nvals[t]*(lambda*exp(rnorm(1,0,sigma)))
    }
    return(Nvals)
}
# Run the simulation
out <- geom_growth_base()
# Plot the results
plot(0:999,
out,
xlab='Time',
ylab='Population size',
type='o')

# Benchmark with microbench
library(microbenchmark)

comp <- microbenchmark(TS_009 = {geom_growth_base(T = 9)},
TS_099 = {geom_growth_base(T = 99)},
TS_999 = {geom_growth_base(T = 999)})
comp