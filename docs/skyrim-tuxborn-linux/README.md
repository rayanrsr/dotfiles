# Tuxborn on Linux (CachyOS) via Jackify

Tuxborn is a Wabbajack modlist built *for* Linux and the Steam Deck by the author of Jackify, so
unlike a Windows-only pack it is not fighting the platform. This documents the install on a desktop
machine and the six places it actually goes wrong.

**Status: working as of 2026-09-20.** 1,371 mods, 1,484 plugins. RTX 5070 Ti (16 GB),
Ryzen 7 5700X3D, 62 GB RAM, CachyOS/Hyprland. Paths are this machine's; adjust them.

Replaces [`../skyrim-thana-khan-linux/`](../skyrim-thana-khan-linux/), which was retired because its
look depends on ENB and ENB does not render in-game under Proton.

---

## Requirements, as actually observed

| | Value | Note |
|---|---|---|
| Skyrim SE | **1.6.1170** | The wiki says 1.7.104. **The published modlist expects 1.6.1170** — trust the installer's error, not the docs. |
| Anniversary Edition DLC | **required, paid** | The four free Creations are not enough. Tuxborn wants files like `ccbgssse012-hrsarmrstl.esl`. |
| Language | **English** | |
| Disk | 344 GB | plus a separate downloads dir |
| Proton | GE-Proton 10-14 | recommended by Jackify; newer builds break ENB |

## Tooling

```bash
# Jackify is on GitHub - no Nexus login needed for the tool itself
curl -fL -o Jackify.AppImage \
  https://github.com/Omni-guides/Jackify/releases/download/v0.8.1.1/Jackify.AppImage
chmod +x Jackify.AppImage

sudo pacman -S fuse2          # AppImages need FUSE2; FUSE3 alone is not enough
uv tool install protontricks  # avoids sudo; winetricks must already be present
```

GE-Proton 10-14 into `~/.steam/root/compatibilitytools.d/`:

```bash
curl -fL -O https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton10-14/GE-Proton10-14.tar.gz
tar xzf GE-Proton10-14.tar.gz -C ~/.steam/root/compatibilitytools.d/
```

## Layout

```
MegaDrive/Games/Jackify/Jackify.AppImage
MegaDrive/Games/Tuxborn/                     install target (no spaces in the path)
MegaDrive/Games/Modlist_Downloads/Tuxborn/   downloads
```

---

## The six things that go wrong

### 1. Steam reinstalls *over* leftover mod files

Uninstalling Skyrim through Steam removes only files Steam owns. A previous modlist's `Data` survives —
here, 190 GB and 1,939 plugins remained, and the reinstall layered 16 GB of vanilla on top of it.
Tuxborn will not install onto that.

```bash
rm -rf "$LIBRARY/steamapps/common/Skyrim Special Edition"
# then Steam -> Properties -> Installed Files -> Verify integrity
```

Verify the result is ~15 GB and ~10 plugins before continuing.

### 2. Rare Curios must come from in-game Creations, not the Steam depot

Same filename, different hash. The Steam-delivered copy fails Jackify's check:

```
One or more Skyrim Anniversary Edition Creation Club files were not found (ccbgssse037-curios.esl)
```

Delete both `ccBGSSSE037-Curios.bsa` and `.esl` from `Data`, then in-game:
**Creations → Category → Creation Club → Rare Curios → download**. Do not alt-tab while it downloads —
losing focus stops it, and with `follow_mouse = 1` on Hyprland the pointer crossing to another monitor
is enough. `hyprctl keyword input:follow_mouse 0` for the duration.

### 3. Never run Steam "Verify Integrity" after this point

It re-delivers the depot versions and undoes both the downgrade and the Creations files.

### 4. The downgrade tool defaults to the wrong two fields

Jackify → **Additional Tasks → Downgrade Game Version**:

| Field | Default | Set to |
|---|---|---|
| Game | *Skyrim Special Edition: **Creation Kit*** | **Skyrim Special Edition** |
| Downgrade to | 1.6.1130 "Recommended" | **1.6.1170** |

Leaving Game on Creation Kit produces `Download the free Creation Kit through Steam and run it once
first`, which is not the real problem. Keep "Create full backup" checked.

Afterwards the manifest still records the *new* `buildid` while the files on disk are the old version.
That is normal for a steamcmd downgrade and works in your favour: Steam sees no pending update.

### 5. `Failed to delete` / `Failed to copy` in `mo_interface.log` is usually a stale wineserver

```
[RootBuilder] Failed to delete Game Root\skse64_1_6_1170.dll
[RootBuilder] Failed to copy   mods\SSE Engine Fixes (skse64 plugin)\Root\tbb.dll
```

Looks fatal, usually isn't — a previous `wineserver` still holds those DLLs open read-only:

```bash
lsof "$TUXBORN/Game Root"/*.dll
pgrep -a wineserver
```

Kill the stale wineserver and relaunch. Compare sizes in `Game Root` against `mods/*/Root` to confirm
the deployment is actually correct before chasing RootBuilder.

### 6. Profile defaults to Deck

MO2's dropdown starts on **Tuxborn - Deck** — Steam Deck settings. On a desktop GPU switch to
**Tuxborn - Desktop**. `TuxBFCO - *` are the same list with BFCO combat animations.

Quit the game before switching profiles.

---

## Install order

1. Clean Skyrim install (§1), 1.7.104 + English, all Creations downloaded in-game
2. `Jackify.AppImage` → Add a Modlist → Skyrim → Authorise (Nexus OAuth) → Tuxborn
3. Directories above, resolution 3840x2160 → Start
4. **Non-premium: every mod is a manual browser download.** Jackify opens two Nexus tabs at a time,
   validates, and queues the next pair. Leave that dialog open.
5. Unattended for a few hours — extract, texture conversion, BSA building, Steam shortcut, prefix
6. Downgrade to 1.6.1170 (§4), re-run the install
7. Launch "Tuxborn" from Steam → MO2 → profile → Run

## While playing

**Do not click "Unblock"** on MO2's `The application must run to completion because its output is
required` dialog. It is normal and clicking it breaks the install.

First launch compiles shaders and is slow; a crash or two on early launches is documented as expected
for this list.

## Diagnostics

```bash
tail -40 "$TUXBORN/logs/mo_interface.log"    # RootBuilder deployment
ls -la "$TUXBORN/crashDumps"
find "$TUXBORN/overwrite/SKSE/Plugins" -name '*.log'   # SKSE plugins that ran
nvidia-smi --query-gpu=memory.used,utilization.gpu,temperature.gpu --format=csv
```

A frozen image with a healthy framerate is not a hang. High CPU with an idle, cool GPU is a spin.
