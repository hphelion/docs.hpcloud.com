# Role Assignment

API to create, update, list and delete CS role assignments

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## List role assignments made on a tenant
#### GET /tenants/{tenantId}/roles?{serviceId=xxx&roleId=yyy&subjectType=User/Group&subjectId=1234} 
*Privilege Level: SA, DA, DU*

This API would return all the role assignments made on a tenant in its domain filtered by serviceId. Tenant role assignments are always associated with a tenant.

Constraints:

List tenant role assignments is not a privileged operation so far.
ServiceId is not a mandatory field, if provided response should be filtered.
SubjectType is required if subjectId filter is used

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant

The following are the supported list of query parameters to filter the results

* *serviceId* (Optional) - string - list roles specific to the service identified by this id
* *roleId* (Optional) - string - filter by roles having this id
* *subjectType* (Optional) - string - could be one of User/Group
* *subjectId* (Optional)} - string - id of the User/Group specified above
* *limit* (Optional)} - number - limit the results by the specified page size
* *marker* (Optional)} - string - continue returning results after the specified marker

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

```
GET /v2.0/HP-IDM/v1.0/tenants/11111111/roles?serviceId=120 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK
204 - No content

**Response Data**


JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
{"roles": {"role": [
      {
      "roleAssignmentId": "CmVSz8s9o1ds4Pw25S0Mwk8SBgA63FXWMxRIx4Ix9DQ=",
      "roleId": "00000000004023",
      "roleName": "Admin",
      "subjectId": "777700000004",
      "subjectName": "testGroupId01",
      "subjectType": "Group",
      "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   },
      {
      "roleAssignmentId": "az1UVA2ngsdEGgLgOm9kXRbt3FcN3TqaJLO0zN9Aww=",
      "roleId": "00000000004023",
      "roleName": "Admin",
      "subjectId": "777700000003",
      "subjectName": "atiwari-1",
      "subjectType": "User",
      "description": "Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   },
      {
      "roleAssignmentId": "oYYbwF2RKU5YRURKRAlJnKvNGbqaeEaenvr0YFFr5s=",
      "roleId": "00000000004016",
      "roleName": "netadmin",
      "subjectId": "777700000004",
      "subjectName": "testGroupId01",
      "subjectType": "Group",
      "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   },
      {
      "roleAssignmentId": "znWxft23Ncf3GIWbTJQhlL7jnzLkW5jFLXmRWPh2vIg=",
      "roleId": "00000000004016",
      "roleName": "netadmin",
      "subjectId": "777700000003",
      "subjectName": "atiwari-1",
      "subjectType": "User",
      "description": "Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   }
]}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
<roles xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <role>
      <roleAssignmentId>CmVSz8s9o1ds4Pw25S0Mwk8SBgA63FXWMxRIx4Ix9DQ=</roleAssignmentId>
      <roleId>00000000004023</roleId>
      <roleName>Admin</roleName>
      <subjectId>777700000004</subjectId>
      <subjectName>testGroupId01</subjectName>
      <subjectType>Group</subjectType>
      <description>Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000</description>
      <domainId>777700000000</domainId>
      <serviceId>120</serviceId>
      <tenantId>777700000001</tenantId>
      <isCrossDomain>false</isCrossDomain>
   </role>
   <role>
      <roleAssignmentId>az1UVA2ngsdEGgLgOm9kXRbt3FcN3TqaJLO0zN9Aww=</roleAssignmentId>
      <roleId>00000000004023</roleId>
      <roleName>Admin</roleName>
      <subjectId>777700000003</subjectId>
      <subjectName>atiwari-1</subjectName>
      <subjectType>User</subjectType>
      <description>Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000</description>
      <domainId>777700000000</domainId>
      <serviceId>120</serviceId>
      <tenantId>777700000001</tenantId>
      <isCrossDomain>false</isCrossDomain>
   </role>
   <role>
      <roleAssignmentId>oYYbwF2RKU5YRURKRAlJnKvNGbqaeEaenvr0YFFr5s=</roleAssignmentId>
      <roleId>00000000004016</roleId>
      <roleName>netadmin</roleName>
      <subjectId>777700000004</subjectId>
      <subjectName>testGroupId01</subjectName>
      <subjectType>Group</subjectType>
      <description>Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000</description>
      <domainId>777700000000</domainId>
      <serviceId>120</serviceId>
      <tenantId>777700000001</tenantId>
      <isCrossDomain>false</isCrossDomain>
   </role>
   <role>
      <roleAssignmentId>znWxft23Ncf3GIWbTJQhlL7jnzLkW5jFLXmRWPh2vIg=</roleAssignmentId>
      <roleId>00000000004016</roleId>
      <roleName>netadmin</roleName>
      <subjectId>777700000003</subjectId>
      <subjectName>atiwari-1</subjectName>
      <subjectType>User</subjectType>
      <description>Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000</description>
      <domainId>777700000000</domainId>
      <serviceId>120</serviceId>
      <tenantId>777700000001</tenantId>
      <isCrossDomain>false</isCrossDomain>
   </role>
</roles>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended tenant making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

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
curl -sk --cacert $CACERT -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/98765733650021/roles?serviceId=xxx\&domainId=yyy\&limit=10\&marker=zzz
```

**Additional Notes**

None


## List tenant role assignments for a user
#### GET {path only, no root path} tenants/{tenantId}/users/{userId}/roles?serviceId=xxx&limit=pagesize&marker=roleId
*Privilege Level: SA, DA, DU*

This API would return all the role assignments made on a particular tenant for a user filtered by serviceId.

Constraints:

List a users tenant role assignments is not a privileged operation so far.
ServiceId is not a mandatory field, if provided response should be filtered.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *userId* - string - the unique id of the user

The following are the supported list of query parameters to filter the results

* *serviceId* (Optional) - string - list roles specific to the service identified by this id
* *limit* (Optional)} - number - limit the results by the specified page size
* *marker* (Optional)} - string - continue returning results after the specified marker

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

```
GET /v2.0/HP-IDM/v1.0/tenants/11111111/users/345678902345/roles?serviceId=120 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK
204 - No content

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
{"roles": {"role": [
      {
      "roleAssignmentId": "az1UVA2ngsdEGgLgOm9kXRbt3FcN3TqaJLO0zN9Aww=",
      "roleId": "00000000004023",
      "roleName": "Admin",
      "subjectId": "777700000003",
      "subjectName": "atiwari-1",
      "subjectType": "User",
      "description": "Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   },
      {
      "roleAssignmentId": "znWxft23Ncf3GIWbTJQhlL7jnzLkW5jFLXmRWPh2vIg=",
      "roleId": "00000000004016",
      "roleName": "netadmin",
      "subjectId": "777700000003",
      "subjectName": "atiwari-1",
      "subjectType": "User",
      "description": "Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   }
]}}
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
<roles xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <role>
      <roleAssignmentId>az1UVA2ngsdEGgLgOm9kXRbt3FcN3TqaJLO0zN9Aww=</roleAssignmentId>
      <roleId>00000000004023</roleId>
      <roleName>Admin</roleName>
      <subjectId>777700000003</subjectId>
      <subjectName>atiwari-1</subjectName>
      <subjectType>User</subjectType>
      <description>Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000</description>
      <domainId>777700000000</domainId>
      <serviceId>120</serviceId>
      <tenantId>777700000001</tenantId>
      <isCrossDomain>false</isCrossDomain>
   </role>
   <role>
      <roleAssignmentId>znWxft23Ncf3GIWbTJQhlL7jnzLkW5jFLXmRWPh2vIg=</roleAssignmentId>
      <roleId>00000000004016</roleId>
      <roleName>netadmin</roleName>
      <subjectId>777700000003</subjectId>
      <subjectName>atiwari-1</subjectName>
      <subjectType>User</subjectType>
      <description>Tenant Role Assignment : User atiwari-1, id 777700000003, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000</description>
      <domainId>777700000000</domainId>
      <serviceId>120</serviceId>
      <tenantId>777700000001</tenantId>
      <isCrossDomain>false</isCrossDomain>
   </role>
</roles>
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended user making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

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
curl -sk --cacert $CACERT -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/11111111/roles?serviceId=120
```

**Additional Notes**

None


## Check tenant role assignment for a user
#### HEAD /tenants/{tenantId}/users/{userId}/roles/{roleId}
*Privilege Level: SA, DA, DU*

This API would not return any content.

Constraints:

This is not a privileged operation so far.
All the id's should represent a valid entity (userId, roleId)
non tenant role assignments are not associated with a tenant.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *userId* - string - the unique id of the user
* *roleId* - string - the unique id of the role

The following are the supported list of query parameters to filter the results

* *limit* (Optional)} - number - limit the results by the specified page size
* *marker* (Optional)} - string - continue returning results after the specified marker

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

```
HEAD /v2.0/HP-IDM/v1.0/tenants/777700000001/users/777700000003/roles/00000000004026 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK
204 - No content

**Response Data**


JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=20DD4F9E1E3D2B0485DC81D93609DE30; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Wed, 26 Sep 2012 17:58:59 GMT
```

XML

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=20DD4F9E1E3D2B0485DC81D93609DE30; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Length: 0
Date: Wed, 26 Sep 2012 17:58:59 GMT
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended tenant making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

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
curl -sk --cacert $CACERT -XHEAD -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/98765733650021/users/1234/roles/4567
```

**Additional Notes**

None


## Create tenant role assignments for a user
#### PUT /tenants/{tenantId}/users/{userId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to create a tenant role assignment for user.

Constraints:

This is a privileged operation, only superadmin or domainadmin can create a role assignment.
Only super admin is allowed to make a role assignment for "System" scoped roles.
All the entities in the context should be valid (User, Domain, Role)
non tenant role assignment is not allowed.
Cross domain role assignment is supported for non tenant role.
Role assignment should be made on tenant's domain.
Service must be activated on the tenant.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *userId* - string - the unique id of the user
* *roleId* - string - the unique id of the role

No query parameters are required for this call

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

```
PUT /v2.0/HP-IDM/v1.0/tenants/11111111/users/12345678909876/roles/00000000004023 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK (if role already exists)
201 - Created

**Response Data**

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended tenant making the request |
| 404 | Not Found | The specified tenant, user or role was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

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
curl -sk --cacert $CACERT -XPUT -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/98765733650021/users/1234/roles/4567
```

**Additional Notes**

None


## Delete tenant role assignment for a user
#### DELETE /tenants/{tenantId}/users/{userId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to delete a tenant role assignment for a user. 

Constraints:

This is a privileged operation.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *userId* - string - the unique id of the user
* *roleId* - string - the unique id of the role

No query parameters are required for this call

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

```
DELETE /v2.0/HP-IDM/v1.0/tenants/11111111/users/12345678909876/roles/00000000004023 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 09 Aug 2011 22:20:25 GMT
```

**Error Response**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended tenant making the request |
| 404 | Not Found | The specified tenant, user or role was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

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
curl -sk --cacert $CACERT -XDELETE -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/11111111/users/12345678909876/roles/00000000004023
```

**Additional Notes**

None


## List tenant role assignments for a group
#### GET /tenants/{tenantId}/groups/{groupId}/roles?{serviceId=xxx} 
*Privilege Level: SA, DA, DU*

This API would return all the tenant role assignments for a group filtered by serviceId. 

Constraints:

List a group's tenant role assignments is not a privileged operation so far.
ServiceId is not a mandatory field, if provided response should be filtered.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *groupId* - string - the unique group id 

The following are the supported list of query parameters to filter the results

* *serviceId* (Optional) - string - list roles specific to the service identified by this id
* *limit* (Optional)} - number - limit the results by the specified page size
* *marker* (Optional)} - string - continue returning results after the specified marker


**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

```
GET /v2.0/HP-IDM/v1.0/tenants/11111111/groups/345678902345/roles?serviceId=120 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK
204 - No Content

**Response Data**

JSON

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
{"roles": {"role": [
      {
      "roleAssignmentId": "CmVSz8s9o1ds4Pw25S0Mwk8SBgA63FXWMxRIx4Ix9DQ=",
      "roleId": "00000000004023",
      "roleName": "Admin",
      "subjectId": "777700000004",
      "subjectName": "testGroupId01",
      "subjectType": "Group",
      "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   },
      {
      "roleAssignmentId": "oYYbwF2RKU5YRURKRAlJnKvNGbqaeEaenvr0YFFr5s=",
      "roleId": "00000000004016",
      "roleName": "netadmin",
      "subjectId": "777700000004",
      "subjectName": "testGroupId01",
      "subjectType": "Group",
      "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   }
]}}
```

XML 

```
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
{"roles": {"role": [
      {
      "roleAssignmentId": "CmVSz8s9o1ds4Pw25S0Mwk8SBgA63FXWMxRIx4Ix9DQ=",
      "roleId": "00000000004023",
      "roleName": "Admin",
      "subjectId": "777700000004",
      "subjectName": "testGroupId01",
      "subjectType": "Group",
      "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role Admin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   },
      {
      "roleAssignmentId": "oYYbwF2RKU5YRURKRAlJnKvNGbqaeEaenvr0YFFr5s=",
      "roleId": "00000000004016",
      "roleName": "netadmin",
      "subjectId": "777700000004",
      "subjectName": "testGroupId01",
      "subjectType": "Group",
      "description": "Tenant Role Assignment : Group testGroupId01, id 777700000004, domain 777700000000, role netadmin, service 120 on tenant 777700000001 domain 777700000000",
      "domainId": "777700000000",
      "serviceId": "120",
      "tenantId": "777700000001",
      "isCrossDomain": false
   }
]}}
```

**Error Response**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended group making the request |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

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
curl -sk --cacert $CACERT -XDELETE -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/11111111/groups/12345678909876/roles?serviceId=120\&limit=10\&marker=1234
```

**Additional Notes**

None


## Create tenant role assignments for a group
#### PUT /tenants/{tenantId}/groups/{groupId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to create a tenant role assignment for group.

Constraints:

This is a privileged operation, only superadmin or domainadmin can create a role assignment.
Only super admin is allowed to make a role assignment for "System" scoped roles.
All the entities in the context should be valid (Group, Domain, Role)
non tenant role assignment is not allowed.
Role assignment should be made on tenant's domain.
Cross domain role assignment is supported for non tenant role.
Service must be activated on the tenant.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *groupId* - string - the unique id of the group
* *roleId* - string - the unique id of the role

No query parameters are required for this call

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

```
PUT /v2.0/HP-IDM/v1.0/tenants/11111111/groups/12345678909876/roles/00000000004023 HTTP/1.1
Accept: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK (if role already exists)
201 - Created

**Response Data**

```
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
```

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended group making the request |
| 404 | Not Found | The specified tenant, user or role was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

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
curl -sk --cacert $CACERT -XPUT -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/98765733650021/groups/1234/roles/4567
```

**Additional Notes**

None


## Delete tenant role assignment for a group
#### DELETE /tenants/{tenantId}/groups/{userId}/roles/{roleId}
*Privilege Level: SA, DA*

This API is used to delete a tenant role assignment for a group. 

Constraints:

This is a privileged operation.

**Request Data**

See examples below.

**URL Parameters**

The following parameters need to be specified in the resource path

* *tenantId* - string - the unique id of the tenant
* *groupId* - string - the unique id of the group
* *roleId* - string - the unique id of the role

No query parameters are required for this call

**Data Parameters**

The following HTTP headers must be specified.

* *X-Auth-Token* - token ID

This call does not require a request body

```
DELETE /v2.0/HP-IDM/v1.0/tenants/11111111/groups/12345678909876/roles/00000000004023 HTTP/1.1
Accept: application/json
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
```

**Success Response**

**Status Code**

200 - OK
204 - No Content

**Response Data**

```
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Tue, 09 Aug 2011 22:20:25 GMT
```

**Error Response**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body | 
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |   
| 403 | Forbidden | Disabled or suspended group making the request |
| 404 | Not Found | The specified tenant, user or role was not found |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

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
curl -sk --cacert $CACERT -XDELETE -H "X-Auth-Token: <Auth_Token>" $CS/HP-IDM/v1.0/tenants/11111111/groups/12345678909876/roles/00000000004023
```

**Additional Notes**

None

