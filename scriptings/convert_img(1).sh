#!/bin/bash 
#
#	convert_img_1.sh - Realiza a conversão de imagens JPG para PNG
#
# Site:       https://github.com/jackson-vip/Shell_Script
# Author:     Jackson F. Tiburtino
# Maintence:  Jackson    e-mail : jackson.tiburtinopb@gmail.com   
# License:    GPLv3 
# Distro: 		Debian GNU/Linux
#
# »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»» # 
#  
#  $ ./convert_img_1.sh        
#  
#  O script realiza a conversão das imgens JPG para PNG 
#
# »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»» # 
# Version : v1.0 
# Date :    08/03/2023 
#
# Tested on:
#         bash 5.1.16
# »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»» # 


# função convert_img 

converte_img(){

# Path da pasta imagens-livros 
cd ~/Downloads/imagens-livos 

# A condicional está verificando se existe a pasta PNG 
# se não existir então criar pasta PNG 
if [ ! -d png ]
then
		mkdir png 
fi 

# Laço de repetição : A variável img está recebendo uma lista de arq .png dentro da pastsa imagens-livros 
for img in *.jpg
do
	# img_sx ( Imagens sem extensãoes ) 
	local	img_sx=$(ls $img | awk -F. '{print $1}')
	convert $img_sx.jpg  png/$img_sx.png
done

}

# Chamando nossa função e na existencia de erro jogando para uma log.txt 
converte_img 2> log_conversão.txt
# Se o status de saída for = a 0 então msg="Sucesso na conversão"
# se falso msg="erro de conversão!"
if [ $? -eq 0 ]
then
		echo "Conversão feita com Sucesso"
else 
		echo "Hove um erro no processo de conversão"
fi 
