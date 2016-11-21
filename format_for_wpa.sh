#!/bin/bash
# Formats a text file given as the first argument
# 1. Removes any non-ascii characters
# 2. Removes lines that are all digits and either 8 or 10 chars in length as these are covered in other lists
# 3. Removes any lines that are < 8 or > 63 chars as per wpa spec
# 4. Sorts the file and removes any duplicates
if [ -n "$1" ]
then
	cat $1 | perl -p -e 's/[^[:ascii:]]//g' > a.txt
	cat a.txt | sed -r -e '/^[0-9]{8}$/d' -e '/^[0-9]{10}$/d' -e '/^.{0,7}$/d' -e '/^.{64,}$/d' > b.txt
	rm -f a.txt
	#cat b.txt | sort | uniq > formatted_wpa.txt
	#rm -f b.txt
else
	echo "Usage: $0 wordlist_file.txt"
	echo "  The wordlist file will not be overwritten."
	echo "  Resulting file will be in the same directory called formatted_wpa.txt."
fi
