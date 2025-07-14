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
                brew update &> /dev/null
                brew upgrade &> /dev/null
                PCKM="brew"
            fi
        fi
    elif [[ "$OS" == "Linux" ]]; then
        if command -v apt &> /dev/null; then
            sudo apt-get update &> /dev/null && sudo apt-get upgrade -y &> /dev/null
            PCKM="apt"
        fi
    fi
}

git_install() {
    detectPCKM
    if [[ "$PCKM" == "brew" ]]; then
        if ! command -v git &> /dev/null; then
            brew install git &> /dev/null
            echo "Git is installed"
        else
            echo "Git is already installed"
        fi
    elif [[ "$PCKM" == "apt" ]]; then
        if ! command -v git &> /dev/null; then
            sudo apt-get install git -y &> /dev/null
            echo "Git is installed"
        else
            echo "Git is already installed"
        fi
    else
        echo "The program does not seem to support your package manager yet"
    fi
}

curl_install() {
    detectPCKM
    if [[ "$PCKM" == "brew" ]]; then
        if ! command -V curl &> /dev/null; then
            brew install curl &> /dev/null
            echo "Curl is installed"
        else
            echo "Curl is already installed"
        fi
    elif [[ "$PCKM" == "apt" ]]; then
        if ! command -V curl &> /dev/null; then
            sudo apt-get install curl &> /dev/null
            echo "Curl is installed"
        else
            echo "Curl is already installed"
        fi
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
git_install
curl_install