#!/bin/bash
set -e
ROOT_PATH=$(pwd -P)

# main() {

# }

add_source () {
	echo "hello"
}

sym_link() {
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

info() {
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

ok() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

err() {
	printf "\r\033[2K  [\033[0;31mERR\033[0m] $1\n"
	exit
}

install_homebrew() {
	if ! which brew >/dev/null 2>&1; then
		echo "Installing homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi
}

install_neovim() {
	brew install neovim ripgrep fzf
	sym_link $ROOT_DIR/nvim ~/.config/nvim 
	nvim --headless +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins +qall
	# undo history
	mkdir -p ~/.vimdid 
}

install_languages() {
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

install_shell() {
	# install alacritty terminal and terminfo
	brew cask install alacritty
	curl -o /Applications/Alacritty.app/Contents/Resources/alacritty.info https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info
	tic -xe alacritty,alacritty-direct /Applications/Alacritty.app/Contents/Resources/alacritty.info
	sym_link $ROOT_PATH/.alacritty ~/.alacritty

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
	brew tap homebrew/cask-fonts
	brew cask install font-meslolg-nerd-font
	brew cask install font-fira-code-nerd-font
	echo "!! Terminal Apps need 'MesloLGM Nerd Font' in order to properly display Powerline Fonts"
}

install_tools() {
	brew install kubectx hub
	brew cask install google-cloud-sdk

	brew cask install visual-studio-code
	rm -rf ~/Library/Application\ Support/Code/User/keybindings.json
	rm -rf ~/Library/Application\ Support/Code/User/settings.json
	mkdir -p ~/Library/Application\ Support/Code/User
	cp vscode/* ~/Library/Application\ Support/Code/User/
}

make_links() {
	sym_link $ROOT_PATH/.tmux.conf ~/.tmux.conf
}

setup_git() {
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

# setup_git

make_links

# # merge our zshrc contents if one already exists, otherwise just copy it over
# if [ -f ~/.zshrc ]; then
#     echo "=== Merging .zshrc Files (MIGHT REQUIRE MANUAL CLEANUP!) ==="
#     cat .zshrc | cat - ~/.zshrc > temp && rm ~/.zshrc && mv temp ~/.zshrc
# else
#     echo "=== Copying .zshrc File ==="
#     cp .zshrc ~/.zshrc
# fi

