autoload -Uz colors && colors

function git_prompt() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  ref=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always)
  echo "%F{173}($ref)%f"
}
setopt PROMPT_SUBST
PROMPT='%F{245}%1~%f$(git_prompt) %F{180}❯%f '
