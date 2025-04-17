#!/bin/bash

# colors
green="\033[0;32m"
no_color="\033[0m"

# locations

dotfiles="$HOME/.dotfiles"
tmp="/tmp/.dotfiles"
log=$HOME/.dotfiles_installation_log

# functions 
function echoSectionTitle() {
  echo -e "${green}";
  echo >> $log;
  echo "==============================================================" | tee -a $log;
  echo "= $1" | tee -a $log;
  echo "==============================================================" | tee -a $log;
  echo -e "${no_color}";
  echo >> $log;
}

function cmd() {
  "$@" 2>&1 | tee -a $log;
}

function echoColorEmptyLine() {
  echo -e "${green}\n";
  echo >> $log;
}

function echoNoColorEmptyLine() {
  echo -e "${no_color}\n";
  echo >> $log;
}

function aptUpdate() {
  cmd sudo apt update;
}

function aptInstall() {
  cmd sudo apt install -y "$@";
}

function gitClone() {
  cmd git clone "$@";
}

echoColorEmptyLine;
cmd echo "Hello, fellow programmer! Welcome to Abraao's";
cmd echo;

cmd echo "██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗";
cmd echo "██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝";
cmd echo "██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗";
cmd echo "██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║";
cmd echo "██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║";
cmd echo "╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝";

cmd echo -e "                                              install script.";
cmd echo;
cmd echo "This script will automatically install";
cmd echo "some dev and utility stuff, which I use in my main machine.";
cmd echo;
cmd echo "It may ask you something in the middle of the proccess.";
cmd echo;
cmd echo "Now sit back and relax. It'll take some time, but when done,";
cmd echo "you'll have a much more simpler, focused  system.";
cmd echo;
cmd echo "-Abraao";
echoNoColorEmptyLine;

read -p "Press Enter to continue...";

echoSectionTitle "Updating system";

aptUpdate;
cmd sudo apt -y upgrade;

echoColorEmptyLine;
echo "██████╗ ███████╗██████╗ ███████╗███╗   ██╗██████╗ ███████╗███╗   ██╗ ██████╗██╗███████╗███████╗";
echo "██╔══██╗██╔════╝██╔══██╗██╔════╝████╗  ██║██╔══██╗██╔════╝████╗  ██║██╔════╝██║██╔════╝██╔════╝";
echo "██║  ██║█████╗  ██████╔╝█████╗  ██╔██╗ ██║██║  ██║█████╗  ██╔██╗ ██║██║     ██║█████╗  ███████╗";
echo "██║  ██║██╔══╝  ██╔═══╝ ██╔══╝  ██║╚██╗██║██║  ██║██╔══╝  ██║╚██╗██║██║     ██║██╔══╝  ╚════██║";
echo "██████╔╝███████╗██║     ███████╗██║ ╚████║██████╔╝███████╗██║ ╚████║╚██████╗██║███████╗███████║";
echo "╚═════╝ ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝╚══════╝╚══════╝";
echoNoColorEmptyLine;

# echoSectionTitle "Installing curl e wget";
aptInstall curl;
aptInstall wget;

# echoSectionTitle "Installing exa (um 'ls' melhorado)";
aptInstall exa;

# echoSectionTitle "Installing bat (alternativa ao 'cat')";
aptInstall bat;

# echoSectionTitle "Installing gh (github)";
aptInstall gh;

# echoSectionTitle "Installing ncdu (alternativa ao 'du' para listar tamanho dos diretórios)";
aptInstall ncdu;

# echoSectionTitle "Installing tilix (Terminal)";
aptInstall tilix;

# echoSectionTitle "Installing fzf";
aptInstall fzf;

# echoSectionTitle "Installing apt dependencies";
# aptInstall software-properties-common;

# echoSectionTitle "Installing dconf";
# aptInstall dconf-editor;

# echoSectionTitle "Installing Git";
aptInstall git;

echoSectionTitle "Cloning dotfiles repo in $dotfiles directory";
gitClone https://github.com/rodolfobertini/dotfiles.git $dotfiles;

echoColorEmptyLine;
cmd echo "████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗     ";
cmd echo "╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║     ";
cmd echo "   ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║     ";
cmd echo "   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     ";
cmd echo "   ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗";
cmd echo "   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝";
echoNoColorEmptyLine;

echoSectionTitle "Installing Zsh";
aptInstall zsh;

echoSectionTitle "Installing HackNerdFont in .fonts directory";
cmd mkdir -p $HOME/.local/share/fonts;
cmd ln -s $HOME/.local/share/fonts $HOME/.fonts;
cmd wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf;
cmd wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf;
cmd mv $HOME/*.ttf $HOME/.fonts;

echoSectionTitle "Installing Z.sh in home directory";
cmd wget https://raw.githubusercontent.com/rupa/z/master/z.sh;
cmd mv z.sh .z.sh;

echoSectionTitle "Improved Nano Syntax Highlighting Files";
gitClone --depth=1 https://github.com/scopatz/nanorc.git .nano;
cmd echo "include $HOME/.nano/*.nanorc" >> ~/.nanorc;

echoSectionTitle "Installing Oh My Zsh";
gitClone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh;

echoSectionTitle "Installing Powerlevel10k";
gitClone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k;

echoSectionTitle "Installing zsh-autosuggestions";
gitClone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions;

echoSectionTitle "Installing zsh-completions";
gitClone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions;


echoColorEmptyLine;
echo "██████╗ ███████╗██╗   ██╗    ███████╗████████╗██╗   ██╗███████╗███████╗";
echo "██╔══██╗██╔════╝██║   ██║    ██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝";
echo "██║  ██║█████╗  ██║   ██║    ███████╗   ██║   ██║   ██║█████╗  █████╗  ";
echo "██║  ██║██╔══╝  ╚██╗ ██╔╝    ╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ";
echo "██████╔╝███████╗ ╚████╔╝     ███████║   ██║   ╚██████╔╝██║     ██║     ";
echo "╚═════╝ ╚══════╝  ╚═══╝      ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ";
echoNoColorEmptyLine;

# install asdf
gitClone https://github.com/asdf-vm/asdf.git ~/.asdf

# install asdf plugins
cmd $HOME/.asdf/lib/asdf.sh plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
cmd $HOME/.asdf/lib/asdf.sh plugin add yarn 
cmd $HOME/.asdf/lib/asdf.sh install yarn
cmd $HOME/.asdf/lib/asdf.sh install nodejs lts

echoColorEmptyLine;
echo "███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗";
echo "██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝";
echo "███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗";
echo "╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║";
echo "███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║";
echo "╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝";
echoNoColorEmptyLine;

# zsh
echoSectionTitle "Creating symlink for Zsh at ~/.zshrc";
cmd rm $HOME/.zshrc;
cmd ln -s $dotfiles/zsh/.zshrc $HOME/.zshrc;
cmd sudo chsh -s $(which zsh);

# p10k
echoSectionTitle "Creating symlink for .p10k.zsh at ~/.p10k.zsh";
cmd rm $HOME/.p10k.zsh;
cmd ln -s $dotfiles/zsh/.p10k.zsh $HOME/.p10k.zsh;

# .gitconfig
echoSectionTitle "Creating symlink for .gitconfig at ~/.gitconfig";
cmd ln -sf $dotfiles/git/.gitconfig $HOME/.gitconfig;

# .asdf
echoSectionTitle "Creating symlink for .asdfrc at ~/.asdfrc";
cmd ln -sf $dotfiles/asdf/.asdfrc $HOME/.asdfrc;
cmd ln -sf $dotfiles/asdf/.tool-versions $HOME/.tool-versions;


echoColorEmptyLine;
cmd echo "Congratulations!";
cmd echo;
cmd echo "Now you have all the environment set in minutes.";
cmd echo "Read the docs in https://github.com/AbraaoAlves/dotfiles to know the features and keymappings.";
cmd echo "Also you can see .dotfiles_installation_log file in you home directory with all outputs from this operation.";
cmd echo;
cmd echo "You have to reboot your system to see the changes.";
echoNoColorEmptyLine;

cmd read -p "Press Enter to quit..."
