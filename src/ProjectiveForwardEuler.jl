function amplification_PFE(λ::Number, δt::Real, K::Int, Δt::Real)
  M = projective_M(δt, K, Δt)
  ρ = amplification_FE(λ, δt)
  factor = ((M + 1) * ρ − M) * ρ^K
  return factor
end

projective_M(δt::Real, K::Int, Δt::Real) = Δt / δt - (K + 1)

max_projective_K(δt::Real, Δt::Real) = floor(Int, Δt / δt - 1)

evaluations_PFE(δt::Real, K::Int, Δt::Real) = (K + 1) / Δt

function get_parameters_PFE(λ::AbstractArray)
  δt = get_parameters_FE(λ) * 0.99

  function f(rec)
    δt = 1 / rec
    K, Δt = find_optimal_K_Δt_PFE(λ, δt)
    E = (K > 1000) ? Inf : evaluations_PFE(δt, K, Δt)
    return E
  end

  rec = find_convex_minimum_growth(f, 1 / δt)
  δt = 1 / rec
  K, Δt = find_optimal_K_Δt_PFE(λ, δt)
  return δt, K, Δt
end
export get_parameters_PFE

function find_optimal_K_Δt_PFE(λ::AbstractArray, δt::Real)
  function f(Δt)
    try
      K = find_optimal_K_PFE(λ, δt, Δt)
    catch e
      if e isa InexactError
        return Inf
      else
        rethrow(e)
      end
    end
    E = (K > 1000) ? Inf : evaluations_PFE(δt, K, Δt)
    return E
  end
  Δt = find_convex_minimum_growth(f, δt)
  K = find_optimal_K_PFE(λ, δt, Δt)
  return K, Δt
end

function find_optimal_K_PFE(λ::AbstractArray, δt::Real, Δt::Real)
  f(K) = all(is_stable_PFE.(λ, δt, K, Δt))

  if f(1)
    return 1
  end

  K_initial = max_projective_K(δt, Δt)
  K = find_smallest_integer_true_bisection(f, 1, K_initial)
  return K
end
