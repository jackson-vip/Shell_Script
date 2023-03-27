#!/bin/bash
#
#    lista.sh - Listagem de tarefas a serem realizadas 
#
#    Site:       https://github.com/
#    Author:     Jackson F. Tiburtino
#    Maintence:  Jackson    e-mail : jackson.tiburtinopb@gmail.com
#    License:    GPLv3 
#    Distro:     Debian GNU/Linux
#
# ------------------------------------------------------------------------ #
#
#    Examples:
#         $ ./list.sh
#
#    O script irá criar um arquivo de nome "lista_de_tarefas.txt"     
#    Ao digitar as tarefas o usuário pode salvar sua tarefas em uma pasta
#    de nome "my_list"     
# ------------------------------------------------------------------------ #
#    Version : v1.0 
#    Date :    27/03/2023
#
#    Tested on:
#         bash 5.1.16
# ------------------------------------------------------------------------ #


# Função para gerar um ID aleatório
gerar_id() {
    
    # Gera um número aleatório entre 1 e 1000 e verifica se o ID já existe na lista
    while true
    do
        id=$(( (RANDOM % 1000) +1))
        # Formata o número com zeros à esquerda para garantir que ele tenha 6 dígitos
        id=$(printf "%06d" $id) # Adiciona zeros à esquerda para ter 6 dígitos
        # Verifica se o ID já existe na lista
        if ! grep -q "^$id " lista_de_tarefas.txt
        then
            # Retorna o ID se ele não existe na lista
            echo $id
            return
        fi
    done
}

# Color : 
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# Hora 
hora=$(date +%H:%M:%S)

# Data e Hora 
data_hora=$(date +%d-%m-%Y"_"%H:%M:%S)

# Cria um arquivo vazio para armazenar a lista
touch lista_de_tarefas.txt

# ID
id=1

# Loop principal do programa
while true
do
    # Exibe o menu e solicita a opção desejada ao usuário
    echo -e "\n"
    echo -e "================================================\n"
    echo -e "${GREEN}Selecione uma opção:${NC}\n"
    echo "1. Adicionar item"
    echo "2. Listar todos os itens"
    echo "3. Remover item"
    echo "4. Salvar"
    echo "5. sair"
    echo -e "\n"
    echo -e "================================================\n"
    read opcao

    case $opcao in
        1)
            # Solicita ao usuário para digitar um item e adiciona-o à lista
            echo "Digite um item:"
            read item
            # Gera um ID exclusivo aleatório e verifica se ele já existe na lista
            id=$(gerar_id)
            # Adiciona o item à lista com o ID único
            echo -e "$id : $hora → $item" >> lista_de_tarefas.txt
            clear
            echo -e "Item adicionado com sucesso!${GREEN} (ID: $id)${NC}"
            # Incrementa a variável de contagem de IDs
            ;;
        2)
            # Lista todos os itens na lista
            clear
            echo "-----------------------------------------------"
            echo -e "\t\t${GREEN}Itens na lista:${NC}"
            echo -e "-----------------------------------------------\n"
            echo -e "${GREEN}  ID   |   HORA   | MSG:${NC}"
            cat lista_de_tarefas.txt
            echo ""
            echo -e "-----------------------------------------------\n"
            ;;
        3)
            # Solicita ao usuário para digitar um item para remover e remove-o da lista
            echo "Digite o ID do item a ser removido:"
            read id_remover
            # Remove o item com o ID especificado da lista
            if grep -q "^$id_remover " lista_de_tarefas.txt
            then
                sed -i "/^$id_remover /d" lista_de_tarefas.txt
                clear
                echo -e "-----------------------------------------------\n"
                echo -e "\t${GREEN}Item removido com sucesso!${NC}"
                echo -e "-----------------------------------------------\n"
            else
                clear
                echo -e "-----------------------------------------------\n"
                echo -e "${RED}O ID $id_remover não foi encontrado na lista.${NC}"
                echo -e "-----------------------------------------------\n"
            fi
            ;;
        4)
            # Salva a lista e sai do programa
            if [ ! -d my_list ];then 
                mkdir my_list
            fi 
            cp lista_de_tarefas.txt my_list/lista_$data_hora.txt
            echo "Salvando lista na pasta my_list e saindo..."
            exit 0
            ;;
        5)
            # Sair do programa
            echo "Saindo..."

            sleep 2
            exit 0
            ;;
        *)
            # Exibe uma mensagem de erro para opções inválidas
            clear
            echo -e "-----------------------------------------------\n"
            echo -e "${RED}\tOpção inválida. Tente novamente.${NC}"
            echo -e "-----------------------------------------------\n"
            ;;
    esac
done