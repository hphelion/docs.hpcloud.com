---layout: page  title: CS Admin API  title_section:   description:  group: apispec  ---{% include JB/setup %}# 1. Overview*Brief introduction and overview of the service and its intended use.*## 1.1 API Maturity Level**Maturity Level**: Experimental**Version API Status**: CURRENT---# 2. Architecture View## 2.1 OverviewControl services provide a variety of APIs for the control and
management of various aspects of the HPCS OpenStack solution. Control
services APIs are defined using specific guidelines to ensure that they
are correct and fit into the OpenStack ecosystem. APIs
are an important part of control services offering clients a variety of
interfaces to control and manage behavior of HPs OpenStack solution.
OpenStack in itself offers many APIs including those defined by KeyStone
( Diablo OpenStack Identity management solution ). Control services will
support the standard OpenStack APIs for KeyStone as well as extend and
add our own for HP value add features. Control services APIs are based
on RESTful interfaces which have much in common with other cloud RESTful
design patterns. The intent is for control services to design and
deliver top notch APIs which will have the capability to become public
APIs in the future.
## 2.2 Conceptual/Logical Architecture View*Describe the logical components of the system and their responsibilities*## 2.3 Infrastructure Architecture View*Describe how the API fits into the overall HPCS Infrastructure*## 2.4 Entity Relationship Diagram*Describe the relationships between the various entities (resources) involved in the API*---# 3. Account-level View*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*## 3.1 Accounts*Describe the structure of the user accounts, groups and tenants. Currently this might be described separately in context of Control Services, but in future each service API needs to state their usage. In future CS might support complex group hierarchies, enterprise account structures while there maybe a phased adoption by individual service APIs*## 3.2 Regions and Availability Zones*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.***Region(s)**: region-a, region**Availability Zone(s)**: az-1, az-2, az-3 **Future Expansion**: Expanded to all regions## 3.3 Service CatalogThe service is exposed in the service catalog, as shown in the following fragment:

```
{
    "name": "Identity",
    "type": "identity",
    "endpoints": [
        {
            "publicURL": "https://region-b.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
            "region": "region-b.geo-1",
            "versionId": "2.0",
            "versionInfo": "https://region-b.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
            "versionList": "https://region-b.geo-1.identity.hpcloudsvc.com:35357"
        },
        {
            "publicURL": "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
            "region": "region-a.geo-1",
            "versionId": "2.0",
            "versionInfo": "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/",
            "versionList": "https://region-a.geo-1.identity.hpcloudsvc.com:35357"
        }
    ]
}```---# 4. REST API Specifications*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*## 4.1 Action API Operations**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**Base URI**: {Host}/v2.0

**Namespace** /identity/api/v2.0

**Admin URI**: N/A


| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| **Token**  | Authenticate | POST | {BaseURI}/tokens | Y/Y    |                 |
|            | Rescope Token | POST | {BaseURI}/tokens | Y/Y    |                 |
|            | Revoke | DELETE | {BaseURI}/HP-IDM/v1.0/tokens/<tokenId> | Y/Y    |                 |
| **Tenant** | List Tenants | GET | {BaseURI}/tenants | Y/Y    |                 |
## 4.2 Common Request HeadersX-Auth-Token
Content-Type## 4.3 Common Response Headers*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *## 4.4 Service API Operation Details*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*### 4.4.1 Action*Describe the resource and what information they provide. Then enumerate all the API method calls below.***Status Lifecycle**N/A**Rate Limits**N/A**Quota Limits**N/A**Business Rules**None.#### 4.4.1.1 {Short description of the method call}#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}*Description about the method call***Request Data***Specify all the required/optional url and data parameters for the given method call.***URL Parameters***Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}**Data Parameters***List all the attributes that comprises the data structure** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}*Either put 'This call does not require a request body' or include JSON/XML request data structure*JSON```{json data structure here}```XML```<xml data structure here>```Optional:JSON```{json data structure here}```XML```<xml data structure here>```**Success Response***Specify the status code and any content that is returned.***Status Code**200 - OK**Response Data***Either put 'This call does not require a request body' or include JSON/XML response data structure*JSON```{json data structure here}```XML```<xml data structure here>```**Error Response***Enumerate all the possible error status codes and any content that is returned.***Status Code**500 - Internal Server Error**Response Data**JSON```{"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}```XML```<xml data structure here>```**Curl Example**```curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]```**Additional Notes***Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*---
## Content Types

The Control Services API supports both the JSON and XML data serialization formats. The request format is specified using the Content-Type header and is *required* for operations that have a request body. The response format can be specified in requests using either the `Accept` header or adding an *.xml* or *.json* extension to any request URI. Note, it is possible for a response to be serialized using a format different from the request but ***this is not a supported feature of Control Services.*** If no response format is specified, JSON is the default. If conflicting formats are specified using both an Accept header and a query extension, the query extension takes precedence.

### Response Types

| Format | Accept Header    | Extension | Default |
| :----- | :--------------- | :-------- | :------ |
| JSON   | application/json | .json     | yes     |
| XML    | application/xml  | .xml      | no      |


### XML Schemas

| KeyStone Schema | Description | HP Changes / Extensions |
| :-------------- | :---------- | :---------------------- |
| [api.xsd](xsd/api.xsd) | Keystone Core API | None |
| [api-common.xsd](xsd/api-common.xsd) | Rackspace Common API | None |
| [atom.xsd](xsd/atom.xsd) | Keystone Atom | None |
| [credentials.xsd](csd/credentials.xsd) | Keystone Credentials  | None |
| [endpoints.xsd](xsd/endpoints.xsd) | Keystone Service Endpoint | None |
| [extensions.xsd](xsd/extensions.xsd) | Keystone Extension API  | None |
| [fault.xsd](xsd/fault.xsd) | Keystone Error and Faults  | None |
| [roles.xsd](xsd/roles.xsd) | Keystone Roles  | None |
| [services.xsd](xsd/services.xsd) | Keystone Services | None |
| [tenant.xsd](xsd/tenant.xsd) | Keystone Tenant | None |
| [token.xsd](xsd/token.xsd) | Keystone Authentication Token | None |
| [user.xsd](xsd/user.xsd) | Keystone User | None |
| [version.xsd](xsd/version) Keystone Version | None |
| [xml.xsd](xsd/xml.xsd) | Keystone XML / Atom | None |


#### HP Extension Schemas

| HP Schema |  | Description
| :-------- | :--------- |
| [authz-models.xsd](xsd/authz-models.xsd) | Authorization service schema (Roles, RoleRefs, HasRole) Note: Grant, GroupRef is also included in this schema but not ready to review |
| [JobTicket.xsd](xsd/JobTicket.xsd) | Job Tickets are both submitted to initiate an Action, and retrieved in order to access the Action results. |



# Fault and Error Responses
---
Errors returned by Control Services (CS) will result in HTTP error
status for a specific REST API invocations. Each CS API has its own
defined set of error codes describing the error reason. In addition, a
Keystone specific error body is used to describe additional fault
information. All non-successful API calls will return a Keystone fault
error body as defined in [csbu:Error Responses\^fault.xsd] .

## HTTP Status Codes

The intent is that the standard HTTP status code is used in conjunction
with the Keystone fault body to describe the entire error ( Please refer
to individual API definitions for specifics on actual HTTP error codes).
Status used by CS represents standard HTTP status codes defined in the
HTTP standards , see [HTTP response
codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) .

## Keystone Fault Schema

The Keystone fault schema defines a simple hierarchy of all faults
possible with the root being "identityFault".  The following table
desribes possible instances of Keystone faults which can be returned.

| Fault Element | Associ Error Code | Description | 
| :------------ | :--------- | :-------- |
| identityFault | 500 series or 400 series status | Base class for all faults, can be used as catch all for non specific errors |
| serviceUnavailable | 503 | The server is currently not able to handle the request. Can be due to overloading. |
| badRequest | 400 | The request could not be understood due to malformed syntax by the client. |
| unauthorized | 401 | The request requires authentication. | 
| overLimit | 413 | The server is refusing to process the request because the entity is larger than the server can process. |
| userDisabled | 403 | User making request or being referenced is disabled. Request will not be performed. |
| forbidden | 403 | The server understood the request but is refusing to fulfill it. |
| itemNotFound | 404 | The server has not found anything matching the URI request. |
| tenantConflict | 409 | The request could not be completed due to a conflict with another tenant resource. | 

#### Fault Representation

The error code is returned in the body of the response for convenience.
The message section returns a human readable message. The details
section is optional and may contain useful information for tracking down
an error (e.g a stack trace). The root element of the fault ( e.g.
identityFault ) may change depending on the type of error.  A JSON or
XML fault representation is possible based on the content type
associated with the request. For example, a request for a resource in
JSON representation may result in a JSON format error. 

#### XML Example

```
<?xml version="1.0" encoding="UTF-8"?>
   <identityFault xmlns="http://docs.openstack.org/identity/api/v2.0" code="500">
   <message>Fault</message>
   <details>Error Details...</details>
</identityFault>
```

#### JSON Example

```
{
    "identityFault": {
        "message": "Fault",
        "details": "Error Details...",
        "code": 500
    }
}
```

# Pagination
---
OpenStack cloud APIs and the control services API use a common
pagination technique called *'limit and marker pagination'*. To navigate
a collection, the query parameters '*limit*' and '*marker*' can be set
in the URI. For example, **GET /books?limit=100&marker=123**.
The *limit* parameter sets the page size and the *marker* parameter is
the resource Id of the last item in the previous list. This requires
that the resource collection is sorted in some manner like update time
or by Ids. Both of these parameters are optional. 

| Parameter Name | Default Value | Description |  
| :------------- | :------------ | :---------- |  
| limit | If not specified, a cloud service will default the page size to some safe value. |  The *limit* value represents the maximum number of elements which will be returned in the request. |
| marker | If not specified, the marker value is null to denote start at the beginning of the collection. | The marker parameter is the resource Id of the last item in the previous list. |  


### Error Cases

-   If a client requests a limit of greater size than supported by a
    REST handler, an over limit error (413) will be returned.
-   If an invalid marker is requested by a client, an item not found
    error (404) will be returned.
-   Paginated collections should never return a item not found (404)
    when the collection is empty. Instead there shall be no resource
    instances in the returned list.
    
    
#### Keystone Extensions

The OpenStack Keystone Identity API is extensible.  Applications can
programmatically determine what extensions are available by performing a
GET on the /extensions URI. The HP Control Services APIs are implemented
as Keystone extensions and supports this call to allow finding more
details on the the HP extension. Specifically, a caller can retrieve the
name, namespace and WADL location for the Control Services extension.
Additional details about all the APIs can be found within the the WADL.

#### 

| Verb | URI | Description |

**GET**

***[csbu:KeystoneBaseURI]******/extensions***

Get keystone extension information

  

#### **Normal Response Codes**

**200** (OK)

HTTP Status Code

Reason(s)

***400*** (Bad Request) \

*Malformed request in URI or request body* \
 When both tenantId and tenantName is provided in request.

***401**** *(Unauthorized) \

*Invalid username* 

***403*** *(Forbidden) * \

*Disabled or suspended user* \
 *Disabled or suspended domain* \
 *Inactive access key* \
 *Expired access key*

***503**** *(Service Unavailable) \

*Internal service error, see error body*

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### ***Query String Values***

No additional query string values required.

| Content Type | Supported |
| XSD  | Yes. Based on standard keystone schema. |
| XML  | Yes |
| JSON | Yes |
| gzip | No |

#### **Preconditions & Default Behavior**

*No precondition.*

#### **Example(s)**

**XML Request and Response Example**

```
GET https://localhost:8443/v2.0/extensions HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/xml
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443


HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Content-Type: application/xml
Content-Length: 606
Date: Mon, 10 Oct 2011 17:47:30 GMT

<?xml version="1.0" encoding="UTF-8"?>
<extension  xmlns="http://docs.openstack.org/common/api/v1.0"
            xmlns:atom="http://www.w3.org/2005/Atom"
            name="HP Identity Management APIs" namespace="http://www.hp.com/identity/api/ext/HP-IDM/v1.0"
            alias="HP-IDM"
            updated="2011-09-14T13:25:27-06:00">
            <description>
                        HP Identity Management extension APIs based on Openstack Keystone v2.0 APIs
            </description>
            <atom:link rel="describedby" type="application/vnd.sun.wadl+xml"
                        href="/v2.0/wadl">
</extension>
```

**JSON Request and Response Example**

```
GET https://localhost:8443/v2.0/extensions HTTP/1.1
Accept-Encoding: gzip,deflate
Accept: application/json
User-Agent: Jakarta Commons-HttpClient/3.1
Host: localhost:8443


HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Content-Type: application/json
Content-Length: 606
Date: Mon, 10 Oct 2011 17:47:30 GMT


{
  "extension":{
    "name": "HP Identity Management APIs",
    "namespace": "http://www.hp.com/identity/api/ext/HP-IDM/v1.0",
    "alias": "HP-IDM",
    "updated": "2011-09-14T13:25:27-06:00",
    "description": "HP Identity Management extension APIs based on Openstack Keystone v2.0 APIs",
    "links": [
    {
        "rel": "describedby",
        "type": "application/vnd.sun.wadl+xml",
        "href": "/v2.0/wadl"
    }
 ]
   }
}
```


---

# Authentication Methods

<h2 id="TokenAuthentication">Token Authentication</h2>

Each REST request to an HP Cloud Service requires the inclusion of a
specific authorization token ( an HTTP header name and value ), defined
as `X-Auth-Token`. Clients obtain this token, along with the URLs to
other service APIs, by first authenticating against Control Services and
supplying valid credentials. Client authentication is provided via a
REST interface using the `POST v2.0/tokens` method. A payload of
credentials must be included within the request body.

As Control Services are a RESTful web service, you must know the URL of
its endpoint to access the Control Services.

### **Obtain authentication token**

Verb

URI

Description

**POST**

***[csbu:KeystoneBaseURI]******/tokens***

Authenticates the user and returns a bearer token

This API is used to authenticate a user to be able to use an Openstack
service. The result of a successful authentication is a token to be used
with service requests. A username and password credential (other
credentials may also be supported) are given as input to this interface.
 If authentication succeeds, the response will include an authentication
token and service catalog ( list of available services and endpoints for
that user ).  Tokens are valid for 12 hours and the maximum number of
concurrent tokens per user is defined as 10 tokens.  Issued tokens can
become invalid in two cases: 1) token has expired and 2) token has been
revoked.  In the event a user has been disabled, currently issued tokens
will remain valid until expired.

Another way to authenticate is to provide a set of of symmetric keys as
credentials. Symmetric keys are user access key and secret key
provisioned for the user account.  For this type of credential data, the
request body is expected to contain access key and secret key
information belonging to the user. Once those keys are verified,  a new
token is created.. There is no difference in response format/content
whether authentication is done using password credential data or access
key credential data

For more information, please refer to the [detailed API operations page
for token authentication](#TokenOperations).

### Scoped vs. Unscoped Tokens

The tenantId is an optional parameter in the request body when
requesting a token.  It is important to note that if no tenantId is
provided and the credentials are successfully validated, that an
unscoped token will be returned.  Unscoped tokens can only be used when
communicating/authenticating with control service interfaces.  If a
token is required to communicate/authenticate with other HP Cloud
Service (e.g. Nova, Swift, Glance), then a scoped token MUST be used.  A
scoped token is obtained by providing an tenantId in the token request.
 When credentials are validated, Control Services will then check to see
if the particular user has ANY role assignments to the provided
tenantId.  If roles assignments are found, then a scoped token is
returned.  If no role assignments are found, then authentication will
fail.  

##### **Example Authentication Request using JSON (Password credential data)**

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

##### **Example Authentication  Response using JSON (same response for password and access key credential data)**

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 5475
Date: Thu, 06 Oct 2011 20:42:38 GMT

{"access": {
   "token":    {
      "expires": "2011-10-06T20:57:21.171Z",
      "id": "HPAuth_4e8e0f29b0be2944baebb825",
      "tenant":       {
         "id": "95096564413950",
         "name": "HP5 Tenant Services"
      }
   },
   "user":    {
      "id": "66696939904302",
      "name": "arunkant",
      "roles":       [
                  {
            "id": "00000000004008",
            "serviceId": "120",
            "tenantId": "95096564413950"
         },
                  {
            "id": "00000000004017",
            "serviceId": "100",
            "tenantId": "95096564413950"
         }
      ]
   },
   "serviceCatalog":    [
            {
         "name": "storage2868777434008486569",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
            "region": "SFO"
         }]
      },
            {
         "name": "COMPUTE2868779230272558985",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/6",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/6",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/6",
            "region": "LSV"
         }]
      },
     {
         "name": "COMPUTE2868780304831141259",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/6",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/6",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/6",
            "region": "LSV"
         }]
      },
            {
         "name": "storage2868780931731025607",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/0",
            "internalURL": "https://localhost:8443/identity/api/v2.0/internal/0",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/0",
            "region": "SFO"
         }]
      },
            {
         "name": "database2868695877510917197",
         "type": "compute",
         "endpoints": [         {
            "tenantId": "95096564413950",
            "adminURL": "https://localhost:8443/identity/api/v2.0/admin/4",
            "publicURL": "https://localhost:8443/identity/api/v2.0/public/4",
            "region": "US-EAST"
         }]
      }
   ]
}}
~~~

#### Using the Token 

Once a client has a token it will then pass this in all the X-Auth-Token
header of all subsequent HP Cloud Services requests

##### **Example of Passing the Token in the HTTP Header**

~~~
Host: identity.api.openstack.org
GET /v2.0/tenants HTTP/1.1
Content-Type: application/json
X-Auth-Token: HPAuth_fa8426a0-8eaf-4d22-8e13-7c1b16a9370c
Accept: application/json
~~~

---

<h2 id="EC2SignatureAuthentication">EC2 Signature Authentication</h2>

Each REST request using EC2 signature authentication with the Openstack
API (Nova) requires the inclusion of request specific signature
information (HTTP header names and values). The REST client will
calculate the value of the signature for each request using an access
key, the private key of a key pair, or the private key corresponding to
the public key in a certificate. Metadata included along with the
signature in the request includes the signature version, signature
algorithm, and key identifier. The client must scope the signature
authentication to a specific tenant, by prefixing the AWS access key ID
with the tenant ID. See [AWS Access Key
Requirements](#EC2SignatureAuthentication-AWSAccessKeyRequirements) for
more details. If the signature authentication is not scoped, a 401 will
be returned.

### AWS Access Key Requirements

Since a user's access key can associate with multiple tenants, **clients
must prefix the user access key ID with the tenant ID of the tenant
where the signature is scoped to prior to the signature calculation**.
For example, "84569201246014:8WXZS37LDZGYWM32H4LP". Notice the tenant ID
"84569201246014".

For Swift-migrated access keys, which already have a tenant ID prefix,
we would end up with this,
"84569201246014:84569201246015:8WXZS37LDZGYWM32H4LP". In this case, both
tenant IDs will be part of the signature but only the first prefix,
"84569201246014", will be used to determine the tenant to be scoped. The
second tenant ID, "84569201246015", is treated as part of the access
key.

### Calculating Signatures

See [Amazon Web Services
Documentation](http://docs.amazonwebservices.com/AlexaWebInfoService/latest/index.html?CalculatingSignatures.html)
for more details.

> Although we still support signature version 0, 1, and 2, however, as of 
> November 25, 2011, all clients must use signature verison 2.

> When preparing the HTTPRequestURI portion of the StringToSign, the (HTTP) 
> port number must not be included if the port is a standard port, such as 
> 80 or 443.

### Using Signature Authentication

The signature, along with other meta information, must be part of the
query string of an EC2 request.

##### **Example REST (DescribeImages) Request using Signature Authentication**

Here's an example of a DescribeImages request.

~~~
GET  /services/Cloud?AWSAccessKeyId=84569201246014%3A8WXZS37LDZGYWM32H4LP&Action=DescribeImages&Owner.1=self&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=2011-12-28T18%3A46%3A08&Version=2009-11-30&Signature=hxEsReGdWHUQtFjGOhfe32qqarCD/pP%2BX76LIySViwo%3D HTTP/1.0
~~~

### Configuring CS Middle-ware To Validate EC2 Signatures

See [CS Integration
Wiki](https://wiki.hpcloud.net/display/csbu/CS+Integration#CSIntegration-Nova%28EC2SignatureValidation%29)
for more details.

### Validating a Signature

A service may validate a signature with the resource described in [Token
Operations](Token%20Operations.html "Token Operations")

---

<h2 id="S3SignatureAuthentication">S3 Signature Authentication</h2>

CS S3 signature authentication is meant to be used in conjunction with the [Swift S3 emulator middleware
(swift3)](https://github.com/openstack/swift/blob/stable/diablo/swift/common/middleware/swift3.py)
to support [Amazon S3 signature authentication](http://docs.amazonwebservices.com/AmazonS3/2006-03-01/dev/RESTAuthentication.html).

However, it can be deployed alone, without [Swift S3 emulator middleware (swift3)](https://github.com/openstack/swift/blob/stable/diablo/swift/common/middleware/swift3.py),
to offer S3-like signature-based authentication. See [Deploying CS S3
Signature Validation Filter Without Swift Amazon S3 API Emulator (swift3)](#S3SignatureAuthentication-DeployingCSS3SignatureValidationFilterWithoutSwiftAmazonS3APIEmulator%28swift3%29)
for more details.

CS S3 signature authentication middleware is essentially a replacement
of [Keystone s3\\_token middleware](https://github.com/openstack/keystone/blob/master/keystone/middleware/s3_token.py),
to take advantage of [CS generic signature authentication
API](https://wiki.hpcloud.net/display/iaas/Generic+Signature+Operations).

[Swift S3 emulator middleware (swift3)](https://github.com/openstack/swift/blob/stable/diablo/swift/common/middleware/swift3.py)
**must sit in front of CS S3 signature authentication filters in order
to fully support Amazon S3 APIs**.

The pipeline would look something like this.

~~~
pipeline = catch_errors healthcheck crossdomain cache ratelimit name_check authtoken formpost tempurl swift3 css3sigblder cssigvalidator authz sos staticweb proxy-server

[filter:css3sigblder]
paste.filter_factory = hp.middleware.cs_s3_sig_builder:filter_factory
log_service = swift

[filter:cssigvalidator]
log_service = swift
log_level = DEBUG
paste.filter_factory = hp.middleware.cs_sig_validator:filter_factory
auth_uri = thrift_ssl://<cs_ip>:9543
ca_certs = /etc/idm/security/ca.pem
certfile = /etc/idm/security/hpmiddleware.pem
endpoint_template_ids = <comma-separated endpoint template IDs>
~~~

### Different Between HP and Amazon S3 Signature

For HPCS, the Authorization header must begins with "HP".

~~~
Authorization = "HP" + " " + AWSAccessKeyId + ":" + Signature
~~~

### Creating Signatures

Please refer to [Amazon S3 API Doc](http://docs.amazonwebservices.com/AmazonS3/2006-03-01/dev/RESTAuthentication.htm) on how to generate the signature. In short,

~~~
Authorization = "HP" + " " + AWSAccessKeyId + ":" + Signature;

Signature = Base64( HMAC-SHA1( YourSecretAccessKeyID, UTF-8-Encoding-Of( StringToSign ) ) );

StringToSign = HTTP-Verb + "\n" +
    Content-MD5 + "\n" +
    Content-Type + "\n" +
    Date + "\n" +
    CanonicalizedAmzHeaders +
    CanonicalizedResource;

CanonicalizedResource = [ "/" + Bucket ] +
    <HTTP-Request-URI, from the protocol name up to the query string> +
    [ sub-resource, if present. For example "?acl", "?location", "?logging", or "?torrent"];

CanonicalizedAmzHeaders = <described below>
~~~

> Authorization header must begins with "HP "

### Using Signature Authentication

Here's an example of S3 signature request.

~~~
GET /photos/puppy.jpg HTTP/1.1
Host: johnsmith.s3.amazonaws.com
Date: Mon, 26 Mar 2007 19:37:58 +0000

Authorization: HP AKIAIOSFODNN7EXAMPLE:frJIUN8DYpKDtOLCwo//yllqDzg=
~~~

Please see [Amazon S3 API Doc](http://docs.amazonwebservices.com/AmazonS3/2006-03-01/dev/RESTAuthentication.htm) for more examples.

> Authorization header must begins with "HP"

### Configuring CS Middleware To Validate Amazon S3 Signatures

See [CS Integration Wiki](https://wiki.hpcloud.net/display/iaas/CS+Integration#CSIntegration-AmazonS3SignatureAuthenticationSupport) for more details.

### Validating a Signature

A service may validate a signature with the resource described in [Generic Signature Operations](#GenericSignatureOperations "Generic Signature Operations")

### Deploying CS S3 Signature Validation Filter Without Swift Amazon S3 API Emulator (swift3)

CS S3 Signature Validation Filter, under the cover, is essentially a
shared-secret authentication filter utilizing S3 headers to convey
signature information. Which means there are only two HTTP headers that
we care about.

~~~
X-Storage-Token: <data_to_sign>
Authorization: HP <AWS access key ID>:<signature>
~~~

Notice that \<data\_to\_sign\> can be an arbitrary string and may not
need to conform to S3 syntax. As long as the signature being generated
is consistent with S3 signature generation, we should be able to
authenticate it.

~~~
Signature = Base64( HMAC-SHA1( YourSecretAccessKeyID, UTF-8-Encoding-Of( StringToSign ) ) );
~~~

---

<h2 id="TempURLAuthentication">TempURL Authentication</h2>

A website may wish to provide a link to download a large object in
Swift, but the Swift account has no public access. The website can
generate a URL that will provide GET access for a limited time to the
resource. When the web browser user clicks on the link, the browser will
download the object directly from Swift, obviating the need for the
website to act as a proxy for the request.

If the user were to share the link with all his friends, or accidentally
post it on a forum, etc. the direct access would be limited to the
expiration time set when the website created the link.

User access key ID and secret key are required in order to create
temporary URLs. To create a temporary URL, an HMAC-SHA1 (RFC 2104)
signature is generated using the HTTP method to allow (GET or PUT), the
Unix timestamp the access should be allowed until, the full path to the
object, and the user's secret key.

### Supported Methods

TempURL is designed to support **GET, PUT, and HEAD** requests only.
POST is expected to be handled by FormPost.

### Differences Between CS and OpenStack Swift TempURL Signature Generation

There are two (2) noticeable differences between CS and OpenStack Swift
TempURL signature generation.

1.  OpenStack Swift TempURLs required the X-Account-Meta-Temp-URL-Key
    header be set on the Swift account. CS does not.
2.  CS TempURLs require the user's access key ID to be prepended to the
    signature. OpenStack Swift does not 

### CS TempURL Signature Requirements

Since signature validation is done at the CS backend instead of
middleware, there is no need to set the secret key on the Swift account
and expose it via the X-Account-Meta-Temp-URL-Key. Therefore, it buys us
both security and efficiency. The trade-off is we need to identity which
secret key was used to generate the signature since user may have
multiple secret keys. This is done by prepending the access key ID to
the signature itself. For example,
"84569201246014:8WXZS37LDZGYWM32H4LP". Notice the access key ID
"84569201246014".

### Creating Signatures

User access key ID and secret key are required in order to create
temporary URLs. To create a temporary URL, an HMAC-SHA1 (RFC 2104)
signature is generated using the HTTP method to allow (GET or PUT), the
Unix timestamp the access should be allowed until, the full path to the
object, and the user's secret key.

For example, here is code generating the signature for a GET for 60
seconds on /v1/AUTH\_account/container/object::

~~~
import hmac
from hashlib import sha1
from time import time

method = 'GET'
expires = int(time() + 60)
path = '/v1/account/container/object'
access_key_id = '12345'
secret_key = 'mykey'
hmac_body = '%s\\n%s\\n%s' % (method, expires, path)
sig = access_key_id + ':' + hmac.new(secret_key, hmac_body, sha1).hexdigest()
~~~

Be certain to use the full path, from the /v1/ onward.

### Using Signature Authentication

Let's say the signature ends up equaling
"12345:da39a3ee5e6b4b0d3255bfef95601890afd80709" and expires ends up
"1323479485". Then, for example, the website could provide a link to:

~~~
https://swift-cluster.example.com/v1/account/container/object?temp_url_sig=12345%3Ada39a3ee5e6b4b0d3255bfef95601890afd80709&temp_url_expires=1323479485
~~~

Any alteration of the resource path or query arguments would result in
401 Unauthorized. Similary, a PUT where GET was the allowed method would
result in 401. HEAD is allowed if GET or PUT is allowed.

### Configuring CS Middleware To Validate TempURLs Signatures

See [CS Integration Wiki](https://wiki.hpcloud.net/display/csbu/CS+Integration#CSIntegration-Nova%28EC2SignatureValidation%29) for more details.

### Validating a Signature

A service may validate a signature with the resource described
in [Generic Signature Operations](Generic%20Signature%20Operations.html "Generic Signature Operations")

---

<h2 id="FormPOSTAuthentication">FormPOST Authentication</h2>  

FormPost is designed to allow web browsers to upload (typically large)
files directly into Swift, by using signature-based authentication,
eliminating the need for (control panel) proxy.

FormPost middleware translates a browser form post into a regular Swift
object PUT.

The format of the form is::

~~~
<form action="<swift-url>" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="redirect" value="<redirect-url>" />
    <input type="hidden" name="max_file_size" value="<bytes>" />
    <input type="hidden" name="max_file_count" value="<count>" />
    <input type="hidden" name="expires" value="<unix-timestamp>" />
    <input type="hidden" name="signature" value="<access_key_id>:<hmac>" />
    <input type="file" name="file1" />
    <input type="submit" />
</form>
~~~

The `<swift-url>` is the URL to the Swift desination, such as:

~~~
[https://swift-cluster.example.com/v1/AUTH_account/container/object_prefix]
~~~

The name of each file uploaded will be appended to the `<swift-url>`
given. So, you can upload directly to the root of container with a
 url like:

~~~
[https://swift-cluster.example.com/v1/AUTH_account/container/]
~~~

Optionally, you can include an object prefix to better separate
different users' uploads, such as::

~~~
[https://swift-cluster.example.com/v1/AUTH_account/container/object_prefix]
~~~

> The form method must be POST and the enctype must be set as 
> "multipart/form-data".

To upload file(s) into sub-containers/sub-dirs with multipart form data
mechanism, the path must end with a backslash (/) , such as::

~~~
[https://swift-cluster.example.com/v1/AUTH_account/container/subcontainer1/subcontainer2/]
~~~

The redirect attribute is the URL to redirect the browser to after the
upload completes. The URL will have status and message query parameters
added to it, indicating the HTTP status code for the upload (2xx is
success) and a possible message for further information if there was an
error (such as "max\_file\_size exceeded").

The max\_file\_size attribute must be included and indicates the largest
single file upload that can be done, in bytes.

The max\_file\_count attribute must be included and indicates the
maximum number of files that can be uploaded with the form. Include
additional `<input type="file" name="filexx"/>` attributes if\
 desired.

The expires attribute is the Unix timestamp before which the form must
be submitted before it is invalidated.

User access key ID and secret key are required in order to create form
signature.

### Supported Methods

The form method must be **POST** and the enctype must be set as
**"multipart/form-data"**.

### Differences Between CS and OpenStack Swift FormPOST Signature Generation

There are two (2) noticeable differences between CS and OpenStack Swift
FormPost signature generation.

1.  OpenStack Swift form posts required the X-Account-Meta-Temp-URL-Key
    header be set on the Swift account. CS does not.
2.  CS form posts require the user's access key ID to be prepended to
    the signature. OpenStack Swift does not.

### CS Form Post Signature Requirements

Since signature validation is done at the CS backend instead of
middleware, there is no need to set the secret key on the Swift account
and expose it via the X-Account-Meta-Temp-URL-Key. Therefore, it buys us
both security and efficiency. The trade-off is we need to identity which
secret key was used to generate the signature since user may have
multiple secret keys. This is done by prepending the access key ID to
the signature itself. For example,
"84569201246014:8WXZS37LDZGYWM32H4LP". Notice the access key ID
"84569201246014".

### Creating Signatures

User access key ID and secret key are required in order to create form
signature.

The signature attribute is the HMAC-SHA1 signature of the form. Here is
sample code for computing the signature::

~~~
import hmac
from hashlib import sha1
from time import time

path = '/v1/account/container/object_prefix'
redirect = 'https://myserver.com/some-page'
max_file_size = 104857600
max_file_count = 10
expires = int(time() + 600)
access_key_id = '12345'
secret_key = 'mykey'
hmac_body = '%s\n%s\n%s\n%s\n%s' % (path, redirect,
    max_file_size, max_file_count, expires)
signature = access_key_id + ':' + hmac.new(key, hmac_body, sha1).hexdigest()    
~~~

> Be certain to use the full path, from the /v1/ onward.

> Also note that the file attributes must be after the other attributes in
> order to be processed correctly. If attributes come after the file, they
> won't be sent with the subrequest (there is no way to parse all the
> attributes on the server-side without reading the whole thing into
> memory to service many requests, some with large files, there just
> isn't enough memory on the server, so attributes following the file are
> simply ignored).

### Configuring CS Middle-ware To Support FormPOST

See [CS Integration Wiki](https://wiki.hpcloud.net/display/csbu/CS+Integration#CSIntegration-Nova%28EC2SignatureValidation%29)
for more details.

### Validating a Signature

A service may validate a signature with the resource described
in [Generic Signature Operations](Generic%20Signature%20Operations.html "Generic Signature Operations")


---# 5. Additional References## 5.1 Resources**Wiki Page**: {Link to Wiki page}**Code Repo**:  {Link to the internal Github repo}**API Lead Contact**: {Name of contact}---# 6. Glossary{Put down definitions of terms and items that need explanation.}---