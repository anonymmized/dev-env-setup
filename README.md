# 🚀 Development Environment Setup Script

A comprehensive, cross-platform bash script that automates the installation and configuration of essential development tools and programming languages. Save hours of manual setup and get your development environment ready in minutes!

## ✨ Features

- **Cross-platform support**: Works on macOS, Linux (Ubuntu/Debian, CentOS/RHEL/Fedora)
- **Smart package management**: Automatically detects and uses the appropriate package manager (Homebrew, APT, DNF, YUM)
- **Modular installation**: Choose exactly what you need with flexible installation options
- **Colorful output**: Beautiful, informative console output with progress indicators
- **Dry-run mode**: Preview what will be installed before making changes
- **Update functionality**: Keep your tools up-to-date with a single command

## 📦 Installation Categories

### 🔧 Basic Utilities (`--basic`)
Essential command-line tools for everyday use:
- **Git** - Version control system
- **Curl** - Data transfer tool
- **Htop** - Interactive process viewer
- **Tree** - Directory structure visualization
- **Wget** - Web content retrieval
- **Jq** - JSON processor
- **Unzip** - Archive extraction
- **Neofetch** - System information display

### 🛠️ Development Tools (`--dev`)
Powerful development environment setup:
- **Node.js** - JavaScript runtime
- **Python 3** - Python programming language
- **Vim** - Text editor
- **Docker** - Containerization platform
- **Tmux** - Terminal multiplexer
- **GitHub CLI** - GitHub command-line interface
- **VS Code** - Modern code editor

### 🔤 Programming Languages (`--langs`)
Multiple programming language support:
- **Go** - Google's programming language
- **Rust** - Systems programming language
- **Java JDK** - Java development kit
- **Ruby** - Dynamic programming language
- **PHP** - Web development language

### 🎯 Full Installation (`--full`)
Complete development setup including basic utilities and development tools.

## 🚀 Quick Start

### Prerequisites
- Unix-like operating system (macOS, Linux)
- Bash shell
- Internet connection
- Administrator privileges (for package installation)

### Installation

1. **Download the script:**
   ```bash
   git clone <repository-url>
   cd dev-env-setup
   ```

2. **Make it executable:**
   ```bash
   chmod +x env_setup.sh
   ```

3. **Run the script:**
   ```bash
   ./env_setup.sh --help
   ```

## 📖 Usage

### Basic Commands

```bash
# Show help information
./env_setup.sh --help

# Preview what will be installed (dry run)
./env_setup.sh --dry-run

# Install basic utilities only
./env_setup.sh --basic

# Install development tools
./env_setup.sh --dev

# Install programming languages
./env_setup.sh --langs

# Full installation (basic + dev tools)
./env_setup.sh --full

# Update existing packages
./env_setup.sh --update
```

### Usage Examples

**For beginners:**
```bash
./env_setup.sh --basic
```

**For web developers:**
```bash
./env_setup.sh --dev
```

**For polyglot programmers:**
```bash
./env_setup.sh --langs
```

**For comprehensive setup:**
```bash
./env_setup.sh --full
```

## 🖥️ Supported Operating Systems

| OS | Package Manager | Status |
|---|---|---|
| macOS | Homebrew | ✅ Fully Supported |
| Ubuntu/Debian | APT | ✅ Fully Supported |
| CentOS/RHEL | YUM | ✅ Supported |
| Fedora | DNF | ✅ Supported |
| Other Linux | - | ⚠️ Limited Support |

## 🎨 Script Features

- **Intelligent Detection**: Automatically detects your operating system and package manager
- **Duplicate Prevention**: Checks if packages are already installed before attempting installation
- **Error Handling**: Graceful error handling with informative messages
- **Progress Feedback**: Real-time installation progress with colored output
- **Modular Design**: Clean, maintainable code structure

## 🔧 Customization

The script is designed to be easily customizable. You can modify the package lists in each function to suit your specific needs:

- Edit `basic_setup()` for basic utilities
- Edit `dev_setup()` for development tools
- Edit `langs_setup()` for programming languages
- Edit `full_setup()` for comprehensive installation

## 🐛 Troubleshooting

### Common Issues

**Permission denied:**
```bash
chmod +x env_setup.sh
```

**Package manager not found:**
- Ensure you have the appropriate package manager installed
- For macOS: Install Homebrew first
- For Linux: The script supports APT, DNF, and YUM

**Installation fails:**
- Check your internet connection
- Ensure you have sufficient privileges
- Try running with `sudo` if needed (the script will prompt when necessary)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for:
- Additional package managers support
- New tool suggestions
- Bug fixes
- Documentation improvements

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Thanks to all the maintainers of the included tools and packages
- Inspired by the need for streamlined development environment setup
- Built with ❤️ for the developer community

---

**Made with ❤️ by developers, for developers**

*Save time, code more, deploy faster!*
