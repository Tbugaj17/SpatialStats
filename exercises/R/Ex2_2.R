library(spatstat)
data(humberside)

# Extract cancer cases
cancer_cases <- split(humberside)$case

# Plot cancer cases
plot(cancer_cases, main = "Geographical Locations of Cancer Cases")
