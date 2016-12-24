#!/bin/sh
#########################################################
# File: download_flags.sh
# Author: Nabil Elqatib
# Email: nabilelqatib@gmail.com
# Date: 23/12/2016
# Description: 
#########################################################

HERE=$(cd "$(dirname "$0")" && pwd)
url="i.infopls.com/images"

while IFS= read -r line; do
# 	echo "tester: $line"
	countryName=${line%:*}
	countryLowerCase=$(echo "$countryName"|tr '[:upper:]' '[:lower:]')

	# flags of double worded-country names are stored in the same url
	# replacing the full country name with its first world
	# example for US: $usr/uni
	if ( echo "$countryLowerCase" | grep -q ' ' ); then
		echo "$countryLowerCase has space!"
		#TODO solve this problem!
	else
		wget -nc "$url/$countryLowerCase.gif" -O "flags/$countryLowerCase.gif" >/dev/null 2>&1
	fi
done < "capitals.txt"
