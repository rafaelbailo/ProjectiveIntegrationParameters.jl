using ProjectiveIntegrationParameters
using SafeTestsets, Test

@testset "ProjectiveIntegrationParameters.jl" begin
  for test ∈ [#
    "aqua",
    "format",
    "search",
    "ForwardEuler",
    "ProjectiveIntegrationParameters",
  ]
    @eval begin
      @safetestset $test begin
        include($test * ".jl")
      end
    end
  end
end
