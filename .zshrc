# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions colorize zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:/Users/alphabrain/.local/bin
export LDFLAGS="-L/opt/homebrew/opt/lapack/lib"
export CPPFLAGS="-I/opt/homebrew/opt/lapack/include"
export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"
export LDFLAGS="-L/opt/homebrew/opt/lapack/lib"
export CPPFLAGS="-I/opt/homebrew/opt/lapack/include"
export PATH=$PATH:/Users/alphabrain/.local/bin
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.10/bin

export M2_HOME=/Users/alphabrain/Workspace/Libraries/Java/apache-maven-3.9.0/bin
export PATH=$PATH:$M2_HOME

export PATH=/Users/alphabrain/Library/Java/JavaVirtualMachines/openjdk-18/Contents/Home/bin:$PATH
#source /Users/alphabrain/Workspace/Libraries/Python/envs/daily/bin/activate
