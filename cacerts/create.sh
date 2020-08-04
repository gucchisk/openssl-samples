#!/bin/bash

mkdir -p keys
mkdir -p certs

# genkey
openssl ecparam -genkey -name prime256v1 -out keys/ca.key

# csr
openssl req -new -key keys/ca.key -subj "/CN=root ca/" -out certs/ca.csr

# cert
openssl x509 -req -in certs/ca.csr -signkey keys/ca.key -days 365 -out certs/ca.crt -extfile ca.txt

# cert 2
openssl x509 -req -in certs/ca.csr -signkey keys/ca.key -days 365 -out certs/ca2.crt -extfile ca.txt

# genkey
openssl ecparam -genkey -name prime256v1 -out keys/server.key

# csr
openssl req -new -key keys/server.key -subj "/CN=server/" -out certs/server.csr

# cert
openssl x509 -req -in certs/server.csr -CA certs/ca.crt -CAkey keys/ca.key -CAcreateserial -days 365 -sha256 -out certs/server.crt -extfile server.txt

# csr 2
openssl req -new -key keys/server.key -subj "/CN=server2/" -out certs/server.csr

# cert 2
openssl x509 -req -in certs/server.csr -CA certs/ca2.crt -CAkey keys/ca.key -CAcreateserial -days 365 -sha256 -out certs/server2.crt -extfile server.txt

