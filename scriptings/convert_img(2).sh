#!/bin/bash
#
#	convert_img_2.sh - Realiza a conversão de imagens JPG para PNG
#
# Site:       https://github.com/jackson-vip/Shell_Script
# Author:     Jackson F. Tiburtino
# Maintence:  Jackson    e-mail : jackson.tiburtinopb@gmail.com   
# License:    GPLv3 
# Distro: 		Debian GNU/Linux
#
# »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»» # 
#  
#  $ ./convert_img_2.sh        
#  
#  O script faz uma varredura no diretório informado e em todas as pastas       
#  subsequentes e realiza a conversão das imgens JPG para PNG 
#
# »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»» # 
# Version : v1.0 
# Date :    08/03/2023 
#
# Tested on:
#         bash 5.1.16
#
# »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»» # 

convert_img(){

		local des_img=$1
		local img_sx=$(ls $des_img | awk -F. '{ print $1 }')
		convert $img_sx.jpg $img_sx.png 
}

varrer_dir(){
 	cd  $1
	for arq in * 
	do 	
				
		local des_arq=$(find ~/Downloads/imagens-livros -name $arq)

		if [[ -d $des_arq ]]
		then
				varrer_dir $des_arq
		else 
				convert_img $des_arq
		fi
		
	done 
}

varrer_dir ~/Downloads/imagens-livros

if [ $? -eq 0 ]
then 
		echo "Conversão realizado com Sucesso!"
else 
		echo "Erro no Processo de conversão"
fi 
