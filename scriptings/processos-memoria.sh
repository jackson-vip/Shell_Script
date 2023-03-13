#!/bin/bash 

# Criando uma Dir chamando log
if [ ! -d log ] ;then
	mkdir log 
fi 

# função 
processo_memoria(){

# Armazenando os 10 primeiros processos por tamanho

processo=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])
date_hora=$(date +%F,%H:%M:%S,)

for pid in $processo 
do
	nome_processo=$(ps -p $pid -o comm= | sed s/' '//g)
	echo -n $date_hora >> log/$nome_processo.log
	tamanho_processo=$(ps -p $pid -o size | grep [0-9])
	echo "$(bc <<< "scale=2;$tamanho_processo/1024") MB" >> log/$nome_processo.log
done 
}

# chamando a função e em seguida realizando um teste de funcionalidade
processo_memoria
if [ $? -eq 0 ] ;then 
	echo "Os arquivos foram salvos com sucesso"
else 
	echo "Houve um erro ao salvar os arquivos"
fi 
