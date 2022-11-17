#!/bin/sh

# NOTE: run this_script in its this_folder i.e. cd this_folder; ./this_script
_user="admin"
_pass="password"

_rest_ip="192.168.1.1"
_rest_port="1234"
_rest_url="https://$_rest_ip:$_rest_port"
_auth_endpoint="api/auth"
_endpoint="api/endpoint"   

curl $_rest_url/$_endpoint \
    -k \
    -X GET \
    -H "Authorization: `./lib/get_token.sh`"
    #                   ^ other script to be called \
