# zsh configuration
SAVEHIST=100
HISTFILE=~/.zsh_history

# zsh functions and loading
fpath=( ~/.zfuncs "${fpath[@]}" )
autoload -Uz cb-remote 
autoload -Uz cp-agence-remote

export EDITOR=nvim
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:/usr/local/bin
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

# Vim Mods https://dev.to/matrixersp/how-to-use-fzf-with-ripgrep-to-selectively-ignore-vcs-files-4e27 
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# keys
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
# bindkey "^[a" beginning-of-line
# bindkey "^[e" end-of-line

# import plugins
source ~/.zsh_plugins.sh
source ~/.cargo/env

source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# if [ "$OSTYPE" == "linux-gnu" ]; then
# elif [[ "$OSTYPE" == "darwin"* ]]; then
# else
# fi

# aliases
alias git=hub
alias cat='bat'
alias l='exa'
alias la='exa -a'
alias ll='exa -lah'
alias ls='exa --color=auto'
alias shfmt='shfmt -i 4'
eval "$(zoxide init zsh)"

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
source /opt/homebrew/opt/powerlevel9k/powerlevel9k.zsh-theme

export PATH="$PATH:/Users/denis/.foundry/bin"
