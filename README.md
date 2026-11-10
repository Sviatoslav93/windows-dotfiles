# Windows dotfiles

Windows-only dotfiles, managed with [chezmoi](https://chezmoi.io). Kept separate from the
Linux dotfiles (github.com/Sviatoslav93/dotfiles); the starship, git and Alacritty configs started as ports of those.

## What's here

| Config | Source (this repo) | Target |
|---|---|---|
| PowerShell 7 profile | `Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | `$PROFILE` |
| Starship | `dot_config/starship.toml` | `~/.config/starship.toml` |
| Git | `dot_config/git/config.tmpl`, `ignore` | `~/.config/git/` |
| Alacritty | `AppData/Roaming/alacritty/` | `%APPDATA%\alacritty\` |
| Windows Terminal | `AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json` | same under `%USERPROFILE%` |
| Neovim | `AppData/Local/nvim/` | `%LOCALAPPDATA%\nvim\` |
| Zellij | `AppData/Roaming/Zellij/config/` | `%APPDATA%\Zellij\config\` |
| lazygit | `AppData/Local/lazygit/config.yml` | `%LOCALAPPDATA%\lazygit\` |
| Apps | `winget/packages.json` | installed by `run_onchange_before_10-winget.ps1.tmpl` |

nvim is the default editor (`$EDITOR`, git). Plugins install on first launch (lazy.nvim); treesitter
parsers are compiled with zig. Zellij starts locked: `Ctrl g` unlocks it, and `zellij --layout agent`
opens Claude next to lazygit and a shell.

Git commit signing is turned on automatically once `~/.ssh/id_ed25519.pub` exists (run `chezmoi apply` after creating the key).

## New machine

```powershell
winget install twpayne.chezmoi
git clone <this repo> D:\windows-dotfiles
chezmoi init --source D:\windows-dotfiles
chezmoi apply
```

`apply` installs the winget packages, then the PowerShell module PSFzf, then writes the configs.

## Daily use

- Edit files here, then `chezmoi diff` and `chezmoi apply`.
- Changed something in an app's UI (e.g. Windows Terminal settings)? `chezmoi re-add` copies it back into the repo.
- New app: add it to `winget/packages.json`; the next `chezmoi apply` installs it.
