# enable zsh menu completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload -Uz compinit && compinit

# setup homebrew
eval "$(brew shellenv)"

# setup zsh plugins
source $HOMEBREW_PREFIX/etc/profile.d/autojump.sh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# setup volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# setup default editor
export EDITOR=$(which nvim)

# export mason bins
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
