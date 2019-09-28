export PATH=$PATH:$HOME/Projects/flutter/bin:$HOME/Projects/gcc-arm-none-eabi-8-2018-q4-major/bin

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#code () {
#    if [[ $# = 0 ]]
#    then
#        open -a "Visual Studio Code"
#    else
#        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
#        open -a "Visual Studio Code" --args "$F"
#    fi
#}


export PS1='$(if [[ $? == 0 ]]; then printf "\xf0\x9f\x98\x89"; else printf "\xf0\x9f\x98\xa1"; fi) \u \w $(parse_git_branch) $ '

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.cargo/bin:$PATH"
