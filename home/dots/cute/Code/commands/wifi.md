## wifi - Enable Radio
```bash
rfkill unblock 1
```
## wifi - Disable Radio
```bash
rfkill block 1
```
## wifi - connect (wpa_gui)
```bash
niri msg action spawn -- wpa_gui
```