# User

Cloud users.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## List Users
#### GET [HPKeystoneExtensionBaseURI]/users?name=username&emailAddress=email&limit=pagesize&marker=userId
*Privilege Level: SA, DA, SS*

Returns all users of all tenants and takes a "marker" and "limit" parameter to limit the number of Users in the response. Can also be used to lookup users by `name` or `emailAddress`.

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list
* *name* (Optional) - string - lookup users by name
* *emailAddress* (Optional) - string - lookup users by emailAddress

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/users HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

Optional:

JSON

Return 50 users at a time.

```
GET /v2.0/HP-IDM/v1.0/users?limit=50 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

Return 10 users at a time, starting with user ID `345367`

```
GET /v2.0/HP-IDM/v1.0/users?limit=10&marker=345367 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

Lookup users by name.

```
GET /v2.0/HP-IDM/v1.0/users?name=jdoe HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

Lookup users by email.

```
GET /v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```


XML

Lookup users by name.

```
GET /v2.0/HP-IDM/v1.0/users?name=jdoe HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

Lookup users by email.

```
GET /v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
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
```

XML

```
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
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error
* 503 - Service Unavailable

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

***List Users***

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users"
```

***Lookup Users By Name***

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?name=jdoe"
```

***Lookup Users By Email***

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?emailAddress=jdoe@acme.com"
```

**Additional Notes**


## Get A User
#### GET [HPKeystoneExtensionBaseURI]/users/\<userId\> 
*Privilege Level: SA, DA, SS*


Gets a user resource for the specified userId.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
GET /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b8ddf2cdcd8e4c569ca3a
Host: localhost:9999
Connection: keep-alive
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
```

XML

```
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
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error
* 503 - Service Unavailable

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467
```

**Additional Notes**


## Check For Existence Of User
#### HEAD [HPKeystoneExtensionBaseURI]/users?name=username
*Privilege Level: Anon*

This API does case-insensitive username lookup in system. It returns http status code 200 (Ok) when provided username exists and returns 404 (not found) when provided username is not found in the system. If provided username is blank or missing, then it returns 204 (No content).
As this API just checks for existence of provided username, it does not do look into status (or any other entity attribute) for case when matching user is found.

There is no response body returned in API response data. This API does not require http header X-Auth-Token and is protected by client certificate authentication.

**Request Data**

**URL Parameters**

* *name* (Optional) - string - username

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.


JSON

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=User1_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
```

XML

```
HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/users?name=user1_2012_08_21_11_01_30_565 HTTP/1.1
Accept-Encoding: gzip,deflate
```

**Success Response**

**Status Code**

* 200 - OK
* 404 - Not Found

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 18:49:33 GMT
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Tue, 21 Aug 2012 18:49:33 GMT
```

**Error Response**

**Status Code**

* 204 - No Content
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error
* 503 - Service Unavailable

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users?name=user1_2012_08_21_11_01_30_565"
```

**Additional Notes**

## Create A New User
#### POST [HPKeystoneExtensionBaseURI/users
*Privilege Level: SA, DA, SR*

Creates a new user within a specific domain with a service generated userId for the user resource.

When a Domain Administrator creates a new User, the User object created will have the "passwordResetRequired" flag set to "true". In this case, the caller should force the User to reset the password for the User.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

```
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
```

XML

```
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
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
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
```

XML

```
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
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 409 - Conflict
* 500 - Internal Server Error
* 503 - Service Unavailable

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

Assuming there exist a file "new_user.json" with the following content:

```
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
```

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPOST -d @new_user.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users"
```

**Additional Notes**


## Update A User
#### PUT [HPKeystoneExtensionBaseURI]/users/\<userId\> 
*Privilege Level: SA, DA\*, SS*

Updates a user for the specified userId.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

JSON

```
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
```

XML

```
PUT /v2.0/HP-IDM/v1.0/users/559855934411 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
Content-Length: 177
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" emailAddress="janedoe2@timewarner.com" status="enabled"/>
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
```

XML

```
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
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbiddena
* 404 - Not Found
* 409 - Conflict
* 500 - Internal Server Error
* 503 - Service Unavailable

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

Assuming there exist a file "update_user.json" with the following content:

```
{
  "user": {
    "emailAddress": "larrykinglive@timewarner.com"
  }
}
```

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @update_user.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467"
```

**Additional Notes**


## Delete A User
#### DELETE [HPKeystoneExtensionBaseURI]/users/\<userId\>
*Privilege Level: SA, DA*

Deletes a user for the specified userId. If the User is an owner of the Domain, this API checks if the caller has privileges to delete a owner of the Domain.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.


A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
DELETE /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b95f52cdcd8e4c569ca44
Host: localhost:9999
Connection: keep-alive
```

XML

```
DELETE /v2.0/HP-IDM/v1.0/users/96015523000467 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e7b95f52cdcd8e4c569ca44
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

204 - No Content

**Response Data**

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=A17A0BD786F05FEC1AE4E25BF8680323; Path=/v2.0
Date: Thu, 22 Sep 2011 20:10:44 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=A17A0BD786F05FEC1AE4E25BF8680323; Path=/v2.0
Date: Thu, 22 Sep 2011 20:10:44 GMT
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 409 - Conflict
* 500 - Internal Server Error
* 503 - Service Unavailable

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -XDELETE "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467"
```

**Additional Notes**


## Get All Groups For A User
#### GET [HPKeystoneExtensionBaseURI]/users/\<userId\>/groups?limit=pagesize&marker=groupId
*Privilege Level: SA, DA, SS*

Returns all groups for the user specified within the userId.

**Request Data**

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.


JSON

```
GET /v2.0/HP-IDM/v1.0/users/627893056455/groups HTTP/1.1
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

XML

```
GET /v2.0/HP-IDM/v1.0/users/627893056455/groups HTTP/1.1
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
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
```

XML

```
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
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 500 - Internal Server Error
* 503 - Service Unavailable

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

Return all the groups for a given user.

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467/groups"
```

Return maximum of 10 groups at a time, starting with groupId '1234556', for a given user.

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/96015523000467/groups?limit=10&marker=1234556"
```


**Additional Notes**


## Update Password For A User
#### PUT [HPKeystoneExtensionBaseURI]/users/\<userId\>/password
*Privilege Level: SA, DA, SS*

Update a user's password specified by the userId.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


JSON

```
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
```

XML

```
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
```

**Success Response**

**Status Code**

204 - No Content

**Response Data**

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=4470C4AB8BD315EAAC0156F5AF822442; Path=/
Date: Fri, 18 Nov 2011 18:03:03 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=8C6A602EB93E746CCE4B6F173E6FA484; Path=/
Date: Fri, 18 Nov 2011 17:58:24 GMT
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 500 - Internal Server Error
* 503 - Service Unavailable

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

Assuming there exist a file "new_password.json" with the following content:

```
{
  "passwordUpdate": {
    "newPassword": "changed$pwd"
  }
}
```

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @new_password.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/53382673413858/password"
```

**Additional Notes**


## Initial Password Reset
#### POST [HPKeystoneExtensionBaseURI]/users/password/reset?userName=username
*Privilege Level: SA, DA, Anon*

This API is used to initiate a forgot password reset for a given username.  If the username is validated, an email will be sent to the user (based on the email attribute of the user object) containing a URL link with an embedded resetId.  The user is expected to then click on the link which will send them to a location on the HP Services web management console where the console will then pickup the resetId and validate it.

**Request Data**

**URL Parameters**

* *userName* - string - username of the user to reset the password

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

```
POST /v2.0/HP-IDM/v1.0/users/password/reset?userName=jschmo HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8080
Content-Length: 0
```

XML

```
POST /v2.0/HP-IDM/v1.0/users/password/reset?userName=jschmo HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8080
Content-Length: 0
```

**Success Response**

**Status Code**

204 - No Content

**Response Data**

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 22 Aug 2011 04:55:08 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 22 Aug 2011 04:55:08 GMT
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 409 - Conflict
* 500 - Internal Server Error
* 503 - Service Unavailable

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
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -XPOST "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/password/reset?usernName=jschmo"
```

**Additional Notes**


## Validate Password ResetId And Update Password
#### PUT [HPKeystoneExtensionBaseURI]/users/password/reset/\<resetId\>
*Privilege Level: Anon*

This API is used to validate the password resetId (nonce), if validated, then the user's password will be updated based on the new password passed in the body of the  call.  Updated user object is returned as response.

**Request Data**

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

```
PUT /v2.0/HP-IDM/v1.0/users/password/reset/UlZacHJ4a2V2LzFyNENSMW1vdlhONGJxK2hWMmgxcGVqd0FvVURtOC9jZz1FUA HTTP/1.1
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
```

XML

```
PUT /v2.0/HP-IDM/v1.0/users/password/reset/azEyRGpxK3l3QmdRYmYwZlVBQ0VxUWRncnVScFM4SEJSN3BVUTZ2akJ6OD1Neg HTTP/1.1
Accept-Encoding: gzip,deflate
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:35357
Content-Length: 155
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> <passwordUpdate xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" newPassword="newpwd"  />
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

```
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
```

XML

```
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
```

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbiddena
* 404 - Not Found
* 409 - Conflict
* 500 - Internal Server Error
* 503 - Service Unavailable

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

Assuming there exist a file "mypasword.json" with the following content:

```
{
  "passwordUpdate": {
    "newPassword": "changeme"
  }
}
```

```
curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "Content-Type: application/json" -H "Accept: application/json" -XPUT -d @mypassword.json "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/HP-IDM/v1.0/users/password/reset/UlZacHJ4a2V2LzFyNENSMW1vdlhONGJxK2hWMmgxcGVqd0FvVURtOC9jZz1FUA"
```

**Additional Notes**


## {validatnonce}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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

```
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## {validatsecret}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

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

```
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


