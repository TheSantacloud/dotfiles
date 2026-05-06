# use this for profiling in case the shell becomes slow
export PROFILING_MODE=0
if [ $PROFILING_MODE -ne 0 ]; then
    zmodload zsh/zprof
    zsh_start_time=$(python3 -c 'import time; print(int(time.time() * 1000))')
fi

# compile zsh file, and source them - first run is slower
zsource() {
  local file=$1
  local zwc="${file}.zwc"
  if [[ -f "$file" && (! -f "$zwc" || "$file" -nt "$file") ]]; then
    zcompile "$file"
  fi
  source "$file"
}


# general settings
export ZSH=$(readlink -f $HOME/.config/zsh)
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
export KUBE_EDITOR=nvim

# colorize man/less
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'
export MANPAGER='less'

# NOTE : using ${HOME}/go/bin instead of $(go env GOPATH)/bin for optimization
export PATH="$PATH:$HOME/.local/bin/:${HOME}/go/bin:${HOME}/.platformio/packages/toolchain-xtensa/bin"

# theme
zsource $ZSH/themes/minimal-falcon.zsh-theme

# plugins
zsource $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
zsource $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
zstyle ':completion:*:*:git:*' script $ZSH/plugins/git-completions/git-completion.bash
fpath=($ZSH/plugins/zsh-completions/src $ZSH/plugins/git-completions $fpath ~/.zfunc)

autoload -Uz compinit
ZSH_COMPDUMP="${ZSH}/.zcompdump"
compinit -C -d "$ZSH_COMPDUMP"

# aliases
zsource $ZSH/aliases/customized.plugin.zsh
zsource $ZSH/aliases/kubectl.plugin.zsh

# utilities
[ -f ~/.fzf.zsh ] && zsource ~/.fzf.zsh
# sessionizer
function _smart_ctrl_f() {
  if [[ -n "$BUFFER" ]]; then
    zle autosuggest-accept
  else
    tmux neww ~/.local/bin/tmux-sessionizer
  fi
}
zle -N _smart_ctrl_f
bindkey '^f' _smart_ctrl_f

# postgres
export PATH="$PATH:/opt/homebrew/opt/postgresql@17/bin"

# volta
export PATH="$HOME/.volta/bin:$PATH"

# colima
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

# profiling
if [ $PROFILING_MODE -ne 0 ]; then
    zsh_end_time=$(python3 -c 'import time; print(int(time.time() * 1000))')
    zprof
    echo "Shell init time: $((zsh_end_time - zsh_start_time - 21))"
fi
