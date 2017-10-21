#! /bin/bash

clear

if [ "$1" = "" ] ; then 
	echo "Error: Por favor introduce la direccion IP/mascara para hacer ping."
    exit 1
fi

ip=$(echo $1 | grep "/" | cut -f 1 -d "/")
mask=$(echo $1 | grep "/" | cut -f 2 -d "/")

echo "Haciendo PING a los hosts"
echo "Espere un momento, por favor ..."

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
				echo "$oct1.$i.$j.$k" >> hosts
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
			echo "$oct1.$oct2.$i.$j" >> hosts
		done
	done

elif [ "$mask" = "24" ] ; then 
	oct1=$(echo $ip | grep "." | cut -f 1 -d ".")
	oct2=$(echo $ip | grep "." | cut -f 2 -d ".")
	oct3=$(echo $ip | grep "." | cut -f 3 -d ".")
	for i in {1..254..1}
	do
		echo "$oct1.$oct2.$oct3.$i" >> hosts
	done

else 
	echo "Ingrese mascara 8,16 o 24"
fi
   
for IP in $(cat hosts)
	do
	ping -c1 -w1 "$IP" >& /dev/null #for both -w(deadline) and -c whichever comes first will terminate the ping command. #  >& /dev/null clean up
	
	if [ "$?" != "0" ] ; then # $? exit status variable. holds the exit status of a command...         
		echo -e "$IP \e[0;31m[X]\e[1;37m"
	else
		echo -e "$IP \e[1;32m[OK]\e[1;37m"
	fi
done

rm hosts 

echo
echo "Listo!!!"

