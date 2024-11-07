#!/bin/bash

# Cores para mensagens
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Sem cor

# Função para suspender usuário
suspender_usuario() {
    read -p "Digite o nome do usuário que deseja suspender: " usuario
    if id "$usuario" &>/dev/null; then
        usermod -L "$usuario"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Usuário '$usuario' foi suspenso com sucesso.${NC}"
        else
            echo -e "${RED}Falha ao suspender o usuário '$usuario'.${NC}"
        fi
    else
        echo -e "${RED}Usuário '$usuario' não encontrado.${NC}"
    fi
}

# Função para reativar usuário
reativar_usuario() {
    read -p "Digite o nome do usuário que deseja reativar: " usuario
    if id "$usuario" &>/dev/null; then
        usermod -U "$usuario"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Usuário '$usuario' foi reativado com sucesso.${NC}"
        else
            echo -e "${RED}Falha ao reativar o usuário '$usuario'.${NC}"
        fi
    else
        echo -e "${RED}Usuário '$usuario' não encontrado.${NC}"
    fi
}

# Função para exibir o menu
exibir_menu() {
    clear
    echo -e "${BLUE}=========================================${NC}"
    echo -e "${YELLOW}          GERENCIAMENTO DE USUÁRIOS      ${NC}"
    echo -e "${BLUE}=========================================${NC}"
    echo -e "${YELLOW}1. SUSPENDER USUÁRIO${NC}"
    echo -e "${YELLOW}2. REATIVAR USUÁRIO${NC}"
    echo -e "${YELLOW}3. RETORNAR AO MENU${NC}"
    echo -e "${BLUE}=========================================${NC}"
}

# Loop principal
while true; do
    exibir_menu
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1)
            suspender_usuario
            ;;
        2)
            reativar_usuario
            ;;
        3)
            echo -e "${GREEN}Saindo...${NC}"
            menu
            ;;
        *)
            echo -e "${RED}Opção inválida. Por favor, tente novamente.${NC}"
            ;;
    esac
    read -p "Pressione Enter para continuar..." enter
done
