#! /bin/bash
arr3=()
declare -a arr=("00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "0A" "0B" "0C" "0D" "0E" "0F" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "1A" "1B" "1C" "1D" "1E" "1F" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "2A" "2B" "2C" "2D" "2E" "2F" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "3A" "3B" "3C" "3D" "3E" "3F" "40" "41" "42" "43" "44" "45" "46" "47" "48" "49" "4A" "4B" "4C" "4D" "4E" "4F" "50" "51" "52" "53" "54" "55" "56" "57" "58" "59" "5A" "5B" "5C" "5D" "5E" "5F" "60" "61" "62" "63" "64" "65" "66" "67" "68" "69" "6A" "6B" "6C" "6D" "6E" "6F" "70" "71" "72" "73" "74" "75" "76" "77" "78" "79" "7A" "7B" "7C" "7D" "7E" "7F") 

for j in {1..127..1}; # Cantidad de espacios que se mueve
do
	arr3=()	
	echo
	echo " rotación + $j"
	echo
        for i in {0..127};do
                if [ $((i + j)) -gt 127 ];then # (1)
                	index=$((i + j -128))
                else
                	index=$((i + j)) 		
                fi		
                arr2[$index]=${arr[$i]} # (2)
		
        done

	for l in "$@";do 
		for k in {0..127};do
			if [ $l = ${arr[$k]} ];then #(3)
				arr3+=${arr2[$k]}	
			fi
		done
	done
	#echo "${arr3[0]}" 
	for (( cont=0; cont < ${#arr3[0]}; cont=cont+2 )) 
	do
		echo -e -n "\x${arr3[0]:$cont:2}" #(4)
	done
done

# (1) suma la posicion actual con los espacios que se debe mover para saber en que lugar queda la letra
# si esta posicion es mayor que 127, se le resta 126 y se obtiene la pisicion(indice del array) correcta
# (2) Nuevo array "ascii(Hexa) rotado + j"
# (3) El obejtivo es encontrar el indice en el array original del hexa de entrada, para luego buscar a que hexa corresponde en el
# array rotado + j y llevarlo a un nuevo array para ser impreso.
# (4) se hace con el fin de imprimir los simbolos ascii y no el hexa




