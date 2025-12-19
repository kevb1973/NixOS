
## launch - aichat
```bash
kitty --detach aichat -m llama-cpp:gemma3-4b -r concise -s session --empty-session
```
## launch - atq manager
```bash
kitty --detach tv atq
```
## launch - btop
```bash
kitty --detach btop
```
## launch - color picker (hex/rgb)
```bash
niri msg action spawn -- niri-pick-color
```
## launch - color picker (hex with zoom)
```bash
niri msg action spawn -- hyprpicker -f hex -a
```
## launch - explore environment
```bash
kitty --detach tv env
```
## launch - firefox
```bash
niri msg action spawn -- firefox
```
## launch - helix
```bash
kitty --detach hx
```
## launch - neovide
```bash
niri msg action spawn-sh -- "cd ~/NixOS; neovide" 
```
## launch - podman-tui
```bash
kitty --detach podman-tui
```
## launch - rmpc
```bash
kitty --detach rmpc
```
## launch - spotify
```bash
niri msg action spawn -- spotify --no-zygote
```
## launch - systemctl-tui
```bash
kitty --detach systemctl-tui
```
## launch - puddletag - music tag editor
```bash
niri msg action spawn -- puddletag
```
## launch - timer (peaclock)
```bash
kitty --detach --app-id=timer peaclock
```
## launch - yazi
```bash
kitty --detach yazi ~
```
## launch - zen-browser
```bash
niri msg action spawn -- zen
```
