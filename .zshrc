# ------------------------------
# Zsh specific options
# ------------------------------

#bindkey -e               # キーバインドをemacsモードに設定
bindkey -v              # キーバインドをviモードに設定

setopt no_beep
setopt auto_cd
setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt prompt_subst
setopt notify

### Complement ###
autoload -U compinit; compinit                      # 補完機能を有効にする
setopt auto_list
setopt auto_menu
setopt list_packed                                  # 補完候補をできるだけ詰めて表示する
setopt list_types                                   # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete                # complimentation reverse-toggle :S-Tab
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # ignore uppercase or lowercase
bindkey "^R" history-incremental-search-backward

### Glob ###
setopt extended_glob                                # グロブ機能を拡張する
unsetopt caseglob                                   # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history                             # ヒストリを保存するファイル
HISTSIZE=10000                                      # メモリに保存されるヒストリの件数
SAVEHIST=10000                                      # 保存されるヒストリの件数
# setopt extended_history                             # ヒストリに実行時間も保存する
setopt hist_ignore_dups                             # 直前と同じコマンドはヒストリに追加しない
setopt share_history                                # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks                           # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }


# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
autoload -U colors; colors
tmp_prompt="%{${fg[cyan]}%}%n:%~%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%D %T]%{${reset_color}%}"
temp_rprompt=""
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

# ------------------------------
# Source global definitions
# ------------------------------
# shell env
if [ -f ~/.sh_local ]; then
    . ~/.sh_local
fi

# shell alias
if [ -f ~/.sh_aliases ]; then
    . ~/.sh_aliases
fi

