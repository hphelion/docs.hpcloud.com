# User Access Keys

The User Access Key REST API provides the ability to manage user access keys.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## Create User Access Key
#### POST [HPKeystoneExtensionBaseURI]/accesskeys

*Privilege Level: SA, DA, SS*


**Request Data**

The optional data parameters are algorithm, domainId, keyLength, status, userId, validFrom, and validTo.

**URL Parameters**

There are no URL parameters for this operation.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *algorithm* (Optional) - String - the algorithm the key will be used with. One of 
* *domainId* - String - domain identifier of the owner of the key.
* *keyLength* (Optional) - Integer - Length of the key in bits.
* *status* (Optional) String - the key status. One the values (active, inactive). Defaults to active if not specified.
* *userId* (Optional) - String - User identifier of the owner of the key. If not specified the user identifier defaults to the user identifier of the requester.
* *validFrom* (Optional) - DateTime - The date the key becomes valid specified in the following form "YYYY-MM-DDThh:mm:ss". 
* *validTo* (Optional) - DateTime - The date the key becomes invalid specified in the following form "YYYY-MM-DDThh:mm:ss" 


A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e7b748be4b0600fec3d2a24
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 235
 
{ "accessKey":
            {
         "algorithm": "HmacSHA1",
         "keyLength": 64,
         "domainId": "00000000001001",
         "otherAttributes": {},
         "status": "active",
         "userId": "00000000003002"
       }
}
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e69969de4b0a8f279022d55
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 259
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<accessKey userId="000000003002" domainId="000000001001" status="active" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
<algorithm>HmacSHA1</algorithm>
<keyLength>64</keyLength>
</accessKey>
```

**Success Response**

**Status Code**

201 - Created

**Response Data**

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 376
Date: Thu, 22 Sep 2011 18:01:17 GMT
 
{
  "accessKey" : {
    "algorithm" : "HmacSHA1",
    "keyLength" : 64,
    "secretKey" : "pXmYG556MjD",
    "accessKeyId" : "KNGTV6EFKLPYE8LXF4VL",
    "createdOn" : 1316714474259,
    "domainId" : "00000000001001",
    "otherAttributes" : {
    },
    "status" : "active",
    "userId" : "00000000003002",
    "validFrom" : 1316714474000,
    "validTo" : 1632074474000
  }
}
```

XML

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=C20FB3A7F8BE4A7EF0EA7BE232327FE6; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 448
Date: Fri, 09 Sep 2011 04:32:07 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><accessKey xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" accessKeyId="FG54K8NB67KHASRF6KY1" userId="000000003002" domainId="000000001001" status="active" validFrom="2011-09-08T21:32:04.000-07:00" validTo="2021-09-05T21:32:04.000-07:00" createdOn="2011-09-08T21:32:04.937-07:00">
   <algorithm>HmacSHA1</algorithm>
   <keyLength>64</keyLength>
   <secretKey>iwv//jFjJ2E</secretKey>
</accessKey>
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
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
curl -k -X POST -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys" -d '{
  "accessKey" : {
    "algorithm" : "HmacSHA1",
    "keyLength" : 240,
    "domainId" : "11180052618906",
    "otherAttributes" : {
    },
    "status" : "active",
    "userId" : "84463950217213"
  }}'
```

**Additional Notes**



## Delete User Access Key
#### DELETE [HPKeystoneExtensionBaseURI]/accesskeys/{accesskeyId} 
*Privilege Level: SA, DA, SS*

Delete a user access key.

**Request Data**

The accesskeyId url path parameter is required. The userId query parameter is only required to delete an access key for a user other than the requester.

**URL Parameters**

* *accesskeyId* (Required) - URL path parameter - user access key identifier string
* *userId* (Optional) - Query Parameter - User identifier of the access key owner. If not specified then defaults to userId of the requester.

**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**Success Response**

**Status Code**

204 - No Content

**Response Data**

This call does not return a response body on success.

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=90D365930EDDB20FF49CC2DDA4B7C925; Path=/v2.0; Secure
Date: Thu, 22 Sep 2011 22:15:42 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=7F457E3037CCB2DEC6C33D408F544EA8; Path=/v2.0; 
SecureDate: Fri, 09 Sep 2011 04:25:47 GMT 
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
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
curl -k -X DELETE -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/ZNFNCA1JJL3T7XY12V2F" 
```

**Additional Notes**



## Get Access Keys
#### GET [HPKeystoneExtensionBaseURI]/accesskeys

*Privilege Level: SA,DA, SS*

Gets a list of selected user access keys. 

**Request Data**

The following query parameters are optional (domainId, export, status, userId). There are no required query parameters.


**URL Parameters**

* *domainId* (Optional) - Query Parameter - Domain identifier. Selects keys with matching domain identifier.
* *export* (Optional) - Query Parameter - Export secret key value. Value is one of (true, false). If not specified the value is set to false.
* *status* (Optional) - Query Parameter - Key status. Selects keys with matching status. Value is one of (active, inactive, expired, revoked, deleted, purged).
* *userId* (Optional) - Query Parameter - User identifier. Selects keys with matching user identifier. If not specified the userId of the requester is used.


**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7b71f5e4b0600fec3d2a20
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e699292e4b0a8f279022d4d
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 798
Date: Thu, 22 Sep 2011 17:37:18 GMT
 
{
  "accessKeys" : {
    "anies" : null,
    "accessKey" : [ {
      "algorithm" : "HmacSHA1",
      "keyLength" : 64,
      "accessKeyId" : "V7TEGGSZZ4NJK9UR4UFE",
      "createdOn" : 1316712986234,
      "domainId" : "00000000001001",
      "otherAttributes" : {
      },
      "status" : "active",
      "userId" : "00000000003002",
      "validFrom" : 1316712986000,
      "validTo" : 1632072986000
    }, {
      "algorithm" : "HmacSHA1",
      "keyLength" : 64,
      "accessKeyId" : "WHDFDP7UVJS9F3USU1NF",
      "createdOn" : 1316661731171,
      "domainId" : "00000000001001",
      "otherAttributes" : {
      },
      "status" : "active",
      "userId" : "00000000003002",
      "validFrom" : 1316661731000,
      "validTo" : 1632021731000
    } ],
    "otherAttributes" : {
    }
  }
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=744A36BAF6E7165CCBC4C6CA1812204D; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 1340
Date: Fri, 09 Sep 2011 04:20:29 GMT
 
<accessKeys xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
   <accessKey accessKeyId="2SL748X97NEP7B6MVXPS" userId="000000003002" domainId="000000001001" status="active" validFrom="2011-09-08T15:20:20.000-07:00" validTo="2021-09-05T15:20:20.000-07:00" createdOn="2011-09-08T15:20:20.275-07:00">
      <algorithm>HmacSHA1</algorithm>
      <keyLength>64</keyLength>
   </accessKey>
   <accessKey accessKeyId="98XM1KSN7BC2C88U9S7G" userId="000000003002" domainId="000000001001" status="active" validFrom="2011-09-08T16:43:56.000-07:00" validTo="2021-09-05T16:43:56.000-07:00" createdOn="2011-09-08T16:43:56.494-07:00">
      <algorithm>HmacSHA1</algorithm>
      <keyLength>64</keyLength>
   </accessKey>
   <accessKey accessKeyId="3D76NSUB49C96DFBRUF9" userId="000000003002" domainId="000000001001" status="deleted" validFrom="2011-09-08T15:19:10.000-07:00" validTo="2021-09-05T15:19:10.000-07:00" createdOn="2011-09-08T15:19:10.378-07:00">
      <algorithm>HmacSHA1</algorithm>
      <keyLength>64</keyLength>
   </accessKey>
   <accessKey accessKeyId="9L47KGME4ZKCH9YRWDY7" userId="000000003002" domainId="000000001001" status="active" validFrom="2011-09-08T17:34:09.000-07:00" validTo="2021-09-05T17:34:09.000-07:00" createdOn="2011-09-08T17:34:09.494-07:00">
      <algorithm>HmacSHA1</algorithm>
      <keyLength>64</keyLength>
   </accessKey>
</accessKeys>
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
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
curl -k -H "X-Auth-Token: HPAuth_21805c02da2661574e46235bd8c27c10623bddc09a7cf4c67004771628e5453c" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys?export=true"
```

**Additional Notes**



## Get An Access Key
#### GET [HPKeystoneExtensionBaseURI]/accesskeys/{accesskeyId}

*Privilege Level: SA,DA,SS*

Gets a single user access key by it's access key identifier.

**Request Data**

The accesskeyId URL path parameter is required. The 'export' and 'userId' query parameters are optional.

**URL Parameters**

* *accesskeyId* (Required) - URL path parameter - user access key identifier string
* *userId* (Optional) - Query Parameter - user identifier string for user other than current authenticated user
* *export* (Optional) - Query Parameter - used to specify whether secret key value should be returned ("true" or "false")

**Data Parameters**

This call does not require a request body.

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/V7TEGGSZZ4NJK9UR4UFE?export=true HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bc0d2e4b0600fec3d2a4a
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443 

```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/3D76NSUB49C96DFBRUF9?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e699292e4b0a8f279022d4d
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 376
Date: Thu, 22 Sep 2011 23:12:53 GMT

{  
   "accessKey" : {    
     "algorithm" : "HmacSHA1",    
     "keyLength" : 64,    
     "secretKey" : "hNi0oiTU2sH",    
     "accessKeyId" : "V7TEGGSZZ4NJK9UR4UFE",    
     "createdOn" : 1316712986234,    
     "domainId" : "00000000001001",    
     "otherAttributes" : {    
     },    
     "status" : "active",    
     "userId" : "00000000003002",    
     "validFrom" : 1316712986000,    
     "validTo" : 1632072986000  
   }
} 

```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=34C3B7E6EC0F9035A75BD4A0CF6CAC37; Path=/v2.0; 
SecureContent-Type: application/xml
Content-Length: 415
Date: Fri, 09 Sep 2011 04:15:42 GMT

<accessKey accessKeyId="3D76NSUB49C96DFBRUF9" userId="000000003002" domainId="000000001001" status="deleted" validFrom="2011-09-08T15:19:10.000-07:00" validTo="2021-09-05T15:19:10.000-07:00" createdOn="2011-09-08T15:19:10.378-07:00" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
  <algorithm>HmacSHA1</algorithm>
  <keyLength>64</keyLength>
</accessKey> 
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
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
curl -k -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/HAJ5LLHHTKHBXB6MK3TL?export=true"
```

**Additional Notes**



## Import User Access Key
#### PUT [HPKeystoneExtensionBaseURI]/accesskeys
*Privilege Level: SA, DA, SS*

Import one or more user access keys. 

**Request Data**

The request data consists of an accessKeys data structure containing one or more accessKey elements. The secretKey and algorithm elements of the accessKey are required. The accessKeyId, domainId, keyLength, status, userId, validFrom, and validTo attributes are optional.

**URL Parameters**

There are no URL parameters for this request.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *algorithm* - String - the algorithm the key will be used with. This is not validated when imported.
* *domainId* (Optional) - String - domain identifier of the owner of the key.
* *keyLength* (Optional) - Integer - Length of the key in bits.
* *status* (Optional) String - the key status. One the values (active, inactive). Defaults to active if not specified.
* *userId* (Optional) - String - User identifier of the owner of the key. If not specified the user identifier defaults to the user identifier of the requester.
* *validFrom* (Optional) - DateTime - The date the key becomes valid specified in the following form "YYYY-MM-DDThh:mm:ss". 
* *validTo* (Optional) - DateTime - The date the key becomes invalid specified in the following form "YYYY-MM-DDThh:mm:ss". 

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e7bb54fe4b0600fec3d2a37
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 919
 
{"accessKeys": {
   "anies": null,
   "accessKey":    [
            {
         "algorithm": "HmacSHA1",
         "keyLength": 64,
         "secretKey": "hNi0oiTU2sH",
         "accessKeyId": "V7TEGGSZZ4NJK9UR4998",
         "createdOn": 1316712986234,
         "domainId": "00000000001001",
         "otherAttributes": {},
         "status": "inactive",
         "userId": "00000000003002",
         "validFrom": 1316712986000,
         "validTo": 1632072986000
      },
            {
         "algorithm": "HmacSHA1",
         "keyLength": 64,
         "secretKey": "DBWjcUCMEED",
         "accessKeyId": "RVWVEGE88EHZBSBMJ999",
         "createdOn": 1316724920250,
         "domainId": "00000000001001",
         "otherAttributes": {},
         "status": "inactive",
         "userId": "00000000003002",
         "validFrom": 1316724920000,
         "validTo": 1632084920000
      }
    ],
   "otherAttributes": {}
}}
```

XML

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e6d258be4b05605729d7c3a
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 546
 
<accessKeys xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <accessKey accessKeyId="98XM1KSN7BC2C88U9999" userId="000000003002" domainId="000000001001" status="inactive" validFrom="2011-09-08T16:43:56.000-07:00" validTo="2021-09-05T16:43:56.000-07:00" createdOn="2011-09-08T16:43:56.494-07:00">
      <algorithm>HmacSHA1</algorithm>
      <keyLength>64</keyLength>
      <secretKey>HyGB2QRiOu7</secretKey>
   </accessKey>
</accessKeys>
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 802
Date: Thu, 22 Sep 2011 22:23:53 GMT
 
{
  "accessKeys" : {
    "anies" : null,
    "accessKey" : [ {
      "algorithm" : "HmacSHA1",
      "keyLength" : 64,
      "accessKeyId" : "V7TEGGSZZ4NJK9UR4998",
      "createdOn" : 1316730228058,
      "domainId" : "00000000001001",
      "otherAttributes" : {
      },
      "status" : "inactive",
      "userId" : "00000000003002",
      "validFrom" : 1316712986000,
      "validTo" : 1632072986000
    }, {
      "algorithm" : "HmacSHA1",
      "keyLength" : 64,
      "accessKeyId" : "RVWVEGE88EHZBSBMJ999",
      "createdOn" : 1316730228065,
      "domainId" : "00000000001001",
      "otherAttributes" : {
      },
      "status" : "inactive",
      "userId" : "00000000003002",
      "validFrom" : 1316724920000,
      "validTo" : 1632084920000
    } ],
    "otherAttributes" : {
    }
  }
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=41C4EA0FDBAB389A7F904935A283566A; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 537
Date: Sun, 11 Sep 2011 21:18:37 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<accessKeys xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <accessKey accessKeyId="98XM1KSN7BC2C88U9999" userId="000000003002" domainId="000000001001" status="inactive" validFrom="2011-09-08T16:43:56.000-07:00" validTo="2021-09-05T16:43:56.000-07:00" createdOn="2011-09-11T14:18:34.736-07:00">
      <algorithm>HmacSHA1</algorithm>
      <keyLength>64</keyLength>
   </accessKey>
</accessKeys>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
| 409 | Conflict | An access key already exists with the specified access key identifier |
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
curl -k -X PUT -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys" -d '{"accessKeys": {
   "anies": null,
   "accessKey":    [
            {
         "algorithm": "HmacSHA1",
         "keyLength": 64,
         "secretKey": "hNi0oiTU2sH",
         "accessKeyId": "V7TEGGSZZ4NJK9UR4998",
         "createdOn": 1316712986234,
         "domainId": "11180052618906",
         "otherAttributes": {},
         "status": "inactive",
         "userId": "84463950217213",
         "validFrom": 1316712986000,
         "validTo": 1632072986000
      },
            {
         "algorithm": "HmacSHA1",
         "keyLength": 64,
         "secretKey": "DBWjcUCMEED",
         "accessKeyId": "RVWVEGE88EHZBSBMJ999",
         "createdOn": 1316724920250,
         "domainId": "11180052618906",
         "otherAttributes": {},
         "status": "inactive",
         "userId": "84463950217213",
         "validFrom": 1316724920000,
         "validTo": 1632084920000
      }
    ],
   "otherAttributes": {}
}}'

```

**Additional Notes**


## Update User Access Key
#### PUT [HPKeystoneExtensionBaseURI]/accesskeys/{accesskeyId}?userId=value
*Privilege Level: SA, DA, SS*

Update a user access key. This method may be used to modify the key status only.

**Request Data**

The accesskeyId url path parameter is required. The userId query parameter is optional. If the userId parameter is not specified then it defaults to the user identifer of the requester.

**URL Parameters**

* *accesskeyId* - URL path parameter - user access key identifier.
* *userId* (Optional) - Query Parameter - user identifier string. Defaults to user identifier of the requester if not specified.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *status* - {data type} - Key status. One of the values (active, inactive).

A valid token must be present in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/KNGTV6EFKLPYE8LXF4VL HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e7bba89e4b0600fec3d2a3a
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 51
 
{
  "accessKey" : {
    "status" : "inactive"
  }
}
```

XML

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/2SL748X97NEP7B6MVXPS HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e6ab9fde4b06fe4272ee23e
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 146
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<accessKey status="inactive" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"/>
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 345
Date: Thu, 22 Sep 2011 22:47:17 GMT
 
{
  "accessKey" : {
    "algorithm" : "HmacSHA1",
    "keyLength" : 64,
    "accessKeyId" : "KNGTV6EFKLPYE8LXF4VL",
    "createdOn" : 1316714474259,
    "domainId" : "00000000001001",
    "otherAttributes" : {
    },
    "status" : "inactive",
    "userId" : "00000000003002",
    "validFrom" : 1316714474000,
    "validTo" : 1632074474000
  }
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=4D3047BA05428AD806C48E269C8DD8B4; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 416
Date: Sat, 10 Sep 2011 01:16:12 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><accessKey xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" accessKeyId="2SL748X97NEP7B6MVXPS" userId="000000003002" domainId="000000001001" status="inactive" validFrom="2011-09-08T15:20:20.000-07:00" validTo="2021-09-05T15:20:20.000-07:00" createdOn="2011-09-08T15:20:20.275-07:00"><algorithm>HmacSHA1</algorithm><keyLength>64</keyLength></accessKey>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation     |
| 403 | Forbidden | Disabled or suspended user making the request  |
| 404 | Not Found | Specified accesskeyId or userId not found   |
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
curl -k -X PUT -H "X-Auth-Token: HPAuth_1661578e273d107d38b732849173e00d0a60d46d9bc279bee31565fd39be48a8" -H "Content-Type: application/json" -H "Accept: application/json" "https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/V7TEGGSZZ4NJK9UR4998" -d '{
  "accessKey" : {
    "status" : "active"
  }
}'
```

**Additional Notes**



