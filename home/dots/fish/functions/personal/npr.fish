function npr
    nix profile list --json >/tmp/nix-profile.json
    set -f pkg (tv nix-profile)
    if test -n "$pkg"
        nix profile remove $pkg
    end
end
