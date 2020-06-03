#!/bin/bash
set -e
ROOT_PATH=$(pwd -P)

function add_source () {
	echo "hello"
}

function sym_link() {
	if [ -e "$2" ]; then
		if [ "$(readlink "$2")" = "$1" ]; then
			echo "Symlink skipped $1"
			return 0
		else
			mv "$2" "$2.bak"
			echo "Symlink moved $2 to $2.bak"
		fi
	fi
	ln -sf "$1" "$2"
	echo "Symlinked $1 to $2"
}

function install_homebrew() {
	if ! which brew >/dev/null 2>&1; then
		echo "Installing homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi
}

function install_languages() {
	brew install go

	if ! which rustup >/dev/null 2>&1; then
		curl https://sh.rustup.rs -sSf | sh -s -- -y
		source ~/.cargo/env
		rustup default stable

		# Rust toolchains and commands
		rustup component add clippy
		rustup target add aarch64-apple-ios armv7-apple-ios armv7s-apple-ios x86_64-apple-ios i386-apple-ios
		rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android
		rustup target add wasm32-unknown-unknown
	else
		rustup update
	fi
}

function install_shell() {
	# install environment tools and languages
	brew install zsh zsh-completions 
	chsh -s /usr/local/bin/zsh

	# install and setup antibody zsh plugin bundler
	brew install getantibody/tap/antibody
	antibody bundle < .zsh_plugins.txt > ~/.zsh_plugins.sh
	antibody update

	# install powerlevel9k and nerdfonts
	brew tap sambadevi/powerlevel9k
	brew install powerlevel9k
	brew tap caskroom/fonts
	brew cask install font-meslo-nerd-font
	echo "!! Terminal Apps need 'MesloLGM Nerd Font' in order to properly display Powerline Fonts"
}

function install_tools() {
	brew install kubectx hub
	brew cask install google-cloud-sdk

	brew cask install iterm2
	brew cask install visual-studio-code
	rm -rf ~/Library/Application\ Support/Code/User 
	mkdir -p ~/Library/Application\ Support/Code
}

function make_links() {
	sym_link $ROOT_PATH/vscode ~/Library/Application\ Support/Code/User 
}

function setup_git() {
	# git settings/aliases
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.com commit
	git config --global alias.st status
	git config --global credential.helper osxkeychain

	if [ -z "$(git config --global --get user.email)" ]; then
		echo "Git user.name:"
		read -r user_name
		echo "Git user.email:"
		read -r user_email
		git config --global user.name "$user_name"
		git config --global user.email "$user_email"
	fi
}

setup_git
# # merge our zshrc contents if one already exists, otherwise just copy it over
# if [ -f ~/.zshrc ]; then
#     echo "=== Merging .zshrc Files (MIGHT REQUIRE MANUAL CLEANUP!) ==="
#     cat .zshrc | cat - ~/.zshrc > temp && rm ~/.zshrc && mv temp ~/.zshrc
# else
#     echo "=== Copying .zshrc File ==="
#     cp .zshrc ~/.zshrc
# fi

