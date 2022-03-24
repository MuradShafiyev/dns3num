#!/bin/bash


# Changing between bash colors in outputs
end="\e[0m"
info="\e[1m\e[36m"
output="\e[1m\e[36m[++]"
error="\e[1m\e[91m[!!]"
question="\e[1m\e[93m[?]"
green="\e[92m"
ok="\e[1m\e[92m"



domain=$2

echo -e "dns3num VERSION:1.0\n"
echo -e "$green----- $domain ----- $end\n"                                                                           
                                                                              



if [ $# -lt 1 ]
then
	echo -e "$info Use --help to see options"
	echo -e "$error You forgot to specify the domain name... \n"
	echo -e "$info Syntax: ./dns3num.sh [Domain name]"
	echo -e "$info Full help: ./$0 -h "
	echo -e "$output ssss"
	echo -e "$green ss"
	echo -e "$ok ss"
	echo -e "$end"
	exit
fi

if [ $1 == --help ]
then
	echo -e "$info Usage: ./dns3num.sh [OPTIONS] [Domain Name]";
	echo -e "$info General Options: $end";
	echo "	-fb   	  Forward Lookup Bruteforce"
	echo -e "$green		Syntax: ./dns3num.sh -fb [Domain Name]$end"
	echo "	-rb    	  Reverse Lookup Bruteforce"
	echo -e "$green		Syntax: ./dns3num.sh -rb [Domain Name]$end"
	echo "	-ns       Nameserver Lookup"
	echo -e "$green		Syntax: ./dns3num.sh -ns [Domain Name]$end"
	echo -e "	-z    : Attempt Zone Transfer"
	echo -e "		Syntax: ./dns3num.sh -z [Nameserver] [Domain Name]\n\n"
#	echo "------------------------------------------------"
	exit
fi


if [ $1 == '' ]; then
	echo -e "$error You forgot to specify the domain name... \n"
	echo -e "$info Syntax: ./dns3num.sh [Domain name]"
	echo -e "$info Full help: $0 -h "
fi





#forward lookup
function forward_lookup(){
	echo -e "========================================";
	echo -e "  Forward Lookup Brute-forcing results  \n";
	for dom in $(cat subdomain_list.txt);do 
		host $dom.$domain | grep "has address"
	done
}


function nameserver_lookup(){
	#for server in $(cat subdomain_list.txt);do 
		host -t ns $domain | cut -d " " -f 4
	#done
	#host -t ns $2 | cut -d " " -f 4
}

function reverse_lookup() {
	# for dom in $(cat subdomain_list.txt);do 
	# 	ip=$(host $dom.$domain | grep "has address" | cut -d " " -f 4) | cut -d "." -f 3
	# 	exit
	# done
	# echo -e $ip;
	ip=$(host admin.megacorpone.com | grep "has address" | cut -d " " -f 4 | cut -d '.' -f-3);
	for i in $(seq 200 255); do
		host $ip.$i;done | grep -v "not found"

	#host admin.megacorpone.com | grep "has address" | cut -d " " -f 4 | cut -d '.' -f-3

}

function mx_lookup() {
	echo -e "$info"
	echo -e "Mail Servers  $end $info"
	echo -e "------------------------$end"
	if host -t mx $domain | grep 'mail' > /dev/null 2>&1; then
		host $domain | grep 'mail' | cut -d " " -f 7
		echo -e ""
	else
		echo -e "$error Hosts $domain has not mail server records\n";
	fi  
}


case "$1" in
	-fb) forward_lookup ;;
	-ns) nameserver_lookup ;;
	-rb) reverse_lookup ;;
	-mx) mx_lookup ;;
	*) echo "Option $1 is not recognized!!" ;;
esac

