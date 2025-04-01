# OneDNS

> A smart and flexible DNS management tool for Linux users.

OneDNS is a simple yet powerful Bash-based tool that helps users easily change their DNS settings, check website access status, and manage multiple DNS providers — all through a clean terminal interface.

## 📦 Features

- 🔧 **Install or use live** — Run without installation or install globally with one click
- 🌐 **Switch DNS providers** — Easily change between Shecan, Electro, 403 DNS and more
- 🌍 **Reset to default DNS (Google 8.8.8.8)**
- 🧪 **Check if a URL is filtered or blocked**
- 🛠 **Coming soon:** New DNS service request system
- 👁 **View current DNS settings**
- 🚀 Clean and simple UI built with colorful Bash menus

## 📥 Installation

You can run OneDNS directly or install it system-wide:

```bash
sudo bash onedns.sh
```

On launch, you'll see this menu:

```
[1] Install (system-wide)
[2] Use in Live mode (no install)
[00] Exit
```

Choose `[1]` to install the tool so you can use the `onedns` command anywhere.

## 💻 Usage

After running the script or typing `onedns` (if installed), you’ll get a menu like this:

```
[1] Start DNS Options
[2] Reset DNS (8.8.8.8)
[3] Check Website Filter Status
[4] Request New DNS Service (Coming)
[5] About
[6] Show Current DNS
[00] Exit
```

### DNS Options

- **403 DNS** – Bypasses common site blocks
- **Electro** – Great for unlocking YouTube
- **Shecan** – Trusted local provider
- **Reset** – Google DNS (8.8.8.8)

## 🌐 Check Website Filter Status

Just paste a domain or URL and OneDNS will tell you if the site is filtered, sanctioned, or supported by 403 services.

Example:
```
Enter website URL: youtube.com
```

## ⚠️ Requirements

- `bash`
- `curl`
- Root access (`sudo`) is needed to modify `/etc/resolv.conf`

## 🔒 Disclaimer

Use this tool responsibly and always comply with local internet regulations. This project is for educational and testing purposes.

## 👨‍💻 Author

Made with 💙 by [@BDadmehr0](https://github.com/BDadmehr0)  
Feel free to contribute, fork, or report issues.

## 📃 License

MIT License
