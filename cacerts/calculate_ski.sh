#!/bin/bash

# create public key
openssl ec -in keys/server.key -pubout -out keys/server.pub.key

# parse public key
openssl asn1parse -in keys/server.pub.key -strparse 23 -noout -out keys/pub.bin

# calculate Subject Key Identifier
openssl sha1 keys/pub.bin
