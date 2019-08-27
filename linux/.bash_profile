export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export PS1="\[\e[35;01m\][\u@\W]\$\[\e[m\]"
export GREP_OPTIONS='--color=auto'
alias ll='ls -l'
alias ctags='/usr/local/bin/ctags'
export PATH=$PATH:.:$HOME/bin

alias k=kubectl
source <(kubectl completion bash | sed s/kubectl/k/g)
alias kcd='kubectl config set-context $(kubectl config current-context) --namespace '
alias kcg='kubectl config get-contexts '
alias kcu='kubectl config use-context '

source <(helm completion bash)
