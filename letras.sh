#! /bin/bash

declare -a arr=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

arr3=()
for l in "$@";do
	for (( cont=0; cont<${#l}; cont++ ))
	do	
		for k in {0..25..1};do
		if [ ${l:$cont:1} = ${arr[$k]} ];then
		echo $k
		arr3+=${arr2[$k]} #nuevo abc rotado	
		fi
		done
	done
done

echo "${arr3[*]}"

# ${l:$cont:1} #cut desde la posi _ y contara _ carac
