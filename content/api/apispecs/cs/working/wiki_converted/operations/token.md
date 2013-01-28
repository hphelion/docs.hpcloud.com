---  
title : Token Operations

---  

### **Authenticate (Obtain authentication token)**

Verb

URI

Description

**POST**

***[iaas:KeystoneBaseURI]******/tokens***

Authenticates the user and returns a bearer token

#### **Detailed Description**

This API is used to authenticate a user to be able to use an Openstack
service. The result of a successful authentication is a token to be used
with service requests. A username and password or access/secret key
credentials are given as input to this interface.  If authentication
succeeds, the response will include an authentication token and service
catalog ( list of available services for that user ).  Tokens are valid
for 12 hours.  Issued tokens can become invalid in two cases: 1) token
has expired and 2) token has been revoked.  In the event a user has been
disabled, currently issued tokens will remain valid until expired.

Besides using a username and password, another way to authenticate is
using symmetric keys. Symmetric keys are user access key and secret key
pairs provisioned for user account.  In this type of credential data,
request body is expected to contain access key and secret key
information belonging to the user. Once those keys are verified,  new
token is created. In this type of authentication, change is in expected
request body data (please see related example below). There is no
difference in response format/content whether authentication is done
using password credential data or access key credential data.

##### Token Generation

Now when an authentication request is made for a user who already has an
unexpired token (for same credential data and tenant as the one provided
in request) in the system, same token is returned instead of creating a
new one. When existing token is returned, token expiration time is
refreshed for another lease of 12 hours from current time. Along the
same lines, in case of multiple unscoped token requests, same token is
returned as long as token is not expired (along with other
validations).\
 This renew of existing token's expiration time happens till subsequent
authenticate request comes within initial lease time frame (i.e. 12
hours from token creation time) of token. If request comes after initial
lease time, then instead a new token is generated with 12 hours
expiration time. And then subsequent authenticate request gets this
newly generated token as long as the request is within that token's
initial lease time. So this way, system can limit the number of active
tokens for clients frequently authenticating with same credential data
(and tenant). Also for all authentication request, token is guaranteed
to be always valid for token default expiration duration i.e. 12 hours.

For getting scoped token, either tenantId or tenantName can be used.  If
both are used, error is returned.

###### Service Catalog:

In case of un-scoped token request, the service catalog is going to
include global active endpoint templates as endpoints in its data. In
case of scoped token request, the service catalog is going to include
tenant specific endpoints as well as global active endpoint templates as
endpoints. If URL attribute of endpoint templates contains %tenant\_id%,
this is going to be replaced by actual tenantId when returning them as
part of service catalog. This applies to publicURL, internalURL and
adminURL attribute of endpoint template data. In service catalog, for
swift service, its going to be replaced by swift account hash if its
available for that tenant. This swift account hash replacement is done
only for endpoints which matches with swift service name and its service
type.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*
 When both tenantId and tenantName is provided in request.

***401**** *(Unauthorized)

*Invalid username*
 *Invalid password*
 *Invalid TenantId*
 *No user association with provided tenantId  ( via roles )*
 Invalid access key
 Invalid secret key
 *Inactive access key*
 *Expired access key*

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*

***503**** *(Service Unavailable)

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*No additional query string values required.*

#### Request and Response Resource Representations

Content Type

Supported

XSD

Yes. Based on standard keystone schema.

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 

[token.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/token.xsd)
[roles.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/roles.xsd)
[hp-credentials.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/hp-credentials.xsd)
[hp-accesskey-credentials.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/ext/hp-accesskey-credentials.xsd)

#### **Example(s)**

##### **Authentication Request using XML request body (Password credential data)**

~~~
POST https://localhost:8443/v2.0/tokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 211

<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantName="HP5 Tenant Services">
  <passwordCredentials username="arunkant" password="changeme"/>
</auth>
~~~

##### **Authentication Request using JSON request body (Password credential data)**

~~~
POST https://localhost:8443/v2.0/tokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Content-Length: 171
Host: localhost:8443

{
    "auth":{
        "passwordCredentials":{
            "username":"arunkant",
            "password":"changeme"
        },
        "tenantId":"95096564413950"
    }
}
~~~

##### **Authentication Request using XML request body (Access key credential data)**

~~~
POST https://localhost:8443/cs/identity/api/v2.0/tokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 219

<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
  <apiAccessKeyCredentials secretKey="vpGCFNzFZ8BMP1g8r3J6Cy7/ACOQUYyS9mXJDlxc" accessKey="9N488ACAF3859DW9AFS9"/>
</auth>
~~~

##### **Authentication Request using JSON request body (Access key credential data)**

~~~
POST https://localhost:8443/v2.0/tokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 176

{
    "auth":{
        "apiAccessKeyCredentials":{
            "accessKey":"19N488ACAF3859DW9AFS9",
            "secretKey":"vpGCFNzFZ8BMP1g8r3J6Cy7/ACOQUYyS9mXJDlxc"
        }       
    }
}
~~~

##### **Authentication XML Response (same response for password and access key credential data)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 2667
Date: Fri, 14 Oct 2011 21:18:40 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4e98a5dbb0befc448cd0454f" expires="2011-10-14T21:42:59.455Z">
      <tenant id="14541255461800" name="HR Tenant Services"/>
   </token>
   <user id="30744378952176" name="arunkant">
      <roles>
         <role id="00000000004008" name="nova:developer" serviceId="120" tenantId="14541255461800"/>
         <role id="00000000004003" name="domainadmin" serviceId="100" tenantId="14541255461800"/>
         <role id="00000000004004" name="domainuser" serviceId="100" tenantId="14541255461800"/>
         <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="14541255461800"/>
      </roles>
   </user>
   <serviceCatalog>
      <service type="compute" name="storage5063096349006363528">
         <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
            <version/>
         </endpoint>
      </service>
      <service type="object-store" name="Object Storage">
         <endpoint region="region-a.geo-1" tenantId="14541255461800" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800" internalURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/auth/v1.0/">
            <version id="1.0" info="https://region-a.geo-1.objects.hpcloudsvc.com/info/v1.0" list="https://region-a.geo-1.objects.hpcloudsvc.com/allVersions"/>
         </endpoint>
      </service>
      <service type="identity" name="Identity">
         <endpoint region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" internalURL="hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0">
            <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
         </endpoint>
      </service>
      <service type="compute" name="storage5065129211418544729">
         <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
            <version/>
         </endpoint>
      </service>
      <service type="compute" name="storage5042344434157721570">
         <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
            <version/>
         </endpoint>
      </service>
   </serviceCatalog>
</access>
~~~

##### **Authentication JSON Response (same response for password and access key credential data)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 3248
Date: Fri, 14 Oct 2011 21:17:14 GMT


{"access": {
   "token":    {
      "expires": "2011-10-14T21:42:59.455Z",
      "id": "HPAuth_4e98a5dbb0befc448cd0454f",
      "tenant":       {
         "id": "14541255461800",
         "name": "HR Tenant Services"
      }
   },
   "user":    {
      "id": "30744378952176",
      "name": "arunkant",
      "roles":       [
                  {
            "id": "00000000004008",
            "serviceId": "120",
            "name": "nova:developer",
            "tenantId": "14541255461800"
         },
                  {
            "id": "00000000004003",
            "serviceId": "100",
            "name": "domainadmin",
            "tenantId": "14541255461800"
         },
                  {
            "id": "00000000004004",
            "serviceId": "100",
            "name": "domainuser",
            "tenantId": "14541255461800"
         },
                  {
            "id": "00000000004017",
            "serviceId": "100",
            "name": "tenant-member",
            "tenantId": "14541255461800"
         }
      ]
   },
   "serviceCatalog":    [
            {
         "name": "storage5063096349006363528",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
            "region": "SFO"
         }]
      },
            {
         "name": "Object Storage",
         "type": "object-store",
         "endpoints": [         {
            "tenantId": "14541255461800",
            "adminURL": "https://region-a.geo-1.objects.hpcloudsvc.com/auth/v1.0/",
            "internalURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800",
            "publicURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800",
            "region": "region-a.geo-1",
            "id": "1.0",
            "info": "https://region-a.geo-1.objects.hpcloudsvc.com/info/v1.0",
            "list": "https://region-a.geo-1.objects.hpcloudsvc.com/allVersions"
         }]
      },
            {
         "name": "Identity",
         "type": "identity",
         "endpoints": [         {
            "adminURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
            "internalURL": "hhttps://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
            "publicURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0",
            "region": "region-a.geo-1",
            "id": "2.0",
            "info": "https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0",
            "list": "https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"
         }]
      },
            {
         "name": "storage5065129211418544729",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
            "region": "SFO"
         }]
      },
            {
         "name": "storage5042344434157721570",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
            "region": "SFO"
         }]
      }
   ]
}}
~~~

##### **Authentication XML Request (scoped token for tenant with swiftAccountHash value defined)**

~~~
POST https://localhost:8443/v2.0/tokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Content-Length: 211
Host: localhost:8443

<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantId="75317651474044">
  <passwordCredentials username="arunkant" password="changeme"/>
</auth>
~~~

##### **Authentication XML Response (service catalog using swiftAccountHash in catalog URL)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=CEF92560877589B666CE4DAEF76E103B; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 1638
Date: Wed, 11 Jan 2012 00:14:47 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4f0cd477b0beb12ecbf704c5" expires="2012-01-11T00:44:47.691Z">
      <tenant id="75317651474044" name="HP Swift Tenant Services"/>
   </token>
   <user id="60705352497264" name="arunkant">
      <roles>
         <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="75317651474044"/>
         <role id="00000000004004" name="domainuser" serviceId="100"/>
         <role id="00000000004003" name="domainadmin" serviceId="100"/>
      </roles>
   </user>
   <serviceCatalog>
      <service type="compute" name="storage63778037336913369">
         <endpoint region="SFO" publicURL="https://localhost:8443/identity/api/v2.0/public/0" internalURL="https://localhost:8443/identity/api/v2.0/internal/0" adminURL="https://localhost:8443/identity/api/v2.0/admin/0">
            <version/>
         </endpoint>
      </service>
      <service type="object-store" name="Object Storage">
         <endpoint region="region-a.geo-1" tenantId="75317651474044" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/1234bcdefgh" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/">
            <version id="1.0"/>
         </endpoint>
      </service>
      <service type="identity" name="Identity">
         <endpoint region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/">
            <version id="2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/extension"/>
         </endpoint>
      </service>
   </serviceCatalog>
</access>
~~~

**Authenticate v1.0/v1.1 (Swift)**
----------------------------------

Verb

URI

Description

Privilege Level

**GET**

***/v1.0***

Authenticate and get a v1/v1.1 token for Swift

Anon

**GET**

***/v1.1***

Authenticate and get a v1/v1.1 token for Swift

Anon

**GET**

***/auth/v1.0***

Authenticate and get a v1/v1.1 token for Swift

Anon

**GET**

***/auth/v1.1***

Authenticate and get a v1/v1.1 token for Swift

Anon

#### **Detailed Description**

Pre-Keystone (aka auth v2.0), Openstack services rely on disparate
authentication mechanisms to authenticate their services.  For example,
Swift uses swauth, while Nova uses novaauth.  The v1/v1.1 style of
authentication relies on custom HTTP headers (specific to each service)
to communicate authentication data, rather than relying on well-defined
XML/JSON documents that can be validated via XSDs.  With the release of
Diablo, most Openstack services have switched to using Keystone API
completely, with the exception of the Swift CLI tool.  To provide
backward-compatibility for this particular tool, CS (as well as the FOSS
Keystone) provides this API.  Underneath the hood, CS simply re-routes
the request to a v2.0 auth token request (POST) and provides the auth
headers that the Swift CLI expects.

Please see more details around token generation at [Token
Generation ](https://wiki.hpcloud.net/display/iaas/Token+Operations#TokenOperations-tokenGeneration).

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*

***401**** *(Unauthorized)

*Invalid username*
 *Invalid password*
 *Invalid TenantId*
 *No user association with provided tenantId  ( via roles )*
 Invalid access key
 Invalid secret key

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*
 *Inactive access key*
 *Expired access key*

***503**** *(Service Unavailable)

Please refer to error response body for additional details.

#### **Header Values**

##### **Request**

-   X-Auth-User:  Header containing the \<tenantId:username\> for a
    scoped token for Swift.
-   X-Auth-Key:  Header containing the password for the given user.

> Note that X-Storage-User and X-Storage-Pass headers are ***not*** supported.  This is done per Keystone specification.

##### **Response**

-   X-Auth-Token:  Header containing the token ID.
-   X-Storage-URL:  Header containing a list of public endpoints for
    Swift

#### ***Query String Values***

*No additional query string values required.*

#### Request and Response Resource Representations

Content Type

Supported

XSD

No (No Keystone XSD available)

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 

N/A

#### **Example(s)**

**Auth request** for a user with Swift privileges on tenant ID
145657307748:

~~~
curl -k -i -H 'X-Auth-User:145657307748:joeuserA@timewarner.com' -H 'X-Auth-Key:XyZ' https://az1-cs-node-0000.rndd.aw1.hpcloud.net:35357/v1.0
~~~

Note that the request works the same at URI /v1.1 or /auth/v1.0 or
/auth/v1.1 as well.

**Auth response** for the above request:

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
X-Auth-Token: HPAuth_4f03696fe4b071e9f15c0550
X-Storage-Url: https://az1-sw-proxy-ext-0001.rndd.aw1.hpcloud.net:443/v1.0/14565730729748
Content-Type: application/json
Content-Length: 1583
Date: Tue, 03 Jan 2012 20:47:43 GMT

{"access": {
  "token": {
    "expires": "2012-01-03T21:17:43.087Z",
    "id": "HPAuth_4f03696fe4b071e9f15c0550",
    "tenant": {
      "id": "14565730729748",
      "name": "Swift SSL"
    }
  },
  "user": {
    "id": "70970596121812",
    "name": "joeuserA@timewarner.com",
    "roles": [
      {
        "id": "00000000004022",
        "serviceId": "110",
        "name": "Admin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004013",
        "serviceId": "130",
        "name": "block-admin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004025",
        "serviceId": "120",
        "name": "sysadmin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004016",
        "serviceId": "120",
        "name": "netadmin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004024",
        "serviceId": "140",
        "name": "user",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004014",
        "serviceId": "150",
        "name": "cdn-admin",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser",
        "tenantId": "14565730729748"
      },
      {
        "id": "00000000004014",
        "serviceId": "150",
        "name": "cdn-admin",
        "tenantId": "14565730729748"
      }
    ]
  }
}}
~~~

**Validate Token**
------------------

Verb

URI

Description

**GET**

***[iaas:KeystoneBaseURI]******/tokens/{tokenId}?belongsTo=tenantId&******HP-IDM-serviceId=*****110,global,130&HP-IDM-endpointTemplateId=110,111**

Check that a token is valid and that it belongs to a particular user.
Return relevant groups and/or roles.
 optional 'HP-IDM-serviceId' paramater for getting service specific
roles. 
 optional 'HP-IDM-endpointTemplateId' for getting endpoint template
specific roles.

#### **Detailed Description**

This API is used to validate a token. Validation includes checking that
the token belongs to a particular user and it has not expired.  On
successful validation, the response contains permissions relevant to a
particular client. If the query parameter, belongTo, is provided the
call will check the corresponding tenantId to ensure that token belongs
to that tenant. If there is no tenantId then it is globally scoped. In
the event a token is not valid, a 404 (item not found) will be returned.

###### Filter Roles

For scoped token validation, optional query parameter **HP-IDM-serviceId
and/or ****HP-IDM-endpointTemplateId** can be used to include only
specific subset of roles in response. If the parameter values are
provided and there are no specific roles found, then 401 (unauthorized)
error is generated. Both HP-IDM-serviceId and HP-IDM-endpointTemplateId
parameter can be used in a validate token request.
 In HP-IDM-serviceId and HP-IDM-endpointTemplateId  parameter
values, multiple ids can be specified as comma separated values. To
request global roles to be included in response, global identifier
(which is currently configured as '**global**') must be used in either
of query parameter value. If both of query parameters are not specified
or has empty values, then response include all roles available for that
scoped token. In case of unscoped token validation, only global roles
are returned and HP-IDM-serviceId and HP-IDM-endpointTemplateId query
parameter, if there, is ignored.
 In case HP-IDM-endpointTemplateId value is provided for scoped token
validation, system looks into existing tenant endpointTemplate
association and uses that to filter matching endpoint specific roles. As
a service can have multiple endpoints (i.e. endpointTemplate), so if
both a serviceId and its endpointTemplateId are provided as input, then
endpointTemplateId takes precedence and we ignore the provided
serviceId. This is done to find more granular role data which in this
case is endpoint template id.

In case of scoped token validation, if that tenant has swift account
hash available in CS system, then its value is returned as a response
header with name 'X-HP-IDM-swift-account-hash'.

Note: This request does not expect X-Auth-Token header but if its
provided, then it needs to be have a valid token value otherwise
forbidden (403) error is returned.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body.*
 Token doesn't belong to the tenant provided in 'belongsTo' query
parameter.

***401**** *(Unauthorized)

*Token is expired.*
 When service id(s) specified in query and no service specific role
is/are found.
 When endpoint template id(s) specified in query and no endpoint
specific role is/are found.
 When both serviceId and endpointTemplateId specified in query and no
specific role is/are found.

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*
 *If invalid X-Auth-Token header is provided (even though its not needed
in request)*

***404**** *(Item not found)

*Token is not valid* (not found)

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*Optional :    belongsTo=tenantId, Additional check to ensure token
belongs to specified tenant.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes, defined in keystone schema

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 

[token.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)

#### **Example(s)**

##### **ValidateToken  Request for JSON (unscoped token where ****HP-IDM-serviceId parameter value is ignored****)**

~~~
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a82d4b0be3c45af828494?HP-IDM-serviceId=110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### **ValidateToken JSON Response (unscoped token ****where ****HP-IDM-serviceId parameter value is ignored****)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=2016B87409FE559F89F1712EC4FA920E; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_USER_ID: 85397174931388
Content-Type: application/json
Content-Length: 459
Date: Fri, 09 Mar 2012 22:25:31 GMT

{"access": {
  "token": {
    "expires": "2012-03-10T10:23:16.730Z",
    "id": "HPAuth_4f5a82d4b0be3c45af828494",
    "tenant": {}
  },
  "user": {
    "id": "85397174931388",
    "name": "TestUser14892658343713707444",
    "roles": [
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin"
      },
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser"
      }
    ]
  }
}}
~~~

##### **ValidateToken  Request for XML (scoped token without any query parameters)**

~~~
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### **ValidateToken XML Response **** (scoped token without any query parameters)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=3E0537286726C3098D9C03EED0AAE588; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/xml
Content-Length: 903
Date: Fri, 09 Mar 2012 22:17:49 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4f5a7fe06a25ab00f896bee4" expires="2012-03-10T10:12:37.474Z">
      <tenant id="22674990706167" name="TestTenant14892659460460094027"/>
   </token>
   <user id="85397174931388" name="TestUser14892658343713707444">
      <roles>
         <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="22674990706167"/>
         <role id="00000000004026" name="projectmanager" serviceId="120" tenantId="22674990706167"/>
         <role id="00000000004003" name="domainadmin" serviceId="100"/>
         <role id="00000000004022" name="Admin" serviceId="110" tenantId="22674990706167"/>
         <role id="00000000004004" name="domainuser" serviceId="100"/>
      </roles>
   </user>
</access>
~~~

##### **ValidateToken  XML Request ( HP-IDM-serviceId parameter with 'global' and 110 service id value)**

~~~
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=global%2C110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### **ValidateToken  XML Response ( HP-IDM-serviceId parameter with 'global'  and 120 service id value)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=BBFC3BFF3CF218091AE9D03FAA3EE6D4; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/xml
Content-Length: 722
Date: Fri, 09 Mar 2012 22:19:40 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4f5a7fe06a25ab00f896bee4" expires="2012-03-10T10:12:37.474Z">
      <tenant id="22674990706167" name="TestTenant14892659460460094027"/>
   </token>
   <user id="85397174931388" name="TestUser14892658343713707444">
      <roles>
         <role id="00000000004022" name="Admin" serviceId="110" tenantId="22674990706167"/>
         <role id="00000000004003" name="domainadmin" serviceId="100"/>
         <role id="00000000004004" name="domainuser" serviceId="100"/>
      </roles>
   </user>
</access>
~~~

##### **ValidateToken  XML Request ( HP-IDM-serviceId parameter with 'global' only)**

~~~
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=global HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### **ValidateToken  XML Response ( HP-IDM-serviceId parameter with 'global' only)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=7554D639C2C12154A7C8688FA01E09FC; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/xml
Content-Length: 640
Date: Fri, 09 Mar 2012 22:13:45 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4f5a7fe06a25ab00f896bee4" expires="2012-03-10T10:12:37.474Z">
      <tenant id="22674990706167" name="TestTenant14892659460460094027"/>
   </token>
   <user id="85397174931388" name="TestUser14892658343713707444">
      <roles>
         <role id="00000000004003" name="domainadmin" serviceId="100"/>
         <role id="00000000004004" name="domainuser" serviceId="100"/>
      </roles>
   </user>
</access>
~~~

##### **ValidateToken JSON Request ( HP-IDM-serviceId parameter with 120 service id value)**

~~~
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=120 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### **ValidateToken  JSON Response ( HP-IDM-serviceId parameter with 120 service id value)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=D63D9FAC8FA835321F36E51CE07F2485; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/json
Content-Length: 454
Date: Fri, 09 Mar 2012 22:16:50 GMT

{"access": {
  "token": {
    "expires": "2012-03-10T10:12:37.474Z",
    "id": "HPAuth_4f5a7fe06a25ab00f896bee4",
    "tenant": {
      "id": "22674990706167",
      "name": "TestTenant14892659460460094027"
    }
  },
  "user": {
    "id": "85397174931388",
    "name": "TestUser14892658343713707444",
    "roles": [{
      "id": "00000000004026",
      "serviceId": "120",
      "name": "projectmanager",
      "tenantId": "22674990706167"
    }]
  }
}}
~~~

##### **ValidateToken XML Request ( HP-IDM-endpointTemplateId parameter with 110 (Compute - AZ2) value)**

~~~
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-endpointTemplateId=110%2C HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### **ValidateToken XML Response ( HP-IDM-endpointTemplateId parameter with 110 (Compute - AZ2) value)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=451446B2BE922152AD41799AC7453A0B; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/xml
Content-Length: 608
Date: Fri, 09 Mar 2012 22:38:55 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom" xmlns:ns4="http://docs.openstack.org/common/api/v1.0">
   <token id="HPAuth_4f5a7fe06a25ab00f896bee4" expires="2012-03-10T10:12:37.474Z">
      <tenant id="22674990706167" name="TestTenant14892659460460094027"/>
   </token>
   <user id="85397174931388" name="TestUser14892658343713707444">
      <roles>
         <role id="00000000004026" name="projectmanager" serviceId="120" tenantId="22674990706167"/>
      </roles>
   </user>
</access>
~~~

##### **ValidateToken JSON Request ( HP-IDM-endpointTemplateId parameter with 111 (Compute - AZ3) value)**

~~~
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-endpointTemplateId=111 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### **ValidateToken JSON Request ( HP-IDM-endpointTemplateId parameter with 111 (Compute - AZ3) value) -- No tenant endpoint association**

~~~
HTTP/1.1 401 Unauthorized
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=69608D18B38CF95E5A845FE4492BA522; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 187
Date: Fri, 09 Mar 2012 22:46:33 GMT

{
  "unauthorized" : {
    "anies" : null,
    "code" : 401,
    "details" : "Not authorized to access the service.",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
~~~

##### **ValidateToken XML Request  (HP-IDM-serviceId parameter with 110 (Object Storage service) value and HP-IDM-endpointTemplateId parameter with 110 (Compute - AZ2) value)**

~~~
GET https://localhost:8443/v2.0/tokens/HPAuth_4f5a7fe06a25ab00f896bee4?HP-IDM-serviceId=110&HP-IDM-endpointTemplateId=110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
~~~

##### **ValidateToken XML Response  (HP-IDM-serviceId parameter with 110 (Object Storage service) value and HP-IDM-endpointTemplateId parameter with 110 (Compute - AZ2) value)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=2609979BEE3D13851C77FE6EAAA40AA5; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
HTTP_X_TENANT_NAME: TestTenant14892659460460094027
HTTP_X_USER_ID: 85397174931388
Content-Type: application/xml
Content-Length: 690
Date: Fri, 09 Mar 2012 22:55:20 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:hpext="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom" xmlns:ns4="http://docs.openstack.org/common/api/v1.0">
   <token id="HPAuth_4f5a7fe06a25ab00f896bee4" expires="2012-03-10T10:12:37.474Z">
      <tenant id="22674990706167" name="TestTenant14892659460460094027"/>
   </token>
   <user id="85397174931388" name="TestUser14892658343713707444">
      <roles>
         <role id="00000000004026" name="projectmanager" serviceId="120" tenantId="22674990706167"/>
         <role id="00000000004022" name="Admin" serviceId="110" tenantId="22674990706167"/>
      </roles>
   </user>
</access>
~~~

**Quick Validation of Token**
------------------------------

Verb

URI

Description

**HEAD**

***[iaas:KeystoneBaseURI]******/tokens/{tokenId}?belongsTo=tenantId***

Check that a token is valid and that it belongs to a particular user.

#### **Detailed Description**

This API is used to do a quick token validation. Validation includes
checking that the token belongs to a particular user and it has not
expired.   If the query parameter, belongTo, is provided the call will
check the corresponding tenantId to ensure membership in that tenant. If
there is no tenantId then it is globally scoped. In the event a token is
not valid, a 404 (item not found) will be returned.  This call won't
return any roles associated with the token.
 In case of scoped token validation, if that tenant has swift account
hash available in CS system, then its value is returned as a response
header with name 'X-HP-IDM-swift-account-hash'.
 Note: This request does not expect X-Auth-Token header but if its
provided, then it needs to be have a valid token value otherwise
forbidden (403) error is returned.

#### **Normal Response Codes**

**204** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body.*
 Token doesn't belong to the tenant provided in 'belongsTo' query
parameter.

***401**** *(Unauthorized)

*Token is expired.*

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*
 *If invalid X-Auth-Token header is provided (even though its not needed
in request)*

***404**** *(Item not found)

*Token is not valid*

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*Optional :    belongsTo=tenantId, Additional check to ensure token
belongs to specified tenant.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes, defined in keystone schema

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 

[token.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)

#### **Example(s)**

### **EC2 Signature (EC2 Signature validation with token response)**

Verb

URI

Description

**POST**

***[iaas:HPKeystoneExtensionBaseURI]******/ec2Tokens?******HP-IDM-serviceId=******110,global,120&HP-IDM-endpointTemplateId=100***

Validates EC2 signature and returns scoped token response.
 optional 'HP-IDM-serviceId' paramater for getting service specific
roles.

#### **Detailed Description**

This API is used to validate EC2 signature and returns a token response.
CS implementation currently supports EC2 signature version 0, 1 and 2
(similar to keystone reference implementation). This API identifies the
user through 'access' identifier and verifies the provided signature
using data provided in request. Once signature is successfully verified,
it returns a scoped token response with tenant and role information.

As nova EC2 signature verification always requires a scoped token in
response, API need to find tenant for user (as tenant data, id or name,
is not provided in signature request). In current implementation, its
expected that tenant is prefixed in 'access' and 'AWSAccessKeyId'. 

For signature request, optional query parameter **HP-IDM-serviceId and
HP-IDM-endpointTemplateId** can be used to include only specific subset
of roles in response. If there are no specific roles found, then 401
(unauthorized) error is generated. Thses parameters can have comma
separated values to specify multiple service ids. To request global
roles to be included in response, **global** identifier (which is
currently configured as 'global') must be used in any of two query
parameter value. If this query parameter is not specified or has empty
value, then response include all roles available for that signature
request. Please see more details around these query parameters at
[Filter Roles](https://wiki.hpcloud.net/display/iaas/Token+Operations#TokenOperations-filterRoles) 

Please see more details around token generation logic at [Token Generation](https://wiki.hpcloud.net/display/iaas/Token+Operations#TokenOperations-tokenGeneration).

##### **AWSAccessKeyId Must Prefixed By Tenant ID**

Since a user's access key can associate with multiple tenants, clients
must prefix the user access key ID with the tenant ID of the tenant
where the signature is scoped to prior to the signature calculation. For
example, "84569201246014:8WXZS37LDZGYWM32H4LP". Notice the tenant ID
"84569201246014".

For Swift-migrated access keys, which already have a tenant ID prefix,
we would end up with this,
"84569201246014:84569201246015:8WXZS37LDZGYWM32H4LP". In this case, both
tenant IDs will be part of the signature but only the first prefix,
"84569201246014", will be used to determine the tenant to be scoped. The
second tenant ID, "84569201246015", is treated as part of the access
key.

#### **Signature Details**

The signature is calculated by first creating the string to sign as
described in the following sections. Then an RFC 2104 compliant HMAC is
calculated over the string using SHA1 or SHA256 as the hash algorithm
and the Secret Access key. The resultant signature bytes are then base64
encoded to form the signature string.

##### **Version 0 Signature String To Sign Details**

The supported signature method for version 0 signatures is HmacSHA1. The
string to sign consists of the value associated with the "Action" query
parameter concatenated with the value associated with the "Timestamp"
query parameter.

##### **Version 1 Signature String To Sign Details**

The supported signature method for version 1 signatures is HmacSHA1. The
string to sign is built by first doing a case insensitive sort of the
query parameters based on the query parameter names. Then the name and
value for each query parameter is concatenated together in the sorted
order one-by-one to form the string.

##### **Version 2 Signature String To Sign Details**

The supported signature methods for version 2 signatures are HmacSHA1
and HmacSHA256.

The string to sign for version 2 signatures consists of the following
concatenated in the order specified:

 1) The value of the "verb" followed by "\\n"

 2) The canonicalized value (lowercase) of the "host" followed by "\\n".
The ":" and the port number may or not be included. The server signature
verifier will calculate the signature with and without the ":" character
and the port number included.

 3) The canonicalized value of the "path" followed by "\\n". If the path
is not specifed or is the empty string then the character "/" is used.
The canonicalized path value is formed by first URL encoding the path
(using UTF-8 character set) and them making the following substitutions:

"%20" replaces "+"\
 "\*" replaces "%2A"\
 "\~" replaces "%7E"\
 "/" replaces "%2F"

 4) The canonicalized query string. The canonicalized query string is
formed by first performing a natural byte ordering (case sensitive sort)
by name of the name/value pairs in the query string. Each name and each
value are then URL encoded (using UTF-8 character set) and the following
substitutions are made:

"%20" replaces "+"\
 "\*" replaces "%2A"\
 "\~" replaces "%7E"

Then name/value strings are formed by concatenating name, "=", and
value.The resulting name/value strings are then concatenated together
based on sorted order above with each separated from the other by the
"&" character.

**Normal Response Codes**

**200**** ****(OK)**

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

Missing access key id.
 Missing signature value.
 Missing parameters ( params is null or empty list).

***401**** *(Unauthorized)

Invalid signature version.
 Missing signature method.
 Invalid access key (not associated with any account)
 Expired access key.
 Inactive access key.
 Invalid signature (Provided signatures are not correct).
 No tenant association found for user (identified by access key).
 When service id(s) specified in query and no service specific role
is/are found.

***403**** *(Forbidden)

User is disabled.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*No additional query string values required.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes, defined in HP extension schema

XML

No

JSON

Yes

gzip

no

#### Request and response schema,  XML Schema Definition 
[hp-ec2signature-credentials.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II-Augusta/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/token.xsd)
[hp-accesskey-credentials.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II-Augusta/ws/StoutServices/KeystoneService/src/main/resources/schemas/ext/hp-accesskey-credentials.xsd)

#### **Example(s)**

##### **EC2Signature  JSON Request (Version 0)**

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 815

{
    "ec2Credentials":{
        "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
        "host":"localhost:80",
        "verb":"GET",
        "params":{
            "SignatureVersion":"0",
            "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "JtISfQAiYdrKOVI3":"iII",
            "3ULz":"mtJWfYPNnfUTHwIRc",
            "fOVH8OwHID":"y79b",
            "Timestamp":"1326934083.16",
            "zvTqAh2Ql9mzE":"zqC6KwMMCYq",
            "j0aawvqoNNibmF4JjoBv":"4WyqLq66tSW5dzQ8Ps.q",
            "OgUE1nimEOBSYkvDd":"dFZX3RjMRh7",
            "kNX6Oit8fDM1":"TJ7mTM7YbJQ84",
            "Action":"RyMTEhVxIOZgysaashyV",
            "w8cpX":"lnjWTLEy0nVLq",
            "4tWPmGmAfEcWP01":"X7zr4JZ1"
        },
        "signature":"4LOFvWlHu1q3jU3R6WmIE3AJpKg=",
        "path":"/"
    }
}
~~~

##### **EC2Signature  JSON Request (Version 1)**

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 607

{
    "ec2Credentials":{
        "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
        "host":"localhost:80",
        "verb":"GET",
        "params":{
            "qI6GjS4":"1TfGb7kP.a",
            "SignatureVersion":"1",
            "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "WQ9":"el2",
            "Timestamp":"1326934083.26",
            "lKi9TPAP":"kQ5qjovtZ2d4wJst7NkU",
            "DuoDn0s1iCYfXnBK3V":"2doHkN",
            "1emaHCDcGwJrKk":"RJKQi",
            "Action":"ngxrsX"
        },
        "signature":"uik8Yk57mcqT85BHR8bAw9HTdiE=",
        "path":"/"
    }
}
~~~

##### **EC2Signature  JSON Request (Version 2)**

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/ec2tokens?HP-IDM-serviceId=100%2C110 HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 818

{
    "ec2Credentials":{
        "access":"77242319481696:M8RVSYL1HEAHP3L11DC5",
        "host":"localhost:80",
        "verb":"GET",
        "params":{
            "puHWtp":"oH.uGBH6F6dI5sQL1",
            "SignatureVersion":"2",
            "AWSAccessKeyId":"77242319481696:M8RVSYL1HEAHP3L11DC5",
            "ehtosy":"z9.idDFmU8hZWMQzS",
            "Timestamp":"1326934083.68",
            "nlKpzmwkDWYM":"9NgzXvwjuaiVoE5cP",
            "SignatureMethod":"HmacSHA256",
            "XNyFgC83lLGV":"QE9YFUoiNaa2qv9sXw",
            "au7":".4mK1HY2",
            "Action":"HJOFRgVIBSvegztSkm",
            "dcD5xQMQx":"i9OeD",
            "5Te8ywzJQsvvsNF":"qUd",
            "ob1e06nT4":"PqqJC3JzTZaofJTfTXB"
        },
        "signature":"f+E0MFsshpiXY3CwXOYv07jJ+FXewLPbjwFk47usPiA=",
        "path":"/"
    }
}
~~~

##### **EC2Signature  JSON Response (Same for all signature versions)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=DA7240A00E59F8E371DE567D405EB085; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 658
Date: Thu, 19 Jan 2012 01:00:36 GMT

{"access": {
  "token": {
    "expires": "2012-01-19T12:43:07.566Z",
    "id": "HPAuth_4f17671bb0be3f62bf1090d2",
    "tenant": {
      "id": "77242319481696",
      "name": "HP nova Tenant Services"
    }
  },
  "user": {
    "id": "97324764821142",
    "name": "arun2",
    "roles": [
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin"
      },
      {
        "id": "00000000004017",
        "serviceId": "100",
        "name": "tenant-member",
        "tenantId": "77242319481696"
      },
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser"
      }
    ]
  }
}}
~~~

##### **EC2Signature JSON Response (Error when signature is not valid)**

~~~
HTTP/1.1 401 Unauthorized
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=82034D30BB39215596243EDD6B9F2BB7; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 222
Date: Fri, 16 Dec 2011 19:19:11 GMT

{
  "unauthorized" : {
    "anies" : null,
    "code" : 401,
    "details" : "Provided signatures are not correct for access key :G8B5UNGWZU39K7BNR9KP",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
~~~

##### **EC2Signature JSON Response (Error when no service specific role found)**

~~~
HTTP/1.1 401 Unauthorized
Server: Apache-Coyote/1.1
Set-Cookie: JSESSIONID=10831C151368F11FE2F8A07EB6B34B87; Path=/; Secure
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 187
Date: Thu, 19 Jan 2012 01:09:29 GMT

{
  "unauthorized" : {
    "anies" : null,
    "code" : 401,
    "details" : "Not authorized to access the service.",
    "message" : "UNAUTHORIZED",
    "otherAttributes" : {
    }
  }
}
~~~

Refresh Token
-------------

Verb

URI

Description

**POST**

***[iaas:HPKeystoneExtensionBaseURI]******/tokens/{tokenId}***

Renew the expiration time by returning newly generated token

#### **Detailed Description**

This API is used to refresh the expiration time by generating new token.
Before expiration time can be modified, validation is done to check
token is not expired, user and its domain is currently enabled (similar
to what is done in token validation). Once all validation checks are
successful, the new token is generated with expiration time is increased
to next 720 minutes (token default expiration duration). The expiration
time is increased by 12 hours from current time and not from token
(passed in request) expiration time. The newly generated will also get
refreshed response data from system.

This a self-service user action. So token in X-Auth-Token header needs
to be same as token to be re-scoped otherwise it will raise unauthorized
error.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body.* 

***401**** *(Unauthorized)

X-Auth-Token header and refresh token is different.

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*
 *Token is expired (thrown by cs-security layer)*

***404**** *(Item not found)

*Token is not valid*  (not found)

Please refer to error response body for additional details.

#### **Header Values**

Valid X-Auth-Token value is required.

#### ***Query String Values***

*No additional query string values required.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 
[token.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/token.xsd)

#### **Example(s)**

##### **Refresh Token  Request for XML**

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tokens/HPAuth_4e934043b0be09f52fb4c29d HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e934043b0be09f52fb4c29d
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 0
~~~

##### **Refresh Token  Request for JSON**

~~~
POST https://localhost:8443/v2.0/HP-IDM/v1.0/tokens/HPAuth_4e934043b0be09f52fb4c29d HTTP/1.1
Accept-Encoding: gzip,deflate
X-Auth-Token: HPAuth_4e934043b0be09f52fb4c29d
Accept: application/json
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 0
~~~

##### **Refresh Token  XML Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Set-Cookie: JSESSIONID=73C402A7E410D5FF0734ED370CF1A40F; Path=/v2.0; Secure
Content-Type: application/xml
Content-Length: 361
Date: Mon, 10 Oct 2011 18:59:53 GMT

<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4e934043b0be09f52fb4e23f" expires="2011-10-10T19:29:53.382Z">
      <tenant id="95096564413950" name="HP5 Tenant Services"/>
   </token>
</access>
~~~

##### **Refresh Token  JSON Response**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 406
Date: Mon, 10 Oct 2011 19:02:25 GMT

{"access": {
   "token":    {
      "tenant":       {
         "id": "95096564413950",
         "name": "HP5 Tenant Services",
         "otherAttributes": {}
      },
      "anies": null,
      "expires": 1318275144906,
      "id": "HPAuth_4e934043b0be09f52fb4c29d",
      "otherAttributes": {}
   },
   "serviceCatalog": null,
   "anies": null,
   "otherAttributes": {}
}}
~~~

Re-scope Token
--------------

Verb

URI

Description

**POST**

***[iaas:KeystoneBaseURI]******/tokens***

Re-scope token to specified tenant

#### **Detailed Description**

This API provides the ability to re-scoping a valid token with another
tenant which token user is associated with. An existing unexpired token,
regardless of its currently scoped or not, can be scoped to another
tenant as long as user has association with that tenant.

Just to be clear, re-scope is not going to change supplied token id
association with tenant. It will just return existing valid token for
matching user and tenant otherwise will create new token. Re-scope
action will return new token if there is no valid token exists in the
system for that user and tenant combination. If there is already a
valid/unexpired matching token exists for that user and tenant, then
that token is returned.

During re-scope request, validation is done to make sure that user and
its domain is in enabled status. Also user has at least one association
with the specified tenant. If that's not the case, then token cannot be
re-scoped but still valid for use with original tenant (or no tenant in
case of unscoped tenant) till that token expires. Re-scoping of token
can be done from 1) unscoped token to a scoped token for specific tenant
2) scoped token from one tenant to another tenant 3) scoped token to
unscoped token (with no tenantId and tenantName specified in request).
Re-scoping of token does not alter the token expiration time and same
token id is returned in response.

In re-scope, new token is returned if there is no existing token for
that user and tenant (target scope tenant). If there already a valid
token exists for that user and tenant (target tenant scope), then that
token is returned. That essentially means, we will never have more than
one valid token for a user and tenant combination regardless of this
re-scope action is performed.

###### Service Catalog:

In case of un-scoped token request, the service catalog is going to
include global active endpoint templates as endpoints in its data. In
case of scoped token request, the service catalog is going to include
tenant specific endpoints as well as global active endpoint templates as
endpoints. If URL attribute of endpoint templates contains %tenant\_id%,
this is going to be replaced by actual tenantId when returning them as
part of service catalog. This applies to publicURL, internalURL and
adminURL attribute of endpoint template data. In service catalog, for
swift service, its going to be replaced by swift account hash if its
available for that tenant. This swift account hash replacement is done
only for endpoints which matches with swift service name and its service
type.

**Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***400*** (Bad Request)

*Malformed request in URI or request body*
 When both tenantId and tenantName is provided in request.
 Missing token id value.

***401**** *(Unauthorized)

*Invalid TenantId*
 *No user association with provided tenantId  ( via roles )*
 In case header token and re-scope token is different.

***403*** *(Forbidden) *

*Disabled or suspended user*
 *Disabled or suspended domain*

**500 **(Internal Server Error)

The server encountered a problem while processing the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

*No additional query string values required.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

Yes

XML

Yes

JSON

Yes

gzip

No

#### Request and response schema,  XML Schema Definition 
[token.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/token.xsd)
[roles.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/roles.xsd)
[hp-credentials.xsd](http://keg.dev.uswest.hpcloud.net:8080/job/Control_Services_II/ws/StoutServices/CSSchema/src/main/resources/schemas/hp-credentials.xsd)

#### **Example(s)**

##### **Re-scope Token  Request using XML request body**

~~~
POST https://localhost:8443/v2.0/tokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 195

<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantId="19694547081948">
  <token id="HPAuth_4e934043b0be09f52fb4c29d" />
</auth>
~~~

##### **Re-scope Token  Request using JSON request body**

~~~
POST https://localhost:8443/v2.0/tokens HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443
Content-Length: 154

{
    "auth": {
        "tenantName": "HP Swift Tenant Services",
        "token": {
            "id": "HPAuth_4ea80da3b0be73fc0385eceb"
        }
    }
}
~~~

##### **Re-scope Token  XML Response **

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 1166
Date: Wed, 26 Oct 2011 13:46:53 GMT


<access xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://docs.openstack.org/common/api/v1.0" xmlns:ns3="http://www.w3.org/2005/Atom">
   <token id="HPAuth_4ea80e72b0be73fc0385ecef" expires="2011-10-26T14:13:14.311Z">
      <tenant id="90260810095453" name="HP Swift Tenant Services"/>
   </token>
   <user id="53449493563804" name="arunkant">
      <roles>
         <role id="00000000004017" name="tenant-member" serviceId="100" tenantId="90260810095453"/>
         <role id="00000000004003" name="domainadmin" serviceId="100" tenantId="90260810095453"/>
         <role id="00000000004004" name="domainuser" serviceId="100" tenantId="90260810095453"/>
      </roles>
   </user>
   <serviceCatalog>
      <service type="identity" name="Identity">
         <endpoint region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0">
            <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
         </endpoint>
      </service>
   </serviceCatalog>
</access>
~~~

##### **Re-scope Token  JSON Response **

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 1283
Date: Wed, 26 Oct 2011 13:43:14 GMT

{"access": {
  "token": {
    "expires": "2011-10-26T14:13:14.311Z",
    "id": "HPAuth_4ea80e72b0be73fc0385ecef",
    "tenant": {
      "id": "90260810095453",
      "name": "HP Swift Tenant Services"
    }
  },
  "user": {
    "id": "53449493563804",
    "name": "arunkant",
    "roles": [
      {
        "id": "00000000004017",
        "serviceId": "100",
        "name": "tenant-member",
        "tenantId": "90260810095453"
      },
      {
        "id": "00000000004003",
        "serviceId": "100",
        "name": "domainadmin",
        "tenantId": "90260810095453"
      },
      {
        "id": "00000000004004",
        "serviceId": "100",
        "name": "domainuser",
        "tenantId": "90260810095453"
      }
    ]
  },
  "serviceCatalog": [{
    "name": "Identity",
    "type": "identity",
    "endpoints": [{
      "adminURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
      "internalURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
      "publicURL": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/v2.0",
      "region": "region-a.geo-1",
      "id": "2.0",
      "info": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/info\/v2.0",
      "list": "https:\/\/region-a.geo-1.identity.hpcloudsvc.com\/allVersions"
    }]
  }]
}}
~~~

Revoke Token
------------

Verb

URI

Description

**DELETE**

***[iaas:HPKeystoneExtensionBaseURI]******/tokens/{tokenId}***

Revokes the specified token

#### **Detailed Description**

This API is used to revoke an authentication token. This operation does
not require a request body. Once a token has been revoked, attempts to
validate the token via GET /tokens/{tokenId} will fail with a 404 (item
not found) as the token no longer exists. Trying revoke a non existing
token, including one which has expired will also return a 404 (item not
found). If user who is revoking the token (X-Auth-Token header) is not
currently enabled, we will get 403 (forbidden) error as disabled user
cannot revoke tokens. If token to be revoked belongs to a disabled user,
it can still be revoked. Enabled user can revoke his/her tokens. Only
enabled authorized users can revoke others token.

#### **Normal Response Codes**

**204** (No Content)

#### ***Error Response Codes***

***HTTP Status Code***

***Reason(s)***

***400****** ***(Bad Request)

Malformed request in URI or request body.
 Token is not valid.

***401****** ***(Unauthorized)

No user association with provided tenantId  ( via roles )***  ***

***403*** (Forbidden)*** ******  ***

Disabled or suspended user (here it means that disabled user is
forbidden to revoke his/her or others token)
 Disabled or suspended domain

#### **Header Values**

Valid X-Auth-Token value is required.

#### ***Query String Values***

None.

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

No request or response body required.

#### **Example(s)**

##### **Revoke Token  Request using XML**

~~~
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/tokens/4e26f9262cdc029a5dc49b9e HTTP/1.1
Connection: close
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **Revoke Token  Request using JSON**

~~~
DELETE http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP-IDM/v1.0/tokens/4e26f9262cdc029a5dc49b9e HTTP/1.1
Connection: close
User-Agent: Jakarta Commons-HttpClient/3.1
Host: haneef-desktop.americas.hpqcorp.net:8080
~~~

##### **Revoke Token Response using XML**

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 20 Jul 2011 16:00:35 GMT
Connection: close
~~~


##### **Revoke Token  Response using JSON**

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Date: Wed, 20 Jul 2011 16:00:35 GMT
Connection: close
~~~
