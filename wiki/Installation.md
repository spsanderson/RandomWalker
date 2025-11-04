# Installation Guide

This guide will help you install the RandomWalker package and set up your environment.

## System Requirements

### R Version
- **Minimum R version**: 4.1.0 or higher
- **Recommended**: Latest stable R release

Check your R version:
```r
R.version.string
```

### Operating Systems
RandomWalker works on all major operating systems:
- Windows (7 or later)
- macOS (10.13 or later)
- Linux (any modern distribution)

## Installation Methods

### Method 1: Install from CRAN (Stable Release)

The easiest way to install RandomWalker is from CRAN:

```r
install.packages("RandomWalker")
```

This installs the latest stable version (currently 1.0.0).

#### Verify CRAN Installation
```r
library(RandomWalker)
packageVersion("RandomWalker")
```

### Method 2: Install from GitHub (Development Version)

For the latest features and bug fixes, install the development version from GitHub:

```r
# Install devtools if you haven't already
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

# Install RandomWalker from GitHub
devtools::install_github("spsanderson/RandomWalker")
```

#### Alternative: Using remotes
```r
# Install remotes if you haven't already
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Install RandomWalker from GitHub
remotes::install_github("spsanderson/RandomWalker")
```

#### Install Specific Branch or Tag
```r
# Install a specific release tag
devtools::install_github("spsanderson/RandomWalker@v1.0.0")

# Install from a specific branch
devtools::install_github("spsanderson/RandomWalker@dev-branch")
```

### Method 3: Install from Source

If you have a source tarball (`.tar.gz` file):

```r
install.packages("path/to/RandomWalker_1.0.0.tar.gz", repos = NULL, type = "source")
```

Or from the command line:
```bash
R CMD INSTALL RandomWalker_1.0.0.tar.gz
```

## Dependencies

RandomWalker automatically installs the following required dependencies:

### Core Dependencies (Automatically Installed)
- **dplyr** - Data manipulation
- **tidyr** - Data tidying
- **purrr** - Functional programming
- **rlang** - R language tools
- **patchwork** - Combining plots
- **NNS** - Nonlinear statistics
- **ggiraph** - Interactive graphics

### Suggested Packages (Optional)
These packages enhance functionality but are not required:
- **knitr** - For building vignettes
- **rmarkdown** - For R Markdown support
- **stats** - Statistical functions (base R)
- **ggplot2** - Custom visualizations
- **tidyselect** - Selecting variables

#### Installing All Optional Dependencies
```r
install.packages("RandomWalker", dependencies = TRUE)
```

## Troubleshooting Installation Issues

### Issue: Package Version Too Old

**Problem**: R version is older than 4.1.0

**Solution**: Update R to the latest version
- Windows/Mac: Download from [CRAN](https://cran.r-project.org/)
- Linux: Use your package manager
  ```bash
  # Ubuntu/Debian
  sudo apt-get update
  sudo apt-get install r-base
  
  # Fedora/RHEL
  sudo dnf install R
  ```

### Issue: Dependency Installation Fails

**Problem**: Required packages fail to install

**Solution 1**: Install dependencies manually
```r
install.packages(c("dplyr", "tidyr", "purrr", "rlang", "patchwork", "NNS", "ggiraph"))
```

**Solution 2**: Check for system dependencies (Linux)
```bash
# Ubuntu/Debian - install required system libraries
sudo apt-get install libxml2-dev libcurl4-openssl-dev libssl-dev

# Fedora/RHEL
sudo dnf install libxml2-devel libcurl-devel openssl-devel
```

### Issue: GitHub Installation Fails

**Problem**: Cannot install from GitHub

**Solution 1**: Check internet connection and GitHub access

**Solution 2**: Install with authentication token (if accessing private repos)
```r
devtools::install_github("spsanderson/RandomWalker", 
                        auth_token = "your_github_token")
```

**Solution 3**: Use HTTPS instead of SSH
```r
devtools::install_github("spsanderson/RandomWalker")  # Uses HTTPS by default
```

### Issue: Compilation Errors (Linux/Mac)

**Problem**: Package compilation fails

**Solution**: Install build tools
```bash
# Ubuntu/Debian
sudo apt-get install build-essential

# macOS - Install Xcode Command Line Tools
xcode-select --install
```

### Issue: Permission Denied

**Problem**: Cannot write to R library location

**Solution 1**: Install to personal library
```r
install.packages("RandomWalker", lib = "~/R/library")
```

**Solution 2**: Create personal library directory
```r
dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)
.libPaths()  # Verify personal library is in the path
```

**Solution 3**: Use sudo (not recommended, but sometimes necessary)
```bash
sudo R
# Then in R console
install.packages("RandomWalker")
```

## Verifying Installation

After installation, verify everything works:

```r
# Load the package
library(RandomWalker)

# Check version
packageVersion("RandomWalker")

# Test basic functionality
walks <- rw30()
head(walks)

# Test visualization
walks |> visualize_walks()

# View help
?RandomWalker
```

## Updating RandomWalker

### Update from CRAN
```r
update.packages("RandomWalker")
```

### Update from GitHub
```r
devtools::install_github("spsanderson/RandomWalker", force = TRUE)
```

## Uninstalling RandomWalker

```r
remove.packages("RandomWalker")
```

## Docker Installation (Advanced)

For reproducible environments:

```dockerfile
FROM rocker/tidyverse:latest

# Install RandomWalker
RUN R -e "install.packages('RandomWalker')"

# Or install from GitHub
RUN R -e "devtools::install_github('spsanderson/RandomWalker')"
```

## RStudio Cloud

RandomWalker can be installed in RStudio Cloud:

1. Create a new project
2. In the Console, run:
   ```r
   install.packages("RandomWalker")
   ```

## conda Installation (Experimental)

If you use conda/mamba for R environments:

```bash
# Create new environment
conda create -n randomwalker-env r-base>=4.1

# Activate environment
conda activate randomwalker-env

# Install R and RandomWalker
R -e "install.packages('RandomWalker')"
```

## Next Steps

Now that you have RandomWalker installed, check out:
- **[Quick Start Guide](Quick-Start-Guide.md)** - Learn the basics
- **[Basic Concepts](Basic-Concepts.md)** - Understand random walks
- **[API Reference](API-Reference.md)** - Explore all functions

## Getting Help with Installation

If you encounter issues not covered here:

1. Check the [Troubleshooting Guide](Troubleshooting.md)
2. Search [GitHub Issues](https://github.com/spsanderson/RandomWalker/issues)
3. Ask in [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)
4. Open a new issue with:
   - Your R version (`R.version.string`)
   - Your OS and version
   - The complete error message
   - Steps to reproduce the problem

---

**Installation successful?** Head to the **[Quick Start Guide](Quick-Start-Guide.md)** to begin using RandomWalker!
