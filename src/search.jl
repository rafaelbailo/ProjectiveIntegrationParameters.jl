function tolerance_condition(
  a::Float64,
  b::Float64,
  atol::Float64,
  rtol::Float64,
)
  return abs(b - a) <= max(atol, rtol * max(abs(a), abs(b)))
end

function find_largest_true_bisection_iteration(
  f::Function,
  lower_bound::Float64,
  upper_bound::Float64,
  atol::Float64,
  rtol::Float64,
)
  if tolerance_condition(lower_bound, upper_bound, atol, rtol)
    return lower_bound
  end

  middle_point = (lower_bound + upper_bound) / 2
  check = f(middle_point)
  if check
    return find_largest_true_bisection_iteration(
      f,
      middle_point,
      upper_bound,
      atol,
      rtol,
    )
  else
    return find_largest_true_bisection_iteration(
      f,
      lower_bound,
      middle_point,
      atol,
      rtol,
    )
  end
  return nothing
end

function find_largest_true_growth_iteration(
  f::Function,
  initial_point::Float64,
  atol::Float64,
  rtol::Float64,
)
  next_point = 2.0 * initial_point

  check = f(next_point)
  if check
    return find_largest_true_growth_iteration(f, next_point, atol, rtol)
  else
    return find_largest_true_bisection(f, initial_point, next_point; atol, rtol)
  end
  return nothing
end

function find_smallest_integer_true_bisection_iteration(
  f::Function,
  lower_bound::Int,
  upper_bound::Int,
)
  if upper_bound == lower_bound + 1
    return upper_bound
  end

  middle_point = (lower_bound + upper_bound) ÷ 2
  check = f(middle_point)
  if check
    return find_smallest_integer_true_bisection_iteration(
      f,
      lower_bound,
      middle_point,
    )
  else
    return find_smallest_integer_true_bisection_iteration(
      f,
      middle_point,
      upper_bound,
    )
  end
  return nothing
end

function find_convex_minimum_trisection_iteration(
  f::Function,
  lower_bound::Float64,
  lower_value::Float64,
  upper_bound::Float64,
  upper_value::Float64,
  atol::Float64,
  rtol::Float64,
)
  if tolerance_condition(lower_bound, upper_bound, atol, rtol)
    return lower_bound
  end

  first_third = (2 * lower_bound + upper_bound) / 3
  second_third = (lower_bound + 2 * upper_bound) / 3
  first_value = f(first_third)
  second_value = f(second_third)
  if first_value <= second_value
    return find_convex_minimum_trisection_iteration(
      f,
      lower_bound,
      lower_value,
      second_third,
      second_value,
      atol,
      rtol,
    )
  else
    return find_convex_minimum_trisection_iteration(
      f,
      first_third,
      first_value,
      upper_bound,
      upper_value,
      atol,
      rtol,
    )
  end
  return nothing
end

function find_convex_minimum_growth_iteration(
  f::Function,
  initial_point::Float64,
  initial_value::Float64,
  growth::Float64,
  atol::Float64,
  rtol::Float64,
)
  second_point = growth * initial_point
  third_point = growth * second_point
  second_value = f(second_point)
  third_value = f(third_point)

  check = second_value < third_value
  if check
    return find_convex_minimum_trisection(
      f,
      initial_point,
      third_point;
      atol,
      rtol,
    )
  else
    return find_convex_minimum_growth_iteration(
      f,
      initial_point,
      initial_value,
      2 * growth,
      atol,
      rtol,
    )
  end
  return nothing
end

function find_largest_true_bisection(
  f::Function,
  lower_bound::Real,
  upper_bound::Real;
  atol::Real = 0.0,
  rtol::Real = 1e-8,
)
  @assert lower_bound < upper_bound
  @assert f(lower_bound)
  @assert !f(upper_bound)
  return find_largest_true_bisection_iteration(
    f,
    Float64(lower_bound),
    Float64(upper_bound),
    Float64(atol),
    Float64(rtol),
  )
end
export find_largest_true_bisection

function find_largest_true_growth(
  f::Function,
  initial_point::Real;
  atol::Real = 0.0,
  rtol::Real = 1e-8,
)
  @assert initial_point > 0
  @assert f(initial_point)
  return find_largest_true_growth_iteration(
    f,
    Float64(initial_point),
    Float64(atol),
    Float64(rtol),
  )
end
export find_largest_true_growth

function find_smallest_integer_true_bisection(
  f::Function,
  lower_bound::Int,
  upper_bound::Int,
)
  @assert lower_bound < upper_bound
  @assert !f(lower_bound)
  @assert f(upper_bound)
  return find_smallest_integer_true_bisection_iteration(
    f,
    lower_bound,
    upper_bound,
  )
end
export find_smallest_integer_true_bisection

function find_convex_minimum_trisection(
  f::Function,
  lower_bound::Real,
  upper_bound::Real;
  atol::Real = 0.0,
  rtol::Real = 1e-8,
)
  lower_value = f(lower_bound)
  upper_value = f(upper_bound)
  return find_convex_minimum_trisection_iteration(
    f,
    Float64(lower_bound),
    lower_value,
    Float64(upper_bound),
    upper_value,
    Float64(atol),
    Float64(rtol),
  )
end
export find_convex_minimum_trisection

function find_convex_minimum_growth(
  f::Function,
  initial_point::Real;
  atol::Real = 0.0,
  rtol::Real = 1e-8,
)
  initial_value = f(initial_point)
  return find_convex_minimum_growth_iteration(
    f,
    Float64(initial_point),
    initial_value,
    2.0,
    Float64(atol),
    Float64(rtol),
  )
end
export find_convex_minimum_growth
