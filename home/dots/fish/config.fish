# FISH SHELL CONFIG

# Add `personal` subdir in `functions` to fish_function_path
set fish_function_path ~/.config/fish/functions/personal $fish_function_path

if status is-interactive
    # Commands to run in interactive sessionif status is-interactive
    switch (hostname)
        case halcyon
            zoxide init fish | source
            atuin init fish | source
            bind ctrl-down 'zi && commandline --function repaint'
            bind ctrl-up __fzf_cd
            set fish_greeting Halcyon NixOS
        case arch.halcyon
            set fish_greeting Halcyon Arch
    end

    set -gx ALTERNATE_EDITOR '' # For emacsclient - if no server, start one.
end

if status is-login
    # set -gx YDOTOOL_SOCKET /run/ydotoold/socket
end

# Created by `pipx` on 2023-05-25 21:07:51
set PATH $PATH /home/kev/.local/bin /home/kev/.config/emacs/bin /home/kev/.cargo/bin /home/kev/NixOS/home/dots/bin
# set -gx DISPLAY :1
# set fish_function_path $fish_function_path $__fish_config_dir/functions/*/
