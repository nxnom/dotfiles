# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000

# check history file is exists
if [ -f $HOME/.cache/zsh/history ]; then
  HISTFILE=$HOME/.cache/zsh/history
fi

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vi mode:
bindkey -v
export KEYTIMEOUT=1
#  ---------------- Extra ------------------- #

# ------------------------------------- #
# Aliases                               #
# ------------------------------------- #
source $ZDOTDIR/aliases.zsh

# device specific configs
[ -f $ZDOTDIR/local.zsh ] && source $ZDOTDIR/local.zsh


# ------------------------------------- #
# ZSH PROMPT                            #
# ------------------------------------- #
# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# https://www.nerdfonts.com/cheat-sheet -- emojis
# icons   ﱾ   

PREFIX=' %F{yellow}'

if [[ $UID -eq 0 ]]; then
  PREFIX=' %F{red}(root)'
fi

PROMPT='$PREFIX %F{#33C8CC}%1~%F{#E1341E}${vcs_info_msg_0_}%f '

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' %F{yellow}✗'
zstyle ':vcs_info:*' stagedstr ' %F{green}+'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       ' (%b )%u%c'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a )%u%c'

# ------------------------------------- #
# PLUGINS                               #
# ------------------------------------- #
ZSH_PLUGINS=$ZDOTDIR/plugins
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$PATH:$ZDOTDIR/scripts"

# eval "$(direnv hook zsh)"
