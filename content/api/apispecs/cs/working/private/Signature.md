# Signature

The Signature APIs enable the requester to obtain a token by using a signature for authentication.


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## EC2 Signature
#### POST [HPKeystoneExtensionBaseURI]/ec2Tokens
*Privilege Level: Anon*

Validate an EC2 signature and return a scoped token.

**Detailed Description**

This API is used to validate an EC2 signature and return a token. This implementation currently supports EC2 signature versions 0, 1 and 2 (similar to keystone reference implementation). This API identifies the user through the 'access' identifier and verifies the provided signature using the data provided in request. Once the signature is successfully verified, the API returns a scoped token response with tenant and role information.

A Nova EC2 signature verification always requires a scoped token in the response. The API has to find a tenant for the user (as tenant data, id or name, if the tenant is not provided in request). This implementation expects that that that the tenant identifier is prefixed in 'access' and 'AWSAccessKeyId'. 

The optional query parameters HP-IDM-serviceId and HP-IDM-endpointTemplateId can be used to include only a specific subset of roles in the response. If there are no specific roles found, then a 401 (unauthorized) error is returned in the response. These parameters can have comma separated values to specify multiple service ids. To request global roles to be included in response, the global identifier (which is currently configured as 'global') must be used in any of two query parameter values. If this query parameter is not specified or has an empty value, then the response will include all roles available for that signature request. 

**AWSAccessKeyId Must Prefixed By Tenant ID**

Since a user's access key can be associated with multiple tenants, clients must prefix the user access key ID with the tenant ID of the tenant where the signature is scoped to prior to the signature calculation. For example, "84569201246014:8WXZS37LDZGYWM32H4LP". Notice the tenant ID "84569201246014".

For Swift-migrated access keys, which already have a tenant ID prefix, it would end up with this, "84569201246014:84569201246015:8WXZS37LDZGYWM32H4LP". In this case, both tenant IDs will be part of the signature but only the first prefix, "84569201246014", will be used to determine the tenant to be scoped. The second tenant ID, "84569201246015", is treated as part of the access key.

**Signature Details**

The signature is calculated by first creating the string to sign as described in the following sections. Then an RFC 2104 compliant HMAC is calculated over the string using SHA1 or SHA256 as the hash algorithm and the Secret Access key. The resultant signature bytes are then base64 encoded to form the signature string.

**Version 0 Signature String To Sign Details**

The supported signature method for version 0 signatures is HmacSHA1. The string to sign consists of the value associated with the "Action" query parameter concatenated with the value associated with the "Timestamp" query parameter.

**Version 1 Signature String To Sign Details**

The supported signature method for version 1 signatures is HmacSHA1. The string to sign is built by first doing a case insensitive sort of the query parameters based on the query parameter names. Then the name and value for each query parameter is concatenated together in the sorted order one-by-one to form the string.

**Version 2 Signature String To Sign Details**

The supported signature methods for version 2 signatures are HmacSHA1 and HmacSHA256.

The string to sign for version 2 signatures consists of the following concatenated in the order specified:

1) The value of the "verb" followed by "\n"

2) The canonicalized value (lowercase) of the "host" followed by "\n". The ":" and the port number may or not be included. The server signature verifier will calculate the signature with and without the ":" character and the port number included.

3) The canonicalized value of the "path" followed by "\n". If the path is not specifed or is the empty string then the character "/" is used. The canonicalized path value is formed by first URL encoding the path (using UTF-8 character set) and them making the following substitutions:

"%20" replaces "+"
"*" replaces "%2A"
"~" replaces "%7E"
"/" replaces "%2F"

4) The canonicalized query string. The canonicalized query string is formed by first performing a natural byte ordering (case sensitive sort) by name of the name/value pairs in the query string. Each name and each value are then URL encoded (using UTF-8 character set) and the following substitutions are made:

"%20" replaces "+"
"*" replaces "%2A"
"~" replaces "%7E"

Then name/value strings are formed by concatenating name, "=", and value.The resulting name/value strings are then concatenated together based on sorted order above with each separated from the other by the "&" character.

**Request Data**


**URL Parameters**

* *HP-IDM-serviceId* - (Optional) - Query Parameter - used to filter roles by service identifier. Value consists of one or more comma separated service identifier values. Specifying the the value "global" will cause global roles to be included.
* *HP-IDM-endpointTemplateId* - (Optional) - Query Parameter - used to filter roles by endpoint template identifier. Consists of one or more comma separated endpoint template identifier values. Specifying the value "global" will cause global roles to be included.

**Data Parameters**

See schema file for more details on the request and response data structure.

See the signature details descriptions above for information on what data parameters are required for each signature version.


JSON Signature Version 2

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 818
 
{
    "ec2Credentials":{
        "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
        "host":"localhost:80",
        "verb":"GET",
        "params":{
            "puHWtp":"oH.uGBH6F6dI5sQL1",
            "SignatureVersion":"2",
            "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "ehtosy":"z9.idDFmU8hZWMQzS",
            "Timestamp":"1326934083.68",
            "nlKpzmwkDWYM":"9NgzXvwjuaiVoE5cP",
            "SignatureMethod":"HmacSHA256",
            "XNyFgC83lLGV":"QE9YFUoiNaa2qv9sXw",
            "au7":".4mK1HY2",
            "Action":"HJOFRgVIBSvegztSkm",
            "dcD5xQMQx":"i9OeD",
            "5Te8ywzJQsvvsNF":"qUd",
            "ob1e06nT4":"PqqJC3JzTZaofJTfTXB"
        },
        "signature":"f+E0MFsshpiXY3CwXOYv07jJ+FXewLPbjwFk47usPiA=",
        "path":"/"
    }
}
```

Optional:

JSON Signature Version 0

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 815
 
{
    "ec2Credentials":{
        "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
        "host":"localhost:80",
        "verb":"GET",
        "params":{
            "SignatureVersion":"0",
            "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "JtISfQAiYdrKOVI3":"iII",
            "3ULz":"mtJWfYPNnfUTHwIRc",
            "fOVH8OwHID":"y79b",
            "Timestamp":"1326934083.16",
            "zvTqAh2Ql9mzE":"zqC6KwMMCYq",
            "j0aawvqoNNibmF4JjoBv":"4WyqLq66tSW5dzQ8Ps.q",
            "OgUE1nimEOBSYkvDd":"dFZX3RjMRh7",
            "kNX6Oit8fDM1":"TJ7mTM7YbJQ84",
            "Action":"RyMTEhVxIOZgysaashyV",
            "w8cpX":"lnjWTLEy0nVLq",
            "4tWPmGmAfEcWP01":"X7zr4JZ1"
        },
        "signature":"4LOFvWlHu1q3jU3R6WmIE3AJpKg=",
        "path":"/"
    }
}
```

JSON Signature Version 1

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 607
 
{
    "ec2Credentials":{
        "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
        "host":"localhost:80",
        "verb":"GET",
        "params":{
            "qI6GjS4":"1TfGb7kP.a",
            "SignatureVersion":"1",
            "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "WQ9":"el2",
            "Timestamp":"1326934083.26",
            "lKi9TPAP":"kQ5qjovtZ2d4wJst7NkU",
            "DuoDn0s1iCYfXnBK3V":"2doHkN",
            "1emaHCDcGwJrKk":"RJKQi",
            "Action":"ngxrsX"
        },
        "signature":"uik8Yk57mcqT85BHR8bAw9HTdiE=",
        "path":"/"
    }
}
```

**Success Response**

**Status Code**

200 - OK

**Response Data**


JSON - All signature versions

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=DA7240A00E59F8E371DE567D405EB085; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 658
Date: Thu, 19 Jan 2012 01:00:36 GMT
 
{"access": {
  "token": {
    "expires": "2012-01-19T12:43:07.566Z",
    "id": "HPAuth_4f17671bb0be3f62bf1090d2",
    "tenant": {
      "id": "77242319481696",
      "name": "HP nova Tenant Services"
    }
  },
  "user": {
    "id": "97324764821142",
    "name": "arun2",
    "roles": [
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin"
      },
      {
        "id": "00000000004017",
        "serviceId": "100",
        "name": "tenant-member",
        "tenantId": "77242319481696"
      },
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser"
      }
    ]
  }
}}
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Missing access key id, signature value, or other parameters |
| 401 | Unauthorized | Invalid signature version, missing signature method, invalid access key, invalid signature, no tenant association found for user, no service specific roles found for service ids specified in query |
| 403 | Forbidden | User is disabled |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |



**Response Data**

JSON - Signature is not valid

```
HTTP/1.1 401 Unauthorized
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=82034D30BB39215596243EDD6B9F2BB7; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 222
Date: Fri, 16 Dec 2011 19:19:11 GMT
 
{
  "unauthorized" : {
    "anies" : null,
    "code" : 401,
    "details" : "Provided signatures are not correct for access key :G8B5UNGWZU39K7BNR9KP",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

JSON - No service specific role is found

```
HTTP/1.1 401 Unauthorized
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=10831C151368F11FE2F8A07EB6B34B87; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 187
Date: Thu, 19 Jan 2012 01:09:29 GMT
 
{
  "unauthorized" : {
    "anies" : null,
    "code" : 401,
    "details" : "Not authorized to access the service.",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -X POST -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100,110" -d '{
    "ec2Credentials":{
        "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
        "host":"localhost:80",
        "verb":"GET",
        "params":{
            "puHWtp":"oH.uGBH6F6dI5sQL1",
            "SignatureVersion":"2",
            "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "ehtosy":"z9.idDFmU8hZWMQzS",
            "Timestamp":"1326934083.68",
            "nlKpzmwkDWYM":"9NgzXvwjuaiVoE5cP",
            "SignatureMethod":"HmacSHA256",
            "XNyFgC83lLGV":"QE9YFUoiNaa2qv9sXw",
            "au7":".4mK1HY2",
            "Action":"HJOFRgVIBSvegztSkm",
            "dcD5xQMQx":"i9OeD",
            "5Te8ywzJQsvvsNF":"qUd",
            "ob1e06nT4":"PqqJC3JzTZaofJTfTXB"
        },
        "signature":"f+E0MFsshpiXY3CwXOYv07jJ+FXewLPbjwFk47usPiA=",
        "path":"/"
    }
}'
```

**Additional Notes**



## Generic Signature
#### POST [HPKeystoneExtensionBaseURI]/gstokens
*Privilege Level: Anon*

This API is used to validate a signature and optionally return a token. Validation includes checking that the key used to generate the signature belongs to a particular user and that the key is in a valid state. The signature may be created using an access key, a private key associated with a certificate, or a private key in a key pair.

Key types supported include "accesskey", "certificate", and "keypair". If key type "certificate" is specified then the subject key identifier should be specified as the keyId parameter value.

The "signatureMethod" attribute is optional and only applicable when "accesskey" is specified for the "keyType" attribute. If the "signatureMethod" attribute is not specified then the algorithm associated with the access key at create or import time is used. 

This API can be used in two modes, (1) Signature Validation with Token Returned Mode, and (2) Signature Validation Mode.

**Signature Validation With Token Returned Mode**

This mode of operation results in a scoped or unscoped token, user information, and roles filtered by service identifiers and/or end point template identifiers being returned in the response. This is the default mode of operation. 

The optional "belongsTo" parameter can be used to verify that the user belongs to a specific tenant and to scope the returned token. The query parameters "HP-IDM-serviceId" and "HP-IDM-endpointTemplateId" are ignored if the "belongsTo" query parameter is not also specified.

The optional query parameters "HP-IDM-serviceId" and "HP-IDM-endpointTemplateId" can be used to include only a specific subset of roles in the response. If there are no specific roles found, then a response code of 401 (unauthorized) error is returned in the response. These parameters can have comma separated values to specify multiple service ids. To request global roles to be included in response, the global identifier (which is currently configured as 'global') must be used in either of the two query parameter values. If these query parameters are not specified or have an  empty value, then the response will include all the available roles for the user. 

**Signature Validation Mode**

Signature Validation Mode is used to quickly and simply validate a signature.  The token identifier and expires values are not returned. This mode is selected by explicitly selected by setting the query parameter "returnToken=false".  The query parameters  

"HP-IDM-serviceId", "HP-IDM-endpointTemplateId" and "belongsTo" function the same as in Signature Validation With Token Returned Mode above

**Request Data**

See the API description above for details on which parameters are required and optional for each mode.

**URL Parameters**

* *belongsTo* - (Optional) - Query Parameter - if specified this parameter is used to scope a token to a tenant. The value consists of a tenant identifier.
* *HP-IDM-serviceId* - (Optional) - Query Parameter - used to filter roles by service identifier. Value consists of one or more comma separated service identifier values. Specifying the the value "global" will cause global roles to be included. Ignored if belongsTo parameter is not also specified.
* *HP-IDM-endpointTemplateId* - (Optional) - Query Parameter - used to filter roles by endpoint template identifier. Consists of one or more comma separated endpoint template identifier values. Specifying the value "global" will cause global roles to be included. Ignored if the belongsTo parameter is not also specified.
* *returnToken* - (Optional) - Query Parameter - used to specify whether or not a token should be returned as a result of signature validation. Value is one of (true, false). The default value is true. This parameter does not affect the function of The query parameters "HP-IDM-serviceId", "HP-IDM-endpointTemplateId" and "belongsTo".

**Data Parameters**

See schema file for more details on the request and response data structure.

* *dataToSign* - String - the data that is to be signed
* *keyId* - String - key identifier for the key used to sign the data. If key type "certificate" is specified then the subject key identifier should be specified. 
* *keyType* - String - type of key used to generate signature. Value is one of (accesskey, certificate, keypair)
* *signature* - String - signature calculated over dataToSign using key identified by key identifier and algorithm specified in signatureMethod (or algorithm associated with key).
* *signatureMethod* - String - the algorithm used to generate the signature is optional and only applicable when "accesskey" is specified for the "keyType" attribute. If the "signatureMethod" attribute is not specified then the algorithm associated with the access key at create or import time is used.

JSON - Validate signature with token returned

```
POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 261
 
{
  "auth": {
      "genericSignatureCredentials": {
      "keyType": "accesskey",
      "keyId": "J926JC4JVE2U4YEJGMFW",
      "signatureMethod": "HmacSHA1",
      "dataToSign": "Some Data to Sign",
      "signature": "nxSnQgBxJ9kWzYzRNME8hILeHIE="
    }
  }
}
```

XML - Validate signature with token returned

```
POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 357
 
<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
<genericSignatureCredentials keyType="accesskey" keyId="J926JC4JVE2U4YEJGMFW" signatureMethod="HmacSHA1">
<dataToSign>Some Data to Sign</dataToSign>
<signature>nxSnQgBxJ9kWzYzRNME8hILeHIE=</signature>
</genericSignatureCredentials>
</auth>
```

XML - Validate signature with token returned and "belongsTo" specified

```
POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens?belongsTo=80471193132652 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 357
 
<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
<genericSignatureCredentials keyType="accesskey" keyId="J926JC4JVE2U4YEJGMFW" signatureMethod="HmacSHA1">
<dataToSign>Some Data to Sign</dataToSign>
<signature>nxSnQgBxJ9kWzYzRNME8hILeHIE=</signature>
</genericSignatureCredentials>
</auth>
```

JSON - Validate signature only

```
POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens?belongsTo=81321234014466&returnToken=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 261
 
{ "auth": {
   "genericSignatureCredentials": {
   "keyType": "accesskey",
   "keyId": "D3ZWJHE58ZX3EDCFZWWE",
   "signatureMethod": "HmacSHA1",
   "dataToSign": "Some Data to Sign",
   "signature": "OiEOOeciHUuXouFh6rX23p2RbE0="
}   } }
```

XML - Validate signature only

```
POST https://localhost:8443//v2.0/HP-IDM/v1.0/gstokens?belongsTo=81321234014466&returnToken=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 357
 
<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
<genericSignatureCredentials keyType="accesskey" keyId="D3ZWJHE58ZX3EDCFZWWE" signatureMethod="HmacSHA1">
<dataToSign>Some Data to Sign</dataToSign>
<signature>OiEOOeciHUuXouFh6rX23p2RbE0=</signature>
</genericSignatureCredentials>
</auth>
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON - Validate signature with token and roles returned

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 439
Date: Fri, 22 Jun 2012 19:42:58 GMT
 
{"access": {
  "token": {
    "expires": "2012-06-23T07:42:58.155Z",
    "id": "HPAuth_4fe4c9a1e4b0a799509ae9d0",
    "tenant": {}
  },
  "user": {
    "id": "70125538195745",
    "name": "sigtoken",
    "roles": [
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser"
      },
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin"
      }
    ]
  }
}}
```

XML - Validate signature with token returned and "belongsTo" specified

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 702
Date: Fri, 22 Jun 2012 20:31:48 GMT
 
<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4fe4d634e4b0a799509ae9e1" expires="2012-06-23T08:31:48.499Z">
      <tenant id="80471193132652" name="Tenant2 for GS Testing"/>
   </token>
   <user id="70125538195745" name="sigtoken">
      <roles>
         <role id="00000000004004" name="domainuser" serviceId="100"/>
         <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="80471193132652"/>
         <role id="00000000004003" name="domainadmin" serviceId="100"/>
      </roles>
   </user>
</access>
```

JSON - Validate signature only

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 557
Date: Wed, 27 Jun 2012 20:16:01 GMT
 
{"access": {
  "token": {"tenant": {
    "id": "81321234014466",
    "name": "Tenant for GS Testing"
  }},
  "user": {
    "id": "86973081871520",
    "name": "kevin999",
    "roles": [
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin"
      },
      {
        "id": "00000000004017",
        "serviceId": "100",
        "name": "tenant-member",
        "tenantId": "81321234014466"
      },
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser"
      }
    ]
  }
}}
```

XML - Validate signature only

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 629
Date: Wed, 27 Jun 2012 20:10:15 GMT
 
<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
   <token>
      <tenant id="81321234014466" name="Tenant for GS Testing"/>
   </token>
   <user id="86973081871520" name="kevin999">
      <roles>
         <role id="00000000004003" name="domainadmin" serviceId="100"/>
         <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="81321234014466"/>
         <role id="00000000004004" name="domainuser" serviceId="100"/>
      </roles>
   </user>
</access>
```


**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Missing key id, missing or invalid key type, missing signature value, or data to sign |
| 401 | Unauthorized | Inactive key state or non-existent key, invalid signature, no tenant association found for user, no service specific roles found for service ids specified in query |
| 403 | Forbidden | User is disabled |
| 500 | Internal Server Error | The server encountered a problem while processing the request  |
| 503 | Service Unavailable | The server is unavailable to process the request  |



**Response Data**

JSON

```
{
  "unauthorized" : {
    "code" : 401,
    "details" : "Invalid credentials",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -k -X POST -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/gstokens?belongsTo=30983299632008" -d '{
  "auth": {
      "genericSignatureCredentials": {
      "keyType": "accesskey",
      "keyId": "V7TEGGSZZ4NJK9UR4998",
      "signatureMethod": "HmacSHA1",
      "dataToSign": "Some Data to Sign",
      "signature": "OVOtheh+ZgbJBOvwSk4mIIMfaDw="
    }
  }
}'
```

**Additional Notes**



