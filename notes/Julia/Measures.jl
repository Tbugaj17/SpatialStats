# Notes on measures for lecture 1
# A measure generalises the concept of length, area, and volume. 
# In spatial statistics, measures are crucial for defining and analysing point processes.

using Random, Distributions, Plots

# Lebesgue measure (area of a region in R^2)
function lebesgue_measure(region)
    x_min, x_max, y_min, y_max = region
    return (x_max - x_min) * (y_max - y_min)  # Area
end

# Counting measure (number of points in a region)
function counting_measure(points, region)
    x_min, x_max, y_min, y_max = region
    count = sum(x_min .<= points[:,1] .<= x_max .&& y_min .<= points[:,2] .<= y_max)
    return count
end

# Example: Generate random points and compute measures
region = (0, 1, 0, 1)
points = rand(100, 2)  # 100 random points in [0,1] x [0,1]

println("Lebesgue Measure (Area of Region): ", lebesgue_measure(region))
println("Counting Measure (Number of Points in Region): ", counting_measure(points, region))

# Key Properties of Point Processes

# Homogeneous Poisson Process: Intensity measure.
function homogeneous_poisson_process(lambda, region)
    x_min, x_max, y_min, y_max = region
    area = (x_max - x_min) * (y_max - y_min)
    n = rand(Poisson(lambda * area))  # Poisson-distributed number of points
    x = rand(n) .* (x_max - x_min) .+ x_min
    y = rand(n) .* (y_max - y_min) .+ y_min
    return hcat(x, y)  # Return points
end

# Intensity Measure
function intensity_measure(points, region)
    area = lebesgue_measure(region)
    return size(points, 1) / area  # Intensity = (Number of points) / (Area)
end

# Stationarity Check (Shift points)
function check_stationarity(points, shift=(0.2, 0.2))
    shifted_points = points .+ shift
    return shifted_points
end

# Isotropy Check (Rotate points by θ)
function rotate_points(points, theta)
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)]
    return (R * points')'
end

# Void Probability
function void_probability(lambda, region)
    Λ = lambda * lebesgue_measure(region)
    return exp(-Λ)  # Poisson void probability
end

# Shifted process to check stationarity
function check_stationarity(points, shift=(0.2, 0.2))
    return points .+ hcat(shift...)  # Correct broadcasting
end

# Example Usage
lambda = 50
region = (0, 1, 0, 1)
points = homogeneous_poisson_process(lambda, region)

println("Intensity Measure: ", intensity_measure(points, region))
println("Void Probability: ", void_probability(lambda, region))

rotated_points = rotate_points(points, pi/4)

# Plot original and rotated
scatter(points[:,1], points[:,2], label="Original", alpha=0.5, markersize=3)
scatter!(rotated_points[:,1], rotated_points[:,2], label="Rotated", alpha=0.5, markersize=3)

# Plot original and shifted
scatter(points[:,1], points[:,2], label="Original", alpha=0.5, markersize=3)
scatter!(shifted_points[:,1], shifted_points[:,2], label="Shifted", alpha=0.5, markersize=3)
