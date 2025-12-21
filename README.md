# NixOS Configuration

This repository contains a declarative and reproducible NixOS system configuration. It is managed using **Nix Flakes** and **Home Manager**, designed to provide a cohesive and high-performance environment for development and daily usage.

> [!WARNING] Hardware Specificity: This configuration is tailored for specific hardware (AMD GPU). Review the 'hardware/' directory and adjust settings to match your system before applying. Creating your own 'hardware-configuration.nix' is mandatory.

> [!IMPORTANT] Installation: Do not use the 'hardware-configuration.nix' provided in this repository. Generate one during your installation process to ensure correct filesystem UUIDs and kernel modules for your machine.

## System Overview

The system is built around the **Niri** window manager, offering a dynamic and infinite scrolling tiling experience.

- **Window Manager**: Niri
- **Shell**: Nushell
- **Terminal Emulator**: Ghostty, Kitty
- **Editor**: Visual Studio Code
- **Package Management**: Nixpkgs, Home Manager, Flox, Chaotic Nyx

## Repository Structure

The configuration is organized into a modular directory structure:

- **`flake.nix`**: The entry point defining inputs and system outputs.
- **`boot/`**: Bootloader (Systemd-boot/GRUB) and kernel parameter configurations.
- **`comp/`**: Desktop environment components and XDG portal settings.
- **`hardware/`**: Hardware-specific configurations, including AMDGPU drivers and filesystem mounts.
- **`localization/`**: Locale, timezone, and keyboard layout settings.
- **`networking/`**: Network stack configuration, including NetworkManager and firewall rules.
- **`programs/`**: System-wide package definitions and application configurations (e.g., Steam, Warp).
- **`services/`**: System services including audio (Pipewire), Flatpak support, and performance tuning.
- **`system/`**: Core NixOS settings, kernel selection, and DNS configuration.
- **`users/`**: User definitions and Home Manager modules.
  - **`users/niri/`**: Niri specific configuration and styling.
  - **`users/home.nix`**: Home Manager entry point.
- **`virtualization/`**: Container and VM stack (Docker, Podman, Libvirt).
