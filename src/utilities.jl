function eigen_cluster(centre::Number, radius::Real, number::Int)
  return [
    centre + sqrt(rand()) * radius * exp(2π * im * rand()) for k ∈ 1:number
  ]
end

function eigen_circle(centre::Number, radius::Real, number::Int)
  return [centre + radius * exp(2π * im * k / number) for k ∈ 1:number]
end

function typical_FE_spectrum(ε::Real)
  modes = eigen_cluster(-1 / ε, 1 / ε, 100)
  return vcat(modes, conj(modes))
end

circle_FE_spectrum(ε::Real) = eigen_circle(-1 / ε, 1 / ε, 100)

for mode ∈ [:typical, :circle]
  FE = Symbol(mode, :_FE_spectrum)
  PFE = Symbol(mode, :_PFE_spectrum)
  @eval begin
    function $(PFE)(ε₀::Real, ε::Real)
      return vcat($(FE)(ε₀), map(s -> 0.5 * (s + 1 / ε) - 1 / ε, $(FE)(ε)))
    end
  end
end
