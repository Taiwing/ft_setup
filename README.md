# ft\_setup

This script installs needed dev dependencies on the 42 mac and linux machines.

## Setup

```shell
# clone the repo
git clone https://github.com/Taiwing/ft_setup
# run it
cd ft_setup/ && ./ft_setup
```

## Usage

ft\_setup will install the dependencies and the config file by default. It can
also remove them if needed.

```
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
```
