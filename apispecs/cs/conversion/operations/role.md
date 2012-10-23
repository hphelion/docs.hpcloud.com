---  
title : Role Operations

---  

Create Role Definition
----------------------

Verb

URI

Description

**POST**

***[csbu:HPKeystoneExtensionBaseURI]/roles***

Create a new role definition.

#### Detailed Description

 This API is used to create new role definition. Roles are scoped to a
specific domain or can be applicable to all domains in the system.  If
the role is applicable to all domains, domainId field of role should be
defined as "\*". 

-   Role creation is a privileged operation 
-   Only superadmin can create global role where the specified
    domainId=\*
-   Only superadmin can create global role where the specified
    serviceId=\*
-   Only superadmin can create global role on behalf of any domain  
-   Domain Admin are allowed to create roles within their own domain
-   Domain Admin are allowed to create roles within their own domain
    with tenantId=\*
-   Role can not be created for non existing domain, tenant, service etc
-   Role are create with default roleScope=Public.

#### **Normal Response Codes**

**201** (Created)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*No user association with provided tenantId  ( via roles )*

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*

***404**** *(Item not found)

*Token is not valid*

***409**** *(Conflict)

*In case of role with same name exist in domain*

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

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

#### *Preconditions & Default Behavior*

*System should be bootstrap with some roles as explained in the*
[Bootstrap roles and RoleRefs](http://wiki.hpcloud.net/display/csbu/Bootstrap+roles+and+RoleRefs) page.

*Subject should be authenticated and authorized to use this API and must have valid token.*

#### Request and response schema,  XML Schema Definition 

The request and response is of type role from
[authz-models.xsd](http://wiki.hpcloud.net/download/attachments/229474615/authz-models.xsd)

#### Example(s)

##### Create Role Request using XML

~~~
<role xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <roleName>db-admin</roleName>
   <description>db-admin for xyz tenant</description>
   <domainId>xxxxxxxxxxxx</domainId>
   <serviceId>xxxxxxxxxxxxxx</serviceId>
   <tenantId>xxxxxxxxxxxx</tenantId>
</role>
~~~

##### Create Role Request using JSON

~~~
{
  "role": {
    "roleName": "db-admin",
    "tenantId": "xxxxxxxxxxxx",
    "domainId": "xxxxxxxxxxxx",
    "serviceId": "xxxxxxxxxxxx"
    "description": "db-admin for xyz tenant"
  }
}
~~~

##### Create Role Response using XML

~~~
<role xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <roleId>xxxxxxxxxxxx</roleId>
   <roleName>db-admin</roleName>
   <description>db-admin for xyz tenant</description>
   <domainId>xxxxxxxxxxxx</domainId>
   <serviceId>xxxxxxxxxxxxxx</serviceId>
   <tenantId>xxxxxxxxxxxx</tenantId>
</role>
~~~

##### Create Role Response using JSON

~~~
{
  "role": {
    "roleId": "xxxxxxxxxxxx"
    "roleName": "db-admin",
    "tenantId": "xxxxxxxxxxxx",
    "domainId": "xxxxxxxxxxxx",
    "serviceId": "xxxxxxxxxxxx"
    "description": "db-admin for xyz tenant"
  }
~~~

**Update Role Definition**
--------------------------

Verb

URI

Description

**PUT**

***[csbu:HPKeystoneExtensionBaseURI]/roles/{roleId}***

Update a role definition.

#### Detailed Description

 This API is used to update a role definition identified. RoleId is used
to uniquely identify a role in the system. A caller cannot update system
defined role or roles from other domains.

Role update is not allowed if there is existing role assignments in the
system for the role. 

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*No user association with provided tenantId  ( via roles )*

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*

***404**** *(Item not found)

*Token is not valid*

***409**** *(Conflict)

*In case of existing role name or role assignment for the role*

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

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

#### *Preconditions & Default Behavior*

*System should be bootstrap with some roles as explained in the*
[Bootstrap roles and RoleRefs](http://wiki.hpcloud.net/display/csbu/Bootstrap+roles+and+RoleRefs) page.

*Subject should be authenticated and authorized to use this API and must have valid token.*

#### Request and response schema,  XML Schema Definition 

The request and response is of type role from
[authz-models.xsd](http://wiki.hpcloud.net/download/attachments/229474615/authz-models.xsd)

#### Example(s)

##### Update Role Request using XML

~~~
<role xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <roleName>db-admin</roleName>
   <description>db-admin for abc tenant</description>
   <domainId>xxxxxxxxxxxx</domainId>
   <tenantId>xxxxxxxxxxxx</tenantId>
   <serviceId>xxxxxxxxxxxxxx</serviceId>
</role>
~~~

##### Update Role Request using JSON

~~~
{
  "role": {
    "roleName": "db-admin",
    "tenantId": "xxxxxxxxxxxx",
    "domainId": "xxxxxxxxxxxx",
    "serviceId": "xxxxxxxxxxxx"
    "description": "db-admin for abc tenant"
  }
}
~~~

##### Update Role Response using XML

~~~
<role xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <roleId>xxxxxxxxxxxx</roleId>
   <roleName>db-admin</roleName>
   <description>db-admin for abc tenant</description>
   <domainId>xxxxxxxxxxxx</domainId>
   <serviceId>xxxxxxxxxxxxxx</serviceId>
   <tenantId>xxxxxxxxxxxx</tenantId>
</role>
~~~

##### Update Role Response using JSON

~~~
{
  "role": {
    "roleId": "xxxxxxxxxxxx"
    "roleName": "db-admin",
    "tenantId": "xxxxxxxxxxxx",
    "domainId": "xxxxxxxxxxxx",
    "serviceId": "xxxxxxxxxxxx"
    "description": "db-admin for abc tenant"
  }
~~~

**Re-scope Role**
-----------------

Verb

URI

Description

**PUT**

***[csbu:HPKeystoneExtensionBaseURI]/roles/{roleId}/rescope***

Re-scope role defined in system.

#### Detailed Description

This API is used to re-scope an existing role defined in system. Role
re-scoping is a privileged operation and require SA level privilege,
role re-scoping is not allowed if there is existing role assignments in
the system for a role. Following are the possible role scope defined in
system

-   Public : Roles with "Public" scope can be used by customer for role
    assignment (e.g. domainadmin, domainuser).
-   Public\_SAR : Roles with "Public\_SAR" scope are defined by service
    and injected in system at the time of service registration (e.g.
    Object Storage admin).  These roles are automatically assigned to
    user at the time of service provisioning, customer domain admin can
    also make role assignment for these roles.
-   System : "System" scoped roles are not visible to customer and are
    reserved for system use only (e.g. superadmin). Special privilege
    (SA) will be required to create role assignment for these roles.
-   #### **Normal Response Codes**

**204** (No Content)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*No user association with provided tenantId  ( via roles )*

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*

***404**** *(Item not found)

*Token is not valid*

***409**** *(Conflict)

*In case of existing role assignment for the role*

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### Header Values

No additional header values required.

#### *Query String Values*

*No additional* *query string values required.*

#### Request and Response Resource Representations

\

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

*Subject should be authenticated and authorized to use this API and must
have valid token.*

#### Request and response schema,  XML Schema Definition 

The request and response is of type role from
[authz-models.xsd](http://wiki.hpcloud.net/download/attachments/229474615/authz-models.xsd)

#### Example(s)

##### Re-scope Role Request using XML

~~~
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roles/XXXXXXXXXXXXXX/rescope HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4ee243692b88f9f72b19c1a3
Accept: application/xml
Content-Type: application/xml
Host: localhost:8443
Content-Length: 50

<scope xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <roleScope>Public_SAR</roleScope>
</scope>
~~~

##### Re-scope Role Request using JSON

~~~
PUT https://localhost:8443/v2.0/HP-IDM/v1.0/roles/XXXXXXXXXXXXXX/rescope HTTP/1.1
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
~~~

##### Re-scope Role Response using XML

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=A392086B1A5647F855359EDD826EB314; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Fri, 09 Dec 2011 17:26:22 GMT
~~~

##### Re-scope Role Response using JSON

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=A392086B1A5647F855359EDD826EB314; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Fri, 09 Dec 2011 17:26:22 GMT
~~~

Delete Role Definition
----------------------

Verb

URI

Description

**DELETE**

***[csbu:HPKeystoneExtensionBaseURI]/roles/{roleId}***

Delete a role.

#### Detailed Description

 This API is used to delete a role definition identified by roleId. Role
deletion is a privileged operation.

#### **Normal Response Codes**

**204** (No Content)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*No user association with provided tenantId  ( via roles )*

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*

***404**** *(Item not found)

*Token is not valid*

***409**** *(Conflict)

*In case of existing role assignment for the role*

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

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

#### *Preconditions & Default Behavior*

*System should be bootstrap with some roles as explained in the*
[Bootstrap roles and RoleRefs](http://wiki.hpcloud.net/display/csbu/Bootstrap+roles+and+RoleRefs) page.

*Subject should be authenticated and authorized to use this API and must
have valid token.*

#### Request and response schema,  XML Schema Definition 

#### Example(s)

##### Delete Role Request using XML

~~~
DELETE /v2.0/HP-IDM/v1.0/roles/xxxxxxxxxx HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### Delete Role Request using JSON

~~~
DELETE /v2.0/HP-IDM/v1.0/roles/xxxxxxxxxx HTTP/1.1
Accept: application/xml
Content-Type: application/json
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### Delete Role Response using XML

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Thu, 11 Aug 2011 17:21:35 GMT
~~~

##### Delete Role Response using JSON

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Thu, 11 Aug 2011 17:21:35 GMT
~~~

Get a Role Definition
---------------------

Verb

URI

Description

**GET**

***[csbu:HPKeystoneExtensionBaseURI]/roles/{roleId}***

Get a role.

#### Detailed Description

 This API is used to get a role defined in the a domain. Users are not
allowed to access roles from other domains. Cloudadmin can get any role
from any domain.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*No user association with provided tenantId  ( via roles )*

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*

***404**** *(Item not found)

*Token is not valid*

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

*The server is unavailable to process the request.*

Please refer to error response body for additional details.

#### Header Values

No additional header values required.

#### *Query String Values*

*No additional query string values required.*

#### Request and Response Resource Representations

The request and response is of type role from
[authz-models.xsd](http://wiki.hpcloud.net/download/attachments/229474615/authz-models.xsd)

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

*Subject should be authenticated and authorized to use this API and must
have valid token.*

#### Request and response schema,  XML Schema Definition 

#### Example(s)

##### Role Request using XML

~~~
GET /v2.0/HP-IDM/v1.0/roles/xxxxxxxxxxx HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive
~~~

##### Role Request using JSON

~~~
GET /v2.0/HP-IDM/v1.0/roles/xxxxxxxxxxx HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive
~~~

##### Role Response using XML

~~~
<role xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
        <roleId>xxxxxxxxxxxx</roleId>
        <roleName>db-admin</roleName>
    <description>db-admin for abc tenant</description>
    <tenantId>xxxxxxxxxxxx</tenantId>
         <serviceId>xxxxxxxxxxxxxx</serviceId>
    <domainId>xxxxxxxxxxxx</domainId>
</role>
~~~

##### Role Response using JSON

~~~
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
~~~