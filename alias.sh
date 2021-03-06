case "$PLATFORM" in
  "Darwin")
    alias ls='ls -GT'
    alias vim='mvim -v'

    source $HOME/.bash/darwin-alias.sh
    ;;
  "Linux")
    alias ls='ls --color'
    ;;
esac

alias ll='ls -l'        # show list in long format
alias la='ls -lA'       # show hidden files
alias lx='ls -lXB'      # sort by extension
alias lk='ls -lSr'      # sort by size
alias lc='ls -lcr'      # sort by change time
alias lu='ls -lur'      # sort by access time
alias lt='ls -ltr'      # sort by date
alias lr='ls -lr'       # recursive ls
alias cls='clear; ls'   # clear before listing
alias tree='tree -Ch'   # list as tree with sizes

# Interactive file system commands
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'

# Grep customizations
alias grep='grep --color=auto'       # color flag enabled
alias lgrep='grep -rl --color=auto'  # list files with matches
function rgrep() {
  echo "grep -r --color=auto $@ ."
  grep -r --color=auto $@ .
}

# System monitoring
alias cpu='top -o cpu'
alias mem='top -o rsize'

# Bash shortcuts
alias bashrc="vim $HOME/.bashrc"
alias src="source $HOME/.bashrc"

# Vim shortcut
alias vimrc="vim $HOME/.vimrc"

# Pretty-print $PATH
alias path='echo -e ${PATH//:/\\n}'

# Mute system volume
alias mute="osascript -e 'set volume output muted true'"

alias down="cd $HOME/Downloads/"

# git-related aliases
alias gb='git branch'
alias gdn='git diff --name-only'
alias gd='git difftool'
alias gs='git status'
alias gp='git pull'

alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'

alias xlog='git log --date-order --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'

alias temp='target=`date "+%Y%m%d"`; mkdir -p ~/.temp/${target}; cd ~/.temp/${target}'

alias fix_brew='sudo chown -R $(whoami) /usr/local'

alias psp='pbpaste | sort | pbcopy'

alias github="cd ${GOPATH}/src/github.com/"
alias istio="cd ${GOPATH}/src/istio.io/"
alias lut="cd ${GOPATH}/src/github.com/lookuptable"
alias k8s="cd ${GOPATH}/src/k8s.io/"

# bazel
alias bb="bazel build //..."
alias bt="bazel test //..."

# go related utilities
alias gg='rgrep --include="*.go" --exclude-dir="vendor"'
alias ggnt='rgrep --include="*.go" --exclude="*_test.go" --exclude-dir="vendor"'

# python related utilities
alias pg='rgrep --include="*.py"'
alias pgnt='rgrep --include="*.py" --exclude="*test*" --exclude-dir=.tox'

alias k='kubectl'
alias kd='kubectl describe'
alias kdd='kubectl describe deploy'
alias kdn='kubectl describe no'
alias kdp='kubectl describe po'
alias kds='kubectl describe svc'
alias ke='kubectl edit'
alias ked='kubectl edit deploy'
alias ken='kubectl edit no'
alias kep='kubectl edit po'
alias kes='kubectl edit svc'
alias kg='kubectl get'
alias kgd='kubectl get deploy'
alias kgn='kubectl get no'
alias kgp='kubectl get po'
alias kgs='kubectl get svc'
