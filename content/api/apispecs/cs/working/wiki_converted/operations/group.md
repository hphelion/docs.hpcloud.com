---  
title : Group Operations

---  

**Create a Group **
-------------------

Verb

URI

Description

POST

***[csbu:HPKeystoneExtensionBaseURI]/groups***

*Create a group in the specified domain*


#### **Detailed Description**

This API is used to create a group within the specified domain. The domainId is part of request body

#### **Normal Response Codes**

**201** (Created)

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

The specified domainId is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*No additional* *query string values required.*

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

#### ***Preconditions & Default Behavior***

*Subject should be authenticated and authorized to use this API and must
have valid token.*

#### Request and Response schema,  XML Schema Definition 

[domainGroups.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domainGroups.xsd)

**Example(s)**

##### **Create Group Request using XML**

~~~
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
~~~

##### **Create Group Request using JSON**

~~~
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
~~~

##### **Create Group Response Using  XML**

~~~
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
~~~

##### **Create Group Response Using  JSON**

~~~
HTTP/1.1 201 Created
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
    "id": "30704719895847",
    "name": "HP Software",
    "otherAttributes": {

    }
  }
}
~~~

**Get a Specific Group **
-------------------------

Verb

URI

Description

GET

***[csbu:HPKeystoneExtensionBaseURI]/groups/{groupId}***

Get a specific group

#### **Detailed Description**

Get a specific group resource specified by the groupId.

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

The specified groupId is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*No additional* *query string values required.*

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

#### Preconditions & Default Behavior

Subject should be authenticated and authorized to use this API and must have valid token.

#### Request and Response schema, XML Schema Definition

[domainGroups.xsd|http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domainGroups.xsd]


**Example(s)**


##### GetSpecificGroup request using XML

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Type : application/xml
~~~

##### **GetSpecificGroup request using JSON**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **GetSpecifcGroup  response using XML**

~~~
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
~~~

##### **GetSpecificGroup response using JSON**

~~~
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
~~~

**Update a Group **
-------------------

Verb

URI

Description

PUT

***[csbu:HPKeystoneExtensionBaseURI]/groups/{groupId}***

Update a group


#### **Detailed Description**

Update a group resource for the specified groupId. Only description
and name can be updated in this operation.

#### **Normal Response Codes**

**200** (OK), group resource has been updated.

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

The specified groupId is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*No additional* *query string values required.*

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

#### ***Preconditions & Default Behavior***

*Subject should be authenticated and authorized to use this API and must have valid token.*

#### Request and Response schema, XML Schema Definition 

[domainGroups.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domainGroups.xsd)

**Example(s)**

##### **Update Group Request using XML**

~~~
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
~~~

##### **Update Group Request using JSON**

~~~
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
~~~

##### **Update Group Response using XML**

~~~
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
~~~

##### **Update Group Response using JSON**

~~~
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
~~~

**Delete a Group **
-------------------

Verb

URI

Description

DELETE

***[csbu:HPKeystoneExtensionBaseURI]/groups/{groupId}***** **

Delete a group


#### **Detailed Description**

Delete a group specified by the groupId. This operation also deletes the
associated Roles associated to the Group. This operation does not delete
User objects associated with the Group.

#### **Normal Response Codes**

**204** (No Content)

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

The specified groupId is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No special additional header value required.

#### ***Query String Values***

*No additional* *query string values required.*

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

#### ***Preconditions & Default Behavior***

*Subject should be authenticated and authorized to use this API and must
have valid token.*

#### Request and Response schema,  XML Schema Definition 

[domainGroups.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domainGroups.xsd)

**Example(s)**

##### **Deete Group Request using XML**

~~~
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/245398746613/ HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **Delete Group Request using JSON**

~~~
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/245398746613/ HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **Delete Group Response using XML & JSON**

**Response for delete group**

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=37BD6EDBDC2A58CD18201DFD2C21B6C2; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 28 Dec 2011 19:14:46 GMT
~~~

Get list of Users for Specified Group
-------------------------------------

Verb

URI

Description

GET

***[csbu:HPKeystoneExtensionBaseURI]/groups/{groupId}/users******?***{\*}{\_}limit=pagesize&marker=userId&

Unknown macro: {username=userName}

 \_\* \

List the users for a specified group

#### **Detailed Description**

This API is used to list the users for a specified group and takes a
"marker" and "limit" parameter to limit the number of Users in the
response. 

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

The specified groupId is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*'limit' and 'marker' values. See **[Pagination with limit and marker
query
parameters](Pagination%20with%20limit%20and%20marker%20query%20parameters.html "Pagination with limit and marker query parameters")*

#### ***Query Filter Values: QueryFilters are optional***

*username =
username*[\\|../../../../../../../../../../display/iaas/Pagination+with+limit+and+marker+query+parameters|]

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

#### ***Preconditions & Default Behavior***

*Subject should be authenticated and authorized to use this API and must have valid token.*

#### Request and Response schema,  XML Schema Definition 

[domainGroups.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domainGroups.xsd)

**Example(s)**

##### **List users for group request using XML with optional query filters**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users?username=username HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Type : application/xml
~~~

##### **List users for group request using XML**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/hp/v1.0/groups/245398746613/users HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Type : application/xml
~~~

**List users for group request using JSON**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/245398746613/users HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

**List users for group request using JSON with optional query filters**

~~~
GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/245398746613/users?username=username HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **List users for group response using XML**

~~~
<groups xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
   <group id="00000000002002" name="Users">
      <description>HP System domain users group</description>
   </group>
   <group id="39559496895932" name="HaneefGroup3">
      <description>A Description of the group1</description>
   </group>
</groups>
~~~

##### **List users for group response using JSON**

~~~
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
~~~

Add a User to a Specified Group 
--------------------------------

Verb

URI

Description

**PUT**

***[csbu:HPKeystoneExtensionBaseURI]/groups/{groupId}/users/{userId}***

Add a user to a specified group

#### **Detailed Description**

This API is used to add an existing user to a specified group of the
given domain. This interface requires the groupId and userId.

#### **Normal Response Codes**

**200** (Created)

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

The specified groupId or userId is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*No additional* *query string values required.*

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

#### ***Preconditions & Default Behavior***

*Subject should be authenticated and authorized to use this API and must have valid token.*

#### Request and Response schema,  XML Schema Definition 

[domainGroups.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domainGroups.xsd)

**Example(s)**

##### **AddUserToGroup request using XML**

~~~
PUT http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Length: 0
~~~

##### **AddUserToGroup request using JSON**

~~~
PUT http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM//v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/json
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
Content-Length: 0
~~~

##### **AddUserToGroup response using XML & JSON**

~~~
HTTP/1.1 303 Created
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Location: http://haneef-desktop.americas.hpqcorp.net:8080/cs/rest/groupId/583891759678
Content-Length: 0
Date: Mon, 01 Aug 2011 18:27:33 GMT
Connection: close
~~~


Remove a User From a Group
--------------------------

Verb

URI

Description

**DELETE**

***[csbu:HPKeystoneExtensionBaseURI]/groups/{groupId}/user/{userId}***

Remove a user from a group

#### **Detailed Description**

This API is used to remove a user from a group.  Note, users and
RoleRefs may depend on a group. If there are users in a group, or roles
references to a group, then a  group can't be deleted . 

#### **Normal Response Codes**

**204** (No Content)

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

The specified groupId or userId is not found.

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*No additional* *query string values required.*

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

#### ***Preconditions & Default Behavior***

*Subject should be authenticated and authorized to use this API and must have valid token.*

#### **Example(s)**

##### **RemoveUserFromGroup request using XML**

~~~
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **RemoveUserFromGroup request using JSON**

~~~
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/groups/583891759678/users/993639569203 HTTP/1.1
Connection: close
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **RemoveUserFromGroup response using XML & JSON**

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Mon, 01 Aug 2011 18:31:40 GMT
Connection: close
~~~

##### Note:

XSD Location :
 [domainGroups.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/domainGroups.xsd)
