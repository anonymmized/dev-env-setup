#!/bin/bash

detectOS() {
    case "${uname}" in 
        Darwin) OS="MacOS" ;;
        Linux) OS="Linux" ;;
        MINGW*|CYGWIN*) OS="MSWin" ;;
        *) OS="Unknown" ;;
    esac
}
detectOS
if [[ OS=="MacOS" ]]; then
    if command -v brew &> /dev/null; then
        brew_version=$(brew -v)
        if [[ $brew_version == *"Homebrew"* ]]; then
            brew update
            echo "Processing..."
            brew upgrade
            echo "All Homebrew packages have been updated"
            echo $brew_version
        fi
    fi
elif [[ "$OS" == "Linux" ]]; then
    if command -v apt &> /dev/null; then
        sudo apt-get update &> /dev/null && sudo apt-get upgrade &> /dev/null && sudo apt-get dist-upgrade &> /dev/null
        echo "All apt packages have been updated"
    fi
fi
