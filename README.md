# ProjectiveIntegrationParameters.jl

[![Build Status](https://github.com/rafaelbailo/ProjectiveIntegrationParameters.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/rafaelbailo/ProjectiveIntegrationParameters.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Installation

```julia
] add git@github.com:rafaelbailo/ProjectiveIntegrationParameters.jl.git
```

## Usage

```julia
δt, K, Δt = get_parameters_PFE(λ)
```
where `λ` is an array of complex eigenvalues.
