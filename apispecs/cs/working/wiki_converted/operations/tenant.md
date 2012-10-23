---  
title : Tenant Operations

---  

### **Get a List of Tenants**

Verb

URI

Description

**GET **

**[*****KeystoneBaseURI******]/tenants******?limit=pagesize&marker=tenantId***

Returns all tenants logged in session.

#### **Detailed Description**

*This API returns a listing of all tenants for which the holder of the
provided token has a role assignment. If the user is not a valid, an
error is returned.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

*name : filter used to filter based on tenant name*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes through WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

No request body is required. The response of this call is the tenants
object with the list of tenant resources for the user in session, the
schema for tenants & tenant can be found
in [tenant.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/tenant.xsd).

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/tenants/ HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Request using name filter

~~~
GET /v2.0/tenants?name=tenantName HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
GET /v2.0/tenants/ HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
~~~

##### JSON Response

~~~
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
~~~

### **Get All Tenants**

Verb

URI

Description

**GET **

**[*****HPKeystoneExtensionBaseURI******]/tenants******?name=tenantName&limit=pagesize&marker=tenantId***

Get a list of all tenants.

#### **Detailed Description**

*Allows reading a list of all tenants across domains. This API supports
pagination through 'limit' and 'marker' usage. The returned list may be
filtered to allow only those tenants which the caller has access to. The
operation does not require a request body.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

*name : filter used to filter based on tenant name*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes through WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

No request body is required. The response of this call is the tenants
object with the list of tenant resources for the user in session, the
schema for tenants & tenant can be found
in [tenant.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/tenant.xsd).

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/tenants/ HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Request using name filter

~~~
GET /v2.0/HP-IDM/v1.0/tenants?name=tenantName HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
GET /v2.0/HP-IDM/v1.0/tenants/ HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ed5120a2cdc1f6ab057b22d
Host: localhost:9999
Connection: keep-alive
~~~

##### JSON Response

~~~
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
~~~

### **Get a List of Users for a Tenant (includes role assignments)**

Verb

URI

Description

**GET **

***[******HP******KeystoneExtensionBaseURI******]/tenants/{tenantId}/users******?limit=pagesize&marker=roleId***

Returns list of Users with Roles for a given Tenant.

#### **Detailed Description**

*This API returns all Users for a given Tenant, Roles associated for
each User is also returned. If the user is not a valid, an error is
returned.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes through WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

No request body is required. The response of this call is the User
objects with the list of roles for the User, the schema for User can be
found
here [user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/user.xsd).

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/tenants/96488406679080/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8b6e4c2cdc999e9328f727
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
GET /v2.0/HP-IDM/v1.0/tenants/96488406679080/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8b5dea2cdc3d29c14604d5
Host: localhost:9999
Connection: keep-alive
~~~

##### JSON Response

~~~
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
~~~

### **Get roles definitions for specified tenants**

Verb

URI

Description

**GET **

***[******HP******KeystoneExtensionBaseURI******]/tenants/{tenantId}/roles******?limit=pagesize&marker=roleId***

Returns all role definitions for a tenant.

#### **Detailed Description**

*This API would return all the role definitions for the specified tenant.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes through WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

No request body is required. The response of this call is of type Roles
[authz-models.xsd](http://wiki.hpcloud.net/download/attachments/229474615/authz-models.xsd).

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/tenants/12345678909876 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT

<roles xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role01</roleName>
      <description>role01- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role02</roleName>
      <description>role02- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role03</roleName>
      <description>role03- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
</roles>
~~~

##### JSON Request


##### JSON Response

~~~
{"roles": {"role": [
      {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role01",
      "description": "role01- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   }, {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role02",
      "description": "role02- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   }, {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role03",
      "description": "role03- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   },
]}
~~~

### **Get the roles for a user on the specified tenant**

Verb

URI

Description

**GET **

***[******HP******KeystoneExtensionBaseURI******]/tenants/{tenantId}/users/{userId}/roles******?limit=pagesize&marker=roleId***

Returns user role assignments on a tenant.

#### **Detailed Description**

*This API would return all the roles assigned to a user on a tenant.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes through WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

No request body is required. The response of this call is of type
Roles;[authz-models.xsd](http://wiki.hpcloud.net/download/attachments/229474615/authz-models.xsd).

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/tenants/12345678909876/users/345678902345/roles HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT

<roles xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role01</roleName>
      <description>role01- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role02</roleName>
      <description>role02- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role03</roleName>
      <description>role03- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
</roles>
~~~

##### JSON Request


##### JSON Response

~~~
{"roles": {"role": [
      {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role01",
      "description": "role01- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   }, {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role02",
      "description": "role02- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   }, {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role03",
      "description": "role03- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   },
]}
~~~

### **Get a Tenant **

Verb

URI

Description

**GET **

**[****HP*****KeystoneExtensionBaseURI******]/tenants/{tenantId}***** **

Get a tenant for the specified tenantId.

#### **Detailed Description**

*Get a tenant based on the {tenantId} specified. tenantId's are opaque
values returned with get tenant list operations. This operation does not
require a request body.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not found)

The Tenant for this tenantId does not exist.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*No additional query parameters required.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes through WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

No request body is required. The response of this call is the tenant
resourcefor the given tenantId, the schema for tenant can be found
[tenant.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/tenant.xsd).

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
GET /v2.0/HP-IDM/v1.0/tenants/48164969660120 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e9767412cdcb18069188479
Host: localhost:9999
Connection: keep-alive
~~~

##### JSON Response

~~~
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
~~~

### **Check for existence of tenant name **

Verb

URI

Description

**HEAD **

**[****HP*****KeystoneExtensionBaseURI******]/tenants?name=tenantName***** **

Returns http status code indicating the result of tenantName existence
check

#### **Detailed Description**

*This API does* ***case sensitive*** *tenantName lookup in system. It
returns http status code 200 (Ok) when provided tenantName exists and
returns 404 (not found) when provided tenantName is not found in the
system. If provided tenantName is blank or missing, then it returns 204
(No content).*
 *As this API just checks for existence of provided tenantName, it does
not do look into status (or any other entity attribute) for case when
matching tenant is found.*

*There is no response body returned in API response data. This API does
not require http header X-Auth-Token and is protected by client
certificate authentication.*

#### **Normal Response Codes**

**200** (OK) and **404** (NOT FOUND)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***204*** (No Content)

When tenantName is missing or blank

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*No additional query parameters required.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes through WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

#### **Example(s)**

##### XML/JSON Request and Response

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants?name=HP%20Cloud%20System%20Domain's-Tenant01 HTTP/1.1
Accept-Encoding: gzip,deflate


HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:29:46 GMT
~~~

##### XML/JSON Request and Response (case-insensitive lookup of above tenantName)

~~~
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
~~~

##### XML/JSON Request and Response (provided tenantName not found)

~~~
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
~~~

##### XML/JSON Request Response (missing tenantName in request)

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept-Encoding: gzip,deflate


HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 21 Aug 2012 19:32:10 GMT
~~~

### **Create a Tenant **

Verb

URI

Description

**POST **

**[****HP*****KeystoneExtensionBaseURI******]/tenants***** **

**Create a tenant**

#### **Detailed Description**

*Creates a tenant using the specified request body. The provided tenant
name MUST be unique in the system.  A response body is also returned
with the new tenant information with a service generated tenantId.*

#### **Normal Response Codes**

**201** (Created)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**409** (Conflict)

*If a Tenant with the name already exist in the system.*
 *If a Tenant with swift account hash already exist in the system.*

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional headers are required.*

#### **Query String Values**

*No additional query strings are required.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes as part of WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

The request of this call contain a tenant resource to be created, the
schema for tenant can be found
in [tenant.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/tenant.xsd). The
response of this call is the tenant created.

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### XML Request (with swift account hash)

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tenants HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e8394e2b0bedc2f5c932a0e
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 239

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenant xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" name="Time Warner Salesforce Services" tenantId="47884429830799" domainId="27960688482075" status="enabled">
  <description>Tenant for hosting Time Warner Salesforce Applications</description>
</tenant>
~~~

##### XML Response (with swift account hash)

~~~
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
~~~

##### JSON Request

~~~
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
    "description": "Payroll Tenant Services for TimeWarmer",
    "domainId": "47826457774667",
    "name": "Payroll Tenant Services",
    "status": "enabled"
  }
}
~~~

##### JSON Response

~~~
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
    "description": "Payroll Tenant Services for TimeWarmer",
    "domainId": "47826457774667",
    "name": "Payroll Tenant Services",
    "otherAttributes": {

    },
    "status": "enabled",
    "tenantId": "34159634776038"
  }
}
~~~

### **Update a Tenant **

Verb

URI

Description

**PUT**

**[****HP*****KeystoneExtensionBaseURI******]/tenants/{tenantID}***

**Update an existing tenant**

#### **Detailed Description**

*Allows updating an existing tenant using the tenantId and request body.
Does not allow update or change of tenantId and domainId. 'domainId'
cannot be updated so don't pass that in request body.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not found)

The Tenant for this tenantId does not exist.

**409** (Conflict)

*If a Tenant with the name already exist in the system.*
 *If another Tenant with provided swift account hash already exist in
the system.*

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header name and values required.*

#### **Query String Values**

#### 

*No additional query string values required.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes as part of WADL

XML

Yes

JSON

Yes

gzip

No

#### ***Request / Response Resource Representation Schema***

No request body is required.  The response of this call is the updated
Tenant, the schema for Tenant can be found in
 [tenant.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/tenant.xsd).

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### XML Request (with swift account hash)

~~~
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
~~~

##### XML Response (with swift account hash)

~~~
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
~~~

##### JSON Request

~~~
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
~~~

##### JSON Resoponse

~~~
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
~~~

### **Delete a Tenant **

Verb

URI

Description

 **DELETE**

**[****HP*****KeystoneExtensionBaseURI******]/tenants/{tenantID}***** **

Delete a tenant

#### **Detailed Description**

*Deletes the specified tenant by its tenantId. This API also deletes the
Roles and Endpoints associated with the Tenant.*

#### **Normal Response Codes**

**204** (No Content), Deletion of the Tenant was successful.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request.This error is also
returned when there is dependent data that needs to be removed as well.

**404** (Not found)

The Tenant for this tenantId does not exist.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header name and values required.*

#### **Query String Values**

#### 

*No additional query string values required.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

NA

XML

NA

JSON

NA

gzip

NA

#### ***Request / Response Resource Representation Schema***

No request body is required and no response body is provided.

#### **Example(s)**

##### XML Request

~~~
DELETE /v2.0/HP-IDM/v1.0/tenants/270316896886 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Thu, 11 Aug 2011 17:21:35 GMT
~~~

##### JSON Request


##### JSON Response


### Get Endpoints for a Tenant

Verb

URI

Description

**GET**

**[csbu:HPKeystoneExtensionBaseURI]/tenants/{tenantId}/endpoints?limit=pagesize&marker=endpointId**

Get a list of endpoints for a tenant.

#### **Detailed Description**

*Get a list of endpoints for a tenant. Each endpoint data in the
returned list has reference URL which can be used to query specific
endpointTemplate (i.e. in format
/endpointTemplates/{endpointTemplateId}) . **This list will include
disabled endpoint templates id. The operation does not require a request
body.*

*TenantId is required and mist be enabled in the system. This will not
include global endpoints which are available to all tenants in all
domains.*

*This API supports pagination through 'limit' and 'marker'
usage. **Marker is endpointId and should be valid otherwise 404 (not
found) error is going to be returned.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request.
 The Tenant for this tenantId is not enabled.

**404** (Not Found)

tenantId specified is not found.
 Invalid marker is provided (matching marker id not found in database)

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*NO additonal header values are required.*

#### **Query String Values**

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

*marker is endpointId*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 
[endpoints.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/endpoints.xsd)
[hp-ks-catalog.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/hp-ks-catalog.xsd)

#### **Example(s)**

##### Tenant Endpoints request for XML request and response body.

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

~~~
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
~~~

##### Tenant Endpoints request for JSON request and response body.

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e9605ffb0be70f2f7118b6a
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

~~~
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
~~~

### Add Endpoint to a Tenant

Verb

URI

Description

**POST**

**[csbu:HPKeystoneExtensionBaseURI]/tenants/{tenantId]}/endpoints**

Add an endpoint to a tenant.

#### **Detailed Description**

*Add endpoint template association with a tenant. *

#### **Normal Response Codes**

**201** (Created)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

tenantId specified was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

No additional query values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes in WADL

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 
[endpoints.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/endpoints.xsd)
[hp-ks-catalog.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/hp-ks-catalog.xsd)

#### **Example(s)**

##### Add request for XML request and response body.

~~~
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
~~~

~~~
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
~~~

##### Add request for JSON request and response body.

~~~
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
~~~

~~~
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
~~~

### Remove Endpoints from a Tenant

Verb

URI

Description

**DELETE**

**[csbu:HPKeystoneExtensionBaseURI]/tenants/{tenantId}/endpoints/{endpointId]}**

Remove endpoint from a tenant.

#### **Detailed Description**

*Remove tenant's endpoint template association for given endpoint id.*
*The operation does not require a request body.*

#### **Normal Response Codes**

**204** (No Content), Deletion of the Tenant was successful.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not found)

The Tenant for this tenantId does not exist.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

No additional query values required.

#### **Request and Response Resource Representations**

*No content is expected in request and response body.*

#### **Example(s)**

~~~
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/tenants/95096564413950/endpoints/543 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e960db7b0bea9987b8d550b
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=74ADEBA6F2523478A1700D664FD70C75; Path=/v2.0; Secure
Date: Wed, 12 Oct 2011 22:02:16 GMT
~~~
