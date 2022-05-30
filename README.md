# ft\_setup

This script installs needed dev dependencies on the 42 mac and linux machines.

## Setup

```shell
# clone the repo
git clone https://github.com/Taiwing/ft_setup
# run the script
cd ft_setup/ && ./ft_setup
```

## Usage

ft\_setup will install the dependencies and the configuration files by default.
It can also remove them if needed. By default it will install the dependencies
on the local goinfre directory which means the script will have to be re-run on
each new host machine.

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
	Install packet managers and dependencies. Also creates the configuration
	files. This is the default behavior.

    -u, --uninstall
        Uninstall packet managers, every program installed with them, and remove
	the configuration files created by this script (make sure to save them
	if any meaningful local modification has been made).
```
