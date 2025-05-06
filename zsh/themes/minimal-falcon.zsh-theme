autoload -Uz colors && colors

# LS colors and such (8-bit color)
export CLICOLOR=1
export LSCOLORS=dxfxfxdxfxdedeacacad

# fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color='dark\
,fg:#b4b4b9\
,bg:#000000\
,hl:#ffc552\
,fg+:#f8f8ff\
,bg+:#36363a\
,hl+:#ffc552\
,query:#f8f8ff\
,gutter:#020221\
,prompt:#ffc552\
,header:#ffd392\
,info:#bfdaff\
,pointer:#ffe8c8\
,marker:#ff3600\
,spinner:#bfdaff\
,border:#36363a'\
"

# prompt
function git_prompt() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  ref=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always)
  echo "%F{173}($ref)%f"
}
setopt PROMPT_SUBST
PROMPT='%F{245}%1~%f$(git_prompt) %F{180}❯%f '
