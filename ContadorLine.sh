#! /bin/bash

TEX="$1"

if [ -f "$TEX" ] ; then

	LINE=$(wc -l $1 | awk '{print $1}') 
	echo "La cantidad de lineas del archivo es: $LINE"

else 
	 echo "Error, no se encontro el archivo $1"

fi
