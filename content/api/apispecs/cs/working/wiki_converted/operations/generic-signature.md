---  
title : Generic Signature Operations

---  

**Validate Generic Signature**
------------------------------

Verb

URI

Description

**POST**

***[HPKeystoneExtensionBaseURI]******/gstokens?belongsTo=tenantId&******HP-IDM-serviceId=1,global,2******&HP-IDM-endpointTemplateId=100&counterExpires=time&returnToken=true***

Check that a signature is valid and optionally return a token. Return
relevant groups and/or roles.

#### **Detailed Description**

This API is used to validate a signature and optionally return a token.
Validation includes checking that the key used to generate the signature
belongs to a particular user and that the key is in a valid state. The
signature may be created using an access key, a private key associated
with a certificate, or a private key in a key pair.

Key types supported include "**accesskey**", "**certificate**", and
"**keypair**". If key type "**certificate**" is specified then the
subject key identifier should be specified as the keyId parameter value.

The "**signatureMethod**" attribute is optional and only applicable when
"**accesskey**" is specified for the "**keyType**" attribute. If the
"**signatureMethod**" attribute is not specified then the algorithm
associated with the access key at create or import time is used. 

The optional query parameter "**counterExpires**" (NOT YET IMPLEMENTED)
can be used to request that the number of times a signature is validated
is to be tracked by the server until the time value specified for the
"**counterExpires**" parameter is reached. Each time the specific
signature value is validated a server persisted counter value is
incremented and returned in the response indicating the current count of
successful validations for that signature. The "**counterExpires**"
query parameter and the same time value must be specified on every
validation request for a specific signature value. When the time
specified in the value of the "**counterExpires**" parameter is reached
the counter is no longer tracked by the server and all tracking
information is purged. The time format for the "**counterExpires**"
value is Unix time (or Posix time) defined as the number of seconds that
have elapsed since midnight Coordinated Universal Time (UTC), January 1,
1970, not counting leap seconds.

Note that both the number of tracked signatures and the length of
tracking are system configurable parameters. A response code of 403
(Forbidden) is returned if the caller attempts to exceed the system
configured limitations. 

This API can be used in two modes, (1) Signature Validation with Token
Returned Mode, and (2) Signature Validation Mode.

##### **Signature Validation With Token Returned Mode**

This mode of operation results in a scoped or unscoped token, user
information, and roles filtered by service identifiers and/or end point
template identifiers being returned in the response. This is the default
mode of operation. 

The optional "**belongsTo"** parameter can be used to verify that the
user belongs to a specific tenant and to scope the returned token. The
query parameters "**HP-IDM-serviceId**" and
"**HP-IDM-endpointTemplateId**" are ignored if the "**belongsTo**" query
parameter is not also specified.

The optional query parameters "**HP-IDM-serviceId**" and
"**HP-IDM-endpointTemplateId**" can be used to include only a specific
subset of roles in the response. If there are no specific roles found,
then a response code of 401 (unauthorized) error is returned in the
response. These parameters can have comma separated values to specify
multiple service ids. To request global roles to be included in
response, the **global** identifier (which is currently configured as
'global') must be used in either of the two query parameter values. If
these query parameters are not specified or have an  empty value, then
the response will include all the available roles for the user. 

##### **Signature Validation Mode**

Signature Validation Mode is used to quickly and simply validate a
signature.  The token identifier and expires values are not returned.
This mode is selected by explicitly selected by setting the query
parameter "**returnToken=false**".  The query parameters  

"**HP-IDM-serviceId**", "**HP-IDM-endpointTemplateId**" and
"**belongsTo**" function the same as in Signature Validation With Token
Returned Mode above

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body.*
 *Missing or invalid key type.*
 *Missing key identifier.*
 *Missing data to sign value.*
 *Missing signature value.*

***401**** *(Unauthorized)

*Inactive, expired, suspended, revoked, or non-existent key.*
 *No roles found that match specified filters.*
 *Tenant not found or user not associated with specified tenant*
 *Signature is not valid.*

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes, defined in keystone schema

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 

#### **Example(s)**

##### **ValidateSignature With Token Returned XML Request**

~~~
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
~~~

##### **ValidateSignature With Token Returned XML Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 562
Date: Fri, 22 Jun 2012 20:10:46 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4fe4c9a1e4b0a799509ae9d0" expires="2012-06-23T08:10:46.017Z">
      <tenant/>
   </token>
   <user id="70125538195745" name="sigtoken">
      <roles>
         <role id="00000000004004" name="domainuser" serviceId="100"/>
         <role id="00000000004003" name="domainadmin" serviceId="100"/>
      </roles>
   </user>
</access>
~~~


##### **ValidateSignature With Token Returned JSON Request**

~~~
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
~~~

##### **Validate Signature With Token Returned JSON Response**

~~~
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
~~~

##### **Validate Signature With Token Returned and "belongsTo" Specified XML Request**

~~~
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
~~~

##### **Validate Signature With Token Returned and "belongsTo" Specified XML Response**

~~~
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
~~~

##### **Validate Signature Only XML Request**

~~~
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
~~~

##### **Validate Signature Only XML Response**

~~~
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
~~~

##### **Validate Signature Only JSON Request**

~~~
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
~~~

##### **Validate Signature Only JSON Response**

~~~
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
~~~
