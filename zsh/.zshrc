# use this for profiling in case the shell becomes slow
export PROFILING_MODE=0
if [ $PROFILING_MODE -ne 0 ]; then
    zmodload zsh/zprof
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
# NOTE : using ${HOME}/go/bin instead of $(go env GOPATH)/bin for optimization
export PATH="$PATH:$HOME/.local/bin/:${HOME}/go/bin:${HOME}/.platformio/packages/toolchain-xtensa/bin"
export KUBE_EDITOR=nvim

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
zsource $ZSH/aliases/git.plugin.zsh

# git
if [[ -f "$ZSH/plugins/git-completions/git-completion.zsh" ]]; then
    source "$ZSH/plugins/git-completions/git-completion.zsh"
    compdef _git git
fi

# docker
_lazy_docker_completions() {
  source <(docker completion zsh)
  unfunction _lazy_docker_completions
}
zle -N _lazy_docker_completions

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
pyenv() {
  unset -f pyenv
  eval "$(command pyenv init -)"
  pyenv "$@"
}


# tmux
[ -f ~/.fzf.zsh ] && zsource ~/.fzf.zsh
bindkey -s '^f' "tmux-sessionizer\n"

# google sdk
if [ -f "${HOME}/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/Downloads/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "${HOME}/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/Downloads/google-cloud-sdk/completion.zsh.inc"; fi

# profiling
if [ $PROFILING_MODE -ne 0 ]; then
    zprof
fi
