#!/bin/bash

detectOS() {
    case "$(uname)" in 
        Darwin) OS="MacOS" ;;
        Linux) OS="Linux" ;;
        MINGW*|CYGWIN*) OS="MSWin" ;;
        *) OS="Unknown" ;;
    esac
}

main() {
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
            fi
        fi
    elif [[ "$OS" == "Linux" ]]; then
        echo "Running Linux setup..."
        if command -v apt &> /dev/null; then
            echo "APT found, updating packages..."
            sudo apt-get update &> /dev/null && sudo apt-get upgrade -y &> /dev/null
            echo "All apt packages have been updated"

        # elif 
        fi
    else
        echo "Unsupported OS: $OS"
    fi
}
main