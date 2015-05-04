#!/bin/bash
unset words
unset m
unset i
unset Passphrase
unset passphrases

read -r -a words < wordlist

read -e -p "How many passphrases do you want?: " -i "1" passphrases

GeneratePassphrase() {
  for i in {1..7}
  do
    let "m = $(od -vAn -N2 -tu4 < /dev/urandom | tr -d ' ') % 6800"
    Passphrase[i]=${words[$m]}
  done

  echo "${Passphrase[@]}"
}

for j in $(eval echo {1..$passphrases})
do
  GeneratePassphrase
done
