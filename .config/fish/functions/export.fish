## set env vars
set -xg PATH $PATH ~/.npm-global/bin

## OS Spesific settings
switch (uname)
case Linux
     set -xg TERM "xterm-256color"
end

set -Ux EDITOR emacs
set -Ux VISUAL emacs
set -Ux NVM_DIR "~/.nvm"