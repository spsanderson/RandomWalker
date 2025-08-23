# RandomWalker R Package Development Instructions

**ALWAYS reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

RandomWalker is an R package that generates random walks of various types compatible with the tidyverse suite of packages. The package provides functions for creating, visualizing, and summarizing random walks using distributions like normal, binomial, Brownian motion, and many others.

## Working Effectively

### Environment Setup
- Install R and core dependencies:
  ```bash
  sudo apt update && sudo apt install -y r-base
  sudo apt install -y r-cran-knitr r-cran-rmarkdown r-cran-devtools
  sudo apt install -y r-cran-dplyr r-cran-tidyr r-cran-purrr r-cran-rlang r-cran-ggplot2 r-cran-patchwork
  ```
- **NEVER CANCEL**: Dependency installation takes 5-15 minutes. NEVER CANCEL. Set timeout to 30+ minutes.

### Package Development and Testing
- **Test individual functions** (recommended approach):
  ```bash
  cd /path/to/RandomWalker
  R -e "library(dplyr); library(tidyr); source('R/auto-rw30.R'); set.seed(123); result <- rw30(); head(result, 10)"
  ```
- **Test core functionality** - takes 30-60 seconds:
  ```bash
  R -e "source('R/helpers.R'); source('R/vec-cumulative-functions.R'); source('R/stats-walk-summary.R')"
  ```
- **Documentation check**:
  ```bash
  R -e "tools::checkRd(list.files('man', pattern='\\\\.Rd$', full.names=TRUE)[1])"
  ```
- **Package build attempt** (may fail due to missing dependencies):
  ```bash
  cd .. && R CMD build RandomWalker
  ```
  - **WARNING**: Build may fail due to missing NNS and ggiraph packages. This is expected.
  - **NEVER CANCEL**: If build works, takes 5-10 minutes. Set timeout to 15+ minutes.

### Validation Requirements
**ALWAYS validate changes using these scenarios:**

1. **Core Random Walk Generation**:
   ```bash
   R -e "library(dplyr); library(tidyr); source('R/auto-rw30.R'); set.seed(123); rw <- rw30(); stopifnot(nrow(rw) == 3000, ncol(rw) == 3, all(c('walk_number', 'step_number', 'y') %in% names(rw)))"
   ```

2. **Function Loading Test**:
   ```bash
   R -e "source('R/helpers.R'); source('R/vec-cumulative-functions.R'); print('All helper functions loaded successfully')"
   ```

3. **Documentation Validation**:
   ```bash
   R -e "length(list.files('man', pattern='\\\\.Rd$'))" # Should return 56
   ```

4. **Additional Random Walk Generator Test**:
   ```bash
   R -e "library(dplyr); library(tidyr); source('R/gen-random-normal-walk.R'); source('R/helpers.R'); source('R/vec-cumulative-functions.R'); set.seed(123); rw <- random_normal_walk(.num_walks=10, .n=50); stopifnot(nrow(rw) == 400, ncol(rw) >= 3)"
   ```

## Package Structure and Key Locations

### Critical Files and Directories
```
RandomWalker/
├── DESCRIPTION          # Package metadata and dependencies
├── NAMESPACE           # Exported functions (60+ functions)
├── R/                  # Core R source code (35+ files)
│   ├── auto-rw30.R     # Main function: generates 30 random walks
│   ├── helpers.R       # Utility functions
│   ├── gen-*.R         # Random walk generators for different distributions
│   ├── plt-visualize-walks.R # Visualization functions
│   └── stats-walk-summary.R  # Summary and statistics functions
├── man/               # Documentation files (60+ .Rd files)
├── vignettes/         # Package vignettes
│   └── getting-started.Rmd
├── docs/              # pkgdown website
├── README.Rmd         # Source for README.md (edit this, not README.md)
└── _pkgdown.yml       # Website configuration
```

### Key Functions by Category
- **Auto Random Walk**: `rw30()` - generates 30 walks with 100 steps each
- **Custom Generators**: `random_normal_walk()`, `brownian_motion()`, `geometric_brownian_motion()`
- **Distribution-specific**: `random_beta_walk()`, `random_binomial_walk()`, `random_cauchy_walk()`, etc.
- **Visualization**: `visualize_walks()` 
- **Summary**: `summarize_walks()`, `summarise_walks()`
- **Utilities**: `euclidean_distance()`, `confidence_interval()`, cumulative functions

## Development Workflow

### Making Changes to R Functions
1. **Edit source files** in `R/` directory
2. **Test immediately**:
   ```bash
   R -e "source('R/your-modified-file.R'); # test your function"
   ```
3. **Update documentation** if function signatures change
4. **Validate with core scenarios** above

### Documentation Updates
- **Edit README.Rmd** (NOT README.md) for package description changes
- **Regenerate README.md**:
  ```bash
  R -e "knitr::knit('README.Rmd')"
  ```
- **.Rd files** are auto-generated from roxygen2 comments in R source files

### Common Development Commands
- **Check R syntax**: R files should source without errors
- **Test package loading**: Individual functions can be sourced and tested
- **Documentation**: Use roxygen2 comments in R source files
- **Dependencies**: Core tidyverse packages available; NNS and ggiraph may be missing

## Important Notes and Warnings

### Build Limitations
- **Full package build may fail** due to missing dependencies (NNS, ggiraph)
- **This is expected and normal** - focus on testing individual functions
- **Do NOT attempt to install missing packages** - they may not be available in the environment

### Timing Expectations
- **Function testing**: 30-60 seconds (measured: rw30() takes ~0.6 seconds)
- **Documentation checks**: 1-2 minutes  
- **README generation**: 1-2 minutes
- **Package building** (if successful): 5-10 minutes, NEVER CANCEL
- **Dependency installation**: 5-15 minutes, NEVER CANCEL

### Critical Validation
- **ALWAYS test rw30() function** after changes to core functionality
- **Verify tibble output** has correct structure (3000 rows, 3 columns)
- **Check function loading** for any modified R source files
- **Test with set.seed(123)** for reproducible results

### Repository Quirks
- **No formal test suite** - validation relies on functional testing scenarios above
- **README.md is generated** from README.Rmd - always edit the .Rmd file
- **Heavy use of tidyverse** - ensure dplyr, tidyr, purrr functions work correctly
- **Multiple random walk types** - test the specific generator you're working on

## Common Tasks Reference

### Quick Function Test
```bash
cd /path/to/RandomWalker
R -e "library(dplyr); library(tidyr); source('R/auto-rw30.R'); rw30() |> head()"
```

### Documentation Check
```bash
R -e "tools::checkRd('man/rw30.Rd')"
```

### Source All Helper Functions  
```bash
R -e "sapply(list.files('R', pattern='helpers|vec-', full.names=TRUE), source); print('Helpers loaded')"
```

### Package Structure Overview
```bash
find . -name "*.R" | wc -l  # Should show 37 R source files
find man -name "*.Rd" | wc -l  # Should show 56 documentation files
```

**Remember: Always start with the validation scenarios above when testing any changes to ensure the package functionality remains intact.**

## Comprehensive End-to-End Validation

For major changes, run this comprehensive validation:

```bash
R -e "
# Comprehensive end-to-end scenario
library(dplyr); library(tidyr)
source('R/auto-rw30.R'); source('R/helpers.R'); source('R/vec-cumulative-functions.R')
source('R/stats-walk-summary.R'); source('R/gen-random-normal-walk.R')

# Test core functionality
set.seed(123); rw <- rw30()
stopifnot(nrow(rw) == 3000, ncol(rw) == 3)

# Test custom generators  
set.seed(123); custom_rw <- random_normal_walk(.num_walks=10, .n=50)
stopifnot(nrow(custom_rw) == 400, ncol(custom_rw) >= 3)

# Test reproducibility
set.seed(123); rw2 <- rw30(); stopifnot(identical(rw, rw2))

cat('SUCCESS: All validation scenarios passed!\n')
"
```

This comprehensive test takes approximately 5-10 seconds and validates:
- Core random walk generation (rw30)
- Custom random walk generators  
- Data structure integrity
- Reproducibility with seeds
- Function loading and dependencies