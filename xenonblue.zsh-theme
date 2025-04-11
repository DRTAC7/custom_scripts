# Custom Fork of Darkblood by DRTAC7

PROMPT=$'%{$fg[blue]%}┌[%{$fg_bold[white]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$fg_bold[white]%}%m%{$reset_color%}%{$fg[blue]%}] %{$(git_prompt_info)%}%(?,,%{$fg[cyan]%}[%{$fg_bold[white]%}%?%{$reset_color%}%{$fg[cyan]%}])
%{$reset_color%}%{$fg[blue]%}└[%{$fg_bold[white]%}%~%{$reset_color%}%{$fg[blue]%}]>:%{$reset_color%} '
PS2=$' %{$fg[green]%}|>%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red]%}] "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"