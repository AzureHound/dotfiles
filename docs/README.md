# First build [bootstrap with flakes]

```bash
sudo nixos-rebuild switch --flake /etc/nixos#Notebook
```

```bash
sudo chown eden:users file/dir
```

---

```bash
crontab -e
```

# Battery logging every 30 minutes

```bash
*/30 * * * * /home/eden/.config/sway/scripts/battery-log
```

# One Off CMD

```bash
nix-shell -p libva-utils --run "vainfo"
```

---

# bat

```bash
bat cache --build
```

# Tailscale

```sh
sudo tailscale set --accept-routes=true
```

## .desktop PATH

```sh
/run/current-system/sw/share/applications
/etc/profiles/per-user/eden/share/applications
```

# Nix

```nix
nix run 'nixpkgs#htop'
```

# HASH

```sh
nix-prefetch-url --unpack https://github.com/viu-media/viu/archive/v3.2.7.tar.gz
```

```sh
sudo tailscale file get "/home/$USER/Downloads"
```

# Espanso

```sh
espanso service register # Register espanso as a systemd service (required only once)
```

# Searxng

```sh
echo "SEARXNG_SECRET=$(openssl rand -hex 32)" | sudo tee /etc/searxng.env
```