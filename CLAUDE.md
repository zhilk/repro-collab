# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an R project for a reproducible research workshop on collaborative writing of academic texts using GitHub. The project creates a self-paced online workshop using R Bookdown that teaches reproducible research practices through an interactive, automated onboarding system.

## Development Commands

### Build System

- `make renv` - Restore R package dependencies using renv
- `make self-paced/` - Build the bookdown site from source files
- `make publish/` - Copy built site to publish directory

### Docker Development

- `docker build -f Dockerfile .` - Build Docker image with R environment
- Uses `rocker/verse:4.5.0` base image with renv for dependency management

### R Package Management

- `Rscript -e "renv::restore()"` - Restore packages from renv.lock
- Project uses renv for reproducible package management

## Project Structure

### Core Components

- `self-paced-source/` - Source files for the bookdown workshop
  - `index.Rmd` - Main entry point and introduction
  - `*.Rmd` - Workshop chapters
  - `functions.R` - Helper functions for generating HTML components
  - `_bookdown.yml` - Bookdown configuration
  - `_output.yml` - Output format configuration
- `self-paced/` - Built bookdown site (output directory)
- `publish/` - Final publication directory
- `data/` - CSV data files for workshop examples
- `R/read.R` - Data processing functions

### Configuration Files

- `repro-collab.Rproj` - RStudio project file with Makefile build type
- `renv.lock` - Locked package dependencies
- `Makefile` - Build automation
- `Dockerfile` - Container configuration for reproducible environment

## Workshop Content Architecture

The workshop is built using R Bookdown and includes:

- Interactive HTML components generated via whisker templates
- Custom CSS styling for info boxes and UI elements
- YAML-based link management system
- Automated cross-references and citations

## GitHub Actions Workflow System

The project uses an automated onboarding system through GitHub Actions:

### Key Workflows

- `.github/workflows/start.yml` - Triggered on fork, creates welcome issue with progress tracking
- `.github/workflows/continue.yml` - Milestone router that responds to `/done N` commands
- `.github/workflows/publish.yml` - Builds and publishes the workshop site to GitHub Pages

### Onboarding Process

The workshop guides users through collaborative GitHub workflows:

1. **Fork Creation**: Automatically creates tracking issue when repository is forked
2. **Milestone Tracking**: Users complete tasks and use `/done N` to mark progress
3. **Issue Management**: Teaches GitHub issue creation and management
4. **Pull Request Workflow**: Automated PR creation and review process
5. **Collaborative Writing**: Sequential collaboration using GitHub's web interface

### Interactive Features

- Cross-repository automation using `GH_PAT_CROSSREPO` token
- Automated issue creation in user forks
- Branch creation and PR management
- Levenshtein distance matching for flexible issue title recognition

## Data Processing

The project includes data reading utilities that:

- Process multiple CSV files from the `data/` directory
- Strip UUIDs from filenames to create clean identifiers
- Combine datasets using rbind operations

## Workshop Teaching Approach

Based on `Plan_outline.md`, the workshop emphasizes:

- **Sequential Collaboration**: Teams work one after another, not simultaneously
- **Weaker Person's Fork**: Uses the less experienced person's repository
- **UI-First Approach**: All interactions happen through GitHub's web interface
- **Practical Application**: Real preregistration writing and data collection
