# Vim Mods https://dev.to/matrixersp/how-to-use-fzf-with-ripgrep-to-selectively-ignore-vcs-files-4e27 
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zsh configuration
SAVEHIST=100
HISTFILE=~/.zsh_history

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:/usr/local/bin
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

# keys
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
# bindkey "^[a" beginning-of-line
# bindkey "^[e" end-of-line

# import plugins
source ~/.zsh_plugins.sh
source ~/.cargo/env

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# if [ "$OSTYPE" == "linux-gnu" ]; then
# elif [[ "$OSTYPE" == "darwin"* ]]; then
# else
# fi

# aliases
alias git=hub

# handle theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir go_version vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator history background_jobs ram load time)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

# Visual customisation of the second prompt line
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰\uF460\uF460\uF460 "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%{%F{249}%}\u250f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%F{249}%}\u2517\uf054%{%F{default}%} "

# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} "$"%{%b%f%k%F{yellow}%} %{%f%}"
POWERLEVEL9K_MODE='nerdfont-complete'
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme
if [ -e /Users/macdenis/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/macdenis/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
