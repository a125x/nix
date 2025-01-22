# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' max-errors 0 not-numeric
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} m:=_ m:=- m:=.'
zstyle ':completion:*' file-sort modification reverse
zstyle ':completion:*' special-dirs false
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
bindkey -M menuselect '^[[Z' reverse-menu-complete # shift tab 

# all the vi mode fixes to make it usable
autoload -U colors && colors	# Load colors
export EDITOR='vim'
set -o vi   

vi-search-fix() {
zle vi-cmd-mode
zle .vi-history-search-backward
}

zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix
setopt PROMPT_SUBST

bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" backward-kill-line      

source ./plugins/git/git-prompt.sh

precmd () { __git_ps1 %F{yellow}"%1d"%f %F{magenta}"%s → "%f }
#PROMPT="$(__git_ps1 " \[\033[1;32m\] (%s)\[\033[0m\]")\$"
#PS1="%{$fg[yellow]%}%1d → %{$reset_color%} $(__git_ps1)"

setopt autocd		# Automatically cd into typed y
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# never beep
unsetopt BEEP
unsetopt LIST_BEEP

export PATH=$PATH:/nix/var/nix/profiles/default/bin/
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

alias ..="cd .."
alias ...='cd ../..'

alias v='nvim'
alias n='nvim'
alias p='python'
alias safari='open -a Safari'
alias eun='euporie-notebook'
alias jn='jupyter notebook'
alias chrome='open -a Google\ Chrome'
alias ssd='smartctl -a disk0'
alias brewclang='/opt/homebrew/opt/llvm/bin/clang++'
alias comp='tar -czvf'
alias uncomp='tar -xvf'
alias cde='codium -r'
alias yab='yabai --start-service'
alias nyab='yabai --stop-service'
alias ls='eza'
alias sf='sudo lf'
alias icat="kitty +kitten icat"
#alias cd='zoxide'

# Inspired by https://github.com/m-ou-se/config/blob/master/shellrc.

# Set a color in the terminal palette.
# \param 1 The index in the pallete.
# \param 2 is a hexadecimal RGB color code.
function set_color {
	if [ "$TERM" = "linux" ]; then
		[ $1 -lt 16 ] && printf $'\e]P%X%s' "$1" "$2"
	else
		printf $'\e]4;%s;#%s\e\\' "$1" "$2"
	fi
}
set_color  0 262626 # black
set_color  1 cc241d # red
set_color  2 98971a # green
set_color  3 d79921 # yellow
set_color  4 458588 # blue
set_color  5 b16286 # magenta
set_color  6 689d6a # cyan
set_color  7 928374 # light grey
set_color  8 282828 # dark grey
set_color  9 fb4934 # bright red
set_color 10 b8bb26 # bright green
set_color 11 fabd2f # bright yellow
set_color 12 83a598 # bright blue
set_color 13 d3869b # bright magenta
set_color 14 8ec07c # bright cyan
set_color 15 F9D9B4 # white
# Set colors for 256
set_color 17 076678 # dark blue
set_color 22 79740e # dark green
set_color 52 9d0006 # dark red
set_color 53 8f3f71 # dark magenta

# theme for bat
export BAT_THEME="gruvbox-dark"

source ./plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#504945,underline"
source ./plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ./plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
eval "$(zoxide init zsh)"

#rxfetch
