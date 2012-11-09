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


## Validate Token
#### GET /tokens/\<tokenId\>?belongsTo=tenantId&HP-IDM-serviceId=110,global,130&HP-IDM-endpointTemplateId=110,111
*Privilege Level: Anon*

This API is used to validate a token. Validation includes checking that
the token belongs to a particular user and it has not expired.  On
successful validation, the response contains permissions relevant to a
particular client. If the query parameter, belongTo, is provided the
call will check the corresponding TenantId to ensure that token belongs
to that tenant. If there is no tenantId then it is globally scoped. In
the event a token is not valid, a 404 (item not found) will be returned.

Filter Roles:

For scoped token validation, optional query parameter **HP-IDM-serviceId
and/or **HP-IDM-endpointTemplateId** can be used to include only
specific subset of roles in response. If the parameter values are
provided and there are no specific roles found, then 401 (unauthorized)
error is generated. Both HP-IDM-serviceId and HP-IDM-endpointTemplateId
parameter can be used in a validate token request.
 In HP-IDM-serviceId and HP-IDM-endpointTemplateId  parameter
values, multiple ids can be specified as comma separated values. To
request global roles to be included in response, global identifier
(which is currently configured as **global**) must be used in either
of query parameter value. If both of query parameters are not specified
or has empty values, then response include all roles available for that
scoped token. In case of unscoped token validation, only global roles
are returned and HP-IDM-serviceId and HP-IDM-endpointTemplateId query
parameter, if there, is ignored.
 In case HP-IDM-endpointTemplateId value is provided for scoped token
validation, system looks into existing tenant endpointTemplate
association and uses that to filter matching endpoint specific roles. As
a service can have multiple endpoints (i.e. endpointTemplate), so if
both a serviceId and its endpointTemplateId are provided as input, then
endpointTemplateId takes precedence and we ignore the provided
serviceId. This is done to find more granular role data which in this
case is endpoint template id.

In case of scoped token validation, if that tenant has swift account
hash available in CS system, then its value is returned as a response
header with name 'X-HP-IDM-swift-account-hash'.

Note: This request does not expect X-Auth-Token header but if its
provided, then it needs to be have a valid token value otherwise
forbidden (403) error is returned.

**Request Data**

See examples below.

**URL Parameters**

* *belongsTo* (Optional) - string - tenent ID in which the token is scoped to
* *HP-IDM-serviceId* (Optional) - list of IDs (strings) - filter service specific roles
* *HP-IDM-endpointTemplateId* (Optional) - list of IDs (strings) - filter endpoint template specific roles

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

JSON

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:

JSON

ValidateToken  Request for JSON (unscoped token where HP-IDM-serviceId parameter value is ignored)

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a82d4b0be3c45af828494?HP-IDM-serviceId=110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

ValidateToken JSON Request ( HP-IDM-serviceId parameter with 120 service id value)

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=120 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

ValidateToken XML Request  (HP-IDM-serviceId parameter with 110 (Object Storage service) value and HP-IDM-endpointTemplateId parameter with 110 (Compute - AZ2) value)

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=110&HP-IDM-endpointTemplateId=110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

ValidateToken  XML Request ( HP-IDM-serviceId parameter with 'global' only)

```
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=global HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
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
Set-Cookie: JSESSIONID=D63D9FAC8FA835321F36E51CE07F2485; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/json
Content-Length: 454
Date: Fri, 09 Mar 2012 22:16:50 GMT
 
{"access": {
  "token": {
    "expires": "2012-03-10T10:12:37.474Z",
    "id": "HPAuth_4f5a7fe06a25ab00f896bee4",
    "tenant": {
      "id": "22674990706167",
      "name": "TestTenant14892659460460094027"
    }
  },
  "user": {
    "id": "85397174931388",
    "name": "TestUser14892658343713707444",
    "roles": [{
      "id": "00000000004026",
      "serviceId": "120",
      "name": "projectmanager",
      "tenantId": "22674990706167"
    }]
  }
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=451446B2BE922152AD41799AC7453A0B; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/xml
Content-Length: 608
Date: Fri, 09 Mar 2012 22:38:55 GMT
 
<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom" xmlns:ns4="http://docs.openstack.org/common/api/v1.0">
   <token id="HPAuth_4f5a7fe06a25ab00f896bee4" expires="2012-03-10T10:12:37.474Z">
      <tenant id="22674990706167" name="TestTenant14892659460460094027"/>
   </token>
   <user id="85397174931388" name="TestUser14892658343713707444">
      <roles>
         <role id="00000000004026" name="projectmanager" serviceId="120" tenantId="22674990706167"/>
      </roles>
   </user>
</access>
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com:35357/v2.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c"
```

**Additional Notes**


## Quick Token Validation
#### HEAD /tokens/\<tokenId\>?belongsTo=tenantId
*Privilege Level: Anon*

This API is used to do a quick token validation. Validation includes checking that the token belongs to a particular user and it has not expired.   If the query parameter, belongTo, is provided the call will check the corresponding tenantId to ensure membership in that tenant. If there is no tenantId then it is globally scoped. In the event a token is not valid, a 404 (item not found) will be returned.  This call won't return any roles associated with the token.
In case of scoped token validation, if that tenant has swift account hash available in CS system, then its value is returned as a response header with name 'X-HP-IDM-swift-account-hash'.
Note: This request does not expect X-Auth-Token header but if its provided, then it needs to be have a valid token value otherwise forbidden (403) error is returned.

**Request Data**

See examples below.

**URL Parameters**

* *belongsTo* (Optional) - string - tenent ID in which the token is scoped to

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

JSON

```
HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

```
HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

Optional:

JSON

With belongsTo filtering.

```
HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?belongsTo=345234435 HTTP/1.1
Accept-Encoding: gzip,deflate
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

XML

With belongsTo filtering.

```
HEAD https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?belongsTo=345234435 HTTP/1.1
Accept-Encoding: gzip,deflate
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
```

**Success Response**

**Status Code**

204 - OK

**Response Data**

This call does not return a response body.

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -XHEAD "https://az-1.region-a.geo-1.compute.hpcloudsvc.com:35357/v2.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c"
```

**Additional Notes**


## Refresh Token
#### [HPKeystoneExtensionBaseURI]/tokens/\<tokenId\>
*Privilege Level: SS*

This API is used to refresh the expiration time by generating new token. Before expiration time can be modified, validation is done to check token is not expired, user and its domain is currently enabled (similar to what is done in token validation). Once all validation checks are successful, the new token is generated with expiration time is increased to next 720 minutes (token default expiration duration). The expiration time is increased by 12 hours from current time and not from token (passed in request) expiration time. The newly generated will also get refreshed response data from system.

This a self-service user action. So token in X-Auth-Token header needs to be same as token to be re-scoped otherwise it will raise unauthorized error.

**Request Data**

See examples below.

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tokens/HPAuth_4e934043b0be09f52fb4c29d HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e934043b0be09f52fb4c29d
Accept: application/json
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 0
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tokens/HPAuth_4e934043b0be09f52fb4c29d HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e934043b0be09f52fb4c29d
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 0
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
Content-Length: 406
Date: Mon, 10 Oct 2011 19:02:25 GMT
 
{"access": {
   "token":    {
      "tenant":       {
         "id": "95096564413950",
         "name": "HP5 Tenant Services",
         "otherAttributes": {}
      },
      "anies": null,
      "expires": 1318275144906,
      "id": "HPAuth_4e934043b0be09f52fb4c29d",
      "otherAttributes": {}
   },
   "serviceCatalog": null,
   "anies": null,
   "otherAttributes": {}
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=73C402A7E410D5FF0734ED370CF1A40F; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 361
Date: Mon, 10 Oct 2011 18:59:53 GMT
 
<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4e934043b0be09f52fb4e23f" expires="2011-10-10T19:29:53.382Z">
      <tenant id="95096564413950" name="HP5 Tenant Services"/>
   </token>
</access>
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

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
curl -k -XPOST --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/tokens/HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c
```

**Additional Notes**

