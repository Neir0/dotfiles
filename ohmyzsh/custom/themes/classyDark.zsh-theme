# ZSH Theme - classyDark

local current_dir='%F{green}[%{$reset_color%}%F{magenta}%~% %F{green}]%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="%(?,%F{green}┌─╼${current_dir}%{$reset_color%} ${git_branch}
%F{green}└────╼%{$reset_color%} ,%F{green}┌─╼${current_dir}%{$reset_color%} ${git_branch}
%F{green}└╼ %{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%F{cyan}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{$reset_color%}"
