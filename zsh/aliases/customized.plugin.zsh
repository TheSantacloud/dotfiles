alias ls="ls -h --color=auto"
alias ll="ls -lah"

alias python="python3"
alias pip="pip3"

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
  if [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate
  elif [ -f "pyproject.toml" ]; then
    $(poetry env activate)
  else
    echo "No virtual environment found"
  fi
}
