# Services

The Service REST API provides the ability to manage registered services.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## Get Service by Id
#### GET [HPKeystoneExtensionBaseURI]/services/{serviceId}   
*Privilege Level: SA, SVC*

This API is used to get registered service data by its id (system generated service identifier).

**Request Data**

**URL Parameters**

* *serviceId* - scalar - The numeric id for a registered service

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

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
Content-Length: 236
Date: Wed, 14 Sep 2011 22:33:42 GMT
 
{"registerService": {
   "description": "Test Service Desc",
   "id": "18",
   "otherAttributes": {},
   "releaseState": "preview",
   "serviceName": "HP-Swift USWest Zone2",
   "serviceType": "object-store"
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=BEEB2026E2A5A6AA5FDCE7E14FB262F9; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 320
Date: Wed, 14 Sep 2011 22:35:31 GMT
 
<ns2:registerService 
serviceName="HP-Swift USWest Zone2" 
serviceType="object-store" 
releaseState="preview"
id="18" 
description="Test Service Desc"
xmlns="http://docs.openstack.org/identity/api/v2.0"
xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"/>
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/services/18"
```

**Additional Notes**

## List Registered Services
#### GET [HPKeystoneExtensionBaseURI]/services?limit={pagesize}&marker={ServiceId}&serviceType={ServiceType}  
*Privilege Level: SA, SVC, DA, DU*

This API is used to get paginated list of registered services available in the system. The marker value is serviceId of last item in previous list. Results are sorted by serviceId. To get list of services for a specific type of service, serviceType request parameter can be added. 

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - represents serviceId of last item in previous returned list of this call. For getting list from beginning, pass no value.
* *serviceType* (Optional) - string - value to filter the list by serviceType

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/services HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_50638582957cd84dc49587a2
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/services HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_50638582957cd84dc49587a2
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

Optional:

Request With serviceType Filter:

JSON

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/services?serviceType=compute HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_50638582957cd84dc49587a2
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/v1.0/services?serviceType=compute HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_50638582957cd84dc49587a2
Host: localhost:35357
Connection: Keep-Alive
User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
```


**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=B34844913BF641E4944208961C8413F5; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1868
Date: Wed, 26 Sep 2012 22:53:50 GMT
 
{"registerServices": {
   "anies": null,
   "otherAttributes": {},
   "registerService":    [
            {
         "description": "HP Cloud Identity",
         "id": "100",
         "otherAttributes": {},
         "releaseState": "public",
         "serviceName": "Identity",
         "serviceType": "identity"
      },
            {
         "description": "HP Cloud Object Storage",
         "id": "110",
         "otherAttributes": {},
         "releaseState": "public",
         "serviceName": "Object Storage",
         "serviceType": "object-store"
      },
            {
         "description": "HP Cloud Compute",
         "id": "120",
         "otherAttributes": {},
         "releaseState": "public",
         "serviceName": "Compute",
         "serviceType": "compute"
      },
            {
         "description": "HP Cloud EC2 Compatibility Layer",
         "id": "121",
         "otherAttributes": {},
         "releaseState": "public",
         "serviceName": "EC2",
         "serviceType": "ec2"
      },
            {
         "description": "HP Cloud Block Storage",
         "id": "130",
         "otherAttributes": {},
         "releaseState": "public",
         "serviceName": "Block Storage",
         "serviceType": "volume"
      },
            {
         "description": "HP Cloud Image Management",
         "id": "140",
         "otherAttributes": {},
         "releaseState": "public",
         "serviceName": "Image Management",
         "serviceType": "image"
      },
            {
         "description": "HP Cloud Content Delivery Network",
         "id": "150",
         "otherAttributes": {},
         "releaseState": "public",
         "serviceName": "CDN",
         "serviceType": "hpext:cdn"
      },
            {
         "description": "HP Cloud Relational Database for MySQL",
         "id": "160",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Relational DB MySQL",
         "serviceType": "hpext:dbaas"
      }
   ]
}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=864B386D67CF39F3ADBE5CD8B8F41748; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 1504
Date: Wed, 26 Sep 2012 22:47:19 GMT
 
<ns1:registerServices xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:registerService id="100" description="HP Cloud Identity" serviceName="Identity" serviceType="identity" releaseState="public"/>
   <ns1:registerService id="110" description="HP Cloud Object Storage" serviceName="Object Storage" serviceType="object-store" releaseState="public"/>
   <ns1:registerService id="120" description="HP Cloud Compute" serviceName="Compute" serviceType="compute" releaseState="public"/>
   <ns1:registerService id="121" description="HP Cloud EC2 Compatibility Layer" serviceName="EC2" serviceType="ec2" releaseState="public"/>
   <ns1:registerService id="130" description="HP Cloud Block Storage" serviceName="Block Storage" serviceType="volume" releaseState="public"/>
   <ns1:registerService id="140" description="HP Cloud Image Management" serviceName="Image Management" serviceType="image" releaseState="public"/>
   <ns1:registerService id="150" description="HP Cloud Content Delivery Network" serviceName="CDN" serviceType="hpext:cdn" releaseState="public"/>
   <ns1:registerService id="160" description="HP Cloud Relational Database for MySQL" serviceName="Relational DB MySQL" serviceType="hpext:dbaas" releaseState="beta"/>
</ns1:registerServices>
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/services?serviceType=compute"
```

**Additional Notes**

## Register New Service
#### POST [HPKeystoneExtensionBaseURI]/services  	
*Privilege Level: SA, SVC*

This API is used to add new service registration. 

**Request Data**

**URL Parameters**

**Data Parameters**

Service registration data is expected in request body. In request data, service name and service type is required. Service name is expected to be unique so passing same service name will result in error. Case-insensitive existence check is done for service name.  If 'releaseState' value is provided, it needs to be system recognized release state otherwise it will result in error. If no release state value is provided, system defined default value ('restricted') is used. Numeric 'id' value needs to be provided otherwise it will result in error. If there is another registered service exists with given id, duplicate conflict (409) error is returned.

Following are pre-defined serviceType and releaseState values in system which are maintained in database. Please note releaseState list may grow with time. Clients can define their own serviceType values when registering new service.

Valid values for serviceType : 'compute' , 'image-service', 'object-store', 'identity', 'hpext:block-store', 'hpext:cdn'
Valid values for releaseState : 'restricted', 'preview', 'beta', 'public' , 'decommissioned'

See schema file for more details on the request and response data structure.

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/services HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f6a6aeab0be221be646e227
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Content-Length: 211
Host: localhost:8443
 
{"registerService": {
   "description": "Test Service Desc",
   "id": "240",
   "otherAttributes": {},
   "releaseState": "preview",
   "serviceName": "HP-Swift USWest Zone2",
   "serviceType": "object-store"
}}
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/services HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f6a6aeab0be221be646e227
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Content-Length: 212
Host: localhost:8443
 
<hpext:registerService 
id="230"
serviceName="HP-Nova USWest Zone2 " 
description="Test Service Desc" 
releaseState="preview" 
serviceType="compute" 
xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"/>
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

201 - Created

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=700D7BA73D95F49792F50528D4A792B7; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 235
Date: Thu, 22 Mar 2012 00:02:46 GMT
 
{
  "registerService" : {
    "description" : "Test Service Desc",
    "id" : "240",
    "otherAttributes" : {
    },
    "releaseState" : "preview",
    "serviceName" : "HP-Swift USWest Zone2",
    "serviceType" : "object-store"
  }
}
```

XML

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=91B57CCC2DF15E35AD6BB6B6884AB1C2; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 249
Date: Wed, 21 Mar 2012 23:59:58 GMT
 
 
<registerService id="230"&nbsp;
description="Test Service Desc"&nbsp;
serviceName="HP-Nova USWest Zone2"&nbsp;
serviceType="compute"&nbsp;
releaseState="preview"&nbsp;
xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"/>
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -H "Content-Type: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/services" -d '{"registerService": {"description": "Test Service Desc","id": "240","otherAttributes": {},"releaseState": "preview","serviceName": "HP-Swift USWest Zone2","serviceType": "object-store"}}'
```

**Additional Notes**

## Update Service
#### PUT [HPKeystoneExtensionBaseURI]/services/{serviceId}  	
*Privilege Level: SA, SVC*

This API is used to modify registered service data and for decommissioning the service if its no longer in use.

**Request Data**

**URL Parameters**

**Data Parameters**

For updating a service, serviceId is required as its used to lookup existing service data. Service name and service type data cannot be null or blank.  Service name is expected to be unique so if service name is changed, it still needs to be unique in the system. Case-insensitive check is done for service name.  If 'releaseState' value is provided, it needs to be system recognized release state otherwise it will result in error. 

If service is no longer is use and needs to be marked deleted, its releaseState can be updated to 'decommissioned' . Note once its releaseState is marked deleted, its release state cannot be altered from there on.

Following are pre-defined serviceType and releaseState values in system which are maintained in database. Please note that this list may grow with time.

Valid values for serviceType : 'compute' , 'image-service', 'object-store', 'identity', 'hpext:block-store', 'hpext:cdn'
Valid values for releaseState : 'restricted', 'preview', 'beta', 'public' , 'decommissioned'

See schema file for more details on the request and response data structure.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/services/150 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9c7424b0be3d7fd233fa60
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Content-Length: 232
Host: localhost:8443
 
{
  "registerService" : {
    "description" : "HP Content Delivery Network Service",
    "id" : "150",
    "otherAttributes" : {
    },
    "releaseState" : "preview",
    "serviceName" : "CDN",
    "serviceType" : "hpext:cdn"
  }
}
```

XML

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/services/150 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9c7424b0be3d7fd233fa60
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Content-Length: 197
Host: localhost:8443
 
<registerService xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
id="150" description="HP Content Delivery Network Service" 
serviceName="CDN" serviceType="hpext:cdn" 
releaseState="preview"/>

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
Content-Length: 232
Date: Mon, 17 Oct 2011 18:54:03 GMT
 
{
  "registerService" : {
    "description" : "HP Content Delivery Network Service",
    "id" : "150",
    "otherAttributes" : {
    },
    "releaseState" : "preview",
    "serviceName" : "CDN",
    "serviceType" : "hpext:cdn"
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
Set-Cookie: JSESSIONID=F5F3B66446537D2E713B4F9747ECCC65; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 252
Date: Mon, 17 Oct 2011 18:52:18 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<registerService xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
id="150" 
description="HP Content Delivery Network Service" 
serviceName="CDN" 
serviceType="hpext:cdn" 
releaseState="preview"/>
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" -H "Content-Type: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/services" -d '{"registerService": {"description": "HP Content Delivery Network Service","id": "150","otherAttributes": {},"releaseState": "preview","serviceName": "CDN","serviceType": "hpext:cdn"}}'
```

**Additional Notes**


