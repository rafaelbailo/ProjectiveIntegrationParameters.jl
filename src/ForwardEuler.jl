function amplification_FE(λ::Number, Δt::Real)
  factor = 1 + λ * Δt
  return factor
end

evaluations_FE(Δt::Real) = 1.0 / Δt

get_parameters_FE(λ::AbstractArray) = find_stable_Δt_FE(λ)
export get_parameters_FE

function find_stable_Δt_FE(λ::AbstractArray; Δt_initial::Real = 1e8)
  f(Δt) = all(is_stable_FE.(λ, Δt))

  if f(Δt_initial)
    return Δt_initial
  end

  Δt = find_largest_true_bisection(f, 0, Δt_initial)
  return Δt
end
