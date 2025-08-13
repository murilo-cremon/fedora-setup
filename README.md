# 🐧 Fedora Setup

This repository contains a custom shell script designed to automate the installation of essential programs and utilities after formatting a Fedora Linux machine. The goal is to simplify and speed up the configuration process, avoiding repetitive manual installations.

## 📌 Purpose

To automate the installation of the software and tools I personally use on Fedora, including:

- Packages via `dnf`
- Applications via `flatpak` (Flathub)
- Additional command-line tools and utilities
- Basic system tweaks (if necessary)

## 🚀 How to Use

> **Requirements**: A fresh Fedora installation with superuser (sudo) privileges.

1. Run command bellow:

```bash
git clone https://github.com/murilo-cremon/fedora-setup.git &&
cd fedora-setup &&
chmod +x *.sh &&
sudo ./fedora_setup.sh
