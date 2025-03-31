# Notes for lecture 1.
# Introduction to Spatial Point Processes
# A spatial point process is a random collection of points in a space R^d. 
# It generalises the concept of a random variable to random point patterns. 
# Formally, it is a random measure N(B) giving the number of points in a region B.

# 1) Binomial Point Process (BPP): A fixed number n of points are independently and uniformly distributed in a bounded region.

using Random, Plots, Distributions

function binomial_point_process(n, region=(0,1,0,1))
    x_min, x_max, y_min, y_max = region
    x = rand(n) .* (x_max - x_min) .+ x_min
    y = rand(n) .* (y_max - y_min) .+ y_min
    return x, y
end

# Example: Generate and plot a binomial point process with 50 points
x, y = binomial_point_process(50)
scatter(x, y, markersize=4, legend=false, title="Binomial Point Process (n=50)")

# 2) Homogeneous Poisson Point Process (PPP): A randon number of N∼Poisson(λa) is distributed independently over the region.

function homogeneous_poisson_process(lambda, region=(0,1,0,1))
    x_min, x_max, y_min, y_max = region
    area = (x_max - x_min) * (y_max - y_min)
    n = rand(Poisson(lambda * area))  # Poisson-distributed number of points
    x = rand(n) .* (x_max - x_min) .+ x_min
    y = rand(n) .* (y_max - y_min) .+ y_min
    return x, y
end

# Example: Generate and plot a homogeneous PPP with λ = 100 points per unit area
x, y = homogeneous_poisson_process(100)
scatter(x, y, markersize=4, legend=false, title="Homogeneous Poisson Point Process (λ=100)")

# 3)Inhomogeneous Poisson Point Process (PPP): Intensity function λ(s) varies over space. Here, we use λ(x,y)=100(x+y) as an example.

function inhomogeneous_poisson_process(lambda_func, region=(0,1,0,1))
    x_min, x_max, y_min, y_max = region
    area = (x_max - x_min) * (y_max - y_min)
    max_lambda = lambda_func(x_max, y_max)
    
    # Generate a homogeneous Poisson process with max intensity
    x, y = homogeneous_poisson_process(max_lambda, region)

    # Thinning: Keep each point with probability λ(x,y)/max_lambda
    keep = rand(length(x)) .< lambda_func.(x, y) ./ max_lambda
    return x[keep], y[keep]
end

# Define an intensity function
lambda_func(x, y) = 100 * (x + y)

# Example: Generate and plot an inhomogeneous PPP
x, y = inhomogeneous_poisson_process(lambda_func)
scatter(x, y, markersize=4, legend=false, title="Inhomogeneous Poisson Point Process (λ(x,y) = 100(x+y))")

# 4) Marked Poisson Point Process (MPP) in Julia: A Marked Point Process associates an extra attribute (mark) to each point. 
# Here’s an example where we generate a homogeneous Poisson Point Process (PPP) and assign each point a random "mark" representing, e.g., the magnitude of an event.

function marked_poisson_process(lambda, mark_dist, region=(0,1,0,1))
    x_min, x_max, y_min, y_max = region
    area = (x_max - x_min) * (y_max - y_min)
    
    # Number of points follows a Poisson distribution
    n = rand(Poisson(lambda * area))
    
    # Generate spatial locations
    x = rand(n) .* (x_max - x_min) .+ x_min
    y = rand(n) .* (y_max - y_min) .+ y_min
    
    # Generate marks from the specified distribution
    marks = rand(mark_dist, n)
    
    return x, y, marks
end

# Example: λ = 100, marks follow a Normal(5,1) distribution
x, y, marks = marked_poisson_process(100, Normal(5, 1))

# Plot points, using the mark as the marker size
scatter(x, y, markersize=marks, alpha=0.6, legend=false, title="Marked Poisson Point Process (Marks ~ Normal(5,1))")

# 5) Extending to a Multivariate Marked Poisson Process: Extend the marks to a vector (e.g., assigning multiple attributes like magnitude, type, and time), we approach a multivariate marked point process.
# Here, each point gets a two-dimensional mark (e.g., event magnitude and time of occurrence).

using ColorTypes

function multivariate_marked_poisson_process(lambda, mark_dists, region=(0,1,0,1))
    x_min, x_max, y_min, y_max = region
    area = (x_max - x_min) * (y_max - y_min)
    
    # Number of points follows a Poisson distribution
    n = rand(Poisson(lambda * area))
    
    # Generate spatial locations
    x = rand(n) .* (x_max - x_min) .+ x_min
    y = rand(n) .* (y_max - y_min) .+ y_min
    
    # Generate multivariate marks
    marks = [rand(d, n) for d in mark_dists]  # List of marks for each attribute
    return x, y, marks
end

# Example: λ = 100, two marks: Normal(5,1) (magnitude) and Uniform(0,10) (time)
x, y, (magnitudes, times) = multivariate_marked_poisson_process(100, [Normal(5, 1), Uniform(0, 10)])

# Use 'times' for the color and 'magnitudes' for the size
scatter(x, y, markersize=magnitudes, color=times, alpha=0.7, 
        legend=false, title="Multivariate Marked Poisson Process", 
        colormap=:viridis, colorrange=(minimum(times), maximum(times)))

