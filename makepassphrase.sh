#!/bin/bash

# makepassphrase - a passphrase generator
# Copyright (C) 2015  Samir Nassar
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
