function rp
    set pkg (tv nix-profile)
    if test -n "$pkg"
        nix profile remove $pkg
    end
end
