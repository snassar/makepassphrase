#!/bin/bash
passphrases=$1

# Generates passphrase array with seven words.
# Use octal dump to capture 2 bytes, 4 bytes per integer,
# address radix none, display duplicates.
# This exists because of Micah F. Lee.
GeneratePassphrase() {
	# Unset any variables to prevent potential injection of external values.
	unset words
	unset w
	unset m
	unset i
	unset Passphrase
	# Read wordlist into array
	read -r -a words < wordlist
      	for i in {1..7}
	do
		let "w = $(od -vAn -N2 -tu4 < /dev/urandom | tr -d ' ') % 6800"
		Passphrase[i]=${words[$w]}
	done

	echo "${Passphrase[@]}"
}

# Generate as many passphrases as desired.
for j in $(eval echo {1..$passphrases})
do
	GeneratePassphrase
done
