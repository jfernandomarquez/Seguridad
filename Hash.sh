#! /bin/bash

if [ "$@" = "" ] ; then 
	echo "Error: Por favor introduce el mensaje"
    exit 1
fi
echo ""
echo "**********************************************************"
echo "Valor de HASH sha1: "
echo -n "$@" | sha1sum | awk '{print toupper($1)}'
echo "**********************************************************"
echo ""
echo "**********************************************************"
echo "Valor de HASH MD5: "
echo - n"$@" | md5sum | awk '{print toupper($1)}'
echo "**********************************************************"
echo ""