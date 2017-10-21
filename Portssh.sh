#! /bin/bash

clear

if [ "$1" = "" ] ; then 
	echo "Error: Por favor introduce la direccion IP/Mascara para verificar SSH."
    exit 1
fi

ip=$(echo $1 | grep "/" | cut -f 1 -d "/")
mask=$(echo $1 | grep "/" | cut -f 2 -d "/")

rm hosts1

echo "Verificando si el servicio SSH esta activo en el puerto 22"
echo "Espere un momento, Por favor ..."

if [ "$ip" = "" ] ; then #si la ip esta vacia es porque no se ingreso /
	echo "Error: ingrese ip/mascara ejm: 192.168.1.1/24"
	exit 1

elif [ "$mask" = "8" ] ; then 
	oct1=$(echo $ip | grep "." | cut -f 1 -d ".")
	for i in {1..255..1}
	do
		for j in {1..255..1}
		do
			for k in {1..254..1}
			do
				echo "$oct1.$i.$j.$k" >> hosts1
			done
		done
	done

elif [ "$mask" = "16" ] ; then 
	oct1=$(echo $ip | grep "." | cut -f 1 -d ".")
	oct2=$(echo $ip | grep "." | cut -f 2 -d ".")
	for i in {1..255..1}
	do
		for j in {1..254..1}
		do
			echo "$oct1.$oct2.$i.$j" >> hosts1
		done
	done

elif [ "$mask" = "24" ] ; then 
	oct1=$(echo $ip | grep "." | cut -f 1 -d ".")
	oct2=$(echo $ip | grep "." | cut -f 2 -d ".")
	oct3=$(echo $ip | grep "." | cut -f 3 -d ".")
	for i in {1..254..1}
	do
		echo "$oct1.$oct2.$oct3.$i" >> hosts1
	done

else 
	echo "Ingrese mascara 8,16 o 24"
fi

counter=22
SERVERFILE=hosts1

for IP in $(cat $SERVERFILE)
do
	#(echo >/dev/tcp/$IP/$counter) > /dev/null 2>&1 
    
	nc -z $IP 22
  
    if [ "$?" != "0" ] ; then   
       
    	echo -e  "$IP \e[0;31m[Close SSH]\e[1;37m"

	else 
		echo -e  "$IP \e[1;32m[Open SSH port 22]\e[1;37m"
    fi

done 
 
echo
echo "Listo!!!"
