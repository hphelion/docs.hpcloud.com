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


## {getallgroupsforanuserextension}
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


## {getallusersextension}
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


## {getsecurityquestions}
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


## {passwordreset}
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


## {returnanuserextension}
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


## {updateanuserextension}
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


## {updatepassword}
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


