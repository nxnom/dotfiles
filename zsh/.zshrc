export XDG_CONFIG_HOME=$HOME/.config
export ZOTDIR=$XDG_CONFIG_HOME/zsh

# ------------------------------------- #
# PLUGINS                               #
# ------------------------------------- #
ZSH_PLUGINS=$ZOTDIR/plugins
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ------------------------------------- #
# Aliases                               #
# ------------------------------------- #
source $ZOTDIR/aliases.zsh

# device specific configs
[ -f $ZOTDIR/internal.zsh ] && source $ZOTDIR/internal.zsh


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
# e.g. here we add the Git information in red  
PROMPT='%F{yellow}➜  %F{blue}%1~ %F{red}${vcs_info_msg_0_}%f '

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' %F{yellow}✗'
zstyle ':vcs_info:*' stagedstr ' %F{green}+'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b)%u%c'
zstyle ':vcs_info:git:*' actionformats '(%b|%a)%u%c'

