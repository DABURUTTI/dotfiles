#[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux && exit

ts="fzf"

if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="新たなセッションを開始"
  kill_all_task_and_Start="Tmuxサーバーをキルして、新たなセッションを開始"
  ID="$ID\n${create_new_session}\n${kill_all_task_and_Start}"
  ID="`echo $ID | $ts | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ "$ID" = "${kill_all_task_and_Start}" ]]; then
    tmux kill-server
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

alias ls="ls -G"
alias ll="ls -lG"
alias la="ls -laG"
eval "$(anyenv init -)"
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir newline vcs)
setopt AUTO_CD
setopt AUTO_PARAM_KEYS
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit wait"!0" lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
    atload"source init.sh" \
        b4b4r07/enhancd

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}


if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
