#!/bin/bash


echo Monitoreo de un servicio del sistema linux sSh > registros.txt
while(true);do

echo $(service sshd status | grep "Active:" ) > estado.txt

if [ $(cut -f 2 -d " " estado.txt) = inactive ];then
	time=$(cut -f 7 -d " " estado.txt)

	echo -n "El servicio fue desactivado por " >> registros.txt
	echo -n $(whoami) >> registros.txt
	echo " a las $time" >> registros.txt
fi
cat registros.txt
sleep 5
done

#Nota: se debe instalar openSSH con el comando sudo apt-get install openssh-server

#Log o registro es la grabación secuencial en un archivo o en una base de datos de todo los aconteciminetos que afectan a un proceso particular

############# ALTERNATIVA ###############
#No se utilizo porque se debe ejecutar el service status dos veces
#status=$(service sshd status | grep "Active:" | cut -f 5 -d ' ')
#if [ "$status" = inactive ];then
#time=$(service sshd status | grep "Active:" | cut -f 10 -d ' ')
#echo -n "El servicio fue desactivado por " > registro.txt
#echo -n $(whoami) >> registro.txt
#echo "a las " >> registro.txt
#echo $time >> registro.txt
#fi

