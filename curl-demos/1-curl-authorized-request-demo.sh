#!/bin/sh

# curl -k -X POST -H Content-Type:application/json -d '{"username":"admin","password":"password"}' https://192.168.14.83:9089/api/auth

# ## V0
# auth_tok=$(curl https://192.168.1.1:1234/api/auth -k -X POST -H Content-Type:application/json -d '{"username":"admin","password":"password"}' )
# ## options: -k (--insecure) to turn off curl's verification of the certificate, -X (--request), -H (--header), 
# # NOTE:                                                     if variable w/ double quotes
# curl 'https://192.168.1.1:1234/api/endpoint' -k -X GET -H "Authorization: $auth_tok"

# ## V1 formatted with \ in the end of line 
# # NOTE: -d '{}' (used w/ single quotes)
# auth_tok=$(curl https://192.168.1.1:1234/api/auth \
#     -k \
#     -X POST \
#     -H Content-Type:application/json \
#     -d '{"username":"admin","password":"password"}'
# )
# curl 'https://192.168.1.1:1234/api/endpoint' -k -X GET -H "Authorization: $auth_tok"

## V2 passing variables 
_user="admin"
_pass="password"

_rest_ip="192.168.1.1"
_rest_port="1234"
_rest_url="https://$_rest_ip:$_rest_port"
_auth_endpoint="api/auth"
_endpoint="api/enpoint"
## WRONG: not accepted variables inside -d option
## GOOD: accepted variables passed using -d "{\"key\":\"$variable\"}"
# NOTE                                      double quptes   
# NOTE                                        \"    
auth_tok=$(curl $_rest_url/$_auth_endpoint \
  -k \
  -X POST \
  -H Content-Type:application/json \
  -d "{\"username\":\"$_user\",\"password\":\"$_pass\"}"
)
echo $auth_tok
curl $_rest_url/$_endpoint -k -X GET -H "Authorization: $auth_tok"