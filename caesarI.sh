#! /bin/bash
arr3=()
declare -a arr=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
echo "mensaje: $@ el cual tiene $# palabras"

for j in {1..25..1}; # Cantidad de espacios que se mueve
do
	arr3=()	
	echo "rotación + $j"
        for i in {0..25..1};do
                if [ $((i + j)) -gt 25 ];then # (1)
                	index=$((i + j -26))
                else
                	index=$((i + j)) 		
                fi		
                arr2[$index]=${arr[$i]} # (2)
        done	

	for l in "$@";do #para todas las palabras que se ingresaron
		for (( cont=0; cont<${#l}; cont++ )) 
		do # (3)
			for k in {0..25..1};do
				if [ ${l:$cont:1} = ${arr[$k]} ];then #(4)
					arr3+=${arr2[$k]}	
				fi
				done
		done
	done
	echo "${arr3[*]}" 
done

# (1) suma la posicion actual con los espacios que se debe mover para saber en que lugar queda la letra
# si esta posicion es mayor que 25, se le resta 26 y se obtiene la pisicion(indice del array) correcta
# (2) Nuevo abecedario rotado + j
# (3) Este for separa cada letra de la palabra, por eso el for va hasta la longitud de dicha palabra
# (4) Compara la letra recortada de la entrada, con el abecedario original para saber a que indice del "array abecedario original" pertenece
# Luego este indice se usa para encontrar la letra en el "nuevo abecedario rotado + j" y formar la frase decifrada.

