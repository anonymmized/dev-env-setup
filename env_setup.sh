#!/bin/bash
# Добавить vim
# Global variables
OS=""
PCKM=""

show_help() {
    echo "System Quick Setup Script"
    echo "Usage: $0 [OPTIONS]"
    echo "Options: "
    echo "  --help     Show this help message"
    echo "  --basic    Install only basic packages (git, curl, htop)"
    echo "  --dev      Install development tools (node, python, docker)"
    echo "  --full     Full installation including VS Code"
    echo "  --update   Update existing packages only"
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
            echo "$display_name is installed"
        else
            echo "$display_name is already installed"
        fi
    elif [[ "$PCKM" == "apt" ]]; then
        if ! command -v "$package_name" &> /dev/null; then
            sudo apt-get install "$package_name" -y &> /dev/null
            echo "$display_name is installed"
        else
            echo "$display_name is already installed"
        fi
    fi
}

update_packages() {
    detectPCKM
    echo "Detected OS: $OS"

    if [[ "$PCKM" == "brew" ]]; then
        echo "Updating Homebrew packages..."
        brew update &> /dev/null
        brew upgrade &> /dev/null
        echo "All Homebrew packages have been updated"
        
    elif [[ "$PCKM" == "apt" ]]; then
        echo "Updating APT packages..."
        sudo apt-get update &> /dev/null && sudo apt-get upgrade -y &> /dev/null
        echo "All APT packages have been updated"
        
    elif [[ "$PCKM" == "dnf" ]]; then
        echo "Updating DNF packages..."
        sudo dnf update -y &> /dev/null
        echo "All DNF packages have been updated"
        
    elif [[ "$PCKM" == "yum" ]]; then
        echo "Updating YUM packages..."
        sudo yum update -y &> /dev/null
        echo "All YUM packages have been updated"
        
    else
        echo "No supported package manager found"
        return 1
    fi
}

basic_setup() {
    detectPCKM
    if [[ "$PCKM" == "" ]]; then
        echo "No supported package manager found"
        return 1
    fi
    
    echo "Installing packages using $PCKM..."
    
    install_package "git" "Git"
    install_package "curl" "Curl"
    install_package "htop" "Htop"
    install_package "tree" "Tree"
}

dev_setup() {
    detectPCKM
    if [[ "$PCKM" == "" ]]; then
        echo "No supported package manager found"
        return 1
    fi

    echo "Installing packages using $PCKM..."

    if [[ "$PCKM" == "brew" ]]; then
        install_package "node" "Node.js"
        install_package "python3" "Python"
        install_package "docker" "Docker"
        
        echo "====================="
        echo "Installing VS Code..."
        echo "====================="
        if ! command -v code &> /dev/null; then
            brew install --cask visual-studio-code &> /dev/null
            echo "VS Code is installed"
        else
            echo "VS Code is already installed"
        fi
    elif [[ "$PCKM" == "apt" ]]; then
        install_package "nodejs" "Node.js"
        install_package "python3" "Python"
    
        if ! command -v docker &> /dev/null; then
            sudo apt-get install docker.io -y &> /dev/null
            echo "Docker is installed"
        else
            echo "Docker is already installed"
        fi
        
        echo "====================="
        echo "Installing VS Code..."
        echo "====================="
        if ! command -v code &> /dev/null; then

            curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg &> /dev/null
            echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list &> /dev/null
            sudo apt-get update &> /dev/null
            sudo apt-get install code -y &> /dev/null
            echo "VS Code is installed"
        else
            echo "VS Code is already installed"
        fi
    fi

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
    esac
done

# Main execution
# update_packages
# packages_install
