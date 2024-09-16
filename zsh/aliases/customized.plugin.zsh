alias ls="ls -h --color=auto"
alias ll="ls -lah"
alias vim=nvim
alias lvim="nvim -c':e#<1'"
alias a="alias | fzf"
alias s="poetry shell"
alias jn="source ~/Library/Caches/pypoetry/virtualenvs/jupyter/bin/activate && jupyter notebook --notebook-dir='~/dev/jupyter-notebooks' --port=18733 > ~/jupyter.log 2>&1 &"
alias jk="pgrep -f 'jupyter' | xargs kill"

