---  
title : Authorization Operations

---

Authorization Result
--------------------

Verb

URI

Description

**POST**

***[csbu:HPKeystoneExtensionBaseURI]/authorization/hasAuth***

Get the authorization result

#### Detailed Description

 This API is used to check the subject's privilege on a particular
target specified by the path. As per the HP's extension, authorization
policy can be associated with User or Role, authorization check can also
performed for User, Role.

#### **Normal Response Codes**

**200** (OK)

#### Error Response Codes

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

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

No additional query string values required.

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

#### **Request and Response schema,  XML Schema Definition **

Request and response schema
[authz-models.xsd](http://wiki.hpcloud.net/download/attachments/229474615/authz-models.xsd)

#### Example(s)

##### Authorization Result Request using XML

~~~
<hasAuthRequests xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
    <hasAuthRequest>
      <subjectId>11111111111111</subjectId>
      <subjectType>User</subjectType>
      <targetDomainId>xxxxxxxxxxxxxx</targetDomainId>
      <targetTenantId>yyyyyyyyyyyyyy</targetTenantId>
      <targetInterface>UMS</targetInterface>
      <target>/user/22222222222222/*</target>
      <privileges>Read</privileges>
      <privileges>Create</privileges>
   </hasAuthRequest>
   <hasAuthRequest>
      <subjectId>11111111111111</subjectId>
      <subjectType>User</subjectType>
      <targetDomainId>xxxxxxxxxxxxxx</targetDomainId>
      <targetTenantId>yyyyyyyyyyyyyy</targetTenantId>
      <targetInterface>UMS</targetInterface>
      <target>/user/33333333333333/*</target>
      <privileges>Read</privileges>
      <privileges>Create</privileges>
   </hasAuthRequest>
</hasAuthRequests>
~~~

##### AuthorizationResult Request using JSON

~~~
{
  "hasAuthRequests": {
    "hasAuthRequest": [
      {
        "subjectId": "11111111111111",
        "subjectType": "User",
        "targetDomainId": "xxxxxxxxxxxxxx",
        "targetTenantId": "yyyyyyyyyyyyyy",
        "target": "/user/22222222222222/*",
        "targetInterface": "UMS",
        "privileges": [
          "Read",
          "Create"
        ]
      },
      {
        "subjectId": "11111111111111",
        "subjectType": "User",
        "targetDomainId": "xxxxxxxxxxxxxx",
        "targetTenantId": "yyyyyyyyyyyyyy",
        "target": "/user/33333333333333/*",
        "targetInterface": "UMS",
        "privileges": [
          "Read",
          "Create"
        ]
      }
    ]
  }
}
~~~

##### Authorization Result Response using XML

~~~
<hasAuthResult xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <code>Deny</code>
   <reason>User not authorized</reason>
   <detail>specific information if needed</detail>
</hasAuthResult>
~~~

##### Authorization Result Response using JSON

~~~
{
  "hasAuthResult": {
    "result": "Deny",
    "reason": "User not authorized",
    "detail": "specific information if needed"
  }
}
~~~

Trust Result (Prove Trust) (Not Needed Will be removed)
-------------------------------------------------------

Verb

URI

Description

POST

*[csbu:HPKeystoneExtensionBaseURI]**/hasTrust*

Get the trust result, prove trust between two tenants.

#### Detailed Description

 User can perform action across the  domains,  to support cross domain
operations there must be trust relation established between domains. 
This API used to prove trusts between two domain.

#### Normal Response Codes

200 (OK)

#### *Error Response Codes*

*401 (Unauthorized), 403 (forbidden), 400 (bad request), 500 (identity
fault), 503 (service unavailable)*

#### Header Values

No additional header values present.

#### *Query String Values*

*No additional query string present.*

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

*Subject should be authenticated and authorized before invoking roles
API and must have valid token.*

#### Example(s)

##### Trust Result Request using XML

~~~
<hasTrustRequest xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
    <domainId>11111111111</domainId>
    <trustedDomainId>222222222222</trustedDomainId>
</trustRequest>
~~~

##### Trust result Request using JSON

~~~
{
  "hasTrustRequest": {
    "domainId": "11111111111",
    "trustedDomainId": "222222222222",
  }
}
~~~

##### Trust result Response using XML

~~~
<hasTrustResult xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <code>Indeterminate</code>
   <reason>User not authorized</reason>
   <detail>specific information if needed</detail>il>
</trustResult>
~~~

##### Trust result Response using JSON

~~~
{
  "hasTrustResult": {
    "result": "Indeterminate",
    "reason": "User not authorized",
    "detail": "specific information if needed"
  }
}
~~~

Get a List of Trusts
--------------------

Verb

URI

Description

**GET**

***[csbu:HPKeystoneExtensionBaseURI]******/trusts?tenantId=value&limit=pagesize&marker=trustId***

Get a list of trusts defined in system.

#### Detailed Description

 This API is used to list all the established trusts in the system, a
query parameter is supported to list tenant specific trusts.

#### **Normal Response Codes**

**200** (OK)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### Header Values

No additional header values present.

#### *Query String Values*

tenantId and 'limit' and 'marker' values. See* *[Pagination with limit
and marker query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")

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

Subject should be authenticated and authorized before invoking roles API
and must have valid token.

#### **Request and Response schema,  XML Schema Definition **

TODO: Add XSD Link here

#### Example(s)

##### Trusts Request using XML

TODO, show the HTTP request

##### Trusts Request using JSON

TODO, show the HTTP request

##### Trusts Response using XML

~~~
<trusts xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
   <trust>
      <domainId>1111111111</domainId>
      <trustedDomainId>22222222</trustedDomainId>
      <expirationDate>MM-DD-YYYY</expirationDate>
      <agreementDate>MM-DD-YYYY</agreementDate>
   </trust>
   <trust>
      <domainId>1111111111</srcTenantAccountId>
      <trustedDomainId>3333333</destTenantAccountId>
      <expirationDate>MM-DD-YYYY</expirationDate>
      <agreementDate>MM-DD-YYYY</agreementDate>
   </trust>
</trusts>
~~~

##### Trusts Response using JSON

~~~
{
  "trusts": {
    "trust": [
      {
        "domainId": "1111111111",
        "trustedDomainId": "22222222",
        "expirationDate": "MM-DD-YYYY",
        "agreementDate": "MM-DD-YYYY"
      },
      {
        "domainId": "1111111111",
        "trustedDomainId": "333333333",
        "expirationDate": "MM-DD-YYYY",
        "agreementDate": "MM-DD-YYYY"
      }
    ]
  }
}
~~~

Add a Trust
-----------

Verb

URI

Description

**POST**

***[csbu:HPKeystoneExtensionBaseURI]******/trusts***

Add a trust.

#### Detailed Description

This API is used to add a trust on behalf of the tenants, system also
keeps track of who established the trust.

User can perform some action across the tenant accounts, to support
cross tenant operations there must be trust relation established between
tenant accounts. Trust are not symmetric by default, means, A trust B
does not means B trust A, to support symmetric  trust relation (A trust
B then B trust A) between tenant account there must be two separate
trust established. Trust are not transitive means if A trust B and B
trust C that does not mean A trust C.

**Use Case:** **To Allow VM access (VM-TA) which is owned by one tenant
(Tenant-A) to the user (User-TB) from another tenant account
(Tenant-B).**

 1. Add a trust (Tenant-A trust Tenant-B)

 2. Define a role (Guest-TB) in Tenant-A

 3. Create a access policy to allow role "Guest-TB" on the "VM-TA"

 4. Assign "User-TB" from Tenant-B to the role "Guest-TB"

#### **Normal Response Codes**

**201** (Created)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

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

*No additional Query string values required.*

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

#### Open Issues

None.

#### *Preconditions & Default Behavior*

Subject should be authenticated and authorized before invoking roles API
and must have valid token.

#### **Request and Response schema,  XML Schema Definition **

TODO: Add XSD Link here

#### Example(s)

##### Add Trust Request using XML

~~~
<trust xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
      <domainId>1111111111</domainId>
      <trustedDomainId>22222222</trustedDomainId>
      <expirationDate>MM-DD-YYYY</expirationDate>
      <agreementDate>MM-DD-YYYY</agreementDate>
   </trust>
~~~

##### Add Trust Request using JSON

~~~
{
  "trust": {
        "domainId": "1111111111",
        "trustedDomainId": "22222222",
        "expirationDate": "MM-DD-YYYY",
        "agreementDate": "MM-DD-YYYY"
      }
}
~~~

##### Add Trust Response using XML

~~~
<trust xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
      <domainId>1111111111</domainId>
      <trustedDomainId>22222222</trustedDomainId>
      <expirationDate>MM-DD-YYYY</expirationDate>
      <agreementDate>MM-DD-YYYY</agreementDate>
   </trust>
~~~

##### Add Trust Response using JSON

~~~
{
  "trust": {
        "domainId": "1111111111",
        "trustedDomainId": "22222222",
        "expirationDate": "MM-DD-YYYY",
        "agreementDate": "MM-DD-YYYY"
      }
}
~~~

Delete a Trust
--------------

Verb

URI

Description

**DELETE**

***[csbu:HPKeystoneExtensionBaseURI]******/trusts/{roleId}***

Delete a trust.

#### Detailed Description

 This API is used to delete a trust.

#### **Normal Response Codes**

**204** (No Content)

#### **Error Response Codes**

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Malformed request in URI or request body

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

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

*No additional Query string values required.*

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

#### Open Issues

None.

#### *Preconditions & Default Behavior*

*Subject should be authenticated and authorized before invoking roles
API and must have valid token.*

#### **Request and Response schema,  XML Schema Definition **

TODO: Add XSD Link here

#### Example(s)

TODO: Show example with HTTP request params

##### Remove Trust Request using XML

N/A

##### Remove Trust Request using JSON

N/A

##### Remove Trust Response using XML

N/A

##### Remove Trust Response using JSON

N/A