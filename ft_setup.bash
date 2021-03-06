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
	Install packet managers and dependencies. Also creates the configuration
	files. This is the default behavior.

    -u, --uninstall
        Uninstall packet managers, every program installed with them, and remove
	the configuration files created by this script (make sure to save them
	if any meaningful local modification has been made).
EOF
}

############################### Handle options #################################

SYSTEM="$(uname)"
INSTALL="yes"
STORAGE_PATH="$HOME/goinfre"
CARGO_HOME="$STORAGE_PATH/cargo"
RUSTUP_HOME="$STORAGE_PATH/rustup"

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

########################## Install Configuration files #########################

if [ ! -z $INSTALL ]; then
	mkdir -p $HOME/.config/alacritty
	cp ./config/alacritty.yml $HOME/.config/alacritty
	cp ./config/bashrc $HOME/.bashrc
	cp ./config/bash_aliases $HOME/.bash_aliases
	cp ./config/profile $HOME/.profile
	cp ./config/tmux.conf $HOME/.tmux.conf
	cp ./config/vimrc $HOME/.vimrc
fi


###################### Install homebrew and rust ###############################

if [ ! -z $INSTALL ]; then
	if [ $SYSTEM != 'Linux' ]; then
		yes "" | INTERACTIVE="yes" /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	export CARGO_HOME
	export RUSTUP_HOME
	echo "export CARGO_HOME=$CARGO_HOME" >> $HOME/.profile
	echo "export RUSTUP_HOME=$RUSTUP_HOME" >> $HOME/.profile
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
elif [ $SYSTEM != 'Linux' ]; then
	echo ERROR: could not find homebrew install directory
	exit 1
fi

if [ ! -z $INSTALL ]; then
	if [ $SYSTEM != 'Linux' ]; then
		echo 'eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >> ~/.profile
		eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
	fi
	source $CARGO_HOME/env
fi

######################### Install dependencies #################################

if [ ! -z $INSTALL ]; then
	if [ $SYSTEM != 'Linux' ]; then
		brew install tmux
	fi
	cargo install alacritty bat ripgrep
fi

######################### Uninstall brew and cargo #############################

if [ -z $INSTALL ]; then
	yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	rm -rf $HOMEBREW_PREFIX
	rustup self uninstall -y
	rm -rf $CARGO_HOME
fi

######################## Uninstall Configuration files #########################

if [ -z $INSTALL ]; then
	rm $HOME/.config/alacritty
	rmdir $HOME/.config/alacritty &> /dev/null
	rmdir $HOME/.config/ &> /dev/null
	rm $HOME/.bashrc
	rm $HOME/.bash_aliases
	rm $HOME/.profile
	rm $HOME/.tmux.conf
	rm $HOME/.vimrc
fi
