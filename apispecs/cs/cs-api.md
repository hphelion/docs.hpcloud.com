---layout: pagetitle: title_section: description: group: apispec---{% include JB/setup %}# 1. Overview*Brief introduction and overview of the service and its intended use.*## 1.1 API Maturity Level**Maturity Level**: GA**Version API Status**: CURRENT---# 2. Architecture View## 2.1 Overview*References to architectural details of the service.*## 2.2 Conceptual/Logical Architecture View*Describe the logical components of the system and their responsibilities*## 2.3 Infrastructure Architecture View*Describe how the API fits into the overall HPCS Infrastructure*## 2.4 Entity Relationship Diagram*Describe the relationships between the various entities (resources) involved in the API*---# 3. Account-level View*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*## 3.1 Accounts*Describe the structure of the user accounts, groups and tenants. Currently this might be described separately in context of Control Services, but in future each service API needs to state their usage. In future CS might support complex group hierarchies, enterprise account structures while there maybe a phased adoption by individual service APIs*## 3.2 Regions and Availability Zones*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.***Region(s)**: region-a, region-b**Availability Zone(s)**: az-1, az-2, az-3 **Future Expansion**: ## 3.3 Service CatalogThe service is exposed in the service catalog, as shown in the following fragment:```{
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
}```---# 4. REST API Specifications*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*## 4.1 Service API Operations**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com**BaseUri**: {Host}/v2.0**Admin URI**: N/A| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level || :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: || Token      | Authenticate | POST | {BaseURI}/tokens | Y/Y    |                 || Token      | Rescope Token | POST | {BaseURI}/tokens | Y/Y    |                 || Tenant     | List Tenants | GET | {BaseURI}/tenants | Y/Y    |                 || Token      | Revoke | DELETE | {BaseURI}/HP-IDM/v1.0/tokens/<tokenId> | Y/Y    |                 |## 4.2 Common Request Headers*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*## 4.3 Common Response Headers*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *## 4.4 Service API Operation Details*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*### 4.4.1 Token*Describe the resource and what information they provide. Then enumerate all the API method calls below.***Status Lifecycle**N/A**Rate Limits**N/A**Quota Limits**N/A**Business Rules**None.#### 4.4.1.1 Authenticate#### POST /tokensThis API is used to authenticate a user to be able to use an OpenStack service. The result of a successful authentication is a token to be used with service requests. A username and password or access/secret key credentials are given as input to this interface. If authentication succeeds, the response will include an authentication token and service catalog ( list of available services for that user ). Tokens are valid for 12 hours. Issued tokens can become invalid in two cases: 1) the token has expired and 2) the token has been revoked.

Besides using a username and password, another way to authenticate is using symmetric keys. Symmetric keys are user access key and secret key pairs provisioned for user account. In this type of credential data, request body is expected to contain an access key and a secret key information belonging to the user. Once those keys are verified, a new token is created. In this type of authentication, the only change is in expected request body data (please see related example below). There is no difference in response format/content whether authentication is done using password credential data or access key credential data.

Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

Scoped Tokens:

A token scoped to a tenant can be obtained by providing either a tenantName or a tenantId. This will also return service endpoints for other services associated with the tenant in question. An unscoped token will likely not contain service endpoints except for those for the Identity Service. Note that if tenant information is unknown, an unscoped token can be obtained and then a list of tenants obtained. Tenant information can also be found in the Management Console.
**Request Data***Specify all the required/optional url and data parameters for the given method call.***URL Parameters***Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}**Data Parameters***List all the attributes that comprises the data structure** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}JSON Authenticate, Username/Password Style Request```Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
Content-Length: 171
 
{
    "auth":{
        "passwordCredentials":{
            "username":"arunkant",
            "password":"changeme"
        },
        "tenantId":"95096564413950"
    }
}```XML Authenticate, Username/Password Style Request```Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
Content-Length: 211
 
<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantName="HP5 Tenant Services">
  <passwordCredentials username="arunkant" password="changeme"/>
</auth>```JSON Authenticate, Access Key Style Request

```  
Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
Content-Length: 176
 
{
    "auth":{
        "apiAccessKeyCredentials":{
            "accessKey":"19N488ACAF3859DW9AFS9",
            "secretKey":"vpGCFNzFZ8BMP1g8r3J6Cy7/ACOQUYyS9mXJDlxc"
        }       
    }
}
```
XML Authenticate, Access Key Style Request```
Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
Content-Length: 219
 
<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0">
  <apiAccessKeyCredentials secretKey="vpGCFNzFZ8BMP1g8r3J6Cy7/ACOQUYyS9mXJDlxc" accessKey="9N488ACAF3859DW9AFS9"/>
</auth>```**Success Response***Specify the status code and any content that is returned.***Status Code**200 - OK**Response Data**JSON```HTTP/1.1 200 OK
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
            "adminURL": "https://region-a.geo-1.comnpute.hpcloudsvc.com:8443/api/v1.0/admin/0",
            "internalURL": "https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/internal/0",
            "publicURL": "https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/public/0",
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
            "adminURL": "https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/admin/0",
            "internalURL": "https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/internal/0",
            "publicURL": "https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/public/0",
            "region": "SFO"
         }]
      },
            {
         "name": "storage5042344434157721570",
         "type": "compute",
         "endpoints": [         {
            "adminURL": "https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/admin/0",
            "internalURL": "https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/internal/0",
            "publicURL": "https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/public/0",
            "region": "SFO"
         }]
      }
   ]
}}
```XML```HTTP/1.1 200 OK
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
         <endpoint region="SFO" publicURL="https://region-a.geo-1.compute.hpcloudsvc.com/api/v1.0/public/0" internalURL="https://region-a.geo-1.compute.com:8443/api/v1.0/internal/0" adminURL="hhttps://region-a.geo-1.compute.com:8443/api/v1.0/admin/0">
            <version/>
         </endpoint>
      </service>
      <service type="object-store" name="Object Storage">
         <endpoint region="region-a.geo-1" tenantId="14541255461800" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800" internalURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/AUTH_14541255461800" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/auth/v1.0/">
            <version id="1.0" info="https://region-a.geo-1.objects.hpcloudsvc.com/info/v1.0" list="https://region-a.geo-1.objects.hpcloudsvc.com/allVersions"/>
         </endpoint>
      </service>
      <service type="identity" name="Identity">
         <endpoint region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0">
            <version id="2.0" info="https://region-a.geo-1.identity.hpcloudsvc.com/info/v2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/allVersions"/>
         </endpoint>
      </service>
      <service type="compute" name="storage5065129211418544729">
         <endpoint region="SFO" publicURL="https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/public/0" internalURL="https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/internal/0" adminURL="https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/admin/0">
            <version/>
         </endpoint>
      </service>
      <service type="compute" name="storage5042344434157721570">
         <endpoint region="SFO" publicURL="https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/public/0" internalURL="https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/internal/0" adminURL="https://region-a.geo-1.compute.hpcloudsvc.com:8443/api/v1.0/admin/0">
            <version/>
         </endpoint>
      </service>
   </serviceCatalog>
</access>
```**Error Response****Status Code**400 - Bad Request  401 - Unauthorized  403 - Forbidden  500 - Internal Server Error  **Response Data**JSON```{
  "identityFault": {
    "message": "Fault",
    "details": "Error Details...",
    "code": 500
  }
}```XML```<?xml version="1.0" encoding="UTF-8"?>
<identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
          code="500">
	<message>Fault</message>
	<details>Error Details...</details>
</identityFault>
```**Curl Examples*****Authenticate with Username/Password and Tenant ID*** ```
curl -X POST -H "Content-Type: application/json" 
     https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens 
     -d '{"auth":{"passwordCredentials":{"username":"falken@wg.com",          "password":"J0shua!"}, "tenantId":"72020596871800"}}'
				  				  ```***Authenticate with Access Keys and Tenant ID***

```
curl -X POST -H "Content-Type: application/json" 
	https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens
    -d '{"auth":{"apiAccessKeyCredentials":{"accessKey":"B5VKMNLEZ7YUN9BTFDZC", "secretKey":"CQSp+KsLQGFz6+V/S1s4XXpE42q472pD9VhIBFsn"}, "tenantId":"72020596871800"}}'
```
		**Additional Notes***Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*#### 4.4.1.2 Rescope Token#### POST /tokensThis API provides the ability to re-scope a valid token with another tenant. An existing unexpired token, regardless of its currently scoped or not, can be scoped to another tenant as long as the user has valid association with that tenant.

Re-scoping of token can be done from 1) unscoped token to a scoped token for specific tenant 2) scoped token from one tenant to another tenant 3) scoped token to unscoped token (with no tenantId and tenantName specified in request). Re-scoping of token does not alter the token expiration time and same token id is returned in response.

Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.
**Request Data***Specify all the required/optional url and data parameters for the given method call.***URL Parameters***Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}**Data Parameters***List all the attributes that comprises the data structure** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}*Either put 'This call does not require a request body' or include JSON/XML request data structure*JSON Rescope Token Request  
g
```  Accept-Encoding: gzip,deflate
Accept: application/json
Content-Type: application/json
Content-Length: 154
 
{
    "auth": {
        "tenantName": "HP Swift Tenant Services",
        "token": {
            "id": "HPAuth_4ea80da3b0be73fc0385eceb"
        }
    }
}  
```XML Rescope Token Request ```Accept-Encoding: gzip,deflate
Accept: application/xml
Content-Type: application/xml
Content-Length: 195
 
<auth xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://docs.openstack.org/identity/api/v2.0" tenantId="19694547081948">
  <token id="HPAuth_4e934043b0be09f52fb4c29d" />
</auth>```**Success Response***Specify the status code and any content that is returned.***Status Code**200 - OK**Response Data***Either put 'This call does not require a request body' or include JSON/XML response data structure*JSON```HTTP/1.1 200 OK
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
```XML```
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
```**Error Response***Enumerate all the possible error status codes and any content that is returned.***Status Code**400 - Bad Request  401 - Unauthorized  403 - Forbidden  500 - Internal Server Error503 - Service Unavailable**Response Data**JSON```{
  "identityFault": {
    "message": "Fault",
    "details": "Error Details...",
    "code": 500
  }
}```XML```<?xml version="1.0" encoding="UTF-8"?>
<identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
          code="500">
	<message>Fault</message>
	<details>Error Details...</details>
</identityFault>
```**Curl Example**```curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]```**Additional Notes***Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*#### 4.4.1.2 List Tenants#### GET /tenantsThis API returns a listing of all tenants for which the holder of the provided token has a role assignment. If the user is not a valid, an error is returned.
**Request Data****URL Parameters**| Parameter Name | Default Value | Description |  
| :------------- | :------------ | :---------- |  
| limit | If not specified, a cloud service will default the page size to some safe value. |  The *limit* value represents the maximum number of elements which will be returned in the request. |
| marker | If not specified, the marker value is null to denote start at the beginning of the collection. | The marker parameter is the resource Id of the last item in the previous list. |  
**Success Response***Specify the status code and any content that is returned.***Status Code**200 - OK**Response Data**JSON```HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 240
Date: Tue, 29 Nov 2011 17:17:50 GMT
 
{
  "tenants": [
    {
      "id": "39595655514446",
      "name": "Banking Tenant Services",
      "description": "Banking Tenant Services for TimeWarner",
      "enabled": true,
      "created": "2011-11-29T16:59:52.635Z",
      "updated": "2011-11-29T16:59:52.635Z"
    }
  ]
}
```XML```HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenants xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.w3.org/2005/Atom">
  <tenant id="541212460710" name="Time Warner Tenant Services" enabled="false" display-name="Time Warner Tenant Services">
    <description>Tenant for hosting Time Warner Applications & services</description>
  </tenant>
</tenants>```**Error Response***Enumerate all the possible error status codes and any content that is returned.***Status Code**400 - Bad Request  401 - Unauthorized  403 - Forbidden  500 - Internal Server Error503 - Service Unavailable**Response Data**JSON```{"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}```XML```<xml data structure here>```**Curl Example**```curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]```**Additional Notes***Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*#### 4.4.1.2 Revoke Token#### DELETE /HP-IDM/v1.0/tokens/<tokenId>This API is used to revoke an authentication token. This operation does not require a request body. Once a token has been revoked, attempts to validate the token via GET /tokens/tokenId will fail with a 404 (item not found) as the token no longer exists. Trying revoke a non existing token, including one which has expired will also return a 404 (item not found).
**Request Data***Specify all the required/optional url and data parameters for the given method call.***URL Parameters***Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}**Data Parameters***List all the attributes that comprises the data structure** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}This call does not require a request body.**Success Response***Specify the status code and any content that is returned.***Status Code**204 - OK**Response Data****Error Response***Enumerate all the possible error status codes and any content that is returned.***Status Code**400 - Bad Request  401 - Unauthorized  403 - Forbidden
**Response Data**JSON```{"cloudServersFault": {"message": "Server Error, please try again later.", "code": 500}}```XML```<xml data structure here>```**Curl Example**```curl -X POST -H "Content-Type: application/json" 
	https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens  
    -d '{"auth":{"apiAccessKeyCredentials":{"accessKey":"B5VKMNLEZ7YUN9BTFDZC", "secretKey":"CQSp+KsLQGFz6+V/S1s4XXpE42q472pD9VhIBFsn"}, "tenantId":"72020596871800"}}'
				  
```**Additional Notes***Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*### 4.4.2 Tenant*Describe the resource and what information they provide. Then enumerate all the API method calls below.***Status Lifecycle**N/A**Rate Limits**N/A**Quota Limits**N/A**Business Rules**None.#### 4.4.2.1 List Tenants#### GET /tenants?limit=pagesize&marker=tenantIdThis API returns a listing of all tenants for which the holder of the provided token has a role assignment. If the user is not a valid, an error is returned.**Request Data***Specify all the required/optional url and data parameters for the given method call.***URL Parameters***Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}**Data Parameters***List all the attributes that comprises the data structure** *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* - {data type} - {description of the attribute}* *name_of_attribute* (Optional) - {data type} - {description of the attribute}*Either put 'This call does not require a request body' or include JSON/XML request data structure*JSON```{json data structure here}```XML```<xml data structure here>```Optional:JSON```{json data structure here}```XML```<xml data structure here>```**Success Response***Specify the status code and any content that is returned.***Status Code**200 - OK**Response Data**JSON```HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/json
Content-Length: 240
Date: Tue, 29 Nov 2011 17:17:50 GMT
 
{
  "tenants": [
    {
      "id": "39595655514446",
      "name": "Banking Tenant Services",
      "description": "Banking Tenant Services for TimeWarner",
      "enabled": true,
      "created": "2011-11-29T16:59:52.635Z",
      "updated": "2011-11-29T16:59:52.635Z"
    }
  ]
}```XML```HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
Content-Length: 380
Date: Thu, 25 Aug 2011 23:33:19 GMT
 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<tenants xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.w3.org/2005/Atom">
  <tenant id="541212460710" name="Time Warner Tenant Services" enabled="false" display-name="Time Warner Tenant Services">
    <description>Tenant for hosting Time Warner Applications & services</description>
  </tenant>
</tenants>
```**Error Response***Enumerate all the possible error status codes and any content that is returned.***Status Code**400 - Bad Request  
401 - Unauthorized  
403 - Forbidden500 - Internal Server Error  503 - Service Unavailable  
**Response Data****Curl Example**```curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]```**Additional Notes***Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*---# 5. Additional References## 5.1 Resources**Wiki Page**: {Link to Wiki page}**Code Repo**:  {Link to the internal Github repo}**API Lead Contact**: {Name of contact}---# 6. Glossary{Put down definitions of terms and items that need explanation.}---