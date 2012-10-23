---  
title : Service Operations

---  


**List Registered Services**
----------------------------

Verb

URI

Description

**GET**

**[iaas:HPKeystoneExtensionBaseURI]/services?limit={pagesize}&marker={ServiceName}&serviceType={ServiceType}**

Gets paginated list of active registered services

#### **Detailed Description**

This API is used to get paginated list of registered services available
in the system. The marker value is *serviceName* of last item in
previous list Results are sorted by serviceName. To get list of services
for a specific type of service, *serviceType* request parameter can be
added. This API will not include services which are in
'**decommissioned**' release state which is used to indicate that
service is no longer in use. This operation does not require a request
body.

**Normal Response Codes**

**200 **(OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400 ***(Bad Request)

Malformed request in URI or invalid data provided.

***401 ***(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403 ****(Forbidden)*

*X-Auth-Token is missing or is invalid.*

***404 ****(Not Found)*

When provided marker is not valid (not found in database).

**500 **(Internal Server Error)

The server encountered a problem while processing the request.

Please refer to error response body for additional details.

#### **Header Values**

Valid X-Auth-Token value is required.

#### **Query String Values**

*'serviceType' value is optional. It may be used to filter the list by
serviceType.*
 'limit' value is optional. If none provided, system default value is
used to limit the number of items returned.
 'marker' value is optional. Its expected to be serviceName of last item
in previous returned list of this call For getting list from beginning,
pass no value.

See [Pagination with limit and marker query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters").

#### Request and Response Resource Representations

Content Type

**Supported**

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

no

#### Request and response schema, XML Schema Definition

[hp-services.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/hp-services.xsd) 
 (hp extension schema for services)
[services.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/services.xsd) 
 (keystone services schema)

#### **Example(s)**

Request content and format is same for XML and JSON response body.

##### Request (without no limit and serviceType parameter values in request)

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/services HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e710bf56691a47df575686e
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### XML Response (without no limit and serviceType parameter values in request)

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=11D06934A1D9267CC25A2C4E69CC15CD; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 1997
Date: Wed, 14 Sep 2011 20:18:28 GMT

<ns2:registerServices xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <ns2:registerService serviceName="HP-Nova USWest Zone1" serviceType="compute" releaseState="preview" id="16" description="Test Service Desc"/>
   <ns2:registerService serviceName="HP-Nova USWest Zone2" serviceType="compute" releaseState="preview" id="17" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test  Service5555" serviceType="compute" releaseState="beta" id="13" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test + Service5555" serviceType="compute" releaseState="beta" id="11" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test + service5555" serviceType="compute" releaseState="beta" id="10" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test Service55" serviceType="compute" releaseState="beta" id="8" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test Service555" serviceType="compute" releaseState="beta" id="7" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test-SErvice5555" serviceType="compute" releaseState="beta" id="14" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test-Service555" serviceType="compute" releaseState="beta" id="15" description="Test Service Desc"/>
   <ns2:registerService serviceName="TestService1" serviceType="image-service" releaseState="beta" id="1" description="Test Service Desc"/>
   <ns2:registerService serviceName="TestService2" serviceType="image-service" releaseState="beta" id="2" description="Test Service Desc"/>
   <ns2:registerService serviceName="TestService3" serviceType="image-service" releaseState="beta" id="3" description="Test Service Desc"/>
   <ns2:registerService serviceName="TestService4" serviceType="compute" releaseState="beta" id="4" description="Test Service Desc"/>
   <ns2:registerService serviceName="Testservice4" serviceType="compute" releaseState="beta" id="5" description="Test Service Desc"/>
   <ns2:registerService serviceName="Testservice5" serviceType="compute" releaseState="beta" id="6" description="Test Service Desc"/>
</ns2:registerServices>
~~~

##### Request (with limit, marker and serviceType parameter values in request)

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/services?serviceType=compute&limit=3&marker=Test%20%20Service5555 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e72281a66919b2665691e1d
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Accept-Encoding: gzip,deflateX-Auth-Token: HPAuth_4e72281a66919b2665691e1dAccept: application/xmlUser-Agent: Jakarta Commons-HttpClient/3.Host: localhost:84
~~~

##### XML Response (with limit, marker and serviceType parameter values in request)

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=61A6674C10E5B06E3C6BEC099A174C20; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 655
Date: Wed, 14 Sep 2011 20:23:49 GMT

<ns2:registerServices xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <ns2:registerService serviceName="Test + Service5555" serviceType="compute" releaseState="beta" id="11" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test + service5555" serviceType="compute" releaseState="beta" id="10" description="Test Service Desc"/>
   <ns2:registerService serviceName="Test Service55" serviceType="compute" releaseState="beta" id="8" description="Test Service Desc"/>
</ns2:registerServices>
~~~

##### JSON Response (without no limit and serviceType parameter values in request)

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2868
Date: Wed, 14 Sep 2011 20:37:00 GMT

{"registerServices": {
   "anies": null,
   "otherAttributes": {},
   "registerService":    [
            {
         "description": "Test Service Desc",
         "id": "13",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test  Service5555",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "11",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test + Service 5555",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "10",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test + service5555",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "8",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test Service55",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "7",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test Service555",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "14",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test-SErvice5555",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "15",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test-Service555",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "1",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "TestService1",
         "serviceType": "image-service"
      },
            {
         "description": "Test Service Desc",
         "id": "2",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "TestService2",
         "serviceType": "image-service"
      },
            {
         "description": "Test Service Desc",
         "id": "3",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "TestService3",
         "serviceType": "image-service"
      },
            {
         "description": "Test Service Desc",
         "id": "4",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "TestService41",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "5",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Testservice4",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "6",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Testservice5",
         "serviceType": "compute"
      }
   ]
}}
~~~

##### JSON Response (with limit, marker and serviceType parameter values in request)

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 746
Date: Wed, 14 Sep 2011 20:31:11 GMT

{"registerServices": {
   "anies": null,
   "otherAttributes": {},
   "registerService":    [
            {
         "description": "Test Service Desc",
         "id": "8",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test Service55",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "7",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test Service555",
         "serviceType": "compute"
      },
            {
         "description": "Test Service Desc",
         "id": "14",
         "otherAttributes": {},
         "releaseState": "beta",
         "serviceName": "Test-SErvice5555",
         "serviceType": "compute"
      }
   ]
}}
~~~

**Register New Service**
------------------------

Verb

URI

Description

**POST**

**[iaas:HPKeystoneExtensionBaseURI]/services **

Register new service

#### **Detailed Description**

This API is used to add new service registration. Service registration
data is expected in request body. In request data, service name and
service type is required. Service name is expected to be unique so
passing same service name will result in error. Case-insensitive
existence check is done for service name.  If 'releaseState' value is
provided, it needs to be system recognized release state otherwise it
will result in error. If no release state value is provided, system
defined default value ('restricted') is used. Numeric 'id' value needs
to be provided otherwise it will result in error. If there is another
registered service exists with given id, duplicate conflict (409) error
is returned.

Following are pre-defined serviceType and releaseState values in system
which are maintained in database. Please note releaseState list may grow
with time. Clients can define their own serviceType values when
registering new service.

Valid values for serviceType : 'compute' , 'image-service',
'object-store', 'identity', 'hpext:block-store', 'hpext:cdn'
 Valid values for releaseState : ''restricted', 'preview', 'beta',
'public' , 'decommissioned'

#### **Normal Response Codes**

**201 **(Created)

#### ***Error Response Codes***

HTTP Status Code

Response(s)

***400*** (Bad Request)

*Malformed request in URI or request body*
 *Missing or duplicate service name*
 *Missing or invalid service type*
 *Invalid release state*
 *Missing or non-numeric service id value.*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*X-Auth-Token is missing or is invalid.*

***409*** *(Conflict) *

Service name or serviceId is duplicate.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

Please refer to error response body for additional details.

#### **Header Values**

Valid X-Auth-Token value is required.

#### ***Query String Values***

*No additional query string values required.*

#### Request and Response Resource Representations

Content Type

**Supported**

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

no

#### Request and response schema, XML Schema Definition

[hp-services.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/hp-services.xsd) 
 (hp extension schema for services)
[services.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/services.xsd) 
 (keystone services schema)

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
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
~~~

##### JSON Response

~~~
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
~~~

**Get Service by Id**
---------------------

Verb

URI

Description

**GET**

**[iaas:HPKeystoneExtensionBaseURI]/services/{serviceId} **

Get a registered service by its Id

#### **Detailed Description**

This API is used to get registered service data by its id (system
generated service identifier). This operation does not require a request
body.

#### **Normal Response Codes**

**200 **(OK)

#### ***Error Response Codes***

HTTP Status Code

Response(s)

***400*** (Bad Request)

*Malformed request in URI.*
 *serviceId is missing or blank.*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*X-Auth-Token is missing or is invalid.*

***404*** *(Not Found) *

Invalid service id provided.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

Please refer to error response body for additional details.

#### **Header Values**

Valid X-Auth-Token value is required.

#### ***Query String Values***

*No additional query string values required.*

#### Request and Response Resource Representations

Content Type

**Supported**

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

no

#### Request and response schema, XML Schema Definition

No request body is required. 

#### **Example(s)**

Request content and format is same for XML and JSON response body.

##### Request (same for XML and JSON response body)

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/services/18 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e71252d6691a47df5756874
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### XML Response

~~~
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
~~~

##### JSON Response

~~~
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
~~~

**Update Service**
------------------

Verb

URI

Description

**PUT**

**[iaas:HPKeystoneExtensionBaseURI]/services/{serviceId} **

Update existing service data

#### **Detailed Description**

This API is used to modify registered service data and for
decommissioning the service if its no longer in use. For updating a
service, serviceId is required as its used to lookup existing service
data. Service name and service type data cannot be null or blank.
 Service name is expected to be unique so if service name is changed, it
still needs to be unique in the system. Case-insensitive check is done
for service name.  If 'releaseState' value is provided, it needs to be
system recognized release state otherwise it will result in error. 

If service is no longer is use and needs to be marked deleted, its
releaseState can be updated to 'decommissioned' . Note once its
releaseState is marked deleted, its release state cannot be altered from
there on.

Following are pre-defined serviceType and releaseState values in system
which are maintained in database. Please note that this list may grow
with time.

Valid values for serviceType : 'compute' , 'image-service',
'object-store', 'identity', 'hpext:block-store', 'hpext:cdn'
 Valid values for releaseState : ''restricted', 'preview', 'beta',
'public' , 'decommissioned'

#### **Normal Response Codes**

**200 **(OK)

#### ***Error Response Codes***

HTTP Status Code

Response(s)

***400*** (Bad Request)

*Malformed request in URI.*
 *serviceId is missing or blank.*
 *Missing or duplicate service name**  (if modified)*
 *Missing or invalid service type** *
 *Invalid release state.*
 *Tried to change release state for 'decommissioned' service.*
 *Non-numeric service id value.*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*X-Auth-Token is missing or is invalid.*

***404*** *(Not Found) *

Invalid service id provided.

***409*** *(Conflict) *

Another registered service with provided name already exists.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

Please refer to error response body for additional details.

#### **Header Values**

Valid X-Auth-Token value is required.

#### ***Query String Values***

*No additional query string values required.*

#### Request and Response Resource Representations

Content Type

**Supported**

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

no

#### Request and response schema, XML Schema Definition

[hp-services.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/hp-services.xsd) 
 (hp extension schema for services)
[services.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/services.xsd) 
 (keystone services schema)

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
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
~~~

##### JSON Response

~~~
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
~~~
