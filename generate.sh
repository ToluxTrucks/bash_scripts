#!/bin/bash

read -p "What is the name of your key file and Cert file?: " KEYNAME
read -p "How many days is this certficate valid for?:" DAYS

#Generating a 4096 bit RSA private key
openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout ${KEYNAME}.key -out ${KEYNAME}.crt -subj "/CN=dashboardnew.com" -days ${DAYS}
