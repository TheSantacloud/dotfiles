alias ls="ls -h --color=auto"
alias ll="ls -lah"
alias vim=nvim
alias lvim="nvim -c':e#<1'"
alias a="alias | fzf"
alias zbr="zig build run"
alias zbt="zig build test"
alias jk="pgrep -f 'jupyter' | xargs kill"
alias jn='if lsof -i:18733 > /dev/null; then \
  open "http://localhost:18733"; \
else \
  source ~/Library/Caches/pypoetry/virtualenvs/jupyter/bin/activate && \
  jupyter notebook --notebook-dir="~/dev/jupyter-notebooks" --port=18733 > ~/jupyter.log 2>&1 & \
fi'

s() {
  if [ -f "pyproject.toml" ]; then
    $(poetry env activate)
  fi
}

