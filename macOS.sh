log(){
    echo -e "\033[1;34m[Setup] $1 \033[0m"
}

# Packages list
BREW=("pyenv" "pyenv-virtualenv" "ffmpeg" "lsd" "tldr" "you-get" "mas" "wget")
BREW_CASK=("iina" "docker" "java" "microsoft-edge" "iterm2" "visual-studio-code" "sourcetree" "wechat" "qq" "obsidian" "discord" "scroll-reverser" "font-hack-nerd-font" "istat-menus" "google-chrome" "forklift")
BREW_TAP=("homebrew/cask-fonts")
MAS=()
VSCODE_EXTENSIONS=("akamud.vscode-theme-onedark" "coenraads.bracket-pair-colorizer" "ms-ceintl.vscode-language-pack-zh-hans" "formulahendry.code-runner" "yzhang.markdown-all-in-one" "ms-python.python" "ms-vscode-remote.remote-ssh")

log "Please make sure you are in a VPN env. Press any key to continue..."
read

# Install Homebrew
log "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Add to Homebrew Tap
for pkg in ${BREW_TAP[*]}
do
    log "Adding $pkg to Homebrew Tap..."
    brew tap $pkg
done

# Install packages with Homebrew
for pkg in ${BREW[*]}
do
    log "Installing $pkg with Homebrew..."
    brew install $pkg
done

# Install packages with Homebrew Cask
for pkg in ${BREW_CASK[*]}
do
    log "Installing $pkg with Homebrew Cask..."
    brew cask install $pkg
done

# Install packages with Mas
for pkg in ${MAS[*]}
do
    log "Installing $pkg with Mas..."
    mas install $pkg
done

# .zshrc file
log "Writing to .zshrc file..."
cat>.zshrc<<EOF
alias cls="clear"
alias ls="lsd"
alias l="ls -al"
  
# ========== PYENV PART START ==========

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ========== PYENV PART END ==========
EOF
source .zshrc

# Python env
log "Installing python 3.8.2 with pyenv..."
pyenv install 3.8.2
log "Setting python env to 3.8.2..."
pyenv global 3.8.2

# git
log "Setting git..."
git config --global user.name "Yifan Wang"
git config --global user.email wyf0762@foxmail.com

# system preference

log "Editing system preference..."
defaults write com.apple.dock tilesize -int 40; killall Dock
defaults write com.apple.Dock showhidden -bool yes; killall Dock

# vscode

log "Please open vscode and add code command to PATH. Press any key to continue."

for ext in ${VSCODE_EXTENSIONS[*]}
do
    log "Installing VSCode extension ${ext}..."
    code --install-extension $ext
done

log "Editing VSCode settings..."
cat>/Users/yifanwang/Library/Application\ Support/Code/User/settings.json<<EOF
{
    "workbench.colorTheme": "Atom One Dark",
    "workbench.tree.indent": 16,
    "editor.fontSize": 20
}
EOF
