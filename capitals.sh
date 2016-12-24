#!/bin/bash
#########################################################
# File: capitals.sh
# Author: Nabil Elqatib
# Email: nabilelqatib@gmail.com
# Date: 17/12/2016
# Description: 
#########################################################
# {MYVAR%pattern} delete shortest match of pattern from the beginning
# {MYVAR##pattern} delete longest match of pattern from the beginning
# {MYVAR%pattern}
# {MYVAR%%pattern} .. same from the end

HERE=$(cd "$(dirname "$0")" && pwd)

declare -a COLORS
COLORS[0]='\033[0;31m'
COLORS[1]='\033[0;32m'
COLORS[2]='\033[0;33m'
COLORS[3]='\033[0;34m'
COLORS[4]='\033[0;35m'
COLORS[5]='\033[0;36m'
selectedColor=${COLORS[$RANDOM % ${#COLORS[@]}]}

factsUrl='http://www.sciencekids.co.nz/sciencefacts/countries'

keepImportantLines(){
	sed -i '/<p align=\"left\">/!d' "$HERE/facts/$1.txt"
}

deletePTags(){
	sed -i 's/<\/p>//g' "$HERE/facts/$1.txt"
	sed -i 's/<p align=\"left\">//g' "$HERE/facts/$1.txt"
}


deleteLiTags(){
	sed -i 's/<\li>//g' "$HERE/facts/$1.txt"
}

getFacts(){
	a="$1"
	if ! [ -f "$HERE/facts/$a.txt" ]; then
		touch "$HERE/facts/$a.txt"
	fi
	curl -s "$factsUrl/$a.html" >> "$HERE/facts/$a.txt"
	keepImportantLines "$a"
	deletePTags "$a"
	deleteLiTags "$a"
}

showSomeRandomFact(){
	shuf -n 2 "$HERE/facts/$1.txt"|grep -v "img src="|grep -v "a href="
}

capitalsFile="$HERE/capitals.txt"
lineChosen=$(shuf -n 1 "$capitalsFile")
country=${lineChosen%:*}
capital=${lineChosen##*:}
countryLowerCase=$(echo "$country"|tr '[:upper:]' '[:lower:]')

echo -e "What's the capital of $country?"
sleep 5
echo -e "$selectedColor$capital\033[m"
# sleep 1

# for some reason there is a syntax problem in this line..
# if ! [ -s "$HERE/facts/$countryLowerCase.txt" ]; then
getFacts "$countryLowerCase"	
# fi
showSomeRandomFact "$countryLowerCase"
