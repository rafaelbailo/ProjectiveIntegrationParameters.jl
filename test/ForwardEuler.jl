using ProjectiveIntegrationParameters, Test

import ProjectiveIntegrationParameters.circle_FE_spectrum

function tests()
  for ε ∈ [1e-1, 1e-5, 1e-8]
    λ = circle_FE_spectrum(ε)
    Δt = get_parameters_FE(λ)
    @test isapprox(Δt, ε)
  end
  return nothing
end

tests()
