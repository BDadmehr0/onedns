# OneDNS

> Smart DNS Switcher for Linux with Backup and Restore  
> Written in pure Bash — minimal, fast, and efficient.

![Version](https://img.shields.io/badge/version-2.0-blue)
![License](https://img.shields.io/badge/license-GPLv3-green)

## 🚀 About

**OneDNS** is a lightweight command-line tool for managing DNS settings on Linux systems.  
It allows you to switch DNS providers with one click, reset to default, and safely restore your original settings from backup.

## 🔧 Features

- ✅ System-wide installation or live usage (no install needed)
- ✅ Switch between trusted DNS providers (403, Electro, Shecan)
- ✅ Reset to Google DNS (8.8.8.8)
- ✅ Automatic backup of original `/etc/resolv.conf`
- ✅ Easy restore of backup anytime
- ✅ Clean uninstallation option
- 🛑 "Filter check" feature is present in code (commented out for now)

## 📦 Installation

### Live mode (no installation):
```bash
sudo bash onedns.sh
```

### Install system-wide:
When prompted, select:
```
[1] Install (system-wide)
```
Then use it from anywhere with:
```bash
sudo onedns
```

## 💻 Usage

You’ll see a menu like this:

```
[1] Start DNS Options
[2] Reset DNS (8.8.8.8)
[5] About
[6] Show Current DNS
[7] Restore Original DNS from Backup
[9] Uninstall OneDNS
[00] Exit
```

### DNS Options:

- **403 Online** → `10.202.10.202, 10.202.10.102`
- **Electro** → DNS optimized for unlocking YouTube
- **Shecan** → Reliable Iranian DNS provider

## 🧠 Backup & Restore

The script creates a **one-time backup** of `/etc/resolv.conf` when you first change the DNS.  
To restore it at any time, select:

```
[7] Restore Original DNS from Backup
```

## 🧹 Uninstalling

You can completely remove OneDNS and its backup using:
```
sudo onedns
# Then select option [9] Uninstall
```

## 📝 License

This project is licensed under the **GNU General Public License v3.0**.  
See the [LICENSE](./LICENSE) file for details.


## 👨‍💻 Author

Made with ❤️ by [@BDadmehr0](https://github.com/BDadmehr0)

If you find this tool useful, feel free to star 🌟 the repo and share it with others!
