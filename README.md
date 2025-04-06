# ProjectiveIntegrationParameters.jl

[![Build Status](https://github.com/rafaelbailo/ProjectiveIntegrationParameters.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/rafaelbailo/ProjectiveIntegrationParameters.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/rafaelbailo/ProjectiveIntegrationParameters.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/rafaelbailo/ProjectiveIntegrationParameters.jl)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Installation

```julia
] add git@github.com:rafaelbailo/ProjectiveIntegrationParameters.jl.git
```

## Usage

```julia
using ProjectiveIntegrationParameters
δt, K, Δt = get_parameters_PFE(λ)
```
where `λ` is an array of complex eigenvalues.
