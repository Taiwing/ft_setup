#!/usr/bin/env bash

################################# utils ########################################

function usage {
	cat << EOF
Usage:
    ./ft_setup.bash
    ./ft_setup.bash -u

Options:
    -h, --help
        Print this.

    -v, --verbose
	Show each line of this script before execution.

    -i, --install
	Install brew, cargo and the dependencies. Also creates the config files.
	This is the default behavior.

    -u, --uninstall
        Uninstall brew, cargo, every program installed with them, and remove the
	config files created by this script (make sure to save them if any local
	modifications have been made).
EOF
}

############################### Handle options #################################

INSTALL="yes"

while [ "$1" != "" ]; do
	case $1 in
	-h | --help )
		usage
		exit 0
		;;
	-v | --verbose )
		set -o xtrace
		;;
	-i | --install )
		INSTALL="yes"
		;;
	-u | --uninstall )
		INSTALL=""
		;;
	* )
		usage
		exit 1
	esac
	shift
done

###################### Install homebrew and rust ###############################

if [ ! -z $INSTALL ]; then
	yes "" | INTERACTIVE="yes" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

######################## Setup shell environment ###############################

LINUX_PREFIX="$HOME/.linuxbrew"
MACOS_ARM_PREFIX="/opt/homebrew"
MACOS_INTEL_PREFIX="/usr/local/Homebrew"
if [ -d $LINUX_PREFIX ]; then
	HOMEBREW_PREFIX=$LINUX_PREFIX
elif [ -d $MACOS_ARM_PREFIX ]; then
	HOMEBREW_PREFIX=$MACOS_ARM_PREFIX
elif [ -d $MACOS_INTER_PREFIX ]; then
	HOMEBREW_PREFIX=$MACOS_INTEL_PREFIX
else
	echo ERROR: could not find homebrew install directory
	exit 1
fi

if [ ! -z $INSTALL ]; then
	echo 'eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >> ~/.bash_profile
	eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
	source $HOME/.cargo/env
fi

######################### Install dependencies #################################

if [ ! -z $INSTALL ]; then
	brew install tmux
	cargo install alacritty bat ripgrep
fi

######################### Uninstall brew and cargo #############################

if [ -z $INSTALL ]; then
	yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	rm -rf $HOMEBREW_PREFIX
	rustup self uninstall -y
	rm -rf ~/.cargo
fi
