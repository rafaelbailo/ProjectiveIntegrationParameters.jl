using ProjectiveIntegrationParameters, JuliaFormatter, Test

function tests()
  f(s) = format(s)
  @test f("..")
end

tests()
