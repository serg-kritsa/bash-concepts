#!/bin/sh

_user="admin"
_pass="password"

_rest_ip="192.168.1.1"
_rest_port="1234"
_rest_url="https://$_rest_ip:$_rest_port"
_auth_endpoint="api/auth"

# NOTE                                             other json file
curl $_rest_url/$_auth_endpoint \
    -k \
    -X POST \
    -H Content-Type:application/json \
    -d@./lib/credentials.json

