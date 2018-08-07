#!/bin/bash
OPENSSL_VER="$(openssl version)"

if [[ $OPENSSL_VER == *"0.9"* ]]; then
	echo "Your OpenSSL version is too old: $OPENSSL_VER"
	echo "Please install version 1.0.1 or later"
	exit -1
else
    echo "Your OpenSSL version is: $OPENSSL_VER"
fi


export CA_PWD="4grTPV2"
export TS_PWD="Q9sgzXK"
export KS_PWD="bUmdN5K"
export KEY_PASS="3nHhssr"
export NODE_NAME="NODE-1"

#Search-guard user password
KIBANA_PWD=aaaa 
LOGSTASH_PWD=bbbb
BEATS_PWD=cccc
ELASTIC_PWD=dddd



set -e
./clean.sh
./gen_root_ca.sh $CA_PWD $TS_PWD 
./gen_node_cert.sh 0 $KS_PWD $CA_PWD && ./gen_node_cert.sh 1 $KS_PWD $CA_PWD &&  ./gen_node_cert.sh 2 $KS_PWD $CA_PWD
#./gen_revoked_cert_openssl.sh "/CN=revoked.ma.lan/OU=SSL/O=Test/L=Test/C=DE" "revoked.ma.lan" "revoked" changeit $CA_PWD
./gen_node_cert_openssl.sh "/CN=es-node.ma.lan/OU=SSL/O=Test/L=Test/C=DE" "es-node.ma.lan" "es-node" $KEY_PASS $CA_PWD
./gen_node_cert_openssl.sh "/CN=node-4.ma.lan/OU=SSL/O=Test/L=Test/C=DE" "node-4.ma.lan" "node-4" $KEY_PASS $CA_PWD
./gen_client_node_cert.sh spock $KS_PWD $CA_PWD
./gen_client_node_cert.sh kirk $KS_PWD $CA_PWD
./gen_client_node_cert.sh logstash $KS_PWD $CA_PWD
./gen_client_node_cert.sh filebeat $KS_PWD $CA_PWD
./gen_client_node_cert.sh kibana $KS_PWD $CA_PWD
#./gen_client_node_cert.sh sgadmin changeit $CA_PWD
rm -f ./*tmp*

