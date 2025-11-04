# RandomWalker Wiki

This directory contains comprehensive documentation for the RandomWalker R package.

## Wiki Structure

### Getting Started
- **[Home](Home.md)** - Wiki overview and navigation
- **[Installation](Installation.md)** - Installation instructions and troubleshooting
- **[Quick Start Guide](Quick-Start-Guide.md)** - Get up and running quickly
- **[Basic Concepts](Basic-Concepts.md)** - Understanding random walks

### Function Guides
- **[Automatic Random Walks](Automatic-Random-Walks.md)** - Using `rw30()` for instant results
- **[Continuous Distribution Generators](Continuous-Distribution-Generators.md)** - Normal, Brownian, Gamma, Beta, and 10+ more
- **[Discrete Distribution Generators](Discrete-Distribution-Generators.md)** - Binomial, Poisson, Geometric, and more
- **[Multi-Dimensional Walks](Multi-Dimensional-Walks.md)** - Working in 2D and 3D space

### Guides
- **[Visualization Guide](Visualization-Guide.md)** - Creating beautiful plots
- **[Statistical Analysis Guide](Statistical-Analysis-Guide.md)** - Computing summary statistics and analysis
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications

### Reference
- **[API Reference](API-Reference.md)** - Complete function documentation
- **[FAQ](FAQ.md)** - Frequently asked questions
- **[Troubleshooting](Troubleshooting.md)** - Common issues and solutions

### Contributing
- **[Contributing Guide](Contributing-Guide.md)** - How to contribute to the project

## Using This Wiki

### For GitHub Wiki

These markdown files are designed to be used as a GitHub Wiki. To set up:

1. Go to your repository's Wiki tab
2. Create pages with the same names (without .md extension)
3. Copy the content from each file

Links between pages will work automatically in GitHub Wiki format.

### For Local Documentation

You can read these files directly:
- Use any markdown viewer
- Use RStudio's markdown preview
- Use pandoc to convert to HTML:
  ```bash
  pandoc Home.md -o Home.html
  ```

### For pkgdown Site

These files can be adapted for use in a pkgdown articles/ directory if desired.

## Quick Links

- **Package Website**: https://www.spsanderson.com/RandomWalker/
- **GitHub Repository**: https://github.com/spsanderson/RandomWalker
- **Issue Tracker**: https://github.com/spsanderson/RandomWalker/issues
- **CRAN Page**: https://cran.r-project.org/package=RandomWalker

## Documentation Statistics

- **Total Pages**: 14
- **Total Words**: ~85,000
- **Total Size**: ~165 KB
- **Last Updated**: 2025-01-04

### Coverage

- ✅ Complete installation instructions
- ✅ Quick start guide with examples
- ✅ Detailed documentation for 27+ distribution generators
- ✅ Comprehensive visualization guide
- ✅ Statistical analysis methods
- ✅ Multi-dimensional walk support (1D, 2D, 3D)
- ✅ Real-world use cases (Finance, Physics, Biology, CS)
- ✅ 50+ FAQ entries
- ✅ Complete API reference
- ✅ Troubleshooting guide
- ✅ Contributing guidelines

## Contributing to the Wiki

Improvements to the wiki are welcome! See [Contributing Guide](Contributing-Guide.md) for details.

### How to Contribute

1. Fork the repository
2. Edit wiki files in the `wiki/` directory
3. Submit a pull request
4. Maintainers will review and merge

### Style Guidelines

- Use clear, concise language
- Include working code examples
- Add cross-references between pages
- Keep examples reproducible
- Follow existing formatting

## File Index

| File | Description | Size |
|------|-------------|------|
| Home.md | Wiki home page | 5.7 KB |
| Installation.md | Installation guide | 6.9 KB |
| Quick-Start-Guide.md | Quick start tutorial | 9.7 KB |
| Basic-Concepts.md | Random walk concepts | 10.4 KB |
| Automatic-Random-Walks.md | Using rw30() | 11.1 KB |
| Continuous-Distribution-Generators.md | Continuous distributions | 16.3 KB |
| Discrete-Distribution-Generators.md | Discrete distributions | 14.7 KB |
| Multi-Dimensional-Walks.md | 2D and 3D walks | 16.0 KB |
| Visualization-Guide.md | Plotting techniques | 14.9 KB |
| Statistical-Analysis-Guide.md | Analysis methods | 15.5 KB |
| Use-Cases-and-Examples.md | Real-world examples | 15.9 KB |
| API-Reference.md | Function reference | 15.1 KB |
| FAQ.md | Frequently asked questions | 13.2 KB |
| Troubleshooting.md | Common issues | 11.1 KB |
| Contributing-Guide.md | How to contribute | 10.6 KB |

## Maintenance

### Keeping Documentation Updated

- Review documentation when adding new functions
- Update examples when API changes
- Add new use cases as they emerge
- Keep troubleshooting guide current with common issues

### Documentation Testing

Before committing changes:

1. **Verify all examples run**:
   ```r
   library(RandomWalker)
   # Run examples from wiki pages
   ```

2. **Check all links work**:
   - Internal links between wiki pages
   - External links to resources

3. **Validate markdown syntax**:
   - Use a markdown linter
   - Preview in GitHub-flavored markdown viewer

## Contact

- **Issues**: Report documentation issues at [GitHub Issues](https://github.com/spsanderson/RandomWalker/issues)
- **Discussions**: Ask questions at [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)
- **Email**: spsanderson@gmail.com

---

**Made with ❤️ for the R community**
