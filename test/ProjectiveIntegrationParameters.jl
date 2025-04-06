using ProjectiveIntegrationParameters, Test

import ProjectiveIntegrationParameters.circle_PFE_spectrum

function tests()
  for ε ∈ [1e-3, 1e-5, 1e-7]
    λ = circle_PFE_spectrum(1e-1, ε)
    δt, K, Δt = get_parameters_PFE(λ)
    @test isapprox(δt, ε, rtol = 1e-1)
    @test isapprox(Δt, 1e-1, rtol = 2e-1)
  end
  return nothing
end

tests()
