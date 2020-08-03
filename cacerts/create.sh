#!/bin/bash

# genkey
openssl ecparam -genkey -name prime256v1 -out ca.key

# csr
openssl req -new -key ca.key -subj "/CN=root ca/" -out ca.csr

# cert
openssl x509 -req -in ca.csr -signkey ca.key -days 365 -out ca.crt -extfile ca.txt

# cert 2
openssl x509 -req -in ca.csr -signkey ca.key -days 365 -out ca2.crt -extfile ca.txt

# genkey
openssl ecparam -genkey -name prime256v1 -out server.key

# csr
openssl req -new -key server.key -subj "/CN=server/" -out server.csr

# cert
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -days 365 -sha256 -out server.crt -extfile server.txt

# csr 2
openssl req -new -key server.key -subj "/CN=server2/" -out server.csr

# cert 2
openssl x509 -req -in server.csr -CA ca2.crt -CAkey ca.key -CAcreateserial -days 365 -sha256 -out server2.crt -extfile server.txt

