#!/usr/bin/env bash

### Install homebrew ###

#yes "" | INTERACTIVE="yes" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#LINUX_PREFIX="$HOME/.linuxbrew"
#MACOS_ARM_PREFIX="/opt/homebrew"
#MACOS_INTEL_PREFIX="/usr/local/Homebrew"
#if [ -d $LINUX_PREFIX ]; then
#	HOMEBREW_PREFIX=$LINUX_PREFIX
#elif [ -d $MACOS_ARM_PREFIX ]; then
#	HOMEBREW_PREFIX=$MACOS_ARM_PREFIX
#elif [ -d $MACOS_INTER_PREFIX ]; then
#	HOMEBREW_PREFIX=$MACOS_INTEL_PREFIX
#else
#	echo ERROR: could not find homebrew install directory
#	exit 1
#fi
#echo 'eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >> ~/.bash_profile
#eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

### Install rust ###

#curl https://sh.rustup.rs -sSf | sh -s -- -y
#source $HOME/.cargo/env

### Install dependencies ### 

brew install tmux
cargo install bat ripgrep

### Uninstall brew and cargo ###

#yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
#rustup self uninstall
