#!/usr/bin/env zsh

platformTmp="$(uname -s)"

case "${platformTmp}" in
    Linux*)   platform=Linux;;
    Darwin*)  platform=macOS;;
    CYGWIN*)  platforme=Cygwin;;
    MINGW*)   platform=MinGw;;
    *)        platform="UNKNOWN:${platformTmp}":
esac

# Update macOS.
sudo softwareupdate --install --all

# Install xcode command line tools
xcode-select --install

# Install rosetta
sudo softwareupdate --install-rosetta --agree-to-license



########## Zsh ##########

if [ -f ${HOME}/.zcompdump ]; then
    rm -f ~/.zcompdump; compinit
fi

if [ ! -f ${HOME}/.zshrc ]; then
    ln -vs ${PWD}/rc/zsh/zshrc ~/.zshrc
    success "${HOME}/.zshrc created"
else
    info "${HOME}/.zshrc already exists"
fi

if [ ! -f ${HOME}/.zprofile ]; then
    ln -vs ${PWD}/rc/zsh/zprofile ~/.zprofile
    success "${HOME}/.zprofile created"
else
    info "${HOME}/.zprofile already exists"
fi


########## Brew ##########

# Check if homebrew is installed

if (( ! ${+commands[brew]} )); then
    # NOINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade

sh ${PWD}/scripts/homebrew


# If you need to have ncurses first in your PATH, run:
#   echo 'export PATH="/opt/homebrew/opt/ncurses/bin:$PATH"' >> ~/.zshrc

# For compilers to find ncurses you may need to set:
#   export LDFLAGS="-L/opt/homebrew/opt/ncurses/lib"
#   export CPPFLAGS="-I/opt/homebrew/opt/ncurses/include"

########## Meta Package Manager ##########

# brew install python@3.11
# brew install pipx
# pipx ensurepath

# brew install meta-package-manager

# mpm --verbosity INFO sync
# mpm --verbosity INFO --exclude mas restore ./package.toml



########## Mac App Store ##########

# ...


########## Node ##########

# Create missing .npm-global/bin directories.

if [ ! -d ${HOME}/.npm-global/bin ]; then
    mkdir -p ${HOME}/.npm-global
fi

# Copy .npmrc file to $HOME

if [ ! -f ${HOME}/.npmrc ]; then
    ln -vs ${PWD}/rc/.npmrc ~/.npmrc
    success "${HOME}/.npmrc created"
else
    info "${HOME}/.npmrc already exists"
fi

# Install node packages

#



########## Cargo ##########


# Install rust.

if (( ! ${+commands[cargo]} )); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi


cargo install --features pcre2 ripgrep
cargo install eza


########## Git ##########

git config --global user.name "Tri Nguyen"
git config --global user.email mail@trimn.net

########## rc ##########

if [ ! -d ${HOME}/.config ]; then
    mkdir ${HOME}/.config
fi


# ssh config
if [ ! -d ${HOME}/.ssh/config.d ]; then
    ln -vs ${PWD}/rc/ssh/config.d ~/.ssh/config.d
fi

if [ ! -f ${HOME}/.ssh/config ]; then
    ln -vs ${PWD}/rc/ssh/config ~/.ssh/config
fi


if [ ! -f ${HOME}/.editorconfig ]; then
    ln -vs ${PWD}/rc/.editorconfig ~/.editorconfig
    success "${HOME}/.editorconfig created"
else
    info "${HOME}/.editorconfig already exists"
fi


if [ ! -f ${HOME}/.gitignore ]; then
    ln -vs ${PWD}/rc/.gitignore ~/.gitignore
    success "${HOME}/.gitignore created"
else
    info "${HOME}/.gitignore already exists"
fi



