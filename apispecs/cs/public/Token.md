# Token

A yummy cookie one uses to bribe the authorization monster.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## Authenticate
#### POST /tokens
*Privilege Level: Anon*

This API is used to authenticate a user to be able to use an OpenStack service. The result of a successful authentication is a token to be used with service requests. A username and password or access/secret key credentials are given as input to this interface. If authentication succeeds, the response will include an authentication token and service catalog ( list of available services for that user ). Tokens are valid for 12 hours. Issued tokens can become invalid in two cases:

1. the token has expired
2. the token has been revoked.

Besides using a username and password, another way to authenticate is using symmetric keys. Symmetric keys are user access key and secret key pairs provisioned for user account. In this type of credential data, request body is expected to contain an access key and a secret key information belonging to the user. Once those keys are verified, a new token is created. In this type of authentication, the only change is in expected request body data (please see related example below). There is no difference in response format/content whether authentication is done using password credential data or access key credential data.

Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

Scoped Tokens:

A token scoped to a tenant can be obtained by providing either a tenantName or a tenantId. This will also return service endpoints for other services associated with the tenant in question. An unscoped token will likely not contain service endpoints except for those for the Identity Service. Note that if tenant information is unknown, an unscoped token can be obtained and then a list of tenants obtained. Tenant information can also be found in the Management Console.

**Request Data**

See examples below.

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

Authenticate using password credential for an unscoped token.

```
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
Content-Length: 171

{
    "auth":{
        "passwordCredentials":{
            "username":"arunkant",
            "password":"changeme"
        }
    }
}
```

Authenticate using password credential for a scoped token.

```
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
Content-Length: 171

{
    "auth":{
        "passwordCredentials":{
            "username":"arunkant",
            "password":"changeme"
        },
        "tenantId":"95096564413950"
    }
}
```

Authenticate using access key credential.

```
POST https://localhost:8443/v2.0/tokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 176
 
{
    "auth":{
        "apiAccessKeyCredentials":{
            "accessKey":"19N488ACAF3859DW9AFS9",
            "secretKey":"vpGCFNzFZ8BMP1g8r3J6Cy7/ACOQUYyS9mXJDlxc"
        }       
    }
}
```

XML

Authenticate using password credential for a scoped token.

```
ccept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
Content-Length: 211

<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantName="HP5 Tenant Services">
  <passwordCredentials username="arunkant" password="changeme"/>
</auth>
```

Authenticate using access key credential.

```
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
Content-Length: 219

<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
  <apiAccessKeyCredentials secretKey="vpGCFNzFZ8BMP1g8r3J6Cy7/ACOQUYyS9mXJDlxc" accessKey="9N488ACAF3859DW9AFS9"/>
</auth>
```

**Success Response**

{Specify the status code and any content that is returned.}

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
Content-Length: 3248
Date: Fri, 14 Oct 2011 21:17:14 GMT
 
 
{"access": {
   "token":    {
      "expires": "2011-10-14T21:42:59.455Z",
      "id": "HPAuth_4e98a5dbb0befc448cd0454f",
      "tenant":       {
         "id": "14541255461800",
         "name": "HR Tenant Services"
      }
   },
   "user":    {
      "id": "30744378952176",
      "name": "arunkant",
      "roles":       [
                  {
            "id": "00000000004008",
            "serviceId": "120",
            "name": "nova:developer",
            "tenantId": "14541255461800"
         },
                  {
            "id": "00000000004003",
            "serviceId": "100",
            "name": "domainadmin",
            "tenantId": "14541255461800"
         },
                  {
            "id": "00000000004004",
            "serviceId": "100",
            "name": "domainuser",
            "tenantId": "14541255461800"
         },
                  {
            "id": "00000000004017",
            "serviceId": "100",
            "name": "tenant-member",
            "tenantId": "14541255461800"
         }
      ]
   },
   "serviceCatalog":    [
            {
         "name": "storage5063096349006363528",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
            "region": "SFO"
         }]
      },
            {
         "name": "Object Storage",
         "type": "object-store",
         "endpoints": [         {
            "tenantId": "14541255461800",
            "adminURL": "https://region-a.geo-1.objects.hpcloudsvc.com/auth/v1.0/",
            "internalURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800",
            "publicURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800",
            "region": "region-a.geo-1",
            "id": "1.0",
            "info": "https://region-a.geo-1.objects.hpcloudsvc.com/info/v1.0",
            "list": "https://region-a.geo-1.objects.hpcloudsvc.com/allVersions"
         }]
      },
            {
         "name": "Identity",
         "type": "identity",
         "endpoints": [         {
            "adminURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
            "internalURL": "hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
            "publicURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
            "region": "region-a.geo-1",
            "id": "2.0",
            "info": "https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0",
            "list": "https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"
         }]
      },
            {
         "name": "storage5065129211418544729",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
            "region": "SFO"
         }]
      },
            {
         "name": "storage5042344434157721570",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
            "region": "SFO"
         }]
      }
   ]
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 2667
Date: Fri, 14 Oct 2011 21:18:40 GMT
 
<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4e98a5dbb0befc448cd0454f" expires="2011-10-14T21:42:59.455Z">
      <tenant id="14541255461800" name="HR Tenant Services"/>
   </token>
   <user id="30744378952176" name="arunkant">
      <roles>
         <role id="00000000004008" name="nova:developer" serviceId="120" tenantId="14541255461800"/>
         <role id="00000000004003" name="domainadmin" serviceId="100" tenantId="14541255461800"/>
         <role id="00000000004004" name="domainuser" serviceId="100" tenantId="14541255461800"/>
         <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="14541255461800"/>
      </roles>
   </user>
   <serviceCatalog>
      <service type="compute" name="storage5063096349006363528">
         <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
            <version/>
         </endpoint>
      </service>
      <service type="object-store" name="Object Storage">
         <endpoint region="region-a.geo-1" tenantId="14541255461800" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800" internalURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/auth/v1.0/">
            <version id="1.0" info="https://region-a.geo-1.objects.hpcloudsvc.com/info/v1.0" list="https://region-a.geo-1.objects.hpcloudsvc.com/allVersions"/>
         </endpoint>
      </service>
      <service type="identity" name="Identity">
         <endpoint region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" internalURL="hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0">
            <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
         </endpoint>
      </service>
      <service type="compute" name="storage5065129211418544729">
         <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
            <version/>
         </endpoint>
      </service>
      <service type="compute" name="storage5042344434157721570">
         <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
            <version/>
         </endpoint>
      </service>
   </serviceCatalog>
</access>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error

**Response Data**

JSON

```
{
  "identityFault": {
    "message": "Fault",
    "details": "Error Details...",
    "code": 500
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8"?>
<identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
          code="500">
        <message>Fault</message>
        <details>Error Details...</details>
</identityFault>
```

Curl Example

***Authenticate with Username/Password and Tenant ID***

```
curl -X POST -H "Content-Type: application/json"
     https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens
     -d '{"auth":{"passwordCredentials":{"username":"falken@wg.com",          "password":"J0shua!"}, "tenantId":"72020596871800"}}'

```

***Authenticate with Access Keys and Tenant ID***

```
curl -X POST -H "Content-Type: application/json"
        https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens
    -d '{"auth":{"apiAccessKeyCredentials":{"accessKey":"B5VKMNLEZ7YUN9BTFDZC", "secretKey":"CQSp+KsLQGFz6+V/S1s4XXpE42q472pD9VhIBFsn"}, "tenantId":"72020596871800"}}'
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## Rescope Token
#### POST /tokens
*Privilege Level: SS*

This API provides the ability to re-scope a valid token with another tenant. An existing unexpired token, regardless of its currently scoped or not, can be scoped to another tenant as long as the user has valid association with that tenant.

Re-scoping of token can be done from 1) unscoped token to a scoped token for specific tenant 2) scoped token from one tenant to another tenant 3) scoped token to unscoped token (with no tenantId and tenantName specified in request). Re-scoping of token does not alter the token expiration time and same token id is returned in response.

Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

**Request Data**


**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

```
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
Content-Length: 154

{
    "auth": {
        "tenantName": "HP Swift Tenant Services",
        "token": {
            "id": "HPAuth_4ea80da3b0be73fc0385eceb"
        }
    }
}
```

XML

```
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
Content-Length: 195

<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantId="19694547081948">
  <token id="HPAuth_4e934043b0be09f52fb4c29d" />
</auth>
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
Content-Length: 1283
Date: Wed, 26 Oct 2011 13:43:14 GMT

{"access": {
  "token": {
    "expires": "2011-10-26T14:13:14.311Z",
    "id": "HPAuth_4ea80e72b0be73fc0385ecef",
    "tenant": {
      "id": "90260810095453",
      "name": "HP Swift Tenant Services"
    }
  },
  "user": {
    "id": "53449493563804",
    "name": "arunkant",
    "roles": [
      {
        "id": "00000000004017",
        "serviceId": "100",
        "name": "tenant-member",
        "tenantId": "90260810095453"
      },
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin",
        "tenantId": "90260810095453"
      },
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser",
        "tenantId": "90260810095453"
      }
    ]
  },
  "serviceCatalog": [{
    "name": "Identity",
    "type": "identity",
    "endpoints": [{
      "adminURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
      "internalURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
      "publicURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
      "region": "region-a.geo-1",
      "id": "2.0",
      "info": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/info\/v2.0",
      "list": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/allVersions"
    }]
  }]
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 1166
Date: Wed, 26 Oct 2011 13:46:53 GMT


<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4ea80e72b0be73fc0385ecef" expires="2011-10-26T14:13:14.311Z">
      <tenant id="90260810095453" name="HP Swift Tenant Services"/>
   </token>
   <user id="53449493563804" name="arunkant">
      <roles>
         <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="90260810095453"/>
         <role id="00000000004003" name="domainadmin" serviceId="100" tenantId="90260810095453"/>
         <role id="00000000004004" name="domainuser" serviceId="100" tenantId="90260810095453"/>
      </roles>
   </user>
   <serviceCatalog>
      <service type="identity" name="Identity">
         <endpoint region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0">
            <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
         </endpoint>
      </service>
   </serviceCatalog>
</access>
```

**Error Response**


**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

**Response Data**

JSON

```
{
  "identityFault": {
    "message": "Fault",
    "details": "Error Details...",
    "code": 500
  }
}
```

XML

```
<?xml version="1.0" encoding="UTF-8"?>
<identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
          code="500">
        <message>Fault</message>
        <details>Error Details...</details>
</identityFault>
```

Curl Example

```
curl -k -H "Content-Type: application/json" -d '{"auth":{"tenantName":"HP Swift Tenant Services","token":{"id":"HPAuth_4ea80da3b0be73fc0385eceb"}}}' -XPOST https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## Revoke Token
#### DELETE /HP-IDM/v1.0/tokens/<tokenId>
*Privilege Level: SA,DA,SS*

This API is used to revoke an authentication token. This operation does not require a request body. Once a token has been revoked, attempts to validate the token via GET /tokens/tokenId will fail with a 404 (item not found) as the token no longer exists. Trying revoke a non existing token, including one which has expired will also return a 404 (item not found).

**Request Data**


**URL Parameters**

None

**Data Parameters**

This call does not require a request body.

**Success Response**


**Status Code**

200 - OK

**Response Data**


**Error Response**


**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden

**Response Data**

JSON

```
{"forbidden":{"message":"Full authentication is required to access this resource","code":403}}
```

XML

```
<?xml version="1.0" encoding="UTF-8"?><forbidden xmlns="http://docs.openstack.org/identity/api/v2.0" code="403"><message>Full authentication is required to access this resource</message></forbidden>
```

Curl Example

```
curl -k -XDELETE https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/HPAuth_123456789
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## Swift Legacy Authentication
#### GET /v1.0
*Privilege Level: Anon*

#### GET /v1.1
*Privilege Level: Anon*

#### GET /auth/v1.0
*Privilege Level: Anon*

#### GET /auth/v1.1
*Privilege Level: Anon*

Pre-Keystone (aka auth v2.0), Openstack services rely on disparate authentication mechanisms to authenticate their services.  For example, Swift uses swauth, while Nova uses novaauth.  The v1/v1.1 style of authentication relies on custom HTTP headers (specific to each service) to communicate authentication data, rather than relying on well-defined XML/JSON documents that can be validated via XSDs.  With the release of Diablo, most Openstack services have switched to using Keystone API completely, with the exception of the Swift CLI tool.  To provide backward-compatibility for this particular tool, CS (as well as the FOSS Keystone) provides this API. 

**Request Data**


**URL Parameters**

None

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-User* - containing the <tenantId:username> for a scoped token for Swift
* *X-Auth-Key* - containing the password for the given user

**Success Response**


**Status Code**

200 - OK

**Response Data**

In addition to the token access response, the following response HTTP headers are populated by the server.

* *X-Auth-Token* - token ID
* *X-Storage-URL* - containing a list of public endpoints for Swift

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
X-Auth-Token: HPAuth_4f03696fe4b071e9f15c0550
X-Storage-Url: https://az1-sw-proxy-ext-0001.rndd.aw1.hpcloud.net:443/v1.0/14565730729748
Content-Type: application/json
Content-Length: 1583
Date: Tue, 03 Jan 2012 20:47:43 GMT
 
{"access": {
  "token": {
    "expires": "2012-01-03T21:17:43.087Z",
    "id": "HPAuth_4f03696fe4b071e9f15c0550",
    "tenant": {
      "id": "14565730729748",
      "name": "Swift SSL"
    }
  },
  "user": {
    "id": "70970596121812",
    "name": "joeuserA@timewarner.com",
    "roles": [
      {
        "id": "00000000004022",
        "serviceId": "110",
        "name": "Admin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004013",
        "serviceId": "130",
        "name": "block-admin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004025",
        "serviceId": "120",
        "name": "sysadmin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004016",
        "serviceId": "120",
        "name": "netadmin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004024",
        "serviceId": "140",
        "name": "user",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004014",
        "serviceId": "150",
        "name": "cdn-admin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004014",
        "serviceId": "150",
        "name": "cdn-admin",
        "tenantId": "14565730729748"
      }
    ]
  }
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
X-Auth-Token: HPAuth_4f03696fe4b071e9f15c0550
X-Storage-Url: https://az1-sw-proxy-ext-0001.rndd.aw1.hpcloud.net:443/v1.0/14565730729748
Content-Type: application/xml
Content-Length: 730
Date: Tue, 03 Jan 2012 20:47:43 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom"><token id="HPAuth_767eaf4d50bee574eefb8e3b1081bde75edf31c59f806e35a8793296247aa7f9" expires="2012-10-10T11:09:38.813Z"><tenant id="62424047631429" name="conser4301_swift"/></token><user id="97539030347757" name="conser4301"><roles><role id="00000000004004" name="domainuser" serviceId="100"/><role id="00000000004022" name="Admin" serviceId="110" tenantId="62424047631429"/><role id="00000000004003" name="domainadmin" serviceId="100"/></roles></user></access>
```

**Error Response**

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
curl -s -k -H "X-Auth-User: 62424047631429:jdoe" -H "X-Auth-Key: secrete" -H "Accept: application/xml" -D /tmp/headers.txt https://region-a.geo-1.identity.hpcloudsvc.com:35357/v1.0
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

