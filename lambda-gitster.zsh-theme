local ret_status="%(?:%{$fg_bold[green]%}λ :%{$fg_bold[red]%}λ %s)"

function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}branch: %{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

if [[ -e $PWD/.git ]]; then
    PROMPT='$ret_status %{$fg[white]%}[ $(get_pwd) ] $(git_prompt_info) %{$fg_bold[green]%}➜ %{$reset_color%} '
else
    PROMPT='$ret_status %{$fg[white]%}[ $(get_pwd) ] %{$fg_bold[green]%}➜ %{$reset_color%} '
fi
