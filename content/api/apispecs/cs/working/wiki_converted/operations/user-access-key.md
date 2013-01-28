---
title: User Access Key Operations

---

### **Get User Access Keys**

Verb

URI

Description

**GET **

**[HPKeystoneExtensionBaseURI]/accesskeys?domainId=value&export=[true|csbu:false]&
status=[*****active|csbu:inactive|expired|revoked|deleted|purged]&userId=value&*****pagesize=value&marker=accesskeyId**

Get user access keys

#### **Detailed Description**

*Allows reading a list of selected keys. This API supports pagination
through 'limit' and 'marker' usage.*

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Comments

**400** (Bad Request)

*Malformed request in URI or request body*

**401 **(Unauthorized)

*The caller does not have the privilege required to perform the
operation*

**403** (Forbidden)

*Disabled or suspended user* making the request

**404** (Not Found)

Specified domainId or userId not found

**413** (Over Limit)

pagesize requested is over maximum allowed limit

**500 **(Internal Server Error)

The server encountered a problem while processing the request

**503 **(Service Unavailable)

The server is unavailable to process the request

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

'limit' and 'marker' values. See** ****[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")****.**

*Parameter*

*Required*

*Description*

*domainId*

*false*

* Domain identifier.*

*export*

*false*

* Export secret key value. One of {true,false}. Default is false.*

*status*

*false*

* Key status. One of {active, inactive, expired, revoked, deleted,
purged}.*

*userId*

*false*

* User identifier to select keys for a specific user. If not specified
the userId of the requester is used.*

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

#### ***Request / Response Resource Representation Schema***

*No request body is required. The response body consists of an
accessKeys object.*

[accessKey.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/accessKey.xsd)

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e699292e4b0a8f279022d4d
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
~~~

##### JSON Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7b71f5e4b0600fec3d2a20
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### JSON Response

~~~
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
~~~

### **Get A User Access Key**

Verb

URI

Description

**GET **

**[HPKeystoneExtensionBaseURI]/accesskeys/{accesskeyId}?****export=[true|csbu:false]&userId=value**

Get a user access key

#### **Detailed Description**

*Get a specific user access key. 'export' and 'userId' query parameters
are optional.*

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Comments

**400** (Bad Request)

*Malformed request in URI or request body*

**401 **(Unauthorized)

*The caller does not have the privilege required to perform the
operation*

**403** (Forbidden)

*Disabled or suspended user* making the request

**404 **(Not Found)

Specified domainId or userId not found

**500 **(Internal Server Error)

The server encountered a problem while processing the request

**503 **(Service Unavailable)

The server is unavailable to process the request

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*export*

*false*

* * *Export secret key. One of {true,false}. Default is false.*

*userId*

*false*

* * *UserId of the access key owner. If not specified then defaults to
userId of the requester.*

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

#### ***Request / Response Resource Representation Schema***

*No request body is required. The response body consists of an accessKey
object.*

[accessKey.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/accessKey.xsd)

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/3D76NSUB49C96DFBRUF9?export=false HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e699292e4b0a8f279022d4d
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
Set-Cookie: JSESSIONID=34C3B7E6EC0F9035A75BD4A0CF6CAC37; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 415
Date: Fri, 09 Sep 2011 04:15:42 GMT

<accessKey accessKeyId="3D76NSUB49C96DFBRUF9" userId="000000003002" domainId="000000001001" status="deleted" validFrom="2011-09-08T15:19:10.000-07:00" validTo="2021-09-05T15:19:10.000-07:00" createdOn="2011-09-08T15:19:10.378-07:00" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
   <algorithm>HmacSHA1</algorithm>
   <keyLength>64</keyLength>
</accessKey>
~~~

##### JSON Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/V7TEGGSZZ4NJK9UR4UFE?export=true HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bc0d2e4b0600fec3d2a4a
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### JSON Response

~~~
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
~~~

### **Import User Access Key(s)**

Verb

URI

Description

PUT 

**[HPKeystoneExtensionBaseURI]/accesskeys**

Import user access key(s)

#### **Detailed Description**

*Import user access key(s). The operation requires a request body
containing the user access key(s).*

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Comments

**400** (Bad Request)

*Malformed request in URI or request body*

**401 **(Unauthorized)

*The caller does not have the privilege required to perform the
operation*

**403** (Forbidden)

*Disabled or suspended user* making the request

**404 **(Not Found)

Specified domainId or userId not found

**409 **(Conflict)

An access key already exists with the specified access key identifier.

**500 **(Internal Server Error)

The server encountered a problem while processing the request

**503 **(Service Unavailable)

The server is unavailable to process the request

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Path Variables**

*No path variables required in the URI.*

#### **Query String Values**

*No additional query string values.*

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

#### ***Request / Response Resource Representation Schema***

*The request body contains an accessKeys object containing one or more
accessKey objects. Each accessKey object within the body must contain
the userId, secretKey, and algorithm. All other attributes and elements
of the accessKey objects are optional. The response body consists of an
accessKeys object.*

[accessKey.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/accessKey.xsd)

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
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
~~~

##### JSON Response

~~~
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
~~~

### **Create User Access Key**

Verb

URI

Description

**POST **

**[HPKeystoneExtensionBaseURI]/accesskeys**

Create user access key

#### **Detailed Description**

*Create a user access key. The operation requires a request body
containing a template for the new access key. *

#### **Normal Response Codes**

**201** (Created)

#### **Error Response Codes**

HTTP Status Code

Comments

**400** (Bad Request)

*Malformed request in URI or request body*

**401 **(Unauthorized)

*The caller does not have the privilege required to perform the
operation*

**403** (Forbidden)

*Disabled or suspended user* making the request

**500 **(Internal Server Error)

The server encountered a problem while processing the request

**503 **(Service Unavailable)

The server is unavailable to process the request

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*No additional query string values.*

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

#### ***Request / Response Resource Representation Schema***

*The request body contains an accessKey object.  The attributes and
elements of the accessKey object are optional. However, the root element
accessKey must be present. The response body contains the created
accessKey object including the secret key.*

[accessKey.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/accessKey.xsd)

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
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
       }}
~~~

##### JSON Response

~~~
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
~~~

### **Update A User Access Key**

Verb

URI

Description

**PUT **

**[HPKeystoneExtensionBaseURI]/accesskeys/{accesskeyId}?userId=value**

Update user access key

#### **Detailed Description**

*Update a user access key. This method may be used to modify the key
status only.*

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Comments

**400** (Bad Request)

*Malformed request in URI or request body*

**401 **(Unauthorized)

*The caller does not have the privilege required to perform the
operation*

**403** (Forbidden)

*Disabled or suspended user* making the request

**404 **(Not Found)

Specified userId not found

**500 **(Internal Server Error)

The server encountered a problem while processing the request

**503 **(Service Unavailable)

The server is unavailable to process the request

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*userId*

*false*

* * *UserId of the access key owner. If not specified then defaults to
userId of the requester.*

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

#### ***Request / Response Resource Representation Schema***

*The request body contains an accessKey object. The status attribute is
required in the accessKey object. All other attributes and elements of
the accessKey object are ignored. The response body contains the updated
accessKey object. The secret key value is not returned in the updated
accessKey object.*

[accessKey.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/accessKey.xsd)

#### **Example(s)**

##### XML Request

~~~
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
~~~

##### XML Response

~~~
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
~~~

##### JSON Request

~~~
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
~~~

##### JSON Response

~~~
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
~~~

### **Delete User Access Key**

Verb

URI

Description

**DELETE **

**[HPKeystoneExtensionBaseURI]/accesskeys/{accesskeyId}?userId=value**

Delete a user access key

#### **Detailed Description**

*Delete a user access key.*

#### **Normal Response Codes**

**204** (No Content)

#### **Error Response Codes**

HTTP Status Code

Comments

**400** (Bad Request)

*Malformed request in URI or request body*

**401 **(Unauthorized)

*The caller does not have the privilege required to perform the
operation*

**403** (Forbidden)

*Disabled or suspended user* making the request

**404 **(Not Found)

Specified accesskeyId or userId not found

**500 **(Internal Server Error)

The server encountered a problem while processing the request

**503 **(Service Unavailable)

The server is unavailable to process the request

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

*Parameter*

*Required*

*Description*

*userId*

*false*

* * *UserId of the access key owner. If not specified then defaults to
userId of the requester.*

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

#### ***Request / Response Resource Representation Schema***

*No request body is required. No response body is returned.*

[accessKey.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/accessKey.xsd)

#### **Example(s)**

##### XML Request

~~~
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/9L47KGME4ZKCH9YRWDY7 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_4e699292e4b0a8f279022d4d
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### XML Response

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=7F457E3037CCB2DEC6C33D408F544EA8; Path=/v2.0; Secure
Date: Fri, 09 Sep 2011 04:25:47 GMT
~~~

##### JSON Request

~~~
DELETE https://localhost:8443/v2.0/HP-IDM/v1.0/accesskeys/RVWVEGE88EHZBSBMJZ94 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_4e7bb370e4b0600fec3d2a34
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### JSON Response

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=90D365930EDDB20FF49CC2DDA4B7C925; Path=/v2.0; Secure
Date: Thu, 22 Sep 2011 22:15:42 GMT
~~~
