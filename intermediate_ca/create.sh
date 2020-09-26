#!/bin/bash

mkdir -p keys
mkdir -p certs

# genkey root
openssl ecparam -genkey -name prime256v1 -out keys/ca.key

# csr root
openssl req -new -key keys/ca.key -subj "/CN=root ca/" -out certs/ca.csr

# cert root
openssl x509 -req -in certs/ca.csr -signkey keys/ca.key -days 365 -out certs/ca.crt -extfile ca.txt

# genkey intermediate
openssl ecparam -genkey -name prime256v1 -out keys/intermediate.key

# csr intermediate
openssl req -new -key keys/intermediate.key -subj "/CN=intermediate/" -out certs/intermediate.csr

# cert intermediate
openssl x509 -req -in certs/intermediate.csr -CA certs/ca.crt -CAkey keys/ca.key -CAcreateserial -days 365 -sha256 -out certs/intermediate.crt -extfile intermediate.txt

# genkey server
openssl ecparam -genkey -name prime256v1 -out keys/server.key

# csr server
openssl req -new -key keys/server.key -subj "/CN=server/" -out certs/server.csr

# cert server
openssl x509 -req -in certs/server.csr -CA certs/intermediate.crt -CAkey keys/intermediate.key -CAcreateserial -days 365 -sha256 -out certs/server.crt -extfile server.txt

# create bundled server cert
cat certs/server.crt certs/intermediate.crt > certs/server_bundled.crt
