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
| Claude Code | `dot_claude/settings.json` | `~/.claude/settings.json` |
| Apps | `winget/packages.json` | installed by `run_onchange_before_10-winget.ps1.tmpl` |
| Windows settings | `run_onchange_after_30-windows-settings.ps1` | Explorer options, Developer Mode |
| WSL config | `dot_wslconfig` | `~/.wslconfig` |
| WSL | `run_onchange_after_40-wsl.ps1` | installs WSL 2 + Ubuntu (admin) |
| WSL Linux configs | `wsl/home/` | `~` inside Ubuntu, via `wsl/setup.sh` |

nvim is the default editor (`$EDITOR`, git). Plugins install on first launch (lazy.nvim); treesitter
parsers are compiled with zig. Zellij starts locked: `Ctrl g` unlocks it, and `zellij --layout agent`
opens Claude next to lazygit and a shell.

Git commit signing is turned on automatically once `~/.ssh/id_ed25519.pub` exists (run `chezmoi apply` after creating the key).

## New machine

```powershell
winget install twpayne.chezmoi
git clone https://github.com/Sviatoslav93/windows-dotfiles.git D:\windows-dotfiles
chezmoi init --source D:\windows-dotfiles
chezmoi apply
```

`apply` installs the winget packages, then the PowerShell module PSFzf, then writes the configs, then
applies the Windows settings (show file extensions and hidden files; Developer Mode only when run as admin).

Only `~/.claude/settings.json` is tracked from `~/.claude`: the rest of that folder (and `~/.claude.json`)
holds login tokens and chat history and must never be committed.

## WSL

Run as admin, `chezmoi apply` installs WSL 2 with Ubuntu. After that, reboot and open **Ubuntu** once to
create your Linux user. Then set up the Linux side from PowerShell:

```powershell
wsl -d Ubuntu -- bash /mnt/d/windows-dotfiles/wsl/setup.sh
```

`wsl/home/` holds a WSL-only copy of a few configs from the Linux dotfiles
(github.com/Sviatoslav93/dotfiles): git, zsh, starship, nvim, lazygit and zellij. `setup.sh` installs
the tools they need (zsh plugins via antidote, Neovim 0.11+, lazygit, zellij, starship, fzf, ripgrep,
eza, zoxide, delta), copies the configs into `~`, and makes zsh the default shell. Re-run it after
editing anything in `wsl/home/`. Commit signing in WSL turns on only if `~/.ssh/id_ed25519.pub` exists there.

After editing `~/.wslconfig`, run `wsl --shutdown` so the new settings take effect.

## Daily use

- Edit files here, then `chezmoi diff` and `chezmoi apply`.
- Changed something in an app's UI (e.g. Windows Terminal settings)? `chezmoi re-add` copies it back into the repo.
- New app: add it to `winget/packages.json`; the next `chezmoi apply` installs it.
