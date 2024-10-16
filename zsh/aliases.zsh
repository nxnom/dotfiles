alias cdd='cd ~/Development'
alias cdt='cd ~/Temp'

alias sls='live-server .'
alias c=clear
alias pn=pnpm

# set SCRCPY_ADB_PATH to the path of your adb binary to avoid conflicts
alias start-scrcpy='ADB=$SCRCPY_ADB_PATH scrcpy --always-on-top'

# setup direnv for python
alias setup-python-direnv='echo "layout python" > .envrc && python3 --version > .tool-versions && direnv allow'
