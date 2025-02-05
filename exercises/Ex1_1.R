# Introduction Exercise 1 - (c) plot data from spatstat package
plot(swedishpines)
plot(redwood)
plot(cells)

# Examples of marked point patterns. 
# (d) Plot these and describe the (marked) point patterns.
# Answer: # They both looks clustered: Points are grouped together in certain areas.
plot(spruces) 
plot(bronzefilter)

# Estimate intensity of the point pattern.
density_spruces <- density(spruces)
plot(density_spruces)

# Estimate intensity of the point pattern.
density_bronzefilter <- density(bronzefilter)
plot(density_bronzefilter)

# Another dataset with trees, bei, contains covariates on the elevation and slope of the ground. Both these covariates are contained in bei.extra. 
# (e) Plot the point pattern and the covariates try the commands

plot(bei)
plot(bei.extra)

# Try the commands: 
names(bei.extra) #returns the names of the components within the object, in this case: "elev" "grad".

par(mfrow=c(1,2)) #sets the layout for multiple plots in one figure.
plot(bei.extra$elev) #creates a plot of the "elev" data from the bei.extra object.
plot(bei,add=TRUE) #plots the bei spatial object, and the add=TRUE parameter ensures that the bei plot is added to the existing plot.
plot(bei.extra$grad) # plots the gradient (grad) component of the bei.extra object.
plot(bei,add=TRUE) # adds the bei spatial data object onto the plot of grad.

# Summary: These commands allow you to visualise two spatial variables "elev" "grad" and overlay the spatial point pattern (represented by bei) on top of them. 
# Each location in the plot has a gradient value, and the plot will show a color scale (e.g., blue for low gradient, red for high gradient) representing the rate of change.

# (f) Run the line ?swedishpines,  get information about a dataset in 
# The functions coords(), npoints(), Window(), marks(), unmark() can be used to extract various bits of information from any point pattern dataset. Try them out.

?swedishpines
coords(swedishpines)
npoints(swedishpines)
Window(swedishpines)
marks(swedishpines)
unmark(swedishpines)
