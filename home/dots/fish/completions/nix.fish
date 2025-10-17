# ~/.config/fish/completions/nix.fish

# Completion for `nix profile remove`
complete -c nix -n '__fish_seen_subcommand_from profile; and __fish_seen_subcommand_from remove' \
    -a '(nix profile list | grep Name: | cut -c 21-)' \
    -d Package \
    --no-files
