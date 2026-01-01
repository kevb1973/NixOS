function npu
    set -f pkg (tv nix-profile)
    if test -n "$pkg"
        nix profile upgrade $pkg
    end
end
