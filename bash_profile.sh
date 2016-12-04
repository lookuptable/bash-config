HOME_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLATFORM=`uname`

# scripts=("environment_variables.sh" "colors.sh" "alias.sh")
well_known_scripts=( environment_variables.sh colors.sh alias.sh gcloud.sh )
for script in "${well_known_scripts[@]}"; do
  script_path="$HOME/.bash/$script"
  if [ -f "${script_path}" ]; then
    source $script_path
  fi
done


#############################
### CUSTOM COMMAND PROMPT ###
#############################

# Format:
# <USERNAME>@<HOSTNAME>: <CURRENT_DIR> [git:<BRANCH>]              [<LAST_STATUS>]
print_before_the_prompt() {
    EXIT_STATUS=$?
    if [ $EXIT_STATUS -eq 0 ]; then
        LAST_STATUS=`printf "$txtrst%${COLUMNS}s$txtrst" ""`
    elif [ $EXIT_STATUS -eq 146 ]; then
        LAST_STATUS=`printf "$txtylw%${COLUMNS}s$txtrst" "[PAUSE]"`
    elif [ $EXIT_STATUS -eq 130 ]; then
        LAST_STATUS=`printf "$txtred%${COLUMNS}s$txtrst" "[KILL]"`
    else
        LAST_STATUS=`printf "$txtred%${COLUMNS}s$txtrst" "[ERROR: $EXIT_STATUS]"`
    fi

    DIR=`pwd | sed -e "s!$HOME!~!"`
    if [ ${#DIR} -gt 50 ]; then
        CD=${DIR:0:22}...${DIR:${#DIR}-25}
    else
        CD=$DIR
    fi

    GIT=''
    BRANCH=`git branch 2> /dev/null | grep \* | awk '{print $2}'`
    if [[ "$BRANCH" != "" ]]; then
        GIT="[git:$BRANCH]"
    fi

    hostname=$(hostname -s)
    PROMPT_LEFT=`printf "$txtcyn%s$txtylw@%s: $txtgrn%s $txtcyn%s\n$txtrst" "$USER" "$hostname" "$CD" "$GIT"`
    PROMPT_RIGHT="$LAST_STATUS"
    COMPENSATE=5
    printf "\n%*s\r%s" "$(($(tput cols)+${COMPENSATE}))" "$PROMPT_RIGHT" "$PROMPT_LEFT"
}
PROMPT_COMMAND=print_before_the_prompt
PS1='→ '

####################
### BASH OPTIONS ###
####################

# Enable expanded globs (regex)
shopt -s extglob

# Automatically correct mistyped directory names
shopt -s cdspell

# Include dot files in filename expansion results
shopt -s dotglob

# Expand aliases
shopt -s expand_aliases

# Use case-insensitive matching for filename expansion results
shopt -s nocaseglob

# Ignore-case for tab-completion
bind "set completion-ignore-case on"

# Improve completion of file and directory names
bind "set show-all-if-ambiguous on"

#################
### FUNCTIONS ###
#################

# Grep from history
hg() {
    term=$1
    history | grep $term
}


# Move up specified number of directories (1 by default)
up() {
  dir=""
  limit=$1
  for ((i=1 ; i <= limit; i++))
  do
    dir=$dir/..
  done
  dir=$(echo $dir | sed 's/^\///')
  if [ -z "$dir" ]; then
    dir=..
  fi
  cd $dir
}

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

set -o vi

upsearch () {
  slashes=${PWD//[^\/]/}
  directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    test -e "$directory/$1" && echo "$directory/$1" && return
    directory="$directory/.."
  done
}

gw() {
  gradlew=`upsearch gradlew`

  if [ ! -z "$gradlew" ]; then
    COMMAND="$gradlew --daemon $@"
    echo $COMMAND
    eval $COMMAND
  fi
}

### Bash history setup ###
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

if [[ "$PLATFORM" == "Darwin" ]]; then
  # brew is only available under MacOS
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

jwt_decode() {
  fields=(`cat | sed 's/\./ /g' | tr " " "\n"`)
  header=${fields[0]}
  payload=${fields[1]}

  echo $header | base64 --decode | python -m json.tool
  echo $payload | base64 --decode | python -m json.tool
}

# Set up go path
if [ ! -d "$GOPATH" ] || [ ! -d "$GOPATH/src" ]; then
  echo "$GOPATH or $GOPATH/src does not exist; creating it"
  mkdir -p $GOPATH/src
fi
