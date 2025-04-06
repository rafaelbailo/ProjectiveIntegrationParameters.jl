for method ∈ [:FE, :PFE]
  amplification_method = Symbol(:amplification_, method)
  abs_amplification_method = Symbol(:abs_amplification_, method)
  is_stable_method = Symbol(:is_stable_, method)
  is_unstable_method = Symbol(:is_unstable_, method)
  @eval begin
    $(abs_amplification_method)(args...) = abs($(amplification_method)(args...))
    $(is_stable_method)(args...) = $(abs_amplification_method)(args...) <= 1
    $(is_unstable_method)(args...) = !$(is_stable_method)(args...)
  end
end
