# =======
# Aliases
# =======

# alias cat="bat" # this alias causes error. Fine if I put it in config.fish. ??
alias edit-aliases="hx ~/NixOS/home/dots/fish/conf.d/aliases-abbrs.fish && source ~/NixOS/home/dots/fish/conf.d/aliases-abbrs.fish"
alias conf="hx ~/NixOS/"
alias dg="nh clean user"
alias edit-broken="hx ~/bin/check_broken" # Edit list of currently broken packages
alias e="hx"
alias find-font="fc-list --format='%{family}\n' | grep"
alias gcroots="sudo nix-store --gc --print-roots | grep -Ev '^(/proc|/nix|/run)'"
alias gc="sudo nix store gc -v"
alias hydra="hydra-check --channel nixos-unstable --arch x86_64-linux"
alias jgp="jj git push"
alias jl="jj log"
alias less="bat --paging=always"
alias lg="lazygit"
alias logs="sudo lazyjournal"
alias lp="nix profile list"
alias more="bat --paging=always"
alias no="optnix -s nixos"
alias np="tv nix -i nixpkgs "
alias opt="nix-store --optimize"
alias ports="netstat -lntup"
alias rb="nh os switch ~/NixOS/"
# alias rb="nixos-rebuild switch --sudo --flake '/home/kev/NixOS#halcyon' && nix flake archive /home/kev/NixOS && /home/kev/bin/sysdiff"
alias referrer="nix-store --query --referrers"
alias repair-store="sudo nix-store --verify --check-contents --repair"
alias rev="nixos-version --hash | cut -c 1-7"
alias sct="systemctl-tui"
alias sg="nixos-rebuild list-generations"
alias sn="nh search"
alias storebin="nix-store -q --roots (which $argv)"
alias ugc="nix store gc -v"
alias ug="nix-env --list-generations"
alias up="nh os switch --update --ask ~/NixOS"
# alias up="nix flake update --flake /home/kev/NixOS"
alias verify-store="sudo nix-store --verify --check-contents"
alias windows="lswt"
alias y="yazi"
alias zzz="cd (fd . -td -tl -H -d2 -c always | fzf --height 50% --color=dark --ansi)" # search for dirs, change dir
alias zz="zi"

# =============
# Abbreviations
# =============
abbr -a --set-cursor='%' -- jbm 'jj bookmark move main -t @-'
abbr -a --set-cursor='%' -- jgc 'jj git clone --colocate %'
abbr -a --set-cursor='%' -- nor 'nixos-option -r % --flake ~/NixOS'
abbr -a --set-cursor='%' -- npg 'nix profile install github:%/'
abbr -a --set-cursor='%' -- npi 'nix profile install nixpkgs#%'
abbr -a --set-cursor='%' -- npis 'nix profile install nixpkgs/release-24.11#%'
abbr -a --set-cursor='%' -- nr 'nix run nixpkgs#%'
abbr -a --set-cursor='%' -- ns 'nix shell nixpkgs#% -c fish'
abbr -a --set-cursor='%' -- park 'nix profile install nixpkgs/(nixos-version --hash)#%'
abbr -a -- scu 'systemctl --user'
abbr -a --set-cursor='%' -- ytm 'yt-dlp -x --audio-format mp3 --audio-quality 320k %'
abbr -a --set-cursor='%' -- ytv "ytd-video %"
abbr -a -- ls lsd
abbr -a -- ll 'lsd -l'
