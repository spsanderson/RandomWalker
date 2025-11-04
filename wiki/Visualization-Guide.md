# Visualization Guide

RandomWalker provides powerful visualization capabilities through the `visualize_walks()` function. This guide covers everything you need to create beautiful, informative plots of your random walks.

## Table of Contents

- [Basic Visualization](#basic-visualization)
- [Interactive Visualizations](#interactive-visualizations)
- [Customizing Plots](#customizing-plots)
- [Selective Visualization](#selective-visualization)
- [Multi-Panel Layouts](#multi-panel-layouts)
- [Exporting Plots](#exporting-plots)
- [Custom ggplot2 Plots](#custom-ggplot2-plots)
- [Tips and Best Practices](#tips-and-best-practices)

## Basic Visualization

### Default Visualization

The simplest way to visualize random walks:

```r
library(RandomWalker)

# Generate and visualize
rw30() |> visualize_walks()
```

This creates a comprehensive multi-panel plot showing:
1. **y** - The original random walk values
2. **cum_sum** - Cumulative sum over time
3. **cum_prod** - Cumulative product
4. **cum_min** - Cumulative minimum
5. **cum_max** - Cumulative maximum
6. **cum_mean** - Cumulative mean

### Single Walk Type

Visualize walks with initial value adjustment:

```r
random_normal_walk(
  .num_walks = 10,
  .n = 100,
  .initial_value = 100
) |> visualize_walks()
```

## Interactive Visualizations

### Enable Interactivity

Add interactive features with a single parameter:

```r
rw30() |> visualize_walks(.interactive = TRUE)
```

**Interactive Features:**
- **Hover**: See exact values at any point
- **Zoom**: Use mouse wheel or pinch to zoom in/out
- **Pan**: Click and drag to move around
- **Toolbar**: Access tools in the top-right corner
- **Selection**: Some plots support selecting regions

### Customizing Interactive Behavior

The interactive mode uses `ggiraph`. Options include:

```r
# More transparent hover effect
rw30() |> visualize_walks(.interactive = TRUE, .alpha = 0.5)

# Focus on specific panels
random_normal_walk(.num_walks = 5, .initial_value = 100) |>
  visualize_walks(.interactive = TRUE, .pluck = c("cum_sum", "cum_mean"))
```

### When to Use Interactive Plots

**Use interactive visualizations for:**
- Exploratory data analysis
- Presentations
- Shiny applications
- Detailed inspection of specific walks
- Identifying outliers or patterns

**Use static plots for:**
- Publications
- Reports (PDF/Word)
- High-quality printing
- Batch processing
- Reproducible documents

## Customizing Plots

### Adjusting Transparency

Control line transparency with `.alpha`:

```r
# More transparent (good for many walks)
rw30() |> visualize_walks(.alpha = 0.3)

# Less transparent (good for few walks)
random_normal_walk(.num_walks = 3) |>
  visualize_walks(.alpha = 0.9)

# Default transparency
rw30() |> visualize_walks(.alpha = 0.7)
```

**Alpha Guidelines:**
- 0.1 - 0.3: Very transparent, good for 50+ walks
- 0.4 - 0.6: Moderate, good for 20-50 walks
- 0.7 - 0.9: Opaque, good for 5-20 walks
- 1.0: Fully opaque, good for 1-5 walks

### Color Schemes

The default color scheme uses the walk number to color lines. You can customize this using ggplot2:

```r
library(ggplot2)

# Get base visualization
p <- random_normal_walk(.num_walks = 5) |>
  visualize_walks(.pluck = "y")

# Customize colors
p + scale_color_viridis_d()
p + scale_color_brewer(palette = "Set1")
p + scale_color_manual(values = c("red", "blue", "green", "orange", "purple"))
```

## Selective Visualization

### Pluck Single Attribute

Focus on one aspect of the walks:

```r
# Show only the original values
rw30() |> visualize_walks(.pluck = "y")

# Show only cumulative sum
random_normal_walk(.num_walks = 10, .initial_value = 100) |>
  visualize_walks(.pluck = "cum_sum")

# Show only cumulative product
geometric_brownian_motion(.num_walks = 10, .initial_value = 100) |>
  visualize_walks(.pluck = "cum_prod")
```

**Available Attributes:**
- `"y"` - Original walk values
- `"cum_sum"` - Cumulative sum
- `"cum_prod"` - Cumulative product
- `"cum_min"` - Cumulative minimum
- `"cum_max"` - Cumulative maximum
- `"cum_mean"` - Cumulative mean

### Pluck Multiple Attributes

Create custom panel layouts:

```r
# Two panels: original and cumulative sum
random_normal_walk(.num_walks = 10, .initial_value = 100) |>
  visualize_walks(.pluck = c("y", "cum_sum"))

# Three panels: min, mean, max
rw30() |> visualize_walks(.pluck = c("cum_min", "cum_mean", "cum_max"))

# Focus on products and sums
geometric_brownian_motion(.num_walks = 10) |>
  visualize_walks(.pluck = c("cum_sum", "cum_prod"))
```

### Pluck with Custom Arrangement

Use `patchwork` to customize layout:

```r
library(patchwork)

walks <- random_normal_walk(.num_walks = 10, .initial_value = 100)

# Get individual plots
p1 <- walks |> visualize_walks(.pluck = "y")
p2 <- walks |> visualize_walks(.pluck = "cum_sum")
p3 <- walks |> visualize_walks(.pluck = "cum_prod")

# Custom arrangement
p1 / (p2 | p3)  # Top row: y, Bottom row: cum_sum and cum_prod side by side
```

## Multi-Panel Layouts

### Understanding Default Layout

The default `visualize_walks()` creates a 3x2 grid:
```
[     y      ] [  cum_sum   ]
[  cum_prod  ] [  cum_min   ]
[  cum_max   ] [  cum_mean  ]
```

### Custom Layouts with Patchwork

Create publication-quality layouts:

```r
library(patchwork)

walks <- rw30()

# Extract individual panels
p_y <- walks |> visualize_walks(.pluck = "y")
p_sum <- walks |> visualize_walks(.pluck = "cum_sum")
p_min <- walks |> visualize_walks(.pluck = "cum_min")
p_max <- walks |> visualize_walks(.pluck = "cum_max")

# Horizontal layout
p_y | p_sum | p_min | p_max

# 2x2 grid
(p_y | p_sum) / (p_min | p_max)

# Complex layout with annotations
(p_y | p_sum) / p_min +
  plot_annotation(
    title = "Random Walk Analysis",
    subtitle = "30 walks of 100 steps each",
    tag_levels = "A"
  )
```

## Exporting Plots

### Save Static Plots

```r
library(ggplot2)

# Create plot
p <- rw30() |> visualize_walks()

# Save as PNG (default size)
ggsave("random_walks.png", p, width = 12, height = 8, dpi = 300)

# Save as PDF (vector graphics)
ggsave("random_walks.pdf", p, width = 12, height = 8)

# Save as SVG (web-friendly vector)
ggsave("random_walks.svg", p, width = 12, height = 8)

# High-resolution for publication
ggsave("random_walks_hires.png", p, width = 12, height = 8, dpi = 600)
```

### Export Interactive Plots

```r
library(ggiraph)
library(htmlwidgets)

# Create interactive plot
p_interactive <- rw30() |> visualize_walks(.interactive = TRUE)

# Save as HTML
saveWidget(p_interactive, "random_walks_interactive.html")

# Self-contained HTML (includes all dependencies)
saveWidget(p_interactive, "random_walks_interactive.html", selfcontained = TRUE)
```

### Export for PowerPoint/Word

```r
library(officer)
library(rvg)

# Create plot
p <- random_normal_walk(.num_walks = 10) |> visualize_walks(.pluck = "y")

# Create PowerPoint
ppt <- read_pptx()
ppt <- add_slide(ppt, layout = "Title and Content", master = "Office Theme")
ppt <- ph_with(ppt, dml(ggobj = p), location = ph_location_fullsize())
print(ppt, target = "random_walks.pptx")
```

## Custom ggplot2 Plots

### Creating Your Own Visualizations

While `visualize_walks()` is convenient, you may want full control:

```r
library(ggplot2)
library(dplyr)

# Generate walks
walks <- random_normal_walk(.num_walks = 10, .n = 100)

# Basic line plot
ggplot(walks, aes(x = step_number, y = cum_sum, color = walk_number, group = walk_number)) +
  geom_line(alpha = 0.7) +
  theme_minimal() +
  labs(
    title = "Random Walk Cumulative Sum",
    x = "Step",
    y = "Cumulative Sum",
    color = "Walk"
  )
```

### Add Confidence Bands

```r
library(ggplot2)
library(dplyr)

walks <- random_normal_walk(.num_walks = 100, .n = 100)

# Calculate quantiles at each step
walk_summary <- walks |>
  group_by(step_number) |>
  summarize(
    mean = mean(y),
    q05 = quantile(y, 0.05),
    q25 = quantile(y, 0.25),
    q75 = quantile(y, 0.75),
    q95 = quantile(y, 0.95)
  )

# Plot with confidence bands
ggplot() +
  # 90% confidence band
  geom_ribbon(data = walk_summary, aes(x = step_number, ymin = q05, ymax = q95),
              alpha = 0.2, fill = "blue") +
  # IQR band
  geom_ribbon(data = walk_summary, aes(x = step_number, ymin = q25, ymax = q75),
              alpha = 0.3, fill = "blue") +
  # Mean line
  geom_line(data = walk_summary, aes(x = step_number, y = mean),
            color = "darkblue", linewidth = 1) +
  # Individual walks (faint)
  geom_line(data = walks, aes(x = step_number, y = y, group = walk_number),
            alpha = 0.05, color = "gray50") +
  theme_minimal() +
  labs(
    title = "Random Walks with Confidence Bands",
    subtitle = "100 walks, showing mean, IQR, and 90% CI",
    x = "Step",
    y = "Value"
  )
```

### Histogram of Final Values

```r
library(ggplot2)
library(dplyr)

# Generate many walks
walks <- random_normal_walk(.num_walks = 1000, .n = 100)

# Get final values
final_values <- walks |>
  group_by(walk_number) |>
  slice_max(step_number, n = 1) |>
  pull(cum_sum)

# Histogram with density overlay
ggplot(data.frame(value = final_values), aes(x = value)) +
  geom_histogram(aes(y = after_stat(density)), bins = 50, fill = "steelblue", alpha = 0.7) +
  geom_density(color = "darkblue", linewidth = 1) +
  theme_minimal() +
  labs(
    title = "Distribution of Final Walk Values",
    subtitle = "1000 random walks, 100 steps each",
    x = "Final Cumulative Sum",
    y = "Density"
  )
```

### 2D Walk Visualization

```r
library(ggplot2)

# Generate 2D walks
walks_2d <- random_normal_walk(.num_walks = 10, .n = 100, .dimensions = 2)

# Plot trajectories
ggplot(walks_2d, aes(x = cum_sum_x, y = cum_sum_y, color = walk_number)) +
  geom_path(alpha = 0.7, linewidth = 0.5) +
  geom_point(data = walks_2d |> filter(step_number == 1),
             size = 3, shape = 21, fill = "white") +  # Start points
  geom_point(data = walks_2d |> group_by(walk_number) |> slice_max(step_number),
             size = 3) +  # End points
  coord_equal() +
  theme_minimal() +
  labs(
    title = "2D Random Walk Trajectories",
    x = "X Position",
    y = "Y Position",
    color = "Walk"
  )
```

### Animated Walks

```r
library(ggplot2)
library(gganimate)

# Generate walks
walks <- random_normal_walk(.num_walks = 5, .n = 100)

# Create animated plot
p <- ggplot(walks, aes(x = step_number, y = cum_sum, color = walk_number)) +
  geom_line(linewidth = 1) +
  theme_minimal() +
  labs(title = "Step: {frame_along}", x = "Step", y = "Cumulative Sum") +
  transition_reveal(step_number)

# Render animation
animate(p, nframes = 100, fps = 10, width = 800, height = 600)

# Save animation
anim_save("random_walk_animation.gif")
```

## Tips and Best Practices

### Choosing the Right Visualization

**For exploratory analysis:**
```r
# Use interactive with moderate transparency
walks |> visualize_walks(.interactive = TRUE, .alpha = 0.5)
```

**For publications:**
```r
# Use static with high DPI, focus on key aspects
walks |> visualize_walks(.pluck = c("y", "cum_sum"), .alpha = 0.7)
ggsave("figure1.pdf", width = 10, height = 6)
```

**For presentations:**
```r
# Use interactive or clean static with fewer walks
walks |> visualize_walks(.interactive = TRUE, .pluck = "cum_sum")
```

### Performance Tips

**For many walks (>50):**
```r
# Use lower alpha and consider sampling
walks_many <- random_normal_walk(.num_walks = 500, .n = 100)

# Sample for visualization
walks_sample <- walks_many |>
  filter(walk_number %in% sample(levels(walk_number), 50))

walks_sample |> visualize_walks(.alpha = 0.2)
```

**For long walks (>1000 steps):**
```r
# Consider downsampling steps
walks_long <- random_normal_walk(.num_walks = 10, .n = 10000)

walks_downsampled <- walks_long |>
  filter(step_number %% 10 == 0)  # Keep every 10th step

walks_downsampled |> visualize_walks()
```

### Color Accessibility

Ensure your plots are accessible:

```r
library(ggplot2)

# Use colorblind-friendly palettes
p <- random_normal_walk(.num_walks = 5) |>
  visualize_walks(.pluck = "y")

# Viridis (colorblind-friendly)
p + scale_color_viridis_d(option = "plasma")

# RColorBrewer colorblind-safe palette
p + scale_color_brewer(palette = "Dark2")
```

### Combining Multiple Distributions

Compare different random walk types:

```r
library(patchwork)
library(ggplot2)

# Generate different types
normal <- random_normal_walk(.num_walks = 10) |>
  visualize_walks(.pluck = "y") +
  labs(title = "Normal Walk")

cauchy <- random_cauchy_walk(.num_walks = 10) |>
  visualize_walks(.pluck = "y") +
  labs(title = "Cauchy Walk (Heavy Tails)")

geometric <- geometric_brownian_motion(.num_walks = 10, .initial_value = 100) |>
  visualize_walks(.pluck = "cum_prod") +
  labs(title = "Geometric Brownian Motion")

# Combine
normal | cauchy | geometric +
  plot_annotation(
    title = "Comparing Random Walk Types",
    theme = theme(plot.title = element_text(size = 16, face = "bold"))
  )
```

### Themes

Apply consistent themes:

```r
library(ggplot2)

# Define custom theme
my_theme <- theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    legend.position = "bottom"
  )

# Apply to plots
rw30() |> visualize_walks(.pluck = "y") + my_theme
```

## Common Visualization Patterns

### Pattern 1: Compare Initial Values

```r
library(patchwork)

p1 <- random_normal_walk(.num_walks = 10, .initial_value = 0) |>
  visualize_walks(.pluck = "cum_sum") +
  labs(title = "Starting at 0")

p2 <- random_normal_walk(.num_walks = 10, .initial_value = 100) |>
  visualize_walks(.pluck = "cum_sum") +
  labs(title = "Starting at 100")

p1 / p2
```

### Pattern 2: Show Uncertainty

```r
# Generate many walks and show spread
walks <- random_normal_walk(.num_walks = 100, .n = 100)

walks |> visualize_walks(.alpha = 0.1, .pluck = "cum_sum")
```

### Pattern 3: Highlight Specific Walks

```r
library(ggplot2)
library(dplyr)

walks <- random_normal_walk(.num_walks = 20, .n = 100)

# Find extreme walks
extremes <- walks |>
  group_by(walk_number) |>
  summarize(final = last(cum_sum)) |>
  arrange(final) |>
  slice(c(1, n())) |>  # Min and max
  pull(walk_number)

# Highlight them
walks |>
  mutate(is_extreme = walk_number %in% extremes) |>
  ggplot(aes(x = step_number, y = cum_sum, color = walk_number, alpha = is_extreme)) +
  geom_line() +
  scale_alpha_manual(values = c(0.1, 0.9)) +
  theme_minimal() +
  labs(title = "Highlighting Extreme Walks")
```

## Next Steps

- **[Statistical Analysis Guide](Statistical-Analysis-Guide.md)** - Analyze your visualizations
- **[Multi-Dimensional Walks](Multi-Dimensional-Walks.md)** - Visualize 2D and 3D walks
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications
- **[API Reference](API-Reference.md)** - Complete function documentation

---

**Want more examples?** Check out the **[Use Cases and Examples](Use-Cases-and-Examples.md)** page!
