# Endpoint Template

The Endpoint Template REST API provides the ability to manage service endpoints.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## Add Endpoint Template
#### POST [HPKeystoneExtensionBaseURI]/endpointTemplates
*Privilege Level: SA, SVC*

Adds new endpoint template data. Endpoint template data is provided in POST request body. Service name ('name' attribute) and region is required in EndpointTemplate. Input 'id' needs to be unique value in the system. 

Name (service name) and region combination needs to be unique in system. 
Service with given name should already be registered with system otherwise related error is returned back. Similarly type (service type) should have a valid system-recognized (pre-defined) value.
Release state attribute if not provided in input data, then its value is derived from related registered service. If provided, then value should have a valid system-recognized (pre-defined) value.

If enabled and global flag values are not provided in input data, system uses 'true' and 'false' as its default value respectively. 

Region code is not marked as required in current implementation but should be provided.  The format of region code is  [csbu:az-number].[csbu:region-alpha].[csbu:geo-number]   So, and example would be: az-1.region-a.geo-1

Note: Only tenant specific enabled and global endpoint templates are returned as part of service catalog during scoped token validation call.


**Request Data**


**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

Request body includes the new endpoint template with required fields defined.

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 704
 
 
  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "216",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-7",
    "releaseState" : "public",
    "type" : "compute"
  }
}
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 719
 
<ns1:endpointTemplate id="215" type="compute" 
name="Compute" region="az-3.region-a.geo-6" 
publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" 
global="false" enabled="true" xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
</ns1:endpointTemplate>
```

**Success Response**


**Status Code**

201 - Created

**Response Data**

JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=A6E1D38BE03CE5F52B1C30D61DE88271; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 705
Date: Tue, 01 May 2012 18:06:19 GMT
 
{
  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "216",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-7",
    "releaseState" : "public",
    "type" : "compute"
  }
}
```

XML

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=30639D2AB6506F0C93DC6D4681AF069A; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 791
Date: Tue, 01 May 2012 18:01:52 GMT
 
<ns1:endpointTemplate id="215" type="compute" 
name="Compute" region="az-3.region-a.geo-6" 
publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" 
global="false" enabled="true" releaseState="public" 
xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
</ns1:endpointTemplate>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | EndpointTemplateId not found |
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X POST -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -d '{  "EndpointTemplate" : {  "name" : "Compute", "type":"compute", "id":"215","region":"az-3.region-a.geo-6","global":"false","enabled":"true",releaseState="public","publicURL": "https:\/\/az-3.region-a.geo-1.compute.hpcloudsvc.com\/v1.1\/", "adminURL": "https:\/\/https://nv-aw2az3-manage0009.uswest.hpcloud.net\/v1.1\/"} }' "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates"

```

**Additional Notes**


## Delete Endpoint Template
#### DELETE [HPKeystoneExtensionBaseURI]/endpointTemplates/ {endpointTemplateId} 
*Privilege Level: SA, SVC*

Deletes an endpoint template for the specified endpointTemplateId This will also remove all tenant association with this template.

endpointTemplateId  is required otherwise 400 (bad request) is returned.

If endpointTemplateId is not present in system, 404 (item not found) error is returned.

**Request Data**


**URL Parameters**

* *endpointTemplateId* - scalar - Unique ID of the endpoint template to be deleted.

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.


**Success Response**

**Status Code**

204 - No Content

**Response Data**

No content is expected in response body

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | EndpointTemplateId not found |
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X DELETE -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/xml" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates/1200"
```

**Additional Notes**


## Get Enabled Endpoint Templates
#### GET [HPKeystoneExtensionBaseURI]/endpointTemplates/enabled?serviceName={ServiceName} 	
*Privilege Level: SA, SVC, DA, DU *

Get a list of available endpoint templates. If serviceName is provided in query, then endpoint templates specific to only that service are included in response.  In case of incorrect service name ( does not exist in system), empty list is returned. This list will to include only enabled endpoint templates. The operation does not require a request body.

This API supports pagination through 'limit' and 'marker' usage. Marker is templateId and should be valid otherwise 404 (not found) error is going to be returned.

Note: Only tenant specific enabled and global endpoint templates are returned as part of service catalog during scoped token validation call.

**Request Data**


**URL Parameters**

* *serviceName* (Optional) - string - service name to return endpoint templates specific to
* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the template Id. 


**Data Parameters**

This call does not require a request body.


**Success Response**


**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=AAB73BB788D3C4C074D29B7FDF0E5E86; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2905
Date: Tue, 01 May 2012 18:11:05 GMT
 
{
  "endpointTemplates" : {
    "anies" : null,
    "endpointTemplate" : [ {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "100",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-1.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "110",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-2.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "111",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-3.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.0",
        "info" : null,
        "list" : null,
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/",
      "enabled" : true,
      "global" : false,
      "id" : "120",
      "internalURL" : null,
      "name" : "Object Storage",
      "otherAttributes" : {
      },
      "publicURL" : "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%",
      "publicURL2" : null,
      "region" : "region-a.geo-1",
      "releaseState" : "public",
      "type" : "object-store"
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
Set-Cookie: JSESSIONID=D2D513368A8C87BB990F528CA809F59F; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 2099
Date: Tue, 01 May 2012 18:13:03 GMT
 
<ns1:endpointTemplates xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:endpointTemplate id="100" type="compute" name="Compute" region="az-1.region-a.geo-1" 
           publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
           publicURL2="https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
           adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" 
           global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="110" type="compute" name="Compute" region="az-2.region-a.geo-1" 
           publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
           publicURL2="https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
           adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" 
           global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="111" type="compute" name="Compute" region="az-3.region-a.geo-1" 
           publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
           publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
           adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" 
           global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="120" type="object-store" name="Object Storage" region="region-a.geo-1" 
           publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%" 
           adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/" 
           global="false" enabled="true" releaseState="public">
      <ns1:version id="1.0"/>
   </ns1:endpointTemplate>
</ns1:endpointTemplates>
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | Marker value is not valid (not found in database).  |
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/xml" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates/enabled?limit=4"
```

**Additional Notes**


## Get Endpoint Template By Id
#### GET [HPKeystoneExtensionBaseURI]/endpointTemplates/{endpointTemplateId}
*Privilege Level: SA, SVC, DA, DU*

Get an endpoint template by endpointTemplateId.

**Request Data**

The operation does not require a request body.

**URL Parameters**

* *endpointTemplateId* - scalar - The numeric id for a endpoint template

**Data Parameters**

This operation does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/111 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
 
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=26457FB26BD6F8EB5D0214BEF521B01A; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 705
Date: Tue, 01 May 2012 17:58:17 GMT
 
{
  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "111",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-1",
    "releaseState" : "public",
    "type" : "compute"
  }
}
```

XML

```
GET https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/111 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
 
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=86F04EB5AE761FF0933F90844BF6441A; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 791
Date: Tue, 01 May 2012 17:59:00 GMT
 
<ns1:endpointTemplate id="111" type="compute" 
name="Compute" region="az-3.region-a.geo-1" 
publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" 
publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" 
adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" 
global="false" enabled="true" releaseState="public" 
xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
</ns1:endpointTemplate>
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | EndpointTemplateId not found. |
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/xml" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates/1200"
```

**Additional Notes**


## Get Endpoint Templates
#### GET [HPKeystoneExtensionBaseURI]/endpointTemplates?serviceName={ServiceName}
*Privilege Level: SA, SVC, DA, DU *

Get a list of endpoint templates. If serviceName is provided in query, then endpoint templates specific to only that service are included in response. In case of incorrect service name ( does not exist in system), empty list is returned. This list will include disabled endpoint templates in addition to enabled endpoint templates. The operation does not require a request body.

This API supports pagination through 'limit' and 'marker' usage. Marker is templateId and should be valid otherwise 404 (not found) error is going to be returned.

Note: Only tenant specific enabled and global endpoint templates are returned as part of service catalog during scoped token validation call.

**Request Data**

**URL Parameters**

* *serviceName* (Optional) - string - service name to return endpoint templates specific to
* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional) - string - the template Id. 

**Data Parameters**

This call does not require a request body.


**Success Response**


**Status Code**

200 - OK

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=DFCFC378DE6320D5C411461BD518902F; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2286
Date: Tue, 01 May 2012 17:56:33 GMT
 
{
  "endpointTemplates" : {
    "anies" : null,
    "endpointTemplate" : [ {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "100",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-1.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "110",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-2.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
    }, {
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      },
      "anies" : null,
      "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
      "enabled" : true,
      "global" : false,
      "id" : "111",
      "internalURL" : null,
      "name" : "Compute",
      "otherAttributes" : {
      },
      "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
      "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
      "region" : "az-3.region-a.geo-1",
      "releaseState" : "public",
      "type" : "compute"
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
Set-Cookie: JSESSIONID=B982B0384A07FED4F9C0182501C7FFDF; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 2543
Date: Tue, 01 May 2012 17:54:24 GMT
 
 
<ns1:endpointTemplates xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <ns1:endpointTemplate id="100" type="compute" name="Compute" region="az-1.region-a.geo-1" publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="110" type="compute" name="Compute" region="az-2.region-a.geo-1" publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="111" type="compute" name="Compute" region="az-3.region-a.geo-1" publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true" releaseState="public">
      <ns1:version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="120" type="object-store" name="Object Storage" region="region-a.geo-1" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/" global="false" enabled="true" releaseState="public">
      <ns1:version id="1.0"/>
   </ns1:endpointTemplate>
   <ns1:endpointTemplate id="130" type="identity" name="Identity" region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" global="true" enabled="true" releaseState="public">
      <ns1:version id="2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/extension"/>
   </ns1:endpointTemplate>
</ns1:endpointTemplates>
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | Marker value is not valid (not found in database).  |
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/xml" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates?serviceName=Compute&limit=5"
```

**Additional Notes**


## Update Endpoint Template
#### PUT HPKeystoneExtensionBaseURI]/endpointTemplates/{endpointTemplateId} 
*Privilege Level: SA, SVC *

Updates existing endpoint template data. Endpoint template data is provided in PUT request body. Id, service name and region are required in EndpointTemplate. Returns back is the updated endpoint template data as the response body. If optional attributes values are not provided or left blank, then it will overwrite existing attribute value, with null or blank respectively, in system if there.

Name (service name) and region combination needs to be unique in system. 
Service with given name should already be registered with system otherwise related error is returned back. Similarly type (service type) should have a valid system-recognized (pre-defined) value.
Release state attribute if not provided in input data, then its value is left unchnaged. If provided, then value should have a valid system-recognized (pre-defined) value.

Template must exist in system otherwise returns 404 (item not found) error.

If enabled and global flag values are not provided in input data, system does not update its existing values for other fields, it will update with null/blank if not provided. 

**Request Data**


**URL Parameters**

* *endpointTemplateId* - scalar - The numeric id for a endpoint template

**Data Parameters**

See schema file for more details on the request and response data structure.

Request body contains the endpoint template to be updated.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/111 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f9ff1d3b0be1d0584f2a7aa
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Content-Length: 704
Host: localhost:8443
 
 
  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "111",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-1",
    "releaseState" : "public",
    "type" : "compute"
  }
}
```

XML

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/endpointTemplates/130 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9c7424b0be3d7fd233fa60
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 536
 
<endpointTemplate id="130" type="identity" 
name="Identity" region="region-a.geo-1" 
publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
internalURL="hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
global="true" enabled="true" 
xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
     <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" 
           list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
</endpointTemplate>
```


**Success Response**


**Status Code**

200 - OK

**Response Data**

Response body is the updated endpoint template.

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=3EA75781EBE573B3E9EA8490E9E20BD0; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 705
Date: Tue, 01 May 2012 18:05:18 GMT
 
{
  "EndpointTemplate" : {
    "version" : {
      "id" : "1.1",
      "info" : null,
      "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
      "otherAttributes" : {
      }
    },
    "anies" : null,
    "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
    "enabled" : true,
    "global" : false,
    "id" : "111",
    "internalURL" : null,
    "name" : "Compute",
    "otherAttributes" : {
    },
    "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
    "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
    "region" : "az-3.region-a.geo-1",
    "releaseState" : "public",
    "type" : "compute"
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
Set-Cookie: JSESSIONID=F40BD043DC35086A78BD2963A2FD5759; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 797
Date: Mon, 17 Oct 2011 18:36:40 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<endpointTemplate xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" 
xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom" 
id="130" type="identity" name="Identity" 
region="region-a.geo-1" 
publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
internalURL="hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" 
global="true" enabled="true" releaseState="public">
  <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0"
         list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
</endpointTemplate>
```

**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | EndpointTemplateId not found.   |
| 409 | Conflict | Another template exists for given service name and region.    |
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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -X PUT -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/endpointTemplates/111" -d '{  "EndpointTemplate" : {  "name" : "Compute",  "region":"az-3.region-a.geo-1",releaseState="preview"} }'
```

**Additional Notes**


