#!/bin/bash

OS=""
PCKM=""
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_header() {
    echo -e "${PURPLE}=== $1 ===${NC}"
}

show_help() {
    print_info "System Quick Setup Script"
    print_info "Usage: $0 [OPTIONS]"
    print_info "Options: "
    print_info "  --help     Show this help message"
    print_info "  --basic    Install only basic packages (git, htop, tree, wget, jq)"
    print_info "  --dev      Install development tools (node, python, docker, vim)"
    print_info "  --langs    Install programming languages (go, rust, java, ruby, php)"
    print_info "  --full     Full installation including VS Code"
    print_info "  --update   Update existing packages only"
    print_info "  --dry-run  Show what will be installed without the actual installation"
}

detectOS() {
    case "$(uname)" in 
        Darwin) OS="MacOS" ;;
        Linux) OS="Linux" ;;
        MINGW*|CYGWIN*) OS="MSWin" ;;
        *) OS="Unknown" ;;
    esac
}

detectPCKM() {
    detectOS
    if [[ "$OS" == "MacOS" ]]; then
        if command -v brew &> /dev/null; then
            PCKM="brew"
        fi
    elif [[ "$OS" == "Linux" ]]; then
        if command -v apt &> /dev/null; then
            PCKM="apt"
        elif command -v dnf &> /dev/null; then
            PCKM="dnf"
        elif command -v yum &> /dev/null; then
            PCKM="yum"
        fi
    fi
}

install_package() {
    local package_name="$1"
    local display_name="$2"
    
    if [[ "$PCKM" == "brew" ]]; then
        if ! command -v "$package_name" &> /dev/null; then
            brew install "$package_name" &> /dev/null
            print_success "$display_name is installed"
        else
            print_success "$display_name is already installed"
        fi
    elif [[ "$PCKM" == "apt" ]]; then
        if ! command -v "$package_name" &> /dev/null; then
            sudo apt-get install "$package_name" -y &> /dev/null
            print_success "$display_name is installed"
        else
            print_success "$display_name is already installed"
        fi
    fi
}

update_packages() {
    detectPCKM
    print_info "Detected OS: $OS"

    if [[ "$PCKM" == "brew" ]]; then
        print_info "Updating Homebrew packages..."
        brew update &> /dev/null
        brew upgrade &> /dev/null
        print_success "All Homebrew packages have been updated"
        
    elif [[ "$PCKM" == "apt" ]]; then
        print_info "Updating APT packages..."
        sudo apt-get update &> /dev/null && sudo apt-get upgrade -y &> /dev/null
        print_success "All APT packages have been updated"
        
    elif [[ "$PCKM" == "dnf" ]]; then
        print_info "Updating DNF packages..."
        sudo dnf update -y &> /dev/null
        print_success "All DNF packages have been updated"
        
    elif [[ "$PCKM" == "yum" ]]; then
        print_info "Updating YUM packages..."
        sudo yum update -y &> /dev/null
        print_success "All YUM packages have been updated"
        
    else
        print_error "No supported package manager found"
        return 1
    fi
}

basic_setup() {
    detectPCKM
    if [[ "$PCKM" == "" ]]; then
        print_error "No supported package manager found"
        return 1
    fi
    
    print_info "Installing packages using $PCKM..."
    
    install_package "git" "Git"
    install_package "curl" "Curl"
    install_package "htop" "Htop"
    install_package "tree" "Tree"
    install_package "wget" "Wget"
    install_package "jq" "Jq"
    install_package "unzip" "Unzip"
    install_package "neofetch" "Neofetch"
}

dev_setup() {
    detectPCKM
    if [[ "$PCKM" == "" ]]; then
        print_error "No supported package manager found"
        return 1
    fi

    print_info "Installing development tools using $PCKM..."

    if [[ "$PCKM" == "brew" ]]; then
        install_package "node" "Node.js"
        install_package "python3" "Python"
        install_package "vim" "Vim"
        install_package "docker" "Docker"
        install_package "tmux" "Tmux"
        install_package "gh" "GitHub CLI"
        
        print_info "====================="
        print_info "Installing VS Code..."
        print_info "====================="
        if ! command -v code &> /dev/null; then
            brew install --cask visual-studio-code &> /dev/null
            print_success "VS Code is installed"
        else
            print_success "VS Code is already installed"
        fi
    elif [[ "$PCKM" == "apt" ]]; then
        install_package "nodejs" "Node.js"
        install_package "python3" "Python"
        install_package "vim" "Vim"
        install_package "tmux" "Tmux"
    
        if ! command -v docker &> /dev/null; then
            sudo apt-get install docker.io -y &> /dev/null
            print_success "Docker is installed"
        else
            print_success "Docker is already installed"
        fi
        
        # GitHub CLI
        if ! command -v gh &> /dev/null; then
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &> /dev/null
            sudo apt-get update &> /dev/null
            sudo apt-get install gh -y &> /dev/null
            print_success "GitHub CLI is installed"
        else
            print_success "GitHub CLI is already installed"
        fi
        
        print_info "====================="
        print_info "Installing VS Code..."
        print_info "====================="
        if ! command -v code &> /dev/null; then
            curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg &> /dev/null
            sudo apt-get update &> /dev/null
            sudo apt-get install code -y &> /dev/null
            print_success "VS Code is installed"
        else
            print_success "VS Code is already installed"
        fi
    fi
}

langs_setup() {
    detectPCKM
    if [[ "$PCKM" == "" ]]; then
        print_error "No supported package manager found"
        return 1
    fi

    print_info "Installing programming languages using $PCKM..."

    if [[ "$PCKM" == "brew" ]]; then
        install_package "go" "Go"
        install_package "rust" "Rust"
        install_package "ruby" "Ruby"
        install_package "php" "PHP"
        
        # Java JDK
        if ! command -v java &> /dev/null; then
            brew install --cask temurin &> /dev/null
            print_success "Java JDK is installed"
        else
            print_success "Java JDK is already installed"
        fi
        
    elif [[ "$PCKM" == "apt" ]]; then
        install_package "golang-go" "Go"
        install_package "rustc" "Rust"
        install_package "ruby" "Ruby"
        install_package "php" "PHP"
        
        # Java JDK
        if ! command -v java &> /dev/null; then
            sudo apt-get install openjdk-11-jdk -y &> /dev/null
            print_success "Java JDK is installed"
        else
            print_success "Java JDK is already installed"
        fi
        
    elif [[ "$PCKM" == "dnf" ]]; then
        install_package "golang" "Go"
        install_package "rust" "Rust"
        install_package "ruby" "Ruby"
        install_package "php" "PHP"
        
        # Java JDK
        if ! command -v java &> /dev/null; then
            sudo dnf install java-11-openjdk-devel -y &> /dev/null
            print_success "Java JDK is installed"
        else
            print_success "Java JDK is already installed"
        fi
        
    elif [[ "$PCKM" == "yum" ]]; then
        install_package "golang" "Go"
        install_package "rust" "Rust"
        install_package "ruby" "Ruby"
        install_package "php" "PHP"
        
        # Java JDK
        if ! command -v java &> /dev/null; then
            sudo yum install java-11-openjdk-devel -y &> /dev/null
            print_success "Java JDK is installed"
        else
            print_success "Java JDK is already installed"
        fi
    fi
}

full_setup() {
    detectPCKM
    if [[ "$PCKM" == "" ]]; then
        print_error "No supported package manager found"
        return 1
    fi

    print_info "Installation of all tools"
    print_info "Installing packages using $PCKM..."

    install_package "git" "Git"
    install_package "curl" "Curl"
    install_package "htop" "Htop"
    install_package "tree" "Tree"

    if [[ "$PCKM" == "brew" ]]; then
        install_package "node" "Node.js"
        install_package "python3" "Python"
        install_package "docker" "Docker"
        
        print_info "====================="
        print_info "Installing VS Code..."
        print_info "====================="
        if ! command -v code &> /dev/null; then
            brew install --cask visual-studio-code &> /dev/null
            print_success "VS Code is installed"
        else
            print_success "VS Code is already installed"
        fi
    elif [[ "$PCKM" == "apt" ]]; then
        install_package "nodejs" "Node.js"
        install_package "python3" "Python"
    
        if ! command -v docker &> /dev/null; then
            sudo apt-get install docker.io -y &> /dev/null
            print_success "Docker is installed"
        else
            print_success "Docker is already installed"
        fi
        
        print_info "====================="
        print_info "Installing VS Code..."
        print_info "====================="
        if ! command -v code &> /dev/null; then

            curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg &> /dev/null
            sudo apt-get update &> /dev/null
            sudo apt-get install code -y &> /dev/null
            print_success "VS Code is installed"
        else
            print_success "VS Code is already installed"
        fi
    fi
}

dry_run() {
    print_info "The packages that will be installed:"
    print_info "1)  Node.ls"
    print_info "2)  Python"
    print_info "3)  Vim"
    print_info "4)  Docker"
    print_info "5)  VScode"
    print_info "6)  Git"
    print_info "7)  Curl"
    print_info "8)  Htop"
    print_info "9)  Tree"
    print_info "10) Wget"
    print_info "11) Jq"
    print_info "12) Unzip"
    print_info "13) Neofetch"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --help)
            show_help
            exit 0
            ;;
        --basic)
            basic_setup
            exit 0
            ;;
        --dev)
            dev_setup
            exit 0
            ;;
        --langs)
            langs_setup
            exit 0
            ;;
        --full)
            full_setup
            exit 0
            ;;
        --update)
            update_packages
            exit 0
            ;;
        --dry-run)
            dry_run
            exit 0
            ;;
    esac
done
