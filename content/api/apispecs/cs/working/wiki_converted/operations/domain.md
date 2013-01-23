---  
title: Domain Operations

---  

### **Get All Domains **

Verb

URI

Description

**GET** 

**[HP*****KeystoneExtensionBaseURI]/domains?limit=pagesize&marker=domainId ***

Get a list of all domains

#### **Detailed Description**

*Allows reading a list of all* *domains**. This API supports pagination
through 'limit' and 'marker' usage. The returned list may be filtered to
allow only those* *domains** which the caller has access to. The
operation does not require a request body.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and marker query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters").

name : used to filter the response based on domain Name

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

[domain.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domain.xsd).

No request body is required. The call returns a list of domains.

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/domains/ HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Request using domain name filter

~~~
GET /v2.0/HP-IDM/v1.0/domains?name=domainName HTTP/1.1
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
Content-Length: 8101
Date: Tue, 09 Aug 2011 22:37:55 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domains  xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0">
  <domain phone="1-800-555-1212" website="http://www.pepsi.com" zip="89072" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" emailAddress="johndoe@papsi.com" name="johndoe@papsi.com-DOMAIN" domainId="798477662343" enabled="false">
    <owners>
      <owner userid="1234" />
    <owners>
  </domain>
  <domain phone="1-800-555-1212" website="http://www.timewarner.com" zip="90210" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" emailAddress="janedoe@timewarner.com" name="janedoe@timewarner.com-DOMAIN" domainId="980913511718" enabled="false">        <owners>
      <owner userid="1234" />
    <owners>  </domain>
 </domains>
~~~

##### JSON Request

~~~
GET /v2.0/HP-IDM/v1.0/domains?limit=5&marker=27816755664144 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8398232cdcb4bf5faa76be
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
Content-Length: 2604
Date: Wed, 28 Sep 2011 21:59:19 GMT

{
  "domains": {
    "anies": null,
    "domain": [
      {
        "owners" : {
           "owner" : [ {
              "userId" : "69863947948962"
         } ]
       },
        "anies": null,
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": null,
        "domainId": "42225450901234",
        "emailAddress": "adduser?group5&@timewarner.com",
        "name": "adduser?group5&@timewarner.com-DOMAIN",
        "otherAttributes": {

        },
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "website": null,
        "zip": "90210"
    },
      },
      {
        "owners" : {
           "owner" : [ {
             "userId" : "69863947948962"
         } ]
        },
        "anies": null,
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": null,
        "domainId": "63090516876965",
        "emailAddress": "Xml?User8&@timewarner.com",
        "name": "Xml?User8&@timewarner.com-DOMAIN",
        "otherAttributes": {

        },
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "website": "http://www.timewarner.com",
        "zip": "90210"

     },
      {
        "owners" : {
          "owner" : [ {
          "userId" : "69863947948962"
          } ]
        },
        "anies": null,
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": null,
        "domainId": "69825394025278",
        "emailAddress": "adduser?group4@timewarner.com",
        "name": "adduser?group5@timewarner.com-DOMAIN",
        "otherAttributes": {

        },
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "website": null,
        "zip": "90210"
      },
      {
       "owners" : {
           "owner" : [ {
             "userId" : "69863947948962"
            } ]
          },
       "anies": null,
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": null,
        "domainId": "75076269797468",
        "emailAddress": "adduser2group2@timewarner.com",
        "name": "adduser2group2@timewarner.com-DOMAIN",
        "otherAttributes": {

        },
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "website": null,
        "zip": "90210"
      },
      {
        "owners" : {
            "owner" : [ {
            "userId" : "69863947948962"
          } ]
        },
       "anies": null,
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": null,
        "domainId": "85999238988890",
        "emailAddress": "adduser2group@timewarner.com",
        "name": "adduser2group@timewarner.com-DOMAIN",
        "otherAttributes": {

        },
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "website": null,
        "zip": "90210"
      }
    ],
    "otherAttributes": {

    }
  }
}
~~~

### **Get a Domain **

Verb

URI

Description

**GET** 

**[HP*****KeystoneExtensionBaseURI]/domains/{domainId}***

Get a Domain.

#### **Detailed Description**

*Get a domain based on the {domainId} specified. DomainId's are opaque
values returned with get domain list operations. This operation does not
require a request body.*

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

The Domain for domainId does not exist.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

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

#### Request and response schema,  XML Schema Definition 

[domain.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domain.xsd).

No request body is required.

The call returns the Domain resource for the specified domainId.

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/81132865245171 HTTP/1.1GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/63283648950838 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
X-Auth-Token: HPAuth_5032ad14957cb3caab6c33eb
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 719
Date: Mon, 20 Aug 2012 23:06:39 GMT

<domain domainId="63283648950838" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled" billingId="4028e69737163f4e013732dc605210ba" contactId="001Q000000TU4q4IAD" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <description>Hp's Private Cloud Domain</description>
</domain>
~~~

##### JSON Request

~~~
GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/63283648950838 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
X-Auth-Token: HPAuth_5032ad14957cb3caab6c33eb
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 603
Date: Mon, 20 Aug 2012 23:07:59 GMT

{
  "domain" : {
    "description" : "Hp's Private Cloud Domain",
    "anies" : null,
    "addressLine1" : "1, HP Way",
    "addressLine2" : null,
    "billingId" : "4028e69737163f4e013732dc605210ba",
    "city" : "Cupertino",
    "company" : "HP",
    "contactId" : "001Q000000TU4q4IAD",
    "country" : "USA",
    "domainId" : "63283648950838",
    "emailAddress" : "hp-private-cloud-6@hp.com",
    "name" : "HP Private Cloud Domain",
    "otherAttributes" : {
    },
    "phone" : "1-888-555-1212",
    "state" : "CA",
    "status" : "enabled",
    "website" : "www.hp.com",
    "zip" : "90210"
  }
}
~~~

### **Check for existence of domain name **

Verb

URI

Description

**HEAD** 

**[HP*****KeystoneExtensionBaseURI]/domains?name=domainName***

Returns http status code indicating the result of domainName existence
check.

#### **Detailed Description**

This API does **case sensitive** domainName lookup in system. It returns
http status code 200 (Ok) when provided domainName exists and returns
404 (not found) when provided domainName is not found in the system. If
provided domainName is blank or missing, then it returns 204 (No
content).
 As this API just checks for existence of provided domainName, it does
not do look into status (or any other entity attribute) for case when
matching domain is found.

There is no response body returned in API response data. *This API does
not require http header X-Auth-Token and is protected by client
certificate authentication.*

#### **Normal Response Codes**

**200** (OK) and **404** (NOT FOUND)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***204*** (No Content)

When domainName is missing or blank

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the operation.*

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

#### Request and response schema,  XML Schema Definition 

#### **Example(s)**

##### XML/JSON Request and Response

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=domain_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml


HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:15:56 GMT
~~~

##### XML/JSON Request and Response (case-insensitive lookup of above domainName)

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json


HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 19:17:00 GMT
~~~

##### XML/JSON Request and Response (provided domainName not found)

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json


HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Content-Type: text/html;charset=utf-8
Content-Length: 952
Date: Tue, 21 Aug 2012 19:17:43 GMT
~~~

##### XML/JSON Request and Response (missing domainName in request)

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json


HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Date: Tue, 21 Aug 2012 19:18:23 GMT
~~~

### **Create a Domain **

Verb

URI

Description

**POST **

**[HP*****KeystoneExtensionBaseURI]/domains***

Create a domain

#### **Detailed Description**

*Creates a domain using the specified request body. A response body is
also returned with the new domain information with a service generated
domainId.*

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

The Domain for domainId does not exist.

409 (Identity Fault)

A Domain with the required parameters already exist in the system.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

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

#### Request and response schema,  XML Schema Definition 

[domain.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domain.xsd).

The request body defines the request for the new domain.

The response is the created Domain including the new domainId.

#### **Example(s)**

##### XML Request

~~~
POST /v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f47d0b12cdc8b1c3905dbda
Host: localhost:9999
Connection: keep-alive
Content-Length: 617

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled">
  <description>Hp's Private Cloud Domain</description>
</domain>
~~~

##### XML Response

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 643
Date: Fri, 24 Feb 2012 18:02:43 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" domainId="80354991891807" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled">
  <description>Hp's Private Cloud Domain</description>
</domain>
~~~

##### JSON Request

~~~
POST /v2.0/HP-IDM/v1.0/domains HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ec1a58d2cdce1fe0e8ce8cb
Host: localhost:9999
Connection: keep-alive
Content-Length: 318

{
  "domain": {
    "addressLine1": "128, Market Blvd",
    "city": "San Francisco",
    "country": "USA",
    "description": "See's Candies Domain",
    "emailAddress": "owner@sees.com",
    "name": "Sees Candies",
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "website": "www.sees.com",
    "zip": "90210"
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
Content-Length: 495
Date: Mon, 14 Nov 2011 23:59:08 GMT

{
  "domain" : {
    "description" : "See's Candies Domain",
    "anies" : null,
    "addressLine1" : "128, Market Blvd",
    "addressLine2" : null,
    "city" : "San Francisco",
    "company" : null,
    "country" : "USA",
    "domainId" : "50277849949620",
    "emailAddress" : "owner@sees.com",
    "name" : "Sees Candies",
    "otherAttributes" : {
    },
    "phone" : "1-800-555-1212",
    "state" : "CA",
    "status" : "enabled",
    "website" : "www.sees.com",
    "zip" : "90210"
  }
}
~~~

### **Update a Domain **

Verb

URI

Description

**PUT**

**[HP*****KeystoneExtensionBaseURI]/domains/{domainId}***

Update an existing domain

#### **Detailed Description**

*Allows update of an existing domain using the {domainId} and request
body. Does not allow update or change of domainID.*

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

**404** (Not Found)

The Domain for domainId does not exist.

**409** (Identity Fault)

A Domain with the required parameters already exist in the system.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header name and values required.*

#### **Query String Values**

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

#### Request and response schema,  XML Schema Definition 

[domain.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domain.xsd).

The request requires the updated Domain resource.

The response is the updated Domain resource.

#### **Example(s)**

##### XML Request

~~~
PUT /v2.0/HP-IDM/v1.0/domains/26856794720485 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ef385b32cdc64f2eead137c
Host: localhost:9999
Connection: keep-alive
Content-Length: 384

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" phone="1-800-NO-DISNEY" addressLine2="Studio Lanes"/>
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 508
Date: Thu, 22 Dec 2011 19:51:00 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" domainId="26856794720485" name="action-king-DOMAIN" emailAddress="actionking@hp.com" addressLine2="Studio Lanes" company="action-king" phone="1-800-NO-DISNEY" status="enabled"/>
~~~

##### JSON Request

~~~
PUT /v2.0/HP-IDM/v1.0/domains/91177319722637 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e83a4532cdcb4bf5faa76ce
Host: localhost:9999
Connection: keep-alive
Content-Length: 40

{
  "domain": {
    "phone": "1-800-NO-DISNEY"
  }
}
~~~

##### JSON Resoponse

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 461
Date: Wed, 28 Sep 2011 22:49:56 GMT


{
  "domain" : {
    "anies" : null,
    "addressLine1" : "128, Hollywood Blvd",
    "addressLine2" : null,
    "city" : "Los Angeles",
    "company" : null,
    "country" : "USA",
    "domainId" : "91177319722637",
    "emailAddress" : "owner@timewarner.com",
    "name" : "Time Warner Inc",
    "otherAttributes" : {
    },
    "phone" : "1-800-NO-DISNEY",
    "state" : "CA",
    "status" : "enabled",
    "website" : "Time Warner",
    "zip" : "90210"
  }
}
~~~

### **Delete a Domain **

Verb

URI

Description

 **DELETE**

**[HP*****KeystoneExtensionBaseURI]/domains/{domainId}***** **

Delete a domain

#### **Detailed Description**

*Deletes the specified domain by its {domainID}. This API deletes the
Users, Tenants, Groups, Roles, RoleRefs and Grants associated to the
Domain.*

#### **Normal Response Codes**

**204** (No Content) Deletion of the Domain was successful.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the
operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request. This error is also
returned when there is dependent data that needs to be removed as well.

**404** (Not Found)

The Domain for domainId does not exist.

**409** (Identity Fault)

A Domain with the required parameters already exist in the system.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header name and values required.*

#### **Query String Values**

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

#### Request and response schema,  XML Schema Definition 

[domain.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domain.xsd).

No request body is required.

#### **Example(s)**

##### XML Request

~~~
DELETE /v2.0/HP-IDM/v1.0/domains/577301946908 HTTP/1.1
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
Date: Wed, 10 Aug 2011 00:03:44 GMT
~~~

##### JSON Request

~~~
DELETE /v2.0/HP-IDM/v1.0/domains/91177319722637 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e83b0642cdc31677a2f445b
Host: localhost:9999
Connection: keep-alive
~~~

##### JSON Response

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=617301A5D3233CCB7FBE07E2FE62FC8F; Path=/v2.0
Date: Wed, 28 Sep 2011 23:44:13 GMT
~~~

### **Get Users for a Domain **

Verb

URI

Description

**GET**

**[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/users?limit=pagesize&marker=userId&excludeGroups=groupid1,groupdid2&excludeRoles=roleId1,roleId2&userId=userId&userName=userName&excludeTenantId=tenantid1,tenantId2**

Returns all Users for a Domain

#### **Detailed Description**

This API returns all users of a {domainId} .  The Api results can be
filtered using filters which are nothing but query parameters.

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

**404** (Not Found)

The specified domainId or userId within the marker was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")****.**

Inclusion-Filters : userId, userName.   Inclusion filters are always
mutually exclusive

Exclusion-Filters :  excludeRoles, excludeGroups, excludeTenantId

excludeGroups : List of group Ids to be excluded. This should be
separated by ","

excludeRoles :  List of role Names  to be excluded. This should be
separated by ","

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

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/user.xsd).

No request body is required.

The response is a list of all user resources for the specified domain.

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/domains/798477662343/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Request with  filter

~~~
GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?excludeGroups=000002002,000002001 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Request with userId filter

~~~
GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?userId=12345 HTTP/1.1
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
Content-Length: 822
Date: Wed, 10 Aug 2011 19:35:24 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
  <user domainId="798477662343" status="enabled" isDomainOwner="true" emailAddress="johndoe@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="627893056455" username="johndoe@papsi.com" name="John Doe"/>
  <user domainId="798477662343" status="enabled" emailAddress="amymiller@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="968754602297" username="amymiller@papsi.com" name="Amy Miller"/>
</users>
~~~

##### JSON Request

~~~
GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
Host: localhost:9999
Connection: keep-alive
~~~

##### JSON Request with excludeRoles

~~~
GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users?excludeRoles=RoleId1, RoleId2 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
Host: localhost:9999
Connection: keep-alive
~~~

##### JSON Request with excludeGroups

~~~
GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users?excludeGroups=GroupId1,GroupId22 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
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
Content-Length: 716
Date: Wed, 05 Oct 2011 21:37:04 GMT

{
  "users" : {
    "anies" : null,
    "otherAttributes" : {
    },
    "user" : [ {
      "roles" : null,
      "addressLine1" : "128, Hollywood Blvd",
      "addressLine2" : null,
      "city" : "Los Angeles",
      "company" : null,
      "country" : "USA",
      "domainId" : "53615830984009",
      "emailAddress" : "larryking@timewarner.com",
      "firstName" : "Larry",
      "lastName" : "King",
      "otherAttributes" : {
      },
      "password" : null,
      "phone" : "1-800-555-1212",
      "state" : "CA",
      "status" : "enabled",
      "userId" : "27000063617046",
      "username" : "larryking@timewarner.com",
      "website" : "http://www.timewarner.com",
      "zip" : "90210"
    } ]
  }
}
~~~

### **Get Tenants for a Domain **

Verb

URI

Description

**GET**

**[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/tenants?limit=pagesize&marker=tenantId**

Returns all tenants for a domain

#### **Detailed Description**

This REST API returns all tenants of a {domainId} and takes a "marker"
and "limit" parameter to limit the number of Tenants in the response.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

The specified domainId or tenantId within the marker was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

'limit' and 'marker' values. See** ****[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")****.**


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

[tenant.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/tenant.xsd).

No request body is required.

The response is a list of tenant resources for the domain. 

#### **Example(s)**

##### XML Request

~~~
GET /V2.0/HP-IDM/v1.0/domains/798477662343/tenants HTTP/1.1
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
Content-Length: 525
Date: Tue, 16 Aug 2011 21:24:54 GMT

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<tenants xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"
xmlns:ns2="http://www.w3.org/2005/Atom"
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0">
  <tenant status="enabled" domainId="798477662343"
  tenantId="842515505915"
  description="Tenant for Sales service"
  name="Forecasting Tenant" />
  <tenant status="enabled" domainId="798477662343"
  tenantId="225260164476"
  description="Tenant for Forecasting service"
  name="Sales Tenant" />
</tenants>
~~~

##### JSON Request

~~~
GET /v2.0/HP-IDM/v1.0/domains/29649421790262/tenants HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
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
Content-Length: 367
Date: Fri, 07 Oct 2011 22:45:44 GMT

{
  "tenants": {
    "anies": null,
    "otherAttributes": {

    },
    "tenant": [
      {
        "description": "Tenant for hosting Time Warner Applications & services",
        "domainId": "29649421790262",
        "name": "Time Warner Tenant Services",
        "otherAttributes": {

        },
        "status": "enabled",
        "tenantId": "96488406679080"
      }
    ]
  }
}
~~~

### **Get Subscribable Services for a Domain **

Verb

URI

Description

**GET**

**[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/subscribeableServices?serviceName={serviceName}&endpointTemplateId={templateId}**

Returns the list of subscribe able services for the domain.
 Filters the result with  optional serviceName or endpoint templateId

#### **Detailed Description**

This API returns all subscribe able services that are available for the
given {domainId} . It can also filter the result based on service name
or endpoint template id. In request, either 'serviceName' filter or
'serviceEndpointId' filter is to be used. If both of filter values are
provided, then error is returned back. This is essentially endpoint
template data with some additional subscription specific attributes.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body.*
 *If present, non-numeric endpoint template id is provided.*
 *If present, invalid endpoint template id is provided.*
 *If present, invalid service name is provided.*
 *If both serviceName and endpointTemplateId values are provided.*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

The specified domain Id is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

'serviceName**'** (optional request parameter) : Use service name if
need to get subscrible data for all endpoints within that service.
 'endpointTemplateId**'** (optional request parameter) : User endpoint
template Id to get specific endpoint subscrible able data

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

[hp-services.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/hp-services.xsd).

No request body is required.

The response is a list of subscribe able services for the domain.
Results are filtered by serviceName if serviceName is provided. Result
will include single subscribe able service as identified endpoint
template id if its provided in query.

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/64521341789596/subscribeableServices HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f46a309b0bebb59e36f663f
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=4ADA3703B5E45F3C198E4E4F0CC9A4D8; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 5128
Date: Thu, 23 Feb 2012 20:37:58 GMT

<subscribeableServices xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="100" type="compute" name="Compute" region="az-1.region-a.geo-1" publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
      <subscribedInfo subscribedOn="2011-10-21T22:04:11.000Z" tenantId="36733265821255" status="deleted"/>
      <subscribedInfo subscribedOn="2011-10-21T22:05:43.000Z" tenantId="79402136023481" status="enabled"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="110" type="compute" name="Compute" region="az-2.region-a.geo-1" publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="111" type="compute" name="Compute" region="az-3.region-a.geo-1" publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" id="120" type="object-store" name="Object Storage" region="region-a.geo-1" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/" global="false" enabled="true">
      <version id="1.0"/>
      <subscribedInfo subscribedOn="2011-10-25T20:51:49.000Z" tenantId="72290583996765"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="130" type="identity" name="Identity" region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" global="true" enabled="true">
      <version id="2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/extension"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="140" type="hpext:block-store" name="Block Storage" region="az-1.region-a.geo-1" publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="141" type="hpext:block-store" name="Block Storage" region="az-2.region-a.geo-1" publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="142" type="hpext:block-store" name="Block Storage" region="az-3.region-a.geo-1" publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
      <version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
   </subscribeableService>
   <subscribeableService releaseState="preview" endpointReleaseState="public" canSubscribe="false" id="150" type="hpext:cdn" name="CDN" region="region-a.geo-1" publicURL="https://region-a.geo-1.cdnmgmt.hpcloudsvc.com/v1.0/" global="false" enabled="true">
      <version id="1.0"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="160" type="image" name="Image Management" region="az-1.region-a.geo-1" adminURL="https://glance1.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
      <version id="1.0"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="170" type="image" name="Image Management" region="az-2.region-a.geo-1" adminURL="https://glance2.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
      <version id="1.0"/>
   </subscribeableService>
   <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="180" type="image" name="Image Management" region="az-3.region-a.geo-1" adminURL="https://glance3.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
      <version id="1.0"/>
   </subscribeableService>
</subscribeableServices>
~~~

##### JSON Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/64521341789596/subscribeableServices?serviceName=Compute HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4f46a309b0bebb59e36f663f
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### JSON Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=3A6DB83BC61CEEE95C029AE81BEEAABF; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 2614
Date: Thu, 23 Feb 2012 20:41:44 GMT

{
  "subscribeableServices" : {
    "anies" : null,
    "otherAttributes" : {
    },
    "subscribeableService" : [ {
      "adminURL" : "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
      "anies" : null,
      "canSubscribe" : true,
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
      "endpointReleaseState" : "public",
      "subscribedInfo" : [ {
        "status": "deleted",
        "subscribedOn" : "2011-10-21T22:04:11.000Z",
        "tenantId" : "36733265821255"
      }, {
        "status": "enabled",
        "subscribedOn" : "2011-10-21T22:05:43.000Z",
        "tenantId" : "79402136023481"
      } ],
      "type" : "compute",
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      }
    }, {
      "adminURL" : "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
      "anies" : null,
      "canSubscribe" : true,
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
      "endpointReleaseState" : "public",
      "type" : "compute",
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      }
    }, {
      "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
      "anies" : null,
      "canSubscribe" : true,
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
      "endpointReleaseState" : "public",
      "type" : "compute",
      "version" : {
        "id" : "1.1",
        "info" : null,
        "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
        "otherAttributes" : {
        }
      }
    } ]
  }
}
~~~

### **Get Service Activations for a Domain **

Verb

URI

Description

**GET**

**[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/services?tenantId={tenantId}**

Returns the list of activated services for the domain.
 Filters the result with  optional tenantId

#### **Detailed Description**

This API returns all services that have been activated for the given
{domainId} . It can also filter the result based on tenantId. 

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

**404** (Not Found)

The specified domainId or tenantId is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

'tenantId**'** (optional request parameter)

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

#### **Open Issues**

None.

#### ***Preconditions & Default Behavior***

None.

#### Request and response schema,  XML Schema Definition 

[hp-services.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/hp-services.xsd).

No request body is required.

The response is a list of activated services for the domain (filtered by tenantId if tenantId is provided)

#### **Example(s)**

##### XML Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/23268133247776/services HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ea802a5b0be7e989230032e
Accept: application/xml
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
Set-Cookie: JSESSIONID=12934DBA01E8E9F9A3E783F34C75F700; Path=/; Secure
Content-Type: application/xml
Content-Length: 894
Date: Wed, 26 Oct 2011 13:20:14 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<activatedServices xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" 
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" 
xmlns:ns4="http://docs.openstack.org/common/api/v1.0" 
xmlns:ns5="http://www.w3.org/2005/Atom">
<activatedService serviceName="Compute" serviceType="compute" region="az-1.region-a.geo-1" subscribedOn="2011-10-25T20:50:13.000Z" tenantId="35871429575842" status="enabled"/>
<activatedService serviceName="Compute" serviceType="compute" region="az-2.region-a.geo-1" subscribedOn="2011-10-25T20:50:28.000Z" tenantId="35871429575842" status="enabled"/>
<activatedService serviceName="Object Storage" serviceType="object-store" region="region-a.geo-1" subscribedOn="2011-10-25T20:51:49.000Z" tenantId="90260810095453" status="enabled"/>
</activatedServices>
~~~

##### JSON Request

~~~
GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/23268133247776/services?tenantId=35871429575842 HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ea802a5b0be7e989230032e
Accept: application/json
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
Content-Length: 686
Date: Wed, 26 Oct 2011 13:14:07 GMT

{
  "activatedServices" : {
    "anies" : null,
    "activatedService" : [ {
      "id" : null,
      "otherAttributes" : {
      },
      "region" : "az-1.region-a.geo-1",
      "serviceName" : "Compute",
      "serviceType" : "compute",
      "status" : "enabled",
      "subscribedOn" : "2011-10-25T20:50:13.000Z",
      "tenantId" : "35871429575842"
    }, {
      "id" : null,
      "otherAttributes" : {
      },
      "region" : "az-2.region-a.geo-1",
      "serviceName" : "Compute",
      "serviceType" : "compute",
      "status" : "enabled",
      "subscribedOn" : "2011-10-25T20:50:28.000Z",
      "tenantId" : "35871429575842"
    } ],
    "otherAttributes" : {
    }
  }
}
~~~

### **Transfer Ownership of a Domain **

Verb

URI

Description

**PUT**

**[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/owner/{userId}**

Transfer ownership of a Domain

#### **Detailed Description**

A Domain has a owner, it is usually the first user of the Domain or the
self registered user during the self registration process. This REST API
transfers the domain ownership from one valid User of that Domain to
another valid User of the Domain. 

{domainId} is the "domanId" of the Domain for which the ownership
transfer should happen.

{userId} is the "userId" of the new owner of the Domain.

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

**404** (Not Found)

The specified domainId or userId was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

*No additional header values required.*

#### **Query String Values**

None.

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

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/user.xsd).

No request body is required.

The response is the user who is the new owner of the domain.

#### **Example(s)**

#### 

##### XML Request

~~~
PUT /v2.0/HP-IDM/v1.0/domains/662648896689/owner/129024620458 HTTP/1.1
Accept: application/xml
account_id: 000000003001
Content-Type: application/xml
domain_id: 000000001001
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
Content-Length: 437
Date: Tue, 30 Aug 2011 00:06:02 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" name="Tom Riddle" username="tomriddle@timewarner.com" userId="129024620458" addressLine1="128, Hollywood Blvd" city="Los Angeles" state="CA" country="USA" zip="90210" phone="1-800-555-1212" website="http://www.timewarner.com" emailAddress="tomriddle@timewarner.com" status="enabled" domainId="662648896689"/>
~~~

##### JSON Request

~~~
PUT /v2.0/HP-IDM/v1.0/domains/29649421790262/owner/60414337132139 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
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
Content-Length: 603
Date: Fri, 07 Oct 2011 22:55:55 GMT

{
  "user": {
    "roles": null,
    "addressLine1": "128, Hollywood Blvd",
    "addressLine2": null,
    "city": "Los Angeles",
    "company": null,
    "country": "USA",
    "domainId": "29649421790262",
    "emailAddress": "larryking3@timewarner.com",
    "firstName": "Larry",
    "lastName": "King III",
    "otherAttributes": {

    },
    "password": null,
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "userId": "60414337132139",
    "username": "larryking3@timewarner.com",
    "website": "http://www.timewarner.com",
    "zip": "90210"
  }
}
~~~

**Get Groups For a Domain **
----------------------------

Verb

URI

Description

**GET**

***[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/groups?***

Unknown macro: {groupId=groupId&groupName=groupName&
excludeRoles=r1,r2,r3}

&limit=pagesize&marker=groupId

Get a list of groups for the given domain

#### **Detailed Description**

This API is used to get list of groups for a given domain. Api results
can be filtered by using parameters. Query parameters "marker" and
"limit" can be used for pagination

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*The caller does not have the privilege required to perform the operation.*

***403*** *(Forbidden) *

*Disabled or suspended user* making the request

**404** (Not Found)

The specified domainId or groupId within the marker was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

'limit' and 'marker' values. See*** ******[Pagination with limit and
marker query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")******.***

Filters:   Filters can be used to filter the requests.

Inclusion Filters     : groupId = groupId, groupName = groupName. 
Filters groupId and groupName are mutually exclusive. You can filter
either using groupId or using groupName

Exclusion-Filters    : excludeRoles =roleId1, roleId2, roleId3

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

[domainGroup.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSChema/src/main/resources/schemas/ext/domainGroup.xsd).

No request body is required.

The response a list of group resources for the domain.

#### **Example(s)**

##### **XML Request**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP_IDM/v1.0/domains/641564254582/groups HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **XML Request with Filters**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP_IDM/v1.0/domains/641564254582/groups/groupId=1234&excludeRoles=roleId1,roleId22 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **XML Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 294
Date: Mon, 01 Aug 2011 18:25:10 GMT
Connection: close

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><groups xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0"><group id="583891759678" name="HaneefGroup3"><description>A Description of the group1</description></group></groups>
~~~

##### **JSON Request**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/domains/641564254582/groups HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### 

##### **JSON Request with Filters**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/domains/641564254582/groups&groupName=haneefGroup&excludeRoles=roleId1,roleId2 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **JSON Response**

~~~
HTTP/1.1 200 OK
~~~

List Role Definitions
---------------------

Verb

URI

Description

**GET**

***[csbu:HPKeystoneExtensionBaseURI]/domains/{domainId}/roles?limit=pagesize&marker=roleId***

Get a list of role definitions for a domain.

#### Detailed Description

This API is used to list all the roles defined in the domain and takes a
"marker" and "limit" parameter to limit the number of roles in the
response.

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

**404** (Not Found)

The specified domainId or groupId within the marker was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### Header Values

No additional header values required.

#### *Query String Values*

*'limit' and 'marker' values. See**** ******[Pagination with limit and
marker query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")******.***

#### Request and Response Resource Representations

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

#### *Preconditions & Default Behavior*

*System should be bootstrap with some roles as explained in the*
[Bootstrap roles and RoleRefs](http://wiki.hpcloud.net/display/csbu/Bootstrap+roles+and+RoleRefs) page.

*Subject should be authenticated and authorized before invoking roles* *API and must have valid token.*

#### Request and response schema,  XML Schema Definition

[authz-models.xsd](http://wiki.hpcloud.net/download/attachments/229474615/authz-models.xsd).

No request body is required.

The response is a list of role resources for the specified domain.

#### Example(s)

##### List Roles Request using XML

~~~
GET /v2.0/HP-IDM/v1.0/domains/641564254582/roles HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### List Roles Request using JSON

~~~
GET /v2.0/HP-IDM/v1.0/domains/641564254582/roles HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### List Roles Response using XML

~~~
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

##### List Roles Response using JSON

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
