#!/bin/bash
set -e
ROOT_PATH=$(pwd -P)

#! https://dev.to/joaovitor/exa-instead-of-ls-1onl

main() {
	downloader --check

	get_arch
	ARCH="$RETVAL"

	install_homebrew
	install_terminal
	install_shell
	install_neovim
	install_languages
	install_tools
	setup_git
}

install_homebrew() {
	if ! which brew >/dev/null 2>&1; then
		info "Installing homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi
}

install_terminal() {
	# install alacritty terminal and terminfo
	brew install alacritty || true
	ensure downloader https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info /Applications/Alacritty.app/Contents/Resources/alacritty.info
	info "setting terminal tic, sudo required"
	sudo tic -xe alacritty,alacritty-direct /Applications/Alacritty.app/Contents/Resources/alacritty.info
	info "configuring terminal"
	sym_link $ROOT_PATH/.alacritty.yml ~/.alacritty.yml
	if [[ $ARCH == *"darwin"* ]]; then
		info "macOs detected, 'open' alacritty in finder to seed permissions"
		open /Applications
	fi
}

install_shell() {
	# install environment tools and languages
	brew install zsh zsh-completions || true
	info "configuring shell"
	chsh -s /usr/local/bin/zsh

	# install and setup antibody zsh plugin bundler
	brew install getantibody/tap/antibody || true
	antibody bundle <.zsh_plugins.txt >~/.zsh_plugins.sh
	antibody update

	# install powerlevel9k and nerdfonts
	brew tap sambadevi/powerlevel9k
	brew tap homebrew/cask-fonts

	brew install powerlevel9k || true
	brew install font-meslo-lg-nerd-font || true
	brew install font-fira-code-nerd-font || true
}

install_neovim() {
	brew install neovim || true
	brew install ripgrep fzf || true
	info "configuring neovim"
	sym_link $ROOT_PATH/nvim ~/.config/nvim
	nvim --headless +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins +qall
	# undo history path
	mkdir -p ~/.vimdid
}

install_languages() {
	brew install go node yarn || true

	if ! which rustup >/dev/null 2>&1; then
		curl https://sh.rustup.rs -sSf | sh -s -- -y
		source ~/.cargo/env
		rustup default stable

		# Rust toolchains and commands
		rustup component add clippy
		rustup target add aarch64-apple-ios armv7-apple-ios x86_64-apple-ios
		rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android
		rustup target add wasm32-unknown-unknown

		# Install sccache
		cargo install sccache --git https://github.com/paritytech/sccache.git
	else
		rustup update
	fi
	# custom global settings
	sym_link $ROOT_PATH/cargo-config.toml ~/.cargo/config.toml
}

install_tools() {
	brew install kubectx hub google-cloud-sdk visual-studio-code || true

	rm -rf ~/Library/Application\ Support/Code/User/keybindings.json
	rm -rf ~/Library/Application\ Support/Code/User/settings.json
	mkdir -p ~/Library/Application\ Support/Code/User
	cp vscode/* ~/Library/Application\ Support/Code/User/
}

setup_git() {
	# git settings/aliases
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.com commit
	git config --global alias.st status
	git config --global credential.helper osxkeychain
	# Updated git requires a way to resolve divergent, this makes it so divergent branch pulls
	# will only fast foward.  A diveragent branch will fail.  A normal thing to do is to pull a
	# into your working copy, such as "git pull origin master".  A divergence can occur if the
	# remote was force pushed with a missing ancestor from your local copy.
	git config --global pull.ff only

	if [ -z "$(git config --global --get user.email)" ]; then
		echo "Git user.name:"
		read -r user_name
		echo "Git user.email:"
		read -r user_email
		git config --global user.name "$user_name"
		git config --global user.email "$user_email"
	fi
}

## Utils

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

ensure() {
	if ! "$@"; then err "command failed: $*"; fi
}

require() {
	if ! check_cmd "$1"; then
		err "need '$1' (command not found)"
	fi
}

check_cmd() {
	command -v "$1" >/dev/null 2>&1
}

append_not_exists() {
	if [ -f "$2" ] && grep -q "$1" "$2"; then
		info "PATH exists in \'$2\'"
		return
	fi

	info "\'$1\' >> \'$2\'"
	echo "$1" >>"$2"
}

sym_link() {
	if [[ -f $2 ]]; then
		if [ -e "$2" ]; then
			if [ "$(readlink "$2")" = "$1" ]; then
				info "Symlink skipped $1"
				return 0
			else
				mv "$2" "$2.bak"
				info "Symlink moved $2 to $2.bak"
			fi
		fi
	fi
	ln -sf "$1" "$2"
	info "Symlinked $1 to $2"
}

get_arch() {
	local _ostype _cputype

	if [ "$OSTYPE" == "linux-gnu" ]; then
		_ostype=unknown-linux-gnu
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		_ostype=apple-darwin
	else
		err "$OSTYPE currently unsupported"
	fi

	_cputype=$(uname -m)
	[ $_cputype == "x86_64" ] || err "$_cputype currently unsupported"

	RETVAL=$_cputype-$_ostype
}

downloader() {
	local _dld
	if check_cmd curl; then
		_dld=curl
	elif check_cmd wget; then
		_dld=wget
	else
		_dld='curl or wget' # to be used in error message of require
	fi

	if [ "$1" = --check ]; then
		require "$_dld"
	elif [ "$_dld" = curl ]; then
		curl --proto '=https' --tlsv1.2 --silent --show-error --fail --location "$1" --output "$2"
	elif [ "$_dld" = wget ]; then
		wget --https-only --secure-protocol=TLSv1_2 "$1" -O "$2"
	fi
}

main "$@"
