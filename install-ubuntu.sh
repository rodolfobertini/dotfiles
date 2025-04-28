#!/bin/bash
# -----------------------------------------------------------------------------
# Script: install-ubuntu.sh
# Descrição: Configura automaticamente o ambiente de desenvolvimento no Ubuntu.
# Requisitos:
#   - Sistema operacional: Ubuntu/Debian.
#   - Permissões de administrador (sudo).
# Uso:
#   bash install-ubuntu.sh
# -----------------------------------------------------------------------------

set -e  # Interrompe o script em caso de erro

# Cores
green="\033[0;32m"
no_color="\033[0m"

# Localizações
dotfiles="$HOME/.dotfiles"
log="$HOME/.dotfiles_installation_log"

# URLs
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/Hack/Regular"

# Funções auxiliares
function echoSectionTitle() {
  echo -e "${green}";
  echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a $log;
  echo "==============================================================" | tee -a $log;
  echo -e "${no_color}";
}

function cmd() {
  "$@" 2>&1 | tee -a $log || handleError "$@"
}

function handleError() {
  echo -e "${no_color}Erro ao executar o comando: $1. Verifique o arquivo de log em $log."
  exit 1
}

function aptUpdate() {
  cmd sudo apt update && sudo apt dist-upgrade -y;
}

function aptInstall() {
  for package in "$@"; do
    if ! dpkg -s "$package" &> /dev/null; then
      echo "Instalando $package..."
      cmd sudo apt install -y "$package";
    else
      echo "$package já está instalado. Pulando..."
    fi
  done
}

function gitClone() {
  cmd git clone "$@";
}

function installNerdFonts() {
  echoSectionTitle "Installing HackNerdFont in .fonts directory";
  cmd mkdir -p $HOME/.local/share/fonts;
  cmd wget -q "$NERD_FONT_URL/HackNerdFont-Regular.ttf" -O $HOME/.local/share/fonts/HackNerdFont-Regular.ttf;
  cmd wget -q "$NERD_FONT_URL/HackNerdFontMono-Regular.ttf" -O $HOME/.local/share/fonts/HackNerdFontMono-Regular.ttf;
}

# Início do script
clear
echoSectionTitle "Bem-vindo ao script de instalação"
cmd echo "Este script configura um ambiente de desenvolvimento no Ubuntu."
cmd echo "Por favor, aguarde enquanto as instalações são realizadas."

read -p "Pressione Enter para continuar..."

# Atualização do sistema
echoSectionTitle "Atualizando o sistema"
aptUpdate;

# Instalação de pacotes essenciais
echoSectionTitle "Instalando pacotes essenciais"
aptInstall curl wget exa bat gh ncdu tilix fzf nala tree git zsh;

# Clonar repositório de dotfiles
echoSectionTitle "Clonando repositório de dotfiles"
if [ ! -d "$dotfiles" ]; then
  gitClone https://github.com/rodolfobertini/dotfiles.git "$dotfiles";
else
  echo "Repositório de dotfiles já existe. Pulando..."
fi

# Instalar fontes Nerd
installNerdFonts;

# Instalar Z.sh
echoSectionTitle "Installing Z.sh in home directory";
if [ ! -f "$HOME/.z.sh" ]; then
  cmd wget -q https://raw.githubusercontent.com/rupa/z/master/z.sh -O $HOME/.z.sh;
else
  echo "Z.sh já está instalado. Pulando..."
fi

# Melhorar Sintaxe do Nano
echoSectionTitle "Improved Nano Syntax Highlighting Files";
if [ ! -d "$HOME/.nano" ]; then
  gitClone --depth=1 https://github.com/scopatz/nanorc.git "$HOME/.nano";
  cmd echo "include $HOME/.nano/*.nanorc" >> ~/.nanorc;
else
  echo "Arquivos de destaque de sintaxe do Nano já clonados. Pulando..."
fi

# Instalar Oh My Zsh
echoSectionTitle "Instalando Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  gitClone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh";
else
  echo "Oh My Zsh já está instalado. Pulando..."
fi

# Instalar Powerlevel10k
echoSectionTitle "Instalando Powerlevel10k"
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  gitClone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k";
else
  echo "Powerlevel10k já está instalado. Pulando..."
fi

# Criar links simbólicos
echoSectionTitle "Criando links simbólicos"
cmd ln -sf "$dotfiles/zsh/.zshrc" "$HOME/.zshrc";
cmd ln -sf "$dotfiles/zsh/.p10k.zsh" "$HOME/.p10k.zsh";
cmd ln -sf "$dotfiles/git/.gitconfig" "$HOME/.gitconfig";

# Criar link simbólico para vte.sh
if [ "$VTE_VERSION" ]; then
  if [ ! -L "/etc/profile.d/vte.sh" ]; then
    echoSectionTitle "Creating symlink for vte.sh";
    cmd sudo ln -sf /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh;
  else
    echo "Link simbólico para vte.sh já existe. Pulando..."
  fi
fi

# Alterar shell padrão para Zsh
echoSectionTitle "Alterando shell padrão para Zsh"
cmd chsh -s "$(which zsh)";

# Finalização
echoSectionTitle "Finalização"
cmd echo "Parabéns! O ambiente foi configurado com sucesso."
cmd echo "Por favor, reinicie o sistema para aplicar todas as mudanças."
read -p "Pressione Enter para sair..."
