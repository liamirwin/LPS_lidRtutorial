# Lidar Summary Metrics
# https://liamirwin.github.io/LPS_lidRtutorial/04_metrics.html

# Environment setup
# -----------------
# Clear workspace and load required packages
rm(list = ls(globalenv()))
library(lidR)
library(terra)
library(lidRmetrics)

# -------------------------------------------------------------------
# Basic Pixel Metrics
# -------------------------------------------------------------------

# Load normalized LiDAR data
las <- readLAS(files = "data/zrh_norm.laz")

# Compute mean and max height at 10m resolution
hmean <- pixel_metrics(las = las, func = ~mean(Z), res = 10)
plot(hmean)

hmax <- pixel_metrics(las = las, func = ~max(Z), res = 10)
plot(hmax)

# Compute multiple metrics simultaneously
metrics_multi <- pixel_metrics(las = las,
                               func = ~list(hmax = max(Z), hmean = mean(Z)),
                               res = 10)
plot(metrics_multi)

# Predefined metrics (.stdmetrics_z)
metrics_std <- pixel_metrics(las = las, func = .stdmetrics_z, res = 10)
plot(metrics_std)
plot(metrics_std, "zsd")

# -------------------------------------------------------------------
# Advanced Metrics (lidRmetrics)
# -------------------------------------------------------------------

# Canopy cover: proportion of returns above 2m
cc <- pixel_metrics(las,
                    func = ~metrics_percabove(z = Z, threshold = 2, zmin = 0),
                    res = 10)
plot(cc)

# Leaf area density profiles (LAD)
lad <- pixel_metrics(las, func = ~metrics_lad(z = Z), res = 10)
plot(lad)
plot(lad, "lad_cv")

# Dispersion and vertical complexity
disp <- pixel_metrics(las, func = ~metrics_dispersion(z = Z, zmax = 40), res = 10)
plot(disp)
plot(disp, "CRR")
plot(disp, "VCI")

# User-defined weighted mean metric
f_weighted <- function(x, weight) sum(x * weight) / sum(weight)
user_weighted <- pixel_metrics(las,
                               func = ~f_weighted(Z, Intensity),
                               res = 10)
plot(user_weighted)

# -------------------------------------------------------------------
# Exercises
# -------------------------------------------------------------------

# E1. Generate another metric set from the lidRmetrics package (voxel metrics may be slow).

# E2. Map ground return density at 5m resolution. Hint: filter = "-keep_class 2" and calculate points/m².

# E3. Estimate biomass using B = 0.5 * mean(Z) + 0.9 * 90th percentile(Z) on first returns only and map the result.
