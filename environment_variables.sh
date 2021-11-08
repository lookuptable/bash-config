#############################################
### COLORS FOR TEXT/BACKGROUND FORMATTING ###
#############################################

# Terminal colors for ls
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

#############################
### ENVIRONMENT VARIABLES ###
#############################

export EDITOR=vim
export HISTCONTROL=ignoredups
export TERM=xterm-256color

export PATH=$PATH:/usr/local/bin
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH//bin

# Show man pages in color
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

if [[ "$PLATFORM" == "Darwim" ]]; then
  # /usr/libexec/java_home is only available under MacOS
  export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
fi
