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
	sed -i '/<p align=\"left\">/!d' "facts/$1.txt"
}

deletePTags(){
	sed -i 's/<\/p>//g' "facts/$1.txt"
	sed -i 's/<p align=\"left\">//g' "facts/$1.txt"
}


deleteLiTags(){
	sed -i 's/<\li>//g' "facts/$1.txt"
}

getFacts(){
	a="$1"
	curl -s "$factsUrl/$a.html" > "facts/$a.txt"
	keepImportantLines "$a"
	deletePTags "$a"
	deleteLiTags "$a"
}

showSomeRandomFact(){
	shuf -n 2 "facts/$1.txt"|grep -v "img src="|grep -v "a href="
}

capitalsFile=capitals.txt
lineChosen=$(shuf -n 1 "$capitalsFile")
country=${lineChosen%:*}
capital=${lineChosen##*:}
countryLowerCase=$(echo "$country"|tr '[:upper:]' '[:lower:]')

echo -e "What's the capital of $country?"
sleep 5
echo -e "$selectedColor$capital\033[m"
sleep 1

# if ![ -s facts/$countryLowerCase.txt ]; then
# fi
getFacts "$countryLowerCase"	
showSomeRandomFact "$countryLowerCase"
