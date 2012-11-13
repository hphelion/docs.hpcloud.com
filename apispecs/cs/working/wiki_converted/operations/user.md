---
title : User Operations

---

### List Users 

#### 

Verb

URI

Description

**GET**

**[HPKeystoneExtensionBaseURI]/users?*****name=username&******limit=pagesize&marker=userId ***

Returns all users for all domains

#### **Detailed Description**

Returns all users of all tenants and takes a "marker" and "limit"
parameter to limit the number of Users in the response.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden)*

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and
marker](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

#### **Request and Response Resource Representations**

####

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

#### Request and Response schema,  XML Schema Definition

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/user.xsd)

No request body is required. The call returns a Users object with a list
of all User objects for all Domains.

#### **Example(s)**

#### 

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/users HTTP/1.1
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
Content-Length: 3225
Date: Tue, 09 Aug 2011 20:53:54 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
  <user domainId="798477662343" isDomainOwner="true" emailAddress="johndoe@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="627893056455" username="johndoe@papsi.com" name="John Doe"/>
  <user domainId="798477662343" emailAddress="amymiller@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="968754602297" username="amymiller@papsi.com" name="Amy Miller"/>
  <user domainId="980913511718" isDomainOwner="true" emailAddress="janedoe@timewarner.com" website="http://www.timewarner.com" phone="1-800-555-1212" zip="90210" country="USA" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" accountId="559855934411" username="janedoe@timewarner.com" name="Jane Doe"/>
</users>
~~~

##### JSON Request

~~~
GET /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
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
Content-Length: 5749
Date: Thu, 22 Sep 2011 19:35:15 GMT

{
  "users": {
    "anies": null,
    "otherAttributes": {

    },
    "user": [
      {
        "addressLine1": null,
        "addressLine2": null,
        "city": null,
        "company": null,
        "country": null,
        "domainId": "00000000001001",
        "emailAddress": null,
        "firstName": null,
        "lastName": null,
        "otherAttributes": {

        },
        "password": null,
        "phone": null,
        "state": null,
        "status": "enabled",
        "userId": "00000000003001",
        "username": "self",
        "website": null,
        "zip": null
      },
      {
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": "USA",
        "domainId": "58569153761853",
        "emailAddress": "JeffWall3@timewarner.com",
        "firstName": "First",
        "lastName": "LAAAST",
        "otherAttributes": {

        },
        "password": null,
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "userId": "68411377324438",
        "username": "XmlUser7@timewarner.com",
        "website": "http://www.timewarner.com",
        "zip": "90210"
      },
      {
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": "USA",
        "domainId": "35682413541771",
        "emailAddress": "larryking@timewarner.com",
        "firstName": "Larry",
        "lastName": "King",
        "otherAttributes": {

        },
        "password": null,
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "userId": "96015523000467",
        "username": "larryking@timewarner.com",
        "website": null,
        "zip": "90210"
      }
    ]
  }
}
~~~

### Get a User 

####

Verb

URI

Description

**GET**

**[HPKeystoneExtensionBaseURI]/users/{userId}**

Returns a user for a specified userId

#### **Detailed Description**

Gets a user resource for the specified userId.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The specified userId was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

No additional Query String Values.

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

#### Request and Response schema,  XML Schema Definition 

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/user.xsd)

No request body is required. The call returns the User object for the
specified userId.

#### **Example(s)**

#### 

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/users/559855934411 HTTP/1.1
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
Content-Length: 429
Date: Tue, 09 Aug 2011 20:59:31 GMT


<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" domainId="980913511718" isDomainOwner="true" emailAddress="janedoe@timewarner.com" website="http://www.timewarner.com" phone="1-800-555-1212" zip="90210" country="USA" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" accountId="559855934411" username="janedoe@timewarner.com" name="Jane Doe" "passwordResetRequired"="true"/>
~~~

##### JSON Request

~~~
GET /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
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
Content-Length: 554
Date: Thu, 22 Sep 2011 19:46:36 GMT

{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "addressLine2": null,
    "city": "Los Angeles",
    "company": null,
    "country": "USA",
    "domainId": "35682413541771",
    "emailAddress": "larryking@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "otherAttributes": {

    },
    "password": null,
    "passwordResetRequired" : "true",
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "userId": "96015523000467",
    "username": "larryking@timewarner.com",
    "website": null,
    "zip": "90210"
  }
}
~~~

### Checks for existence of username

####

Verb

URI

Description

**HEAD**

**[HPKeystoneExtensionBaseURI]/users****?name=username**

Returns http status code indicating the result of username existence
check

#### **Detailed Description**

This API does case-insensitive username lookup in system. It returns
http status code 200 (Ok) when provided username exists and returns 404
(not found) when provided username is not found in the system. If
provided username is blank or missing, then it returns 204 (No
content).
 As this API just checks for existence of provided username, it does not
do look into status (or any other entity attribute) for case when
matching user is found.

There is no response body returned in API response data. This API does
not require http header X-Auth-Token and is protected by client
certificate authentication.

#### **Normal Response Codes**

**200** (OK) and **404** (NOT FOUND)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***204*** (No Content)

When username is missing or blank

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request

#### **Header Values**

No additional header values required.

#### **Query String Values**

No additional Query String Values.

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

#### Request and Response schema,  XML Schema Definition

#### **Example(s)**

#### 

##### XML/JSON Request and Response

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=user1_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate


HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 18:35:21 GMT
~~~

##### XML/JSON Request and Response (case-insensitive lookup of above username)

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=User1_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json


HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 18:49:33 GMT
~~~

##### XML/JSON Request and Response (provided username not found)

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=User1_2012_08_21_11_01_31565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json

HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Content-Type: text/html;charset=utf-8
Content-Length: 952
Date: Tue, 21 Aug 2012 18:52:29 GMT
~~~

##### XML/JSON Request Response (missing username in request)

~~~
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json


HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: \-1
Date: Tue, 21 Aug 2012 18:54:05 GMT
~~~

### Create a new User

####

Verb

URI

Description

**POST**

**[csbu:HPKeystoneExtensionBaseURI]/users**

Create a new User.

#### **Detailed Description**

Creates a new user within a specific domain with a service generated
userId for the user resource.

When a Domain Administrator creates a new User, the User object created
will have the "passwordResetRequired" flag set to "true". In this case,
the caller should force the User to reset the password for the User. The
password reset process is described in detail
[here](https://wiki.hpcloud.net/display/csbu/Password+Reset+Process).

#### **Normal Response Codes**

**201** (OK), User created for the given User in the body of the request.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The specified domain was not found.

**409** (Conflict)

An User with the required parameters already exist in the system.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

No additional Query string values required.

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

#### Request and Response schema,  XML Schema Definition

 [user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/user.xsd)

The request requires a user resource to be created. The user resource
must contain the domainId for the domain to which the user will
belong. The response is the user resource that was created.

#### **Example(s)**

####

##### JSON Request

~~~
POST /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e80e1c62cdc54e6ca175310
Host: localhost:9999
Connection: keep-alive
Content-Length: 354

{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "city": "Los Angeles",
    "country": "USA",
    "domainId": "30047399135069",
    "emailAddress": "larryking@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "password": "changeme",
    "phone": "1-800-555-1212",
    "state": "CA",
    "username": "larryking@timewarner.com",
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
Content-Length: 554
Date: Mon, 26 Sep 2011 20:34:36 GMT

{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "addressLine2": null,
    "city": "Los Angeles",
    "company": null,
    "country": "USA",
    "domainId": "30047399135069",
    "emailAddress": "larryking@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "otherAttributes": {

    },
    "password": null,
    "passwordResetRequired" : "true",
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "userId": "37846208811131",
    "username": "larryking@timewarner.com",
    "website": null,
    "zip": "90210"
  }
}
~~~

##### XML Request

~~~
POST /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e80e1c62cdc54e6ca175310
Host: localhost:9999
Connection: keep-alive
Content-Length: 399

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" emailAddress="XmlUser9@timewarner.com" website="http://www.timewarner.com" phone="1-800-555-1212" zip="90210" country="USA" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" password="changeme" username="XmlUser9@timewarner.com" lastName="Last" firstName="First"/>
~~~

##### XML Response

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=C066B06A95E6B2ED4CF9763AEF2464A2; Path=/v2.0
Content-Type: application/xml
Content-Length: 446
Date: Mon, 26 Sep 2011 20:40:01 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" firstName="First" lastName="Last" username="XmlUser9@timewarner.com" userId="20489940157791" addressLine1="128, Hollywood Blvd" city="Los Angeles" state="CA" country="USA" zip="90210" phone="1-800-555-1212" website="http://www.timewarner.com" emailAddress="XmlUser9@timewarner.com" status="enabled" domainId="34315693600572" passwordResetRequired="true"/>
~~~

### Update a User

####

Verb

URI

Description

**PUT**

**[csbu:HPKeystoneExtensionBaseURI]/users/{userId}**

Updates a user for the specified userId

#### **Detailed Description**

Updates a user for the specified userId*.*

#### **Normal Response Codes**

**200** (OK), User resource was successfully updated.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The specified user was not found.

**409** (Conflict)

An User with the required parameters already exist in the system.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

**503** (Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

No additional query string values required*.*

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

#### Request and Response schema,  XML Schema Definition

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/user.xsd)

The request body contains the user resource to be updated. The response
is the updated User resource.

#### **Example(s)**

####

##### XML Request

~~~
PUT /v2.0/HP-IDM/v1.0/users/559855934411 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
Content-Length: 177

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" emailAddress="janedoe2@timewarner.com" status="enabled"/>
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 430
Date: Tue, 09 Aug 2011 21:07:33 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" domainId="980913511718" isDomainOwner="true" emailAddress="janedoe2@timewarner.com" website="http://www.timewarner.com" phone="1-800-555-1212" zip="90210" country="USA" state="CA" city="Los Angeles" addressLine1="128, Hollywood Blvd" accountId="559855934411" username="janedoe@timewarner.com" name="Jane Doe"/>
~~~

##### JSON Request

~~~
PUT /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b92aa2cdcd8e4c569ca3f
Host: localhost:9999
Connection: keep-alive
Content-Length: 58

{
  "user": {
    "emailAddress": "larrykinglive@timewarner.com"
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
Content-Length: 558
Date: Thu, 22 Sep 2011 19:58:59 GMT


{
  "user": {
    "addressLine1": "128, Hollywood Blvd",
    "addressLine2": null,
    "city": "Los Angeles",
    "company": null,
    "country": "USA",
    "domainId": "35682413541771",
    "emailAddress": "larrykinglive@timewarner.com",
    "firstName": "Larry",
    "lastName": "King",
    "otherAttributes": {

    },
    "password": null,
    "phone": "1-800-555-1212",
    "state": "CA",
    "status": "enabled",
    "userId": "96015523000467",
    "username": "larryking@timewarner.com",
    "website": null,
    "zip": "90210"
  }
}
~~~

### Delete a User 

#### 

Verb

URI

Description

**DELETE**

**[csbu:HPKeystoneExtensionBaseURI]/users/{userId}**

Deletes a user for the specified userId

#### **Detailed Description**

Deletes a user for the specified userId. If the User is an owner of the
Domain, this API checks if the caller has privileges to delete a owner
of the Domain*.*

#### **Normal Response Codes**

**204** (No Content), User resource was successfully deleted.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The specified user was not found.

**409** (Conflict)

An User with the required parameters already exist in the system.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

No additional query string values required*.*

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

#### Request and Response schema,  XML Schema Definition 

No request of response body is required.

#### **Example(s)**

#### 

##### JSON Request

~~~
DELETE /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b95f52cdcd8e4c569ca44
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
Set-Cookie: JSESSIONID=A17A0BD786F05FEC1AE4E25BF8680323; Path=/v2.0
Date: Thu, 22 Sep 2011 20:10:44 GMT
~~~

##### XML Request

~~~
DELETE /v2.0/HP-IDM/v1.0/users/559855934411 HTTP/1.1
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
Date: Tue, 09 Aug 2011 22:20:25 GMT
~~~

### **Get global role assignments for a user**

Verb

URI

Description

**GET **

***[******HP******KeystoneExtensionBaseURI******]/users/{userId}/roles******?limit=pagesize&marker=roleId***\

Returns global role assignments for user.

#### **Detailed Description**

*This API would return all the global role assignments for a user,
global role definitions apply across domains and tenants.*

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
GET /v2.0/HP-IDM/v1.0/users/345678902345/roles HTTP/1.1
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
   </role>
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role02</roleName>
      <description>role02- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
   </role>
   <role>
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role03</roleName>
      <description>role03- description</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
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
   }, {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role02",
      "description": "role02- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
   }, {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role03",
      "description": "role03- description",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
   },
]}
~~~

### Assign a user to a role

#### 

Verb

URI

Description

**POST**

**[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/roles**

Assign a user to a role

#### **Detailed Description**

This API is used to assign a user to a role

#### **Normal Response Codes**

**201** (Created), Role to be assign in the request.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The specified domain was not found.

**200** (OK)

Role assignment is policy and here we can safely return OK in case of
duplicate role assignment

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

No additional Query string values required.

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

#### Request and Response schema,  XML Schema Definition 

The request requires a userId and the role, role must have roleId,
domianId and tenantId in case of tenant specific role . The response is
the role that was created.

#### **Example(s)**

#### 

##### JSON Request

~~~
POST /v2.0/HP-IDM/v1.0/users/12345678909876/roles HTTP/1.1
Accept: application/xml
Content-Type: application/json
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
Content-Length: 353

 {"role": {
    "roleId": "xxxxxxxxxxxxxx",
    "roleName": "role01",
      "serviceId" : "xxxxxxxxxxxxxx",
    "domainId": "xxxxxxxxxxxxxx",
    "tenantId": "12345678909876"
 }}
~~~

##### JSON Response

~~~
{"role": {
      "roleId": "xxxxxxxxxxxxxx",
      "roleName": "role01",
      "description": "user 12345678909876 in role role01",
      "serviceId" : "xxxxxxxxxxxxxx",
      "domainId": "xxxxxxxxxxxxxx",
      "tenantId": "12345678909876"
   }}
~~~

##### XML Request

~~~
POST /v2.0/HP-IDM/v1.0/users/12345678909876/roles HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
Content-Length: 353

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
   <role xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role01</roleName>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
~~~

##### XML Response

~~~
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 403
Date: Tue, 09 Aug 2011 20:31:29 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
   <role xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
      <roleId>xxxxxxxxxxxxxx</roleId>
      <roleName>role01</roleName>
      <description>user 12345678909876 in role role01</description>
      <serviceId>xxxxxxxxxxxxxx</serviceId>
      <domainId>xxxxxxxxxxxxxx</domainId>
      <tenantId>12345678909876</tenantId>
   </role>
~~~

### Remove user from role

#### 

Verb

URI

Description

**DELETE**

***[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/roles/{roleId}***

Remove a role assignment from a user

#### **Detailed Description**

This API is used to remove a role assignment for a user. This API checks
if the caller has privileges to perform this action*.*

#### **Normal Response Codes**

**204** (No Content), User is removed from the specified role.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The specified user was not found.

**409** (Conflict)

An User with the required parameters already exist in the system.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

No additional query string values required*.*

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

#### Request and Response schema,  XML Schema Definition 

No request of response body is required.

#### **Example(s)**

#### 

##### JSON Request

##### JSON Response

##### XML Request

~~~
DELETE /v2.0/HP-IDM/v1.0/users/559855934411/roles/07568653986543 HTTP/1.1
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
Date: Tue, 09 Aug 2011 22:20:25 GMT
~~~

Get All Groups for a User 
--------------------------

#### 

Verb

URI

Description

**GET**

**[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/groups****?*****limit=pagesize&marker=groupId ***

Returns all Groups for a User.

#### **Detailed Description**

Returns all groups for the user specified within the userId.

#### **Normal Response Codes**

**200** (OK), User resource was successfully enabled or disabled.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The specified userId or groupId was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

**503** (Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

'limit' and 'marker' values. See [Pagination with limit and
marker](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

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

[domainGroups.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/domainGroups.xsd)

No request body is required. The response is a groups object with the
list of group resources for the user.

#### **Example(s)**

#### 

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/users/627893056455/groups HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
Content-Type: application/xml
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 465
Date: Tue, 16 Aug 2011 16:40:14 GMT

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<groups xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"
xmlns:ns2="http://www.w3.org/2005/Atom"
xmlns:ns3="http://docs.openstack.org/identity/api/v2.0">
  <group name="Domain Administrators" id="875209688034">
    <description>johndoe@papsi.com-DOMAIN Domain
    Administrators</description>
  </group>
  <group name="Users" id="279700901952">
    <description>johndoe@papsi.com-DOMAIN Users</description>
  </group>
</groups>
~~~

##### JSON Request

**JSON Request**

~~~
GET /v2.0/HP-IDM/v1.0/users/627893056455/groups HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### JSON Response

**JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=DAC25DAF81622AC8A4854FA4687879F7; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 293
Date: Tue, 27 Dec 2011 20:01:19 GMT

{
  "groups" : {
    "anies" : null,
    "group" : [ {
      "description" : "HP System domain users group",
      "anies" : null,
      "domainId" : null,
      "id" : "00000000002002",
      "name" : "Users",
      "otherAttributes" : {
      }
    } ],
    "otherAttributes" : {
    }
  }
}
~~~

### Update Password for a User 

Verb

URI

Description

**PUT**

***[csbu:HPKeystoneExtensionBaseURI]/users/{userId}/password/***

Updates password specified user

#### Detailed Description

Update a user's password specified by the userId.

#### **Normal Response Codes**

**204** (No content), User password was successfully updated.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The specified user was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### Header Values

No additional header values present.

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

#### Request and response schema,  XML Schema Definition

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/user.xsd)

#### Example(s)

##### Update Password Request using XML

~~~
PUT /v2.0/HP-IDM/v1.0/users/53382673413858/password HTTP/1.1
Accept: application/json
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ec697442cdcf4983a3bf3cb
Host: localhost:9999
Connection: keep-alive
Content-Length: 157

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<passwordUpdate xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" newPassword="changed$pwd"/>
~~~

##### Update password  Request using JSON

~~~
PUT /v2.0/HP-IDM/v1.0/users/53382673413858/password HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4ec697442cdcf4983a3bf3cb
Host: localhost:9999
Connection: keep-alive
Content-Length: 50

{
  "passwordUpdate": {
    "newPassword": "changed$pwd"
  }
}
~~~

##### Update password  Result Response using XML

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=8C6A602EB93E746CCE4B6F173E6FA484; Path=/
Date: Fri, 18 Nov 2011 17:58:24 GMT
~~~

##### Update password Result Response using JSON

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=4470C4AB8BD315EAAC0156F5AF822442; Path=/
Date: Fri, 18 Nov 2011 18:03:03 GMT
~~~

### Get System Password Security Question List

Verb

URI

Description

**GET**

***[csbu:HPKeystoneExtensionBaseURI]/******users/password/questions***

Get security questions for a given user

#### Detailed Description

 This API is used to get the security questions asociated with the
system.  Questions are currently pre-configured and part of the Control
Services bootstrap process.  The web management console will need to
present these questions to the end user, collect the answers, and update
the user object with the questionId and answers.

#### **Normal Response Codes**

**200** (OK), User password was successfully updated.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation,

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### Header Values

No additional header values required.

#### *Query String Values*

*No additional* *query string values present.*

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

#### Request and response schema,  XML Schema Definition

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/user.xsd)

#### Example(s)

##### Get Secret questions for the user

~~~
GET http://localhost:8080/v2.0/HP-IDM/v1.0/users/password/questions HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8080
Content-Type : application/xml
~~~

#####

##### Get Secret questions for the user  json

~~~
GET http://localhost:8080/v2.0/HP-IDM/v1.0/users/password/questions HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8080
~~~

##### 

##### Get Secret questions response for the user  XML

~~~
HTTP/1.1 200 OK
cache-Control: no-cacheo-cachexpires: -1ontent-Type: application/xmlontent-Length: 370Date: Wed, 17 Aug 2011 19:10:49 GMTHTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 370
Date: Wed, 17 Aug 2011 19:10:49 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<questions xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
   <question id="4" description="What is ur best friends name"/>
   <question id="2" description="What is ur favourite actor"/>
   <question id="3" description="What is ur favourite sport"/>
   <question id="1" description="What is ur pet's name"/>
</questions>
~~~

#####

##### Get Secret questions for the user response in Json

~~~
HTTP/1.1 200 OKServer: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=0B1D5C05B75BAB64DC71E930B61A85A9; Path=/; Secureche-Control: no-cacheHTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=0B1D5C05B75BAB64DC71E930B61A85A9; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 354
Date: Tue, 27 Dec 2011 19:17:40 GMT

{
  "questions" : {
    "question" : [ {
      "description" : "What is ur best friends name",
      "id" : "4"
    }, {
      "description" : "What is ur favourite actor",
      "id" : "2"
    }, {
      "description" : "What is ur favourite sport",
      "id" : "3"
    }, {
      "description" : "What is ur pet's name",
      "id" : "1"
    } ]
  }
}
Pragma: no-cache
Expires: -1
~~~


Validate Secret Questions & Answers for a User
-----------------------------------------------

Verb

URI

Description

**POST**

***[csbu:HPKeystoneExtensionBaseURI]/******users/{userId}/password/questions***

Validate secret questions/answers for a given user

#### Detailed Description

This API is used to validate the secret questions/answers for the given
user.  This validation is typically done during the forgot password
reset process after the resetId (nonce) that was emailed to the end-user
has been validated.

#### **Normal Response Codes**

**204** (OK), User password was successfully updated.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**404** (Not Found)

The userId specified was not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### Header Values

No additional header values required.

#### *Query String Values*

*No additional* *query string values required.*

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

#### Request and response schema,  XML Schema Definition

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/user.xsd)

#### Example(s)

##### Validate secret question/answers  Request using XML

~~~
POST http://localhost:8080/cs/rest/identity/api/ext/hp/v1.0/users/836097385654/password/questions HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8080
Content-Length: 385

<questionAnswers  xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0">
    <questionAnswer>
    <question id="1"  description="What is ur favourite sport" >
        </question>
    <answer>123</answer>
    </questionAnswer>
<questionAnswer>
    <question id="2"   description="What is ur favourite pet" >
        </question>
    <answer>123</answer>
    </questionAnswer>
</questionAnswers>
~~~

##### 

##### Validate secret question/answers  Request using json

~~~
Todo
~~~

##### 

##### Validate secret question/answers  Response using XML

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 22 Aug 2011 13:31:47 GMT
~~~

##### Validate secret question/answers  failure Response using xml

~~~
<serviceUnavailable code="500" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <message>INTERNAL_SERVER_ERROR</message>
   <details>Input Response for a Challenge does not match the persisted Response</details>
</serviceUnavailable>
~~~

#####

##### Validate secret question/answers  Response using json

~~~
ToDo
~~~

Initiate Password Reset 
------------------------

Verb

URI

Description

**POST**

***[csbu:HPKeystoneExtensionBaseURI]/*****users/password/reset?username={username}**

Initiate a forgot password reset

#### Detailed Description

This API is used to initiate a forgot password reset for a given
username.  If the username is validated, an email will be sent to the
user (based on the email attribute of the user object) containing a URL
link with an embedded resetId.  The user is expected to then click on
the link which will send them to a location on the HP Services web
management console where the console will then pickup the resetId and
validate date it ([see validate resetId operation]( "User Operations"))

#### **Normal Response Codes**

**204** (No Content), User password has successfully been reset.

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### Header Values

No additional header values required.

#### *Query String Values*

*No additional* *query string values required.*

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

#### **Request and response schema,  XML Schema Definition**

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/user.xsd)

#### Example(s)

##### Password rest  Request using XML

~~~
<POST http://localhost:8080/v2.0/HP-IDM/v1.0/user1/password/reset?userName=HaneefUser HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8080
Content-Length: 0
~~~

##### Password reset Request using JSON

N/A

##### Password reset Response using XML

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 22 Aug 2011 04:55:08 GMT
~~~

##### Password reset response using JSON

N/A

Validate Password ResetId and Update Password
---------------------------------------------

Verb

URI

Description

**PUT**

***[csbu:HPKeystoneExtensionBaseURI]/******users/password/reset/{resetId}***

Validate password resetId and update the password.  ResetId is nothing
but nonce

#### Detailed Description

 This API is used to validate the password resetId (nonce), if
validated, then the user's password will be updated based on the new
password passed in the body of the  call.  Updated user object is
returned as response

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the
operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

***404*** *(Not Found) *

When provided nonce is not found and hence user cannot be determined.

**500** (Internal Server Error)

The server encountered a problem while processing therequest.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### Header Values

No additional header values present.

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

#### **Request and response schema,  XML Schema Definition**

[user.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/user.xsd)

#### Example(s)

##### ValidateNonce and Update Password  Request using XML

~~~
PUT https://localhost:35357/v2.0/HP-IDM/v1.0/users/password/reset/azEyRGpxK3l3QmdRYmYwZlVBQ0VxUWRncnVScFM4SEJSN3BVUTZ2akJ6OD1Neg HTTP/1.1ncoding: gzip,deflate-Type: application/xmlPUT https://localhost:35357/v2.0/HP-IDM/v1.0/users/password/reset/azEyRGpxK3l3QmdRYmYwZlVBQ0VxUWRncnVScFM4SEJSN3BVUTZ2akJ6OD1Neg HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:35357
Content-Length: 155

<?xml version="1.0" encoding="UTF-8" standalone="yes"?> <passwordUpdate xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" newPassword="newpwd"  />
~~~


##### ValidateNNonce  Request using JSON

~~~
PUT https://localhost:35357/v2.0/HP-IDM/v1.0/users/password/reset/UlZacHJ4a2V2LzFyNENSMW1vdlhONGJxK2hWMmgxcGVqd0FvVURtOC9jZz1FUA HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:35357
Content-Length: 59

{
  "passwordUpdate": {
    "newPassword": "changeme"
  }
}
~~~

##### Validate nonce Response using JSON

~~~
HTTP/1.1 200 OKHTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=005BC8D3F99AB57DF8CC7A913672E991; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 515
Date: Tue, 29 Nov 2011 17:28:20 GMT

{
  "user" : {
    "roles" : null,
    "addressLine1" : null,
    "addressLine2" : null,
    "city" : null,
    "company" : null,
    "country" : null,
    "domainId" : "00000000001001",
    "emailAddress" : "haneef.ali@hp.com",
    "firstName" : "firstName",
    "lastName" : "lastName",
    "otherAttributes" : {
    },
    "password" : null,
    "phone" : null,
    "state" : null,
    "status" : "enabled",
    "userId" : "62327210706778",
    "username" : "haneef",
    "website" : null,
    "zip" : null
  }
}
~~~

##### Validate nonce response using XML

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=0D4F1347839350183EFE2A3553C4FF61; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 431
Date: Tue, 29 Nov 2011 17:42:30 GMT

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" firstName="firstName" lastName="lastName" username="haneef" userId="62327210706778" emailAddress="haneef.ali@hp.com" status="enabled" domainId="00000000001001"/>
~~~
