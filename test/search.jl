using ProjectiveIntegrationParameters, Test

function largest_true_bisection(lim)
  f(x) = (x < lim)

  atol, rtol = 0, 1e-8
  x = find_largest_true_bisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 0, 1e-12
  x = find_largest_true_bisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 0, 1e-15
  x = find_largest_true_bisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 1e-1, 1e-12
  x = find_largest_true_bisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)
  @test !isapprox(x, lim; atol = 0, rtol)
end

function largest_true_growth(lim)
  f(x) = (x < lim)

  atol, rtol = 0, 1e-8
  x = find_largest_true_growth(f, lim / 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 0, 1e-12
  x = find_largest_true_growth(f, lim / 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 0, 1e-15
  x = find_largest_true_growth(f, lim / 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 1e-1, 1e-12
  x = find_largest_true_bisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)
  @test !isapprox(x, lim; atol = 0, rtol)
  return nothing
end

function smallest_integer_true_bisection(lim)
  f(x) = (x > lim)
  k = find_smallest_integer_true_bisection(f, 0, lim * 100)
  @test k == lim + 1
  return nothing
end

function convex_minimum_trisection(lim)
  f(x) = (x - lim)^4 / 4

  atol, rtol = 0, 1e-8
  x = find_convex_minimum_trisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 0, 1e-12
  x = find_convex_minimum_trisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 0, 1e-15
  x = find_convex_minimum_trisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 1e-1, 1e-12
  x = find_convex_minimum_trisection(f, lim / 100, lim * 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)
  @test !isapprox(x, lim; atol = 0, rtol)
end

function convex_minimum_growth(lim)
  f(x) = (x - lim)^4 / 4

  atol, rtol = 0, 1e-8
  x = find_convex_minimum_growth(f, lim / 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 0, 1e-12
  x = find_convex_minimum_growth(f, lim / 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 0, 1e-15
  x = find_convex_minimum_growth(f, lim / 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)

  atol, rtol = 1e-1, 1e-12
  x = find_convex_minimum_growth(f, lim / 100; atol, rtol)
  @test isapprox(x, lim; atol, rtol)
  @test !isapprox(x, lim; atol = 0, rtol)
end

function tests()
  largest_true_bisection(1)
  largest_true_bisection(100π)
  largest_true_growth(1)
  largest_true_growth(100π)
  smallest_integer_true_bisection(10)
  smallest_integer_true_bisection(54)
  convex_minimum_trisection(1)
  convex_minimum_trisection(100π)
  convex_minimum_growth(1)
  convex_minimum_trisection(100π)
  return nothing
end

tests()
