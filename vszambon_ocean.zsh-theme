function pwd_base() {
  echo $(in_docker)$(pwd)
}

function theme_preexec {
  setopt local_options extended_glob
  if [[ "$TERM" = "screen" ]]; then
    local CMD=${1[(wr)^(=|sudo|-*)]}
    echo -n "\ek$CMD\e\\"
  fi
}

function in_docker() {
    if [ "${RUNNING_IN_DOCKER}" = "true" ]; then
        echo "🐳:"
    else
        echo ""
    fi
}

function default_emoji {
  if [ -d .git ]; then
   echo "";
  else
   echo "🔮✨";
  fi
}

function day_to_night_icon() {
  current_hour=$(date +%H)

  # Calculate the length of each part in hours
  ((part_length = 24 / 8))

  if ((current_hour >= 0 && current_hour < part_length)); then
    echo "🌑"
  elif ((current_hour >= part_length && current_hour < 2 * part_length)); then
    echo "🌒"
  elif ((current_hour >= 2 * part_length && current_hour < 3 * part_length)); then
    echo "🌓"
  elif ((current_hour >= 3 * part_length && current_hour < 4 * part_length)); then
    echo "🌔"
  elif ((current_hour >= 4 * part_length && current_hour < 5 * part_length)); then
    echo "🌕"
  elif ((current_hour >= 5 * part_length && current_hour < 6 * part_length)); then
    echo "🌖"
  elif ((current_hour >= 6 * part_length && current_hour < 7 * part_length)); then
    echo "🌗"
  else
    echo "🌘"
  fi
}

# Set the prompt

# Need this so the prompt will work.
setopt prompt_subst

# See if we can use colors.
autoload zsh/terminfo
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
  typeset -g PR_$color="%{$terminfo[bold]$fg[${(L)color}]%}"
  typeset -g PR_LIGHT_$color="%{$fg[${(L)color}]%}"
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"

# Modify Git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="🐙 %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} %{%G✚%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} %{%G✹%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} %{%G✖%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} %{%G➜%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} %{%G═%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} %{%G?%}"

# Use extended characters to look nicer if supported.
if [[ "${langinfo[CODESET]}" = UTF-8 ]]; then
  PR_SET_CHARSET=""
  PR_HBAR="─"
  PR_ULCORNER="┌"
  PR_LLCORNER="└"
  PR_LRCORNER="┘"
  PR_URCORNER="┐"
  PR_VBAR="│"
else
  typeset -g -A altchar
  set -A altchar ${(s..)terminfo[acsc]}
  # Some stuff to help us draw nice lines
  PR_SET_CHARSET="%{$terminfo[enacs]%}"
  PR_SHIFT_IN="%{$terminfo[smacs]%}"
  PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
  PR_HBAR="${PR_SHIFT_IN}${altchar[q]:--}${PR_SHIFT_OUT}"
  PR_ULCORNER="${PR_SHIFT_IN}${altchar[l]:--}${PR_SHIFT_OUT}"
  PR_LLCORNER="${PR_SHIFT_IN}${altchar[m]:--}${PR_SHIFT_OUT}"
  PR_LRCORNER="${PR_SHIFT_IN}${altchar[j]:--}${PR_SHIFT_OUT}"
  PR_URCORNER="${PR_SHIFT_IN}${altchar[k]:--}${PR_SHIFT_OUT}"
  PR_VBAR="${PR_SHIFT_IN}${altchar[x]:--}${PR_SHIFT_OUT}"
fi

# Decide if we need to set titlebar text.
case $TERM in
  xterm*)
    PR_TITLEBAR=$'%{\e]0;%(!.-=[ROOT]=- | .)ocean - %n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
    ;;
  screen)
    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)ocean - %n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
    ;;
  *)
    PR_TITLEBAR=""
    ;;
esac

# Decide whether to set a screen title
if [[ "$TERM" = "screen" ]]; then
  PR_STITLE=$'%{\ekzsh\e\\%}'
else
  PR_STITLE=""
fi

# Finally, the prompt.
PROMPT='${PR_SET_CHARSET}${PR_STITLE}${(e)PR_TITLEBAR}\
${PR_CYAN}${PR_ULCORNER}${PR_HBAR}${PR_BLUE}\
⦗${PR_GREEN}$(pwd_base)${PR_BLUE}⦘\
$(ruby_prompt_info)${PR_CYAN}${PR_HBAR}${PR_HBAR}${PR_HBAR}${PR_BLUE}\
⟅${PR_CYAN}%(!.%SROOT%s.%n)${PR_WHITE}@${PR_GREEN}%m${PR_BLUE}⟆\
${PR_CYAN}${PR_HBAR}${PR_HBAR}${PR_HBAR}${PR_BLUE}(${PR_YELLOW}%D{%a,%b-%d}${PR_BLUE})\
${PR_CYAN}${PR_HBAR}${PR_HBAR}$(day_to_night_icon)
${PR_VBAR}\

${PR_CYAN}${PR_LLCORNER}${PR_BLUE}${PR_HBAR}\
(${PR_LIGHT_BLUE}%{$reset_color%}$(default_emoji)$(git_prompt_info)$(git_prompt_status)${PR_BLUE})\
${PR_CYAN}꣼ ${PR_NO_COLOUR} '

PS2='${PR_CYAN}${PR_HBAR}\
${PR_BLUE}${PR_HBAR}(\
${PR_LIGHT_GREEN}%_${PR_BLUE})${PR_HBAR}\
${PR_CYAN}${PR_HBAR}${PR_NO_COLOUR} '