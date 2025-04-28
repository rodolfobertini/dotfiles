# Dotfiles

Bem-vindo ao repositório dos meus **dotfiles**! Este projeto contém a configuração do meu ambiente de desenvolvimento no Ubuntu. Ele automatiza a instalação de ferramentas, melhorias de produtividade e personalizações para um workflow eficiente.

## Funcionalidades

- Instalação automática de ferramentas essenciais como `curl`, `wget`, `exa`, `bat`, `gh`, `fzf`, entre outras.
- Configuração de fontes **Nerd Fonts** para um terminal mais estilizado.
- Integração com **Oh My Zsh** e o tema **Powerlevel10k** para uma experiência de terminal aprimorada.
- Aprimoramentos para o editor de texto `nano` com destaque de sintaxe avançado.
- Configuração de atalhos, plugins e melhorias para o shell `zsh`.
- Criação automática de links simbólicos para arquivos de configuração, como `.zshrc`, `.p10k.zsh` e `.gitconfig`.

## Como Instalar

Execute o comando abaixo no terminal para iniciar a instalação:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/rodolfobertini/dotfiles/main/install-ubuntu.sh)
