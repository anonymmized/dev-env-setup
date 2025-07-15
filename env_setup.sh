#!/bin/bash

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
            brew_version=$(brew -v)
            if [[ $brew_version == *"Homebrew"* ]]; then
                PCKM="brew"
            fi
        fi
    elif [[ "$OS" == "Linux" ]]; then
        if command -v apt &> /dev/null; then
            PCKM="apt"
        fi
    fi
}

packages_install() {
    detectPCKM
    if [[ "$PCKM" == "brew" ]]; then
        brew install git &> /dev/null
        echo "Git is installed"
        brew install curl &> /dev/null
        echo "Curl is installed"
        brew install node &> /dev/null
        echo "Node.js is installed"
        brew install python3 &> /dev/null
        echo "Python is installed"
        brew install docker &> /dev/null
        echo "Docker is installed"
        brew install htop &> /dev/null
        echo "Htop is installed"
        brew install tree &> /dev/null
        echo "Tree is installed"
        echo "====================="
        echo "Installing vscode..."
        echo "====================="
        brew install --cask visual-studio-code &> /dev/null
        echo "vscode is installed"

    elif [[ "$PCKM" == "apt" ]]; then
        sudo apt-get install git -y &> /dev/null
        echo "Git is installed"
        sudo apt-get install curl -y &> /dev/null
        echo "Curl is installed"
        sudo apt-get install nodejs -y &> /dev/null
        echo "Node.js is installed"
        sudo apt-get install python3 -y &> /dev/null
        echo "Python is installed"
        sudo apt-get install curl software-properties-common ca-certificates apt-transport-https -y &> /dev/null
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-cache policy docker-ce
        sudo apt-get install docker-ce -y
        sudo systemctl status docker
        echo "Docker is installed"
        sudo apt-get install htop &> /dev/null
        echo "Htop is installed"
        sudo apt-get install tree &> /dev/null
        echo "Tree is installed"
        echo "====================="
        echo "Installing vscode..."
        echo "====================="
        sudo apt-get install code &> /dev/null
        echo "vscode is installed"
    else
        echo "The program does not seem to support your package manager yet"
    fi
}

update_packages() {
    detectOS
    echo "Detected OS: $OS"

    if [[ "$OS" == "MacOS" ]]; then
        if command -v brew &> /dev/null; then
            brew_version=$(brew -v)
            if [[ $brew_version == *"Homebrew"* ]]; then
                brew update &> /dev/null
                echo "Processing..."
                brew upgrade &> /dev/null
                echo "All Homebrew packages have been updated"
                echo $brew_version
                PCKM="brew"
            fi
        fi
    elif [[ "$OS" == "Linux" ]]; then
        echo "Running Linux setup..."
        if command -v apt &> /dev/null; then
            echo "APT found, updating packages..."
            sudo apt-get update &> /dev/null && sudo apt-get upgrade -y &> /dev/null
            echo "All apt packages have been updated"
            PCKM="apt"
        fi
    else
        echo "Unsupported OS: $OS"
    fi
}
# update_packages
packages_install