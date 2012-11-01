# Role Defs

Roles are entities defined in system to support notion of capability (e.g. SuperAdmin, block-admin, projectmanager etc...), subjects (users/groups) are associated with role to form a logical grouping, subjects with same role have similar capabilities in system. Roles are associated with security policies which provides capability to a role on a particular target as defined in the policy.

There are mainly following two types of role definition supported in CS.

###Global Role Definition###
Global roles are defined in system so that they can be used by any domain across the system for purpose of role assignment. Based on the role scope (explained later) of a global role definition, superadmin or a domainadmin can create role assignments with global role. The domainId field of a global role definition is wild carded (domainId=*) that makes the role definition global. 

There are following two categories of global role definition

* *Non Tenant Role Definition:* A non tenant role definition should not be used for tenant role assignment, which means one can not create a tenant role assignment with such role definitions. Global non tenant role definitions should always have tenantId field empty/null (tenantId=null).
* *Tenant Role Definition:* A tenant role definition is used to associate a subject (user/group) with a tenant, that means non tenant role assignment is not possible with such role definitions. Global tenant role definitions should always have tenantId field wild carded (tenantId=*).

###Domain Role Definition###
Role can be defined for specific domain, such roles can not be used for the purpose of role assignments outside the domain, the domainId field of the role definition should point to a specific domain in the system. Superadmin or domainAdmin are allowed to create such roles.  

There is following one category of domain role definition supported

* *Non Tenant Role Definition:* Domain non tenant role should not be used for role assignment with the context of a tenant, in other words the policy associated with the domain non tenant role definition should not mapped to a target in tenant. Domain non tenant role definition should always have tenantId field empty/null (tenantId=null). This is the only kind of role definition a domain admin is allowed to create in his/her domain.

###Role Definition Attributes###

####roleId:
RoleId to uniquely identify a role definition in system. 

#####Constraints:#####
* Should be 14 digit system generated number.  
* RoleId must be uniques in system.

####roleName:
Human readable name of the role definition(e.g. novaadmin, domainadmin). 

#####Constraints:#####  
* Role name must be unique within a domain.  
* Role Name should not have special character, except (-).  
* One can update the roleName of a role definition even if the role assignment exists for that role definition.  

####description:
Description of the role definition. 

####domainId:
Domain id for which this role definition is valid.

#####Constraints:#####  
* If domainId=*, This makes the role definition global, a global role definition can be used for role assignment in any domain.  
* If domainId=xxxx, This makes the role definition domain specific, these role can only be used for role assignment within that domain.  
* SA or service on boarding users can create a global role definition with domainId=*.  
* SA can create role definition for a specific domain domainId=xxx.  
* DA can create role definition with in his domain domainId=xxxx.  

####tenantId:
The tenantId filed of role definition governs whether role can be associated with a tenant. If the tenantId field is null or empty that means tenant role assignment is not possible with that role definition.

#####Constraints:#####  
* If tenantId=Null/Empty, This means that the role assignment with this role definition cannot be possible with any tenant.  
* If tenantId=*, This means that the role assignment with role definition cannot be possible without a tenant and applicable to all tenants in domain.   
* SA or service on boarding user can create a global role definition with tenantId=*.  
* DA can *not* create role definition in his domain with tenantId=xxxx, for DA it will be tenantId=Null/Empty.  

####serviceId:
ServiceId field is used to scope role definition to a specific service. 

#####Constraints:#####  
*  SA or service on boarding user are allowed to create role definition with serviceId=xxx for a valid service.  
*  DA is not allowed to create role definition for a specific service except identity management service (serviceId=100).  

####roleScope:
roleScope impose visibility to the role definition.
Default= Public 

#####Constraints:#####  
* Public : Roles with "Public" scope are visible to customer and can be used by customer for role assignment (e.g. domainadmin, domainuser).  
* Public_SAR : Roles with "Public_SAR" scope are service activation ready. (e.g. Object Storage admin). These roles are automatically assigned to the domain's admin group at the time of service activation, customer domain admin can also make role assignment for these roles.  
* System : "System" scoped roles are not visible to customer and are reserved for system use only (e.g. superadmin). Special privilege (SA) will be required to create role assignment for these roles.  
* This attribute should only be visible to SA but not be visible to customer.  
* Roles are created with the default scope “Public” and only way to change the scope to update the scope.  
* Only SA or service on boarding user can scope a role definition.  

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


## Create Role Definition
#### POST [HPKeystoneExtensionBaseURI]/roleDefs
*Privilege Level: SA, SVC, DA*

This API is used to create a new role definition in system.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

* *roleName* - String - Human readable name of the role definition.
* *domainId* - String - Domain id for which this role definition is valid.
* *tenantId* (Optional) - String - Tenant id for which this role definition is valid.
* *serviceId* (Optional) - String - Service id for which this role definition is valid.
* *description* (Optional) - String - description of the role definition.

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
Accept: application/xml
Content-Type: application/json
Host: localhost:8443
Content-Length: 50
{
  "role": {
    "roleName": "db-admin",
    "tenantId": "222",
    "domainId": "123",
    "serviceId": "140"
    "description": "db-admin for xyz tenant"
  }
}
```

XML

```
POST https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
Accept: application/xml
Content-Type: application/xml
Host: localhost:8443
Content-Length: 50
 
<role xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <roleName>db-admin</roleName>
   <description>db-admin for xyz tenant</description>
   <domainId>123</domainId>
   <serviceId>140</serviceId>
   <tenantId>222</tenantId>
</role>
```

Optional:

**Success Response**

The response body contains data for newly created role definition with http status code of 201.

**Status Code**

201 - CREATED

**Response Data**

Response data should look as below

JSON

```
{
  "role": {
    "roleId": "12121"
    "roleName": "db-admin",
    "tenantId": "222",
    "domainId": "123",
    "serviceId": "140"
    "description": "db-admin for xyz tenant"
  }
}
```

XML

```
<role xmlns=" http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <roleId>12121</roleId>
   <roleName>db-admin</roleName>
   <description>db-admin for xyz tenant</description>
   <domainId>123</domainId>
   <serviceId>140</serviceId>
   <tenantId>222</tenantId>
</role>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 409 | Conflict  | Duplicate role definition |   
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
curl -k -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XPOST -H "X-Auth-Token: HPAuth_TOCKEN" -H "Content-type: application/json" -d '{"role":{"roleName":"db-admin","tenantId":"58046189288043","domainId":"40527047618047","serviceId":"120","description":"role for db admin"}}'  https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs

```

**Additional Notes**
   * Role creation is a privileged operation. 
   * Only superadmin can create global role where the domainId=*.
   * Only superadmin can create role on behalf of any domain.
   * Domain Admin are allowed to create role definitions within their own domain, which means domainId filed should be set to their own domain.
   * Role can not be created for non existing domain, tenant, service etc.
   * Role are create with default roleScope=Public. Role scope provide visibility to the role (e.g. Roles with System scope should not be visible to customer)
   * RoleName is mandatory field and must be unique within a domain per service, there may be duplicate role name across domains.
   * DomainId is a mandatory field.
   * ServiceId is a mandatory field, if serviceId is 100 then tenantId field should be empty or if serviceId is not equal to 100 then there must be a tenantId  provided in request.


## Delete Role Definition
#### DELETE [HPKeystoneExtensionBaseURI]/roleDefs/{roleId}
*Privilege Level: SA, SVC, DA*

This API is used to delete a role definition identified by roleId. 

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**

This call does not require a request body

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

This call does not require a request body.

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 409 | Conflict  | In case of existing role assignment for the role   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON
Response for deleting previously deleted domain.

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=FE74A50121DBE8B200CCA95E9B759EED; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 176
Date: Wed, 31 Oct 2012 20:35:12 GMT

{
  "identityFault" : {
    "code" : "BAD_REQUEST",
    "message" : "Role not found for roleId 16159990324894",
    "details" : "Role not found for roleId 16159990324894"
  }
}

HTTP/1.1 403 Forbidden
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=DCCE78AA6D9D3EF884E81979DC381898; Path=/; Secure
Content-Type: application/json;charset=UTF-8
Content-Length: 54
Date: Wed, 31 Oct 2012 20:38:22 GMT

{
  "forbidden": {
    "message": "Invalid token",
    "code": 403
  }
}

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
<forbidden code="403" xmlns="http://docs.openstack.org/identity/api/v2.0">
   <message>Invalid token</message>
</forbidden>

<?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>
```

Curl Example

```
curl -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XDELETE -H "X-Auth-Token: HPAuth_TOCKEN" https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs/16159990324894

```

**Additional Notes**
* Role deletion is a privileged operation.
* Superadmin can delete roles from customer domain as well as from system domain.
* domain admin can only delete roles defined in their own domain.
* Delete role is not allowed is there exist a role assignment for the role.



## Update Role Definition
#### PUT [HPKeystoneExtensionBaseURI]/roleDefs/{roleId}
*Privilege Level: SA, SVC, DA*

This API is used to update an existing role definition. RoleId is used to uniquely identify a role definition in the system.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

* *roleName* - String - Human readable name of the role definition.
* *description* (Optional) - String - description of the role definition.

JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs/XXXXXXXXXXXXXX HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
Accept: application/xml
Content-Type: application/json
Host: localhost:8443
Content-Length: 50
{
  "role": {
    "roleName": "mongo-db-admin",
    "description": "mongo-db-admin for abc tenant"
  }
}
```

XML 

```

PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs/XXXXXXXXXXXXXX HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
Accept: application/json
Content-Type: application/xml
Host: localhost:8443
Content-Length: 50

<role xmlns=" http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <roleName>mongo-db-admin</roleName>
   <description>mongo-db-admin for xyz tenant</description>
</role>
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

JSON

```
{
  "role": {
    "roleId": "12121"
    "roleName": "mongo-db-admin",
    "tenantId": "222",
    "domainId": "123",
    "serviceId": "140"
    "description": "mongo-db-admin for xyz tenant"
  }
```

XML

```
<role xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <roleId>12121</roleId>
   <roleName>mongo-db-admin</roleName>
   <description>mongo-db-admin for xyz tenant</description>
   <domainId>123</domainId>
   <serviceId>140</serviceId>
   <tenantId>222</tenantId>
</role>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 409 | Conflict  | In case of existing role name or role assignment for the role |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=42CC6D3F833AAB14A6E7B83B2267F251; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 162
Date: Wed, 31 Oct 2012 21:04:36 GMT

{
  "identityFault" : {
    "code" : "BAD_REQUEST",
    "message" : "Role not found for roleId 2342422",
    "details" : "Role not found for roleId 2342422"
  }
}

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
curl -k -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XPUT -H "X-Auth-Token: HPAuth_TOCKEN" -H "Content-type: application/json" '{"role":{"roleName":"mongo-db-admin","description":"mongo-db-admin for abc tenant"}}'  https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs/123456789012
```

**Additional Notes**

* Role update is privileged operation.
* Superadmin can update a role defined within system domain or in customer domain.
* Only superadmin can update the domainId of the role definition unless there is no role association exist for the role.
* Domain admin are not allowed to change the domainId field of role definition.
* Domain admin are not allowed update system defined roles or roles from other domains.
* Update on certain (domainId, tenantId, serviceId) field are not allowed if there are existing role assignments in the system for the role. 
* Update on roleName and description is allowed even if there exist a role assignment.
* Update role should also obeys the constraints defined in create role.



## Update Role Scope
#### PUT [HPKeystoneExtensionBaseURI]/roleDefs/{roleId}/scope
*Privilege Level: SA, SVC*

This API is used to update the scope an existing role defined in system. Following are the possible role scope defined in system

* Public : Roles with "Public" scope can be used by customer for role assignment (e.g. domainadmin, domainuser).
* Public_SAR : Roles with "Public_SAR" scope are defined by service and injected in system at the time of service registration (e.g. Object Storage admin).  These roles are automatically assigned to user at the time of service provisioning, customer domain admin can also make  role assignment for these roles.
* System : "System" scoped roles are not visible to customer and are reserved for system use only (e.g. superadmin). Special privilege (SA) will be required to create role assignment for these roles.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**

See schema file for more details on the request and response data structure.

* *roleScope* - String - Human readable name of the role definition.



JSON

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs/XXXXXXXXXXXXXX/scope HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
Accept: application/xml
Content-Type: application/json
Host: localhost:8443
Content-Length: 50
 
{
  "scope": {
    "roleScope": "Public_SAR"
  }
}
```

XML

```
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roleDefs/XXXXXXXXXXXXXX/scope HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
Accept: application/xml
Content-Type: application/xml
Host: localhost:8443
Content-Length: 50
 
<scope xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <roleScope>Public_SAR</roleScope>
</scope>

```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

204 - No Content

**Response Data**

There will be no response fir this request.

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 409 | Conflict  | In case of existing role name or role assignment for the role |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=42CC6D3F833AAB14A6E7B83B2267F251; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 162
Date: Wed, 31 Oct 2012 21:04:36 GMT

{
  "identityFault" : {
    "code" : "BAD_REQUEST",
    "message" : "Role not found for roleId 2342422",
    "details" : "Role not found for roleId 2342422"
  }
}

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
curl -k -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XPUT -H "X-Auth-Token: HPAuth_TOCKEN" -H "Content-type: application/json" '{"scope":{"roleScope":"Public_SAR"}}'  https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs/123456789012/scipe
```

**Additional Notes**

* Update role scope is a privileged operation, only superadmin is allowed to do so.
* Update role scope is not allowed if there is an existing role assignments in the system for a role.


## Get a Role Definition
#### GET [HPKeystoneExtensionBaseURI]/roleDefs/{roleId}
*Privilege Level: SA, SVC, DA, DU*

This API is used to get a role definition specified by a roleId.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

**Data Parameters**


This call does not require a request body

**Success Response**

The role definition will be return. 

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{
  "role": {
    "roleId": "xxxxxxxxxxxx",
    "roleName": "db-admin",
    "description": "db-admin for abc tenant",
    "tenantId": "xxxxxxxxxxxx"
    "domainId": "xxxxxxxxxxxx"
    "serviceId": "xxxxxxxxxxxx"
  }
}
```

XML

```
<role xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
    <roleId>xxxxxxxxxxxx</roleId>
    <roleName>db-admin</roleName>
    <description>db-admin for abc tenant</description>
    <tenantId>xxxxxxxxxxxx</tenantId>
    <serviceId>xxxxxxxxxxxxxx</serviceId>
    <domainId>xxxxxxxxxxxx</domainId>
</role>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
| 500 | Internal Server Error | The server encountered a problem while processing the request |  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

```
HTTP/1.1 404 Not Found
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=3CF024C732444A0434F6632CA7C3C80A; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 160
Date: Wed, 31 Oct 2012 21:18:51 GMT

{
  "identityFault" : {
    "code" : "BAD_REQUEST",
    "message" : "No role found for roleId 2312312",
    "details" : "No role found for roleId 2312312"
  }
}

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
curl -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XGET -H "X-Auth-Token: HPAuth_TOCKEN" https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs/16159990324894
```

**Additional Notes**
* Superadmin can get a role from any domain.
* Domain admin and domain users are not allowed to access roles from other domains, except system defined public global roles (domainId=*).



## List Role Definitions
#### GET [HPKeystoneExtensionBaseURI]/roleDefs?domainId=xxx&tenantId=yyy&serviceId=zzz&roleName=abc&limit=pagesize&marker=roleId 

*Privilege Level: SA, SVC*

This API is used to get a list of role definitions defined in system and is reserved for admin use only. Filer options (domainId, tenantId, serviceId and serviceName) are provided with this API to get the manageable size of response list.

**Request Data**

A valid token must be presented in the X-Auth-Token HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list
* *domainId* (Optional)} - string - filter by domainId
* *tenantId* (Optional)} - string - filter by tenant
* *serviceId* (Optional)} - string - filter by serviceId
* *roleName* (Optional)} - string - filter by roleName


**Data Parameters**

This call does not require a request body

**Success Response**

Returns list of roleDefs for given input with http status code 200.

**Status Code**

200 - OK

**Response Data**

JSON

```
{"roles": {"role": [
      {
      "roleId": "001",
      "roleName": "role01",
      "description": "role01- description",
      "serviceId" : "100",
      "domainId": "123",
      "tenantId": ""
   }, {
      "roleId": "002",
      "roleName": "role02",
      "description": "role02- description",
      "serviceId" : "140",
      "domainId": "123",
      "tenantId": "*"
   }, {
      "roleId": "003",
      "roleName": "role03",
      "description": "role03- description",
      "serviceId" : "150",
      "domainId": "123",
      "tenantId": "xxxxxxxxxxxx"
   },
]}
```

XML

```
<roles xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
<role >
   <roleId>001</roleId>
   <roleName>Role001</roleName>
   <description>some desc</description>
   <domainId>123</domainId>
   <serviceId>100</serviceId>
   <tenantId></tenantId>
</role>
<role >
   <roleId>002</roleId>
   <roleName>Role001</roleName>
   <description> some desc </description>
   <domainId>123</domainId>
   <serviceId>140</serviceId>
   <tenantId>*</tenantId>
</role>
<role >
   <roleId>003</roleId>
   <roleName>Role003</roleName>
   <description>Some desc</description>
   <domainId>123</domainId>
   <serviceId>150</serviceId>
   <tenantId>xxxxxxxxxxxx</tenantId>
</role>
</roles>
```

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code  | Description  | Reasons |   
| :----------- | :----------- | :-------|  
| 400 | Bad Request | Malformed request in URI or request body |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Item not found | Token is not valid |  
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
curl -s --cert <CERT_FILE> --cacert <CACERT_FILE>  -XGET -H "X-Auth-Token: HPAuth_TOCKEN" https://<HOST>:35357/v2.0/HP-IDM/v1.0/roleDefs
```

**Additional Notes**

* This is a privileged operation and only reserved for admin use .
* This APi will display roles defined in system, to get roles for specific domain appropriate filter should be used (e.g. domainId=* should be use to get global roles).
* Response can be filtered by domainId, tenantId, serviceId and serviceName.


