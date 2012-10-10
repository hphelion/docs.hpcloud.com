# Tenant

Tenant is a collection of services, and associated with zero or more users who have access to these services via role references.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## List Tenants
### GET /tenants?limit=pagesize&marker=tenantId

This API returns a listing of all tenants for which the holder of the provided token has a role assignment. If the user is not a valid, an error is returned.

**Request Data**

This API supports pagination. See Pagination for more details.

This API also supports an optional *name* filter for get-by-name. Pagination and *name* filter are mutually exclusive.

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list
* *name* (Optional) - string - name of the tenant to be returned

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET /v2.0/tenants HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
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

Optional:

JSON

With *name* filter.

```
GET /v2.0/tenants?name=tenantName HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

With pagination.

```
GET /v2.0/tenants?limit=10 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
``` 

XML

With pagination.

```
GET /v2.0/tenants?limit=100&marker=S4DFJ123SF HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

A list of tenants in the specified format is returned.

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
    <description>Tenant for hosting Time Warner Applications & services</description>
  </tenant>
</tenants>
```

**Error Response**

*Enumerate all the possible error status codes and any content that is returned.*

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

*** List Tenants ***

```
curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/tenants"
```

*** Get Tenant By Name ***

```
curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/tenants?name=MyTenant"
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}

