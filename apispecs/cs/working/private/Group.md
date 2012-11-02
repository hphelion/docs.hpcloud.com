# Group

Group is a collection of users. The primary purpose of group is to provide multiple users with the same privillages

**Status Lifecycle**

**Rate Limits**

**Quota Limits**

**Business Rules**

None.


## Add a User to a group
####  PUT [HPKeystoneExtensionBaseURI]/groups/{groupId}/users/{userId}
*Privilege Level: SA, DA*

This API is used to add an existing user to a specified group of the given domain. This interface requires the groupId and userId.

**Request Data**

**URL Parameters**

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

The response body contains location of newly created group with http status code  303.


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

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId or userId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request|
 

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
<?xml version="1.0" ?>
<unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
  <message>
    UNAUTHORIZED
  </message>
  <details>
    Invalid credentials
  </details>
</unauthorized>
```

Curl Example

```
curl -i -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -X PUT "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203"
```

**Additional Notes**


## Create a Group
####  POST [HPKeystoneExtensionBaseURI]/groups
*Privilege Level: SA,DA*

{Description about the method call}

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.


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
Accept: application/xml
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

The response body contains data for newly created group with http status code of 201.


**Status Code**

201 - OK

**Response Data**


JSON

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 507
Date: Thu, 23 Feb 2012 21:36:07 GMT
 
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

Please refer to error response body for additional details.


**Status Code**


| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified domainId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
<?xml version="1.0" ?>
<unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
  <message>
    UNAUTHORIZED
  </message>
  <details>
    Invalid credentials
  </details>
</unauthorized>
```

Curl Example

```
curl -k  -XPOST -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "group": {   "description": "HP Software Group",    "domainId":"69409986171623",    "name": "HP Software"  }}'  https://localhost:35357/v2.0/HP-IDM/v1.0/groups
```

**Additional Notes**


## Delates a group
####  DELETE [HPKeystoneExtensionBaseURI]/groups/{groupId}
*Privilege Level: SA ,DA*

Delete a group specified by the groupId. This operation also deletes the associated Roles associated to the Group. This operation does not delete User objects associated with the Group.

**Request Data**

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.


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


**Success Response**

The response doesn't have any body. It has  http status code  204.

**Status Code**

204 - OK

**Response Data**

This call doesn't have response body. It returns http code 204 

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

Please refer to error response body for additional details.


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
<?xml version="1.0" ?>
<unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
  <message>
    UNAUTHORIZED
  </message>
  <details>
    Invalid credentials
  </details>
</unauthorized>
```

Curl Example

```
curl -i -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -X DELETE "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/"
```

**Additional Notes**



## Get a specific group
####  GET [HPKeystoneExtensionBaseURI]/groups/{groupId}
*Privilege Level: SA,DA, DU *

{Description about the method call}

**Request Data**


**URL Parameters**


**Data Parameters**

This call does not require a request body

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

**Success Response**

This call returns the corresponding group. 

**Status Code**

200 - OK

**Response Data**



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
 
<?xml version="1.0" ?>
<group id="583891759678" name="HaneefGroup3" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0">
  <description>
    A Description of the group1
  </description>
</group>
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
<?xml version="1.0" ?>
<unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
  <message>
    UNAUTHORIZED
  </message>
  <details>
    Invalid credentials
  </details>
</unauthorized>
```

Curl Example

```
curl -k -H "X-Auth-Token:HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3"  "https://localhost:35357/v2.0/HP-IDM/v1.0/groups/583891759678/"
```

**Additional Notes**



## List users for the group
####  GET [HPKeystoneExtensionBaseURI]/groups/{groupId}/users?{username=userName&userId=userId}
*Privilege Level: SA,DA*

This API is used to list the users for a specified group and takes a "marker" and "limit" parameter to limit the number of Users in the response. Results can also be filtered by using optional filters

**Request Data**


**URL Parameters**

* *limit (Optional)*  - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list
* *username* (Optional)}  - string - filter by user name
* *userId* (Optional)}  - string - filter by user Id


**Data Parameters**

This call does not require a request body 

JSON

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080

```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

Optional: Sample requests using query parameters and filters 

JSON :

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?userName=username HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?userId=412367 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```
GET https://localhost:35357/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?limit=50?maker=34353535& HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

**Success Response**

This call retuns list of users 

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
Content-Length: 277
Date: Mon, 01 Aug 2011 18:26:30 GMT
Connection: close

{
  "users" : {
    "otherAttributes" : {
    },
    "user" : [ {
      "domainId" : "00000000001001",
      "emailAddress" : "haneef.ali@hp.com",
      "firstName" : "haneef",
      "otherAttributes" : {
      },
      "passwordResetRequired" : "true",
      "status" : "enabled",
      "userId" : "59587095111744",
      "username" : "haneef"
    },
   {
      "domainId" : "00000000001001",
      "emailAddress" : "haneef.ali1@hp.com",
      "firstName" : "haneef1",
      "otherAttributes" : {
      },
      "passwordResetRequired" : "true",
      "status" : "enabled",
      "userId" : "59587095111745",
      "username" : "haneef1"
    }
 ]
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

<?xml version="1.0" ?>
<users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
  <user domainId="00000000001001" emailAddress="haneef.ali@hp.com" firstName="haneef" passwordResetRequired="true" status="enabled" userId="59587095111744" username="haneef"/>
</users>
```

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

{
  "users" : {
    "otherAttributes" : {
    },
    "user" : [ {
      "domainId" : "00000000001001",
      "emailAddress" : "haneef.ali@hp.com",
      "firstName" : "haneef",
      "otherAttributes" : {
      },
      "passwordResetRequired" : "true",
      "status" : "enabled",
      "userId" : "59587095111744",
      "username" : "haneef"
    }
 ]
 }

```


**Error Response**

Please refer to error response body for additional details.


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId is not found or userid is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
<?xml version="1.0" ?>
<unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
  <message>
    UNAUTHORIZED
  </message>
  <details>
    Invalid credentials
  </details>
</unauthorized>
```

Curl Example

```
curl -v -k -H "X-Auth-Token: HPAuth_b0846199b9d7c4aa0c7c86169ef693e6298da25c564adff6e002bea84f0b337f"   -H "Accept: application/json" https://csnode.ndd.aw1.hpcloud.net:35357/v2.0/HP-IDM/v1.0/groups/00000000002002/users?userName=haneef

```

**Additional Notes**



## Delete user from the group
#### DELETE 	[HPKeystoneExtensionBaseURI]/groups/{groupId}/users/{userId}
*Privilege Level: SA,DA*

Remove a user from a group   

**Request Data**


**URL Parameters**


**Data Parameters**


JSON

```
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```

XML

```
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
```


**Success Response**

The response doesn't have any content. 

**Status Code**

204 - OK

**Response Data**

The response doesn't have any content

JSON

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 01 Aug 2011 18:31:40 GMT
Connection: close
```

XML

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 01 Aug 2011 18:31:40 GMT
Connection: close
```

**Error Response**

Please refer to error response body for additional details.


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
<?xml version="1.0" ?>
<unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
  <message>
    UNAUTHORIZED
  </message>
  <details>
    Invalid credentials
  </details>
</unauthorized>
```

Curl Example

```
curl -v -k -H "X-Auth-Token: HPAuth_b0846199b9d7c4aa0c7c86169ef693e6298da25c564adff6e002bea84f0b337f" -X DELETE  -H "Accept: application/json" https://csnode.ndd.aw1.hpcloud.net:35357/v2.0/HP-IDM/v1.0/groups/00000000002002/993639569203
```

**Additional Notes**


## Update Group
####  PUT 	[HPKeystoneExtensionBaseURI]/groups/{groupId}
*Privilege Level: SA, DA*

Update a group resource for the specified groupId.   Only description and name can  be updated in this operation.

**Request Data**


**URL Parameters**


**Data Parameters**



JSON

```
PUT /v2.0/HP-IDM/v1.0/groups/68906974845076 HTTP/1.1
Accept: application/json
Content-Type: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46b1162cdc8b1c3905dbc3
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
PUT /v2.0/HP-IDM/v1.0/groups/68906974845076 HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4f46b1162cdc8b1c3905dbc3
Host: localhost:9999
Connection: keep-alive
Content-Length: 487
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<group xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" domainId="69409986171623" name="HP Software">
  <description>HP Software Group</description>
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
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 206
Date: Thu, 23 Feb 2012 22:16:06 GMT
 
{
  "group": {
    "description": "HP Software Group",
    "anies": null,
    "domainId": "69409986171623",
    "id": "68906974845076",
    "name": "HP Software",
    "otherAttributes": {
 
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
Content-Length: 507
Date: Thu, 23 Feb 2012 21:36:07 GMT
 
<group id="68906974845076" name="HP Software" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
   <description>HP Software Group</description>
</group>
```

**Error Response**

Please refer to error response body for additional details.


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body  |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified groupId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request| 

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
<?xml version="1.0" ?>
<unauthorized code="401" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
  <message>
    UNAUTHORIZED
  </message>
  <details>
    Invalid credentials
  </details>
</unauthorized>
```

Curl Example

```
curl -k  -X PUT -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "group": {   "description": "HP Software Group",      "name": "HP Software"  }}'  https://localhost:35357/v2.0/HP-IDM/v1.0/groups/68906974845076
```

**Additional Notes**




