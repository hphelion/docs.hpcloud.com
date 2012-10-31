# Tenant

Tenant is a collection of services, users, and roles.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

## Get All Tenants
#### GET [HPKeystoneExtensionBaseURI]/tenants?name=tenantName&limit=pagesize&marker=tenantId
*Privilege Level: SA*

Allows reading a list of all tenants across domains. This API supports pagination through 'limit' and 'marker' usage. The returned list may be filtered to allow only those tenants which the caller has access to. The operation does not require a request body.

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the resource Id of the last item in the previous list.
* *name* (Optional) - string - name of the tenant to be returned.

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.


JSON

```
GET /v2.0/HP-IDM/v1.0/tenants/ HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/tenants/ HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

Optional:

Request With Name Filter:

JSON

```
GET /v2.0/HP-IDM/v1.0/tenants?name=tenantName HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/tenants?name=tenantName HTTP/1.1
Accept: application/json
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 240
Date: Tue, 29 Nov 2011 17:17:50 GMT
 
{
  "tenants": {
    "anies": null,
    "otherAttributes": {
 
    },
    "tenant": [
      {
        "description": "Tenant for hosting Time Warner Applications and services",
        "anies" : null,
        "domainId": "26349998090400",
        "name": "Time Warner Tenant Services",
        "otherAttributes": {
 
        },
        "status": "enabled",
        "tenantId": "541212460710"
      }
    ]
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
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenants xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.w3.org/2005/Atom">
   <tenant name="Time Warner Tenant Services" tenantId="541212460710" domainId="26349998090400" status="enabled">
      <description>Tenant for hosting Time Warner Applications and services</description>
   </tenant>
</tenant>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants"
```

## Check for existence of tenant name
#### HEAD [HPKeystoneExtensionBaseURI]/tenants?name=tenantName
*Privilege Level: SA*

Returns http status code indicating the result of tenantName existence check.

This API does case sensitive tenantName lookup in system. It returns http status code 200 (Ok) when provided tenantName exists and returns 404 (not found) when provided tenantName is not found in the system. If provided tenantName is blank or missing, then it returns 204 (No content). The tenant name with extra spaces is converted to single space in-between words and then look up is done for its existence. So tenant name " Abc Image Service " and "ABC    Image service" are treated as same and will be found if entry is there in system. In system, the corresponding name is going to be stored as "abc image service" in a separate field.
As this API just checks for existence of provided tenantName, it does not do look into status (or any other entity attribute) for case when matching tenant is found.

**Request Data**

**URL Parameters**

* *name* - string - name of the tenant to check for existence of

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

XML/JSON Request and Response

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants?name=HP%20Cloud%20System%20Domain's-Tenant01 HTTP/1.1
Accept-Encoding: gzip,deflate
 
 
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:29:46 GMT
```

XML/JSON Request and Response (case-insensitive lookup of above tenantName)

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants?name=hP%20ClOUD%20SYstem%20Domain's-Tenant01 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
 
 
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:30:54 GMT
```

XML/JSON Request and Response (provided tenantName not found)

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants HTTP/1.1HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
 
 
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Content-Type: text/html;charset=utf-8
Content-Length: 952
Date: Tue, 21 Aug 2012 19:31:40 GMT
```

XML/JSON Request Response (missing tenantName in request)

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept-Encoding: gzip,deflate
 
 
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 21 Aug 2012 19:32:10 GMT
```

**Success Response**

**Status Code**

* 200 - OK
* 404 - NOT FOUND

**Response Data**

This call does not return a response body.

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 204 | No Content | When tenantName is missing or blank. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

**Response Data**

This call does not return a response body.

Curl Example

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X HEAD -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants?name=tenantName"
```

**Additional Notes**

There is no response body returned in API response data. This API does not require http header X-Auth-Token and is protected by client certificate authentication.

## Create a Tenant
#### POST [HPKeystoneExtensionBaseURI]/tenants 
*Privilege Level: SA, DA*

Creates a tenant using the specified request body. The provided tenant name MUST be unique in the system.  A response body is also returned with the new tenant information with a service generated tenantId.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *description* - string - Description of the tenant being created.
* *domainId* - string - The Id of the domain this tenant is a member of.
* *name* - string - The name of the tenant being created.
* *status* - string (Optional) - String to describe the initial status of this tenant (enabled/disabled).

JSON

```
POST /v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e9767412cdcb18069188479
Host: localhost:9999
Connection: keep-alive
Content-Length: 165
 
{
  "tenant": {
    "description": "Payroll Tenant Services for TimeWarner",
    "domainId": "47826457774667",
    "name": "Payroll Tenant Services",
    "status": "enabled"
  }
}
```

XML

```
POST /v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
Content-Length: 254
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" name="Time Warner Salesforce Services" domainId="27960688482075" status="enabled">
  <description>Tenant for hosting Time Warner Salesforce Applications</description>
</tenant>
```

**Success Response**

**Status Code**

* 200 - Created

**Response Data**

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 252
Date: Thu, 13 Oct 2011 22:51:31 GMT
 
{
  "tenant": {
    "description": "Payroll Tenant Services for TimeWarner",
    "domainId": "47826457774667",
    "name": "Payroll Tenant Services",
    "otherAttributes": {
 
    },
    "status": "enabled",
    "tenantId": "34159634776038"
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
Set-Cookie: JSESSIONID=709FDF3145EB4A85A2253B00AE39CD18; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 319
Date: Wed, 28 Sep 2011 21:43:24 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
name="HP Swift Tenant Services" 
description="Tenant for hosting HR Applications &amp; services" 
tenantId="76063089090850" 
domainId="77759980331221" 
status="enabled" 
swiftAccountHash="1234bcdefgh"/>
```

XML response with swift account hash

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 278
Date: Fri, 19 Aug 2011 20:37:03 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" name="HR Tenant Services" description="Tenant for hosting HR Applications &amp; services" tenantId="309492202938" domainId="798477662343" status="enabled"/>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Will be returned if a Tenant with the name already exists in the system or if a Tenant with swift account hash already exists in the system. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X POST -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants" -d '{"tenant":{"description":"Payroll Tenant Services for TimeWarner","domainId":"47826457774667","name":"Payroll Tenant Services","status":"enabled"}}'
```

## Delete a Tenant
#### DELETE [HPKeystoneExtensionBaseURI]/tenants/{tenantId}
*Privilege Level: SA, DA*

Deletes the specified tenant by its tenantId. This API also deletes the Roles and Endpoints associated with the Tenant.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be deleted.

**Data Parameters**

This call does not require a request body.

XML

```
DELETE /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

JSON

```
DELETE /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 204 (No Content), Deletion of the Tenant was successful.

**Response Data**

This call does not return a response body.

(No JSON/XML format differences)

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=74ADEBA6F2523478A1700D664FD70C75; Path=/v2.0; Secure
Date: Wed, 12 Oct 2011 22:02:16 GMT
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request.  This error is also returned when there is dependent data that needs to be removed as well. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X DELETE -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/48164969660120" 
```

## Get a List of Tenants
#### GET [KeystoneBaseURI]/tenants?limit=pagesize&marker=tenantId
*Privilege Level: SS*

This API returns a listing of all tenants for which the holder of the provided token has a role assignment. If the user is not a valid, an error is returned.

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the resource Id of the last item in the previous list.

**Data Parameters**

This call does not require a request body.

JSON

```
GET /v2.0/tenants/ HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/tenants/ HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

Optional (request using name filter):

JSON

```
GET /v2.0/tenants?name=tenantName HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/tenants?name=tenantName HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 240
Date: Tue, 29 Nov 2011 17:17:50 GMT
 
{
  "tenants": [
    {
      "id": "39595655514446",
      "name": "Banking Tenant Services",
      "description": "Banking Tenant Services for TimeWarner",
      "enabled": true,
      "created": "2011-11-29T16:59:52.635Z",
      "updated": "2011-11-29T16:59:52.635Z"
    }
  ]
}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenants xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.w3.org/2005/Atom">
  <tenant id="541212460710" name="Time Warner Tenant Services" enabled="false" display-name="Time Warner Tenant Services">
    <description>Tenant for hosting Time Warner Applications &amp; services</description>
  </tenant>
</tenants>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants"
```

## Get a Tenant
#### GET [HPKeystoneExtensionBaseURI]/tenants/{tenantId} 
*Privilege Level: SA, DA, DU*

Get a tenant based on the {tenantId} specified. tenantId's are opaque values returned with get tenant list operations. This operation does not require a request body.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be retrieved.

**Data Parameters**

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/tenants/48164969660120 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e9767412cdcb18069188479
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e9767412cdcb18069188479
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 286
Date: Thu, 13 Oct 2011 22:36:13 GMT
 
{
  "tenant" : {
    "description" : "Tenant for hosting Time Warner Oracle Applications & services",
    "domainId" : "47826457774667",
    "name" : "Time Warner Oracle Tenant Services",
    "otherAttributes" : {
    },
    "status" : "enabled",
    "tenantId" : "48164969660120"
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
Content-Type: application/xml
Content-Length: 254
Date: Wed, 10 Aug 2011 22:36:32 GMT
 
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"
enabled="true" status="enabled" domainId="798477662343"
tenantId="270316896886"
description="Tenant for Sales Forecasting service" />
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/48164969660120" 
```

## Get Endpoints for a Tenant
#### GET [csbu:HPKeystoneExtensionBaseURI]/tenants/{tenantId}/endpoints?limit=pagesize&marker=endpointId
*Privilege Level: SA, DA, DU*

Get a list of endpoints for a tenant. Each endpoint data in the returned list has reference URL which can be used to query specific endpointTemplate (i.e. in format /endpointTemplates/{endpointTemplateId}) . This list will include disabled endpoint templates id. The operation does not require a request body.

TenantId is required and must be enabled in the system. This will not include global endpoints which are available to all tenants in all domains.

This API supports pagination through 'limit' and 'marker' usage. Marker is endpointId and should be valid otherwise 404 (not found) error is going to be returned.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to return endpoints for.
* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the resource Id of the last item in the previous list.

**Data Parameters**

This call does not require a request body.

JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1311
Date: Wed, 12 Oct 2011 21:55:43 GMT
 
{
  "endpoints" : {
    "anies" : null,
    "endpoint" : [ {
      "version" : {
        "id" : "1.0",
        "info" : "http://127.0.0.1:8080//info/v1.0",
        "list" : "http://127.0.0.1:8080/allVersions",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
      "id" : 541,
      "internalURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
      "name" : "Object Storage",
      "otherAttributes" : {
      },
      "publicURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
      "region" : "RegionOne",
      "tenantId" : "95096564413950",
      "type" : "object-store"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : "http://127.0.0.1:9292/info/v1.1",
        "list" : "http://127.0.0.1:9292/allVersions",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "http://127.0.0.1:9292/v1.1/%tenant_id%",
      "id" : 542,
      "internalURL" : "http://127.0.0.1:9292/v1.1/%tenant_id%",
      "name" : "Image Management",
      "otherAttributes" : {
      },
      "publicURL" : "http://127.0.0.1:9292/v1.1/%tenant_id%",
      "region" : "RegionOne",
      "tenantId" : "95096564413950",
      "type" : "image-service"
    } ],
    "otherAttributes" : {
    }
  }
}
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=CDB7DDF03251286D930B9FEAE11F5128; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 977
Date: Wed, 12 Oct 2011 21:52:02 GMT
 
<endpoints xmlns="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns2="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns3="http://www.w3.org/2005/Atom">
   <endpoint id="541" type="object-store" name="Object Storage"
            region="RegionOne" publicURL="http://127.0.0.1:8080/v1/AUTH_%tenant_id%" 
            internalURL="http://127.0.0.1:8080/v1/AUTH_%tenant_id%" 
            adminURL="http://127.0.0.1:8080/v1/AUTH_%tenant_id%" 
            tenantId="95096564413950">
      <version id="1.0" info="http://127.0.0.1:8080//info/v1.0" list="http://127.0.0.1:8080/allVersions"/>
   </endpoint>
   <endpoint id="542" type="image-service" name="Image Management"
            region="RegionOne" publicURL="http://127.0.0.1:9292/v1.1/%tenant_id%"
            internalURL="http://127.0.0.1:9292/v1.1/%tenant_id%"
            adminURL="http://127.0.0.1:9292/v1.1/%tenant_id%" 
            tenantId="95096564413950">
      <version id="1.1" info="http://127.0.0.1:9292/info/v1.1" list="http://127.0.0.1:9292/allVersions"/>
   </endpoint>
</endpoints>
Accept-Encoding: gzip,deflate
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | Either the tenantId specified is not found or invalid marker is provided (matching marker id not found in database). |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints"
```

**Additional Notes**

*Open Issues*

1. Do we just include enabled endpoints or all of them? In keystone reference code base, it does not filter by enabled flag (i.e. includes all of them).
Current Impl: We don't filter by enabled flag so include all of them.
1. Do we need to include global endpoints (endpoint templates with global flag as true) in this call? In keystone reference code base, it does not include them.  Current Impl: We don't include global endpoint templates in the response.

## Get a List of Users for a Tenant (includes role assignments)
#### GET [HPKeystoneExtensionBaseURI]/tenants/{tenantId}/users?limit=pagesize&marker=roleId
*Privilege Level: SA, DA*

This API returns all Users for a given Tenant, Roles associated for each User is also returned. If the user is not a valid, an error is returned.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to return users for.
* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the resource Id of the last item in the previous list.

**Data Parameters**

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/tenants/96488406679080/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8b5dea2cdc3d29c14604d5
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/tenants/96488406679080/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8b6e4c2cdc999e9328f727
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1484
Date: Tue, 04 Oct 2011 19:44:31 GMT
 
{
  "users": {
    "anies": null,
    "otherAttributes": {
 
    },
    "user": [
      {
        "roles": [
          {
            "anies": null,
            "description": "Group 26155043473055 has role domainadmin in 29649421790262 domain",
            "id": "00000000004003",
            "otherAttributes": {
 
            },
            "serviceId": null,
            "tenantId": null
          },
          {
            "anies": null,
            "description": "User 31190669223287 has role null in 29649421790262 domain",
            "id": "82420955976896",
            "otherAttributes": {
 
            },
            "serviceId": null,
            "tenantId": "96488406679080"
          },
          {
            "anies": null,
            "description": "Group 55207359871951 has role null in 29649421790262 domain",
            "id": "00000000004004",
            "otherAttributes": {
 
            },
            "serviceId": null,
            "tenantId": null
          }
        ],
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": "USA",
        "domainId": "29649421790262",
        "emailAddress": "Xml?User8&@timewarner.com",
        "firstName": "First",
        "lastName": "Last",
        "otherAttributes": {
 
        },
        "password": null,
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "userId": "31190669223287",
        "username": "Xml?User8&@timewarner.com",
        "website": "http://www.timewarner.com",
        "zip": "90210"
      }
    ]
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
Set-Cookie: JSESSIONID=98D892BBE6A3F1093562567297E334B9; Path=/v2.0
Content-Type: application/xml
Content-Length: 913
Date: Tue, 04 Oct 2011 20:36:51 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
  <user firstName="First" lastName="Last" username="Xml?User8&amp;@timewarner.com" userId="31190669223287" addressLine1="128, Hollywood Blvd" city="Los Angeles" state="CA" country="USA" zip="90210" phone="1-800-555-1212" website="http://www.timewarner.com" emailAddress="Xml?User8&amp;@timewarner.com" status="enabled" domainId="29649421790262">
    <roles id="00000000004003" description="Group 26155043473055 has role domainadmin in 29649421790262 domain"/>
    <roles id="82420955976896" description="User 31190669223287 has role null in 29649421790262 domain" tenantId="96488406679080"/>
    <roles id="00000000004004" description="Group 55207359871951 has role null in 29649421790262 domain"/>
  </user>
</users>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/users"
```

## Add Endpoint to a Tenant
#### POST [csbu:HPKeystoneExtensionBaseURI]/tenants/{tenantId]}/endpoints
*Privilege Level: SA, DA*

Add endpoint template association with a tenant. 

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to return users for.

**Data Parameters**

See schema file for more details on the request and response data structure.

* *endpointTemplate id* - string - Unique ID of the endpoint template being associated to this tenant.

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 51
 
{
    "endpointTemplate":{
        "id":120
    }
}
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 183
 
<endpointTemplate
  xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:type="EndpointTemplateWithOnlyId"
  id="110"/>
```

**Success Response**

**Status Code**

* 201 - Created

**Response Data**

JSON

```
HTTP/1.1 201 CreatedHTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 589
Date: Wed, 12 Oct 2011 21:38:10 GMT
 
{
  "endpoint" : {
    "version" : {
      "id" : "1.0",
      "info" : "http://127.0.0.1:8080//info/v1.0",
      "list" : "http://127.0.0.1:8080/allVersions",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
    "id" : 541,
    "internalURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
    "name" : "Object Storage",
    "otherAttributes" : {
    },
    "publicURL" : "http://127.0.0.1:8080/v1/AUTH_%tenant_id%",
    "region" : "RegionOne",
    "tenantId" : "95096564413950",
    "type" : "object-store"
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
Set-Cookie: JSESSIONID=CDB8CBA09CE01A8160BAC1D4A2EE01A4; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 574
Date: Wed, 12 Oct 2011 21:44:26 GMT
 
<endpoint id="542" type="image-service" name="Image Management" 
region="RegionOne" 
publicURL="http://127.0.0.1:9292/v1.1/%tenant_id%" 
internalURL="http://127.0.0.1:9292/v1.1/%tenant_id%" 
adminURL="http://127.0.0.1:9292/v1.1/%tenant_id%" 
tenantId="95096564413950" 
xmlns="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns2="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns3="http://www.w3.org/2005/Atom">
   <version id="1.1" info="http://127.0.0.1:9292/info/v1.1" 
        list="http://127.0.0.1:9292/allVersions"/>
</endpoint>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X POST -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints" -d '{"endpointTemplate":{"id":120}}'
```

## Remove Endpoints from a Tenant
#### DELETE [csbu:HPKeystoneExtensionBaseURI]/tenants/{tenantId}/endpoints/{endpointId}
*Privilege Level: DA, SA*

Remove tenant's endpoint template association for given endpoint id. The operation does not require a request body.

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to delete the endpoint from.
* *endpointId* - string - Unique ID of the endpoint being deleted from this tenant.

**Data Parameters**

This call does not require a request body.

XML

```
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

JSON

```
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

* 204 (No Content), Deletion of the endpoint template association was successful.

**Response Data**

This call does not return a response body.

(No JSON/XML format differences)

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=74ADEBA6F2523478A1700D664FD70C75; Path=/v2.0; Secure
Date: Wed, 12 Oct 2011 22:02:16 GMT
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | Either the Tenant for this tenantId or the Endpoint for the endpointId doesn't exist. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X DELETE -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543"
```

## Update a Tenant
#### PUT [HPKeystoneExtensionBaseURI]/tenants/{tenantID} 
*Privilege Level: SA, DA*

Allows updating an existing tenant using the tenantId and request body. Does not allow update or change of tenantId and domainId ('domainId' cannot be updated, passing that in request body will result in failure).

**Request Data**

**URL Parameters**

* *tenantId* - string - Unique ID of the tenant to be updated.

**Data Parameters**

See tenant schema file for more details on the request and response data structure.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/37942731773710 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ecab298b0be470b008da2ab
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 132
 
{"tenant": {
   "description": "Tenant for Market forecasting service",
   "otherAttributes": {"swiftAccountHash": "abcd23456"}
}}
```

XML

```
PUT /v2.0/HP-IDM/v1.0/tenants/33841725750480 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4eb4288e2cdca60d5a48e9a1
Host: localhost:9999
Connection: keep-alive
Content-Length: 350
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" status="disabled"/>
```

XML (with swift account hash)

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/76063089090850 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e8397c5b0bedc2f5c932a15
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 267
 
<tenant name="HP Swift Tenant Services" 
description="Tenant for hosting HR Applications &amp; services" 
status="enabled" 
swiftAccountHash="abcdefgh123456" 
xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"/>
```

**Success Response**

**Status Code**

* 200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=C869D386993E9F92B3E2FC1935B00154; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 313
Date: Mon, 21 Nov 2011 20:20:53 GMT
 
{
  "tenant" : {
    "description" : "Tenant for Market forecasting service",
    "anies" : null,
    "domainId" : "32046002839662",
    "name" : "HP Swift Tenant 2 Services",
    "otherAttributes" : {
      "swiftAccountHash" : "abcd23456"
    },
    "status" : "enabled",
    "tenantId" : "37942731773710"
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
Set-Cookie: JSESSIONID=3E1203905FC35B1519A6107B936173B5; Path=/
Content-Type: application/xml
Content-Length: 491
Date: Fri, 04 Nov 2011 18:02:42 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" name="EMail Service" tenantId="33841725750480" domainId="36528361097134" status="disabled">
  <description>Tenant for Email and Chat Service</description>
</tenant>
```

XML (with swift account hash)

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=86D76B52AABD080B77ED24F0722DF175; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 322
Date: Wed, 28 Sep 2011 21:59:05 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
name="HP Swift Tenant Services" 
description="Tenant for hosting HR Applications &amp; services" 
tenantId="76063089090850" 
domainId="77759980331221" 
status="enabled" 
swiftAccountHash="abcdefgh123456"/>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The Tenant for this tenantId does not exist. |
| 409 | Conflict | Will be returned if a Tenant with the name already exists in the system or if a Tenant with swift account hash already exists in the system. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X PUT -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tenants/37942731773710" -d '{"tenant":{"description":"Tenant for Market forecasting service","otherAttributes":{"swiftAccountHash":"abcd23456"}}}'
```
