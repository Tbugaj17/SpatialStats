using Plots

# Define the Radon-Nikodým derivative (PDF) for a uniform distribution on [0, 1]
function radon_nikodym_derivative_uniform(x)
    return (x >= 0 && x <= 1) ? 1.0 : 0.0
end

# Define the CDF for a uniform distribution on [0, 1]
function cdf_uniform(x)
    return (x < 0) ? 0.0 : (x > 1) ? 1.0 : x
end

# Generate x values from -0.5 to 1.5 to visualize both the PDF and CDF
x_vals = LinRange(-0.5, 1.5, 100)

# Compute values for the PDF (Radon-Nikodým derivative) and CDF
pdf_vals = radon_nikodym_derivative_uniform.(x_vals)
cdf_vals = cdf_uniform.(x_vals)

# Plot the PDF and CDF on the same graph
plot(x_vals, pdf_vals, label="PDF (Radon-Nikodým Derivative)", xlabel="x", ylabel="Density", title="Uniform Distribution: PDF and CDF", linewidth=2)
plot!(x_vals, cdf_vals, label="CDF", linestyle=:dash, linewidth=2)

using Random, Plots

# Parameters
λ = 100.0                         # Intensity (points per unit area)
r = 0.05                          # Radius
area = 1.0                         # Area (unit square)
n_sim = 10_000                     # Number of simulations to check
x = (0.5, 0.5)                     # Fixed point x

# Simulate and check the condition
function plot_conditioned_realisation()
    while true
        # Generate Poisson process points
        n_points = rand(Poisson(λ * area))  # Number of points in the area
        X = [(rand(), rand()) for _ in 1:n_points]  # Points in the unit square

        # Compute the distances from x to each point in the process
        dists = [sqrt((xi - x[1])^2 + (yi - x[2])^2) for (xi, yi) in X]
        
        # Check if all points are farther than r from x
        if all(d -> d > r, dists)
            # If the condition is satisfied, plot the realisation
            scatter([p[1] for p in X], [p[2] for p in X], label="Poisson points", color=:blue)
            scatter!([x[1]], [x[2]], markershape=:circle, label="Fixed point x", color=:red)
            plot!(xlim=(0,1), ylim=(0,1), aspect_ratio=1, legend=:bottomleft)
            plot!(Shape(x[1] .+ r*cos.(0:0.01:2π), x[2] .+ r*sin.(0:0.01:2π)), opacity=0.2, label="Ball Bₓ(r)")
            return  # Exit once a valid configuration is found
        end
    end
end

# Generate and plot the realisation
plot_conditioned_realisation()
savefig("conditioned_realisation.pdf")  # Save the plot
