function npu
    set pkg (tv nix-profile)
    if test -n "$pkg"
        nix profile upgrade $pkg
    end
end
