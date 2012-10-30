# Group

Group is a collection of users. The primary purpose of group is to provide multiple users with the same privillages

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## Add a User to a group
####  PUT
[HPKeystoneExtensionBaseURI]/groups/{groupId}/users/{userId}
*Privilege Level: SA, DA*

This API is used to add an existing user to a specified group of the given domain. This interface requires the groupId and userId.

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**
N/A

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.


JSON

```
PUT https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Length: 0
```

XML

```
PUT https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Length: 0
```


**Success Response**

**Status Code**

303 - OK

**Response Data**


JSON

```
HTTP/1.1 303 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Location: https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/
Content-Length: 0
Date: Mon, 01 Aug 2011 18:27:33 GMT
Connection: close
```

XML

```
HTTP/1.1 303 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Location: https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/
Content-Length: 0
Date: Mon, 01 Aug 2011 18:27:33 GMT
Connection: close
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 (Bad Request)      		Malformed request in URI or request body    
401 (Unauthorized)	     		The caller does not have the privilege required to perform the operation.   
403 (Forbidden)        		Disabled or suspended user making the request
404 (Not Found) 	     		The specified groupId or userId is not found.
500 (Internal Server Error)		The server encountered a problem while processing the request.   
503 (Service Unavailable)    	The server is unavailable to process the request.    

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
{curl -i -H "X-Auth-Token: <Auth_Token>" -X PUT "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203"
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


## Create a Group
####  POST [HPKeystoneExtensionBaseURI]/groups
*Privilege Level: SA,DA*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

N/A

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
POST /v2.0/HP-IDM/v1.0/groups HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46ba6b2cdc8b1c3905dbca
Host: localhost:9999
Connection: keep-alive
Content-Length: 108
 
{
  "group": {
    "description": "HP Software Group",
    "domainId": "69409986171623",
    "name": "HP Software"
  }
}
```

XML

```
POST /v2.0/HP-IDM/v1.0/groups HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46b1162cdc8b1c3905dbc3
Host: localhost:9999
Connection: keep-alive
Content-Length: 487
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<group xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" domainId="69409986171623" name="HP Cloud Services Business Unit">
  <description>HP Cloud Services Business Unit Engineering and Marketing</description>
</group>
```


**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
POST /v2.0/HP-IDM/v1.0/groups HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46ba6b2cdc8b1c3905dbca
Host: localhost:9999
Connection: keep-alive
Content-Length: 108
 
{
  "group": {
    "description": "HP Software Group",
    "domainId": "69409986171623",
    "name": "HP Software"
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
Content-Type: application/xml
Content-Length: 507
Date: Thu, 23 Feb 2012 21:36:07 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<group xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" id="68906974845076" domainId="69409986171623" name="HP Cloud Services Business Unit">
  <description>HP Cloud Services Business Unit Engineering and Marketing</description>
</group>
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 (Bad Request)      		Malformed request in URI or request body    
401 (Unauthorized)	     		The caller does not have the privilege required to perform the operation.   
403 (Forbidden)        		Disabled or suspended user making the request
404 (Not Found) 	     		The specified domainId is not found.
500 (Internal Server Error)		The server encountered a problem while processing the request.   
503 (Service Unavailable)    	The server is unavailable to process the request.    

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


## Delates a group
####  DELETE [HPKeystoneExtensionBaseURI]/groups/{groupId}
*Privilege Level: SA ,DA*

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
DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/groups/245398746613/ HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
```

XML

```
DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/groups/245398746613/ HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
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
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=37BD6EDBDC2A58CD18201DFD2C21B6C2; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 28 Dec 2011 19:14:46 GMT
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=37BD6EDBDC2A58CD18201DFD2C21B6C2; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 28 Dec 2011 19:14:46 GMT
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


## Get a specific group
####  GET [HPKeystoneExtensionBaseURI]/groups/{groupId}
*Privilege Level: SA,DA, DU *

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
GET https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```

GET https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
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
HTTP/1.1 200 OKHTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=0872F482F66338B2E69820CF34D6BAB0; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 205
Date: Wed, 28 Dec 2011 18:59:46 GMT
 
{
  "group" : {
    "description" : "A Description of the group1",
    "anies" : null,
    "id" : "92138406758615",
    "name" : "HaneefGroup3",
    "otherAttributes" : {
    }
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
Content-Length: 277
Date: Mon, 01 Aug 2011 18:26:30 GMT
Connection: close
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><group xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" id="583891759678" name="HaneefGroup3"><description>A Description of the group1</description></group>
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


## List users for the group
####  GET [HPKeystoneExtensionBaseURI]/groups/{groupId}/users?{username=userName&userId=userId}
*Privilege Level: SA,DA*

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
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?userName=username HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080

```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?userName=username HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
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
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 277
Date: Mon, 01 Aug 2011 18:26:30 GMT
Connection: close

{"groups": {{"groups": {
   "anies": null,
   "group":    [
            {
         "description": "HP System domain users group",
         "anies": null,
         "domainId": null,
         "id": "00000000002002",
         "name": "Users",
         "otherAttributes": {}
      },
            {
         "description": "A Description of the group1",
         "anies": null,
         "domainId": null,
         "id": "39559496895932",
         "name": "HaneefGroup3",
         "otherAttributes": {}
      }
   ],
   "otherAttributes": {}
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
Content-Length: 277
Date: Mon, 01 Aug 2011 18:26:30 GMT
Connection: close

<groups xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <group id="00000000002002" name="Users">
      <description>HP System domain users group</description>
   </group>
   <group id="39559496895932" name="HaneefGroup3">
      <description>A Description of the group1</description>
   </group>
</groups>
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


## {removeuserfromgroup}
#### DELETE 	[HPKeystoneExtensionBaseURI]/groups/{groupId}/users/{userId}
*Privilege Level: SA,DA*

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


## Update Group
####  PUT 	[HPKeystoneExtensionBaseURI]/groups/{groupId}
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


