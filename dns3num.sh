#!/bin/bash

echo -e "dns3num tool"

# Changing between bash colors in outputs
end="\e[0m"
info="\e[1m\e[36m"
output="\e[1m\e[36m[++]"
error="\e[1m\e[91m[!!]"
question="\e[1m\e[93m[?]"
green="\e[92m"
ok="\e[1m\e[92m"


if [$1 == '']; then
	echo -e "$error You forgot to specify the domain name... \n"
	echo -e "$info Syntax: ./dns3num.sh [Domain name]"
	echo -e "$info Full help: ./$0 -h "
fi


#forward lookup
#for dom in $(cat $1);do 
#	host $dom.megacorpone.com | grep "has address"
#done


#reverse lookup
#for ip in $(seq 200 255);do 
#	host 51.222.169.$ip;done | grep -v "not found"


#zone transfer
#for server in $(host -t axfr megacorpone.com);do
#	host -l megacorpone.com $server | grep "has address"
#done
