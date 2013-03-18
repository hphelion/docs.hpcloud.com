---
layout: page
permalink: /api/nextgen/identity/admin/
title: Identity Services Admin API
description: "HP Cloud Identity Services Admin API documenation."
keywords: "Keystone, Identity Services"
product: identity
private: true
---

# Identity Services Admin API

# 1. Overview

*Brief introduction and overview of the service and its intended use.*



## 1.1 API Maturity Level


**Maturity Level**: GA

**Version API Status**: CURRENT


---


# 2. Account-level View
*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*


# 3. REST API Specifications
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*

## 3.1 Admin API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v2.0

**HPKeystoneExtensionBaseURI**: {BaseUri}/HP-IDM/v1.0

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| Domains | [Check For Existence Of Domain Name](#check_for_existence_of_domain_name) | HEAD | /HP-IDM/v1.0/domains | Y/Y | Anonymous |
| Domains | [Create A Domain](#create_a_domain) | GET | /HP-IDM/v1.0/domains  | Y/Y | System Adminstrator (SA) |
| Domains | [Delete A Domain](#delete_a_domain) | DELETE | /HP-IDM/v1.0/domains/{domainId}  | Y/Y | System Adminstrator (SA) |
| Domains | [Get A Domain](#get_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}  | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get All Domains](#get_all_domains) | GET | /HP-IDM/v1.0/domains | Y/Y | System Adminstrator (SA) |
| Domains | [Get Groups For A Domain](#get_groups_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/groups | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Subscribe Able Services For A Domain](#get_subscribe_able_services_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/subscribeableServices | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Service Activations For A Domain](#get_service_activations_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/services | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Tenants For A Domain](#get_tenants_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/tenants | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Get Users For A Domain](#get_users_for_a_domain) | GET | /HP-IDM/v1.0/domains/{domainId}/tenants | Y/Y | System Adminstrator (SA), Domain Admin (DA) |
| Domains | [List Role Definitions (Deprecated)](#list_role_definitions_(deprecated)) | GET | /HP-IDM/v1.0/domains/{domainId}/roles | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Transfer Ownership Of A Domain](#transfer_ownership_of_a_domain) | PUT | /HP-IDM/v1.0/domains/{domainId}/owner/{userId}	 | Y/Y | System Adminstrator (SA) |
| Domains | [List Role Definitions](#list_role_definitions) | GET | /HP-IDM/v1.0/domains/{domainId}/roleDefs | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Check For Existence Of Non Tenant Role For A Given User](#check_for_existence_of_non_tenant_role_for_a_given_user) | HEAD | /HP-IDM/v1.0/domains/{domainId}/users/{userId}/roles/{roleId} | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Domains | [Delete A Non Tenant Role Assignment In The Specified Domain For The Specified User](#delete_a_non_tenant_role_assignment_in_the_specified_domain_for_the_specified_user) | DELETE | /HP-IDM/v1.0/domains/{domainId}/users/{userId}/roles/{roleId} | Y/Y | System Adminstrator (SA), Domain Admin (DA) |
| Domains | [Assign A Non Tenant Role Assignment In The Specified Domain For The Specified User](#assign_a_non_tenant_role_assignment_in_the_specified_domain_for_the_specified_user) | PUT | /HP-IDM/v1.0/domains/{domainId}/users/{userId}/roles/{roleId} | Y/Y | System Adminstrator (SA), Domain Admin (DA) |
| Domains | [List Role Definitions For A Domain And User](#list_role_definitions_for_a_domain_and_user) | GET | /HP-IDM/v1.0/domains/{domainId}/users/{userId}/roles | Y/Y | System Adminstrator (SA), Domain Admin (DA), Domain User (DU) |
| Projects | [List Projects](#list_projects) | GET | /projects | Y/Y | SS |
| Tokens | [Authenticate](#authenticate) | POST | /v3/auth/tokens | Y/Y | Anon |
| Tokens | [Rescope Token](#rescope_token) | POST | /v3/auth/tokens | Y/Y | SS |
| Tokens | [Revoke Token](#revoke_token) | DELETE | /v3/auth/tokens/ | Y/Y | SA,DA,SS |
| Tokens | [Validate Token](#validate_token) | GET | /v3/auth/tokens/HP-IDM-serviceId=110,global,130&HP-IDM-endpointTemplateId=110,111 | Y/Y | Anon |
| Tokens | [Quick Token Validation](#quick_token_validation) | HEAD | /v3/auth/tokens | Y/Y | Anon |
| Versions | [GET Versions](#get_versions) | HEAD | /v3/auth/tokens | Y/Y |   |

## 3.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

## 3.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *

## 3.4 Admin API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*


### 3.4.1 Domains

The entity that serves as a collection of users, groups, roles, and tenants. It represents the primary relationship between the customer and HP.  A Domain can be an individual or company.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 3.4.1.1 Check For Existence Of Domain Name#### {#check_for_existence_of_domain_name}
#### HEAD /HP-IDM/v1.0/domains
*Privilege Level: Anonymous*

This API does case insensitive domainName lookup in system. It returns http status code 200 (Ok) when provided domainName exists and returns 404 (not found) when provided domainName is not found in the system. If provided domainName is blank or missing, then it returns 204 (No content). The domain name with extra spaces is converted to single space in-between words and then look up is done for its existence. So domain name " Abc Corp" and "ABC    Corp" are treated as same and will be found if entry is there in system. In system, the corresponding name is going to be stored as "abc corp" in a separate field.    
  
As this API just checks for existence of provided domainName, it does not do look into status (or any other entity attribute) for case when matching domain is found.

**Request Data**

This API does not require http header X-Auth-Token and is protected by client certificate authentication. There is no response body returned in API response data. 

**URL Parameters**

* *name* - string - name of the domain to look for existence (required)

**Data Parameters**

This call does not require a request body

JSON

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21_11_01_30_565 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json

XML

Case-insensitive lookup of above domainName

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=domain_2012_08_21_11_01_30_565 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml

Optional:

JSON 

When provided domainName not found

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json

When missing domainName in request

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml

**Success Response**

There is no response body returned. Status code indicates the result where 200 indicates that provided name exists and 404 indicates when name does not exist.

**Status Code**

200 - OK , 404 - NOT FOUND

**Response Data**

This call does not return a response body and result is determined through returned http status code. Response body is present only in case of errors.

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Tue, 21 Aug 2012 19:15:56 GMT

XML

Response for case-insensitive lookup of above domainName

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Tue, 21 Aug 2012 19:17:00 GMT

**Error Response**

Status code 204 is returned when either domain name is missing or blank.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 204 | No Content | When domainName is missing or blank |  
| 400 | Bad Request | Malformed request in URI |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

When provided domainName is not found

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: \-1
    Content-Type: text/html;charset=utf-8
    Content-Length: 952
    Date: Tue, 21 Aug 2012 19:17:43 GMT

When missing domainName in request

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: \-1
    Date: Tue, 21 Aug 2012 19:18:23 GMT


Curl Example

    curl -k  --cert dev_hpmiddleware.pem  -I -H "Accept: application/json" "https://localhost:35357/v2.0/HP-IDM/v1.0/domains?name=DoMaiN_2012_08_21565"

**Additional Notes**




#### 3.4.1.2 Create A Domain#### {#create_a_domain}
#### GET /HP-IDM/v1.0/domains 
*Privilege Level: System Adminstrator (SA)*

Creates a domain using the specified request body. A response body is also returned with the new domain information with a service generated domainId.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**



**Data Parameters**

See schema file, domain.xsd, for more details on the request and response data structure.



* *name* - string - Name of the domain to be created
* *description* - (Optional) - string - description of domain
* *addressLine1* (Optional) - string - 
* *addressLine2* (Optional) - string - 
* *city* (Optional) - string - 
* *state* (Optional) - string - 
* *zip* (Optional) - string - 
* *country* (Optional) - string - 
* *phone* (Optional) - string - 
* *company* (Optional) - string - 
* *website* (Optional) - string - 
* *emailAddress* (Optional) - string -
* *billToAddress" (Optional) - Bill to Address 



JSON

    POST https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Content-Type: application/json
    Content-Length: 495
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
    
    {
      "domain" : {
        "description" : "See's Candies Domain",
        "anies" : null,
        "addressLine1" : "128, Market Blvd",
        "addressLine2" : null,
        "city" : "San Francisco",
        "company" : null,
        "country" : "USA",
        "domainId" : "50277849949620",
        "emailAddress" : "owner@sees.com",
        "name" : "Sees Candies",
        "otherAttributes" : {
        },
        "phone" : "1-800-555-1212",
        "state" : "CA",
        "status" : "enabled",
        "website" : "www.sees.com",
        "zip" : "90210"
      }
    }

XML

    POST /v2.0/HP-IDM/v1.0/domains HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4f47d0b12cdc8b1c3905dbda
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 617
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled">
      <description>Hp's Private Cloud Domain</description>
      <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
       </billToAddress> 
    </domain>

Optional:


**Success Response**

The response body contains data for newly created domain with http status code of 201.

**Status Code**

201 - CREATED

**Response Data**

Response data structure is same as input domain data

JSON

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=5A0C0E3AD8FBB574807901C3F1FB5741; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 426
    Date: Tue, 30 Oct 2012 20:19:32 GMT
    
    {
      "domain" : {
        "description" : "See's Candies Domain",
        "addressLine1" : "128, Market Blvd",
        "city" : "San Francisco",
        "country" : "USA",
        "domainId" : "25279093386747",
        "emailAddress" : "owner@sees.com",
        "name" : "Sees Candies",
        "otherAttributes" : {
        },
        "phone" : "1-800-555-1212",
        "state" : "CA",
        "status" : "enabled",
        "website" : "www.sees.com",
        "zip" : "90210"
      }
    }

XML

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 643
    Date: Fri, 24 Feb 2012 18:02:43 GMT
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" domainId="80354991891807" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled">
      <description>Hp's Private Cloud Domain</description>
      <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
       </billToAddress> 
    </domain>

**Error Response**

Please refer to error response body for additional details.

**Status Code**


| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation   |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 409 | Identity Fault | A Domain with the required parameters already exist in the system  |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  



**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

In case domain name already exists
    HTTP/1.1 409 Conflict
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=8AD5634E0DBA2968E3136CDB8F3C6EB5; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 154
    Date: Tue, 30 Oct 2012 20:20:32 GMT
    
    {
      "IdentityFault" : {
        "message" : "Identity fault",
        "details" : "Domain already exists",
        "code" : 409,
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XPOST -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" -d '{  "domain" : {  "name" : "Sees Candies 6" } }'  https://localhost:35357/v2.0/HP-IDM/v1.0/domains

**Additional Notes**



#### 3.4.1.3 Delete A Domain#### {#delete_a_domain}
#### DELETE /HP-IDM/v1.0/domains/{domainId} 
*Privilege Level: System Adminstrator (SA)*

Deletes the specified domain by its {domainID}. This API deletes the Users, Tenants, Groups, Roles, RoleRefs and Grants associated to the Domain.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**



**Data Parameters**

This call does not require a request body

JSON

    DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

Now trying to delete previously deleted domain, expecting error.

    DELETE https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

Optional:



**Success Response**

There is no respone body and respons code of 204 is returned after successful deletion of domain.

**Status Code**

204 - No Content

**Response Data**

This call does not have a response body other than in case of errors.

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=38FAFEF8E7816E6B717B1328FC6AFF49; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 30 Oct 2012 21:30:16 GMT

XML

Response for deleting previously deleted domain.

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=5E50B7163151DDF072B2B0E5AF5B33BF; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 368
    Date: Tue, 30 Oct 2012 21:31:04 GMT
    
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><itemNotFound xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="404"><message>Not found</message><details>Domain does not exist</details></itemNotFound>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation    |  
| 403 | Forbidden | Disabled or suspended user making the request. This error is also returned when there is dependent data that needs to be removed as well |  
| 404 | Not Found | The Domain for domainId does not exist    |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

Response for deleting previously deleted domain.

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=E58C6550A98478BD88C3392EB379F734; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 148
    Date: Tue, 30 Oct 2012 21:43:21 GMT
    
    {
      "itemNotFound" : {
        "code" : 404,
        "details" : "Domain does not exist",
        "message" : "Not found",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XDELETE -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196

**Additional Notes**



#### 3.4.1.4 Get A Domain#### {#get_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId} 
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

Get a domain based on the {domainId} specified. DomainId's are opaque values returned with get domain list operations. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body

JSON

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/63283648950838 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_5032ad14957cb3caab6c33eb

XML

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/81132865245171 HTTP/1.1GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/63283648950838 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_5032ad14957cb3caab6c33eb

Optional:



**Success Response**

The domain data is returned with http status code of 200 for provided domainId.

**Status Code**

200 - OK

**Response Data**

See schema file, domain.xsd, for more details on the domain response data structure.

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 603
    Date: Mon, 20 Aug 2012 23:07:59 GMT
     
    {
      "domain" : {
        "description" : "Hp's Private Cloud Domain",
        "anies" : null,
        "addressLine1" : "1, HP Way",
        "addressLine2" : null,
        "billingId" : "4028e69737163f4e013732dc605210ba",
        "city" : "Cupertino",
        "company" : "HP",
        "contactId" : "001Q000000TU4q4IAD",
        "country" : "USA",
        "domainId" : "63283648950838",
        "emailAddress" : "hp-private-cloud-6@hp.com",
        "name" : "HP Private Cloud Domain",
        "otherAttributes" : {
        },
        "phone" : "1-888-555-1212",
        "state" : "CA",
        "status" : "enabled",
        "website" : "www.hp.com",
        "zip" : "90210"
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 719
    Date: Mon, 20 Aug 2012 23:06:39 GMT
     
    <domain domainId="63283648950838" name="HP Private Cloud Domain" emailAddress="hp-private-cloud-6@hp.com" addressLine1="1, HP Way" city="Cupertino" state="CA" zip="90210" country="USA" website="www.hp.com" company="HP" phone="1-888-555-1212" status="enabled" billingId="4028e69737163f4e013732dc605210ba" contactId="001Q000000TU4q4IAD" xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
       <description>Hp's Private Cloud Domain</description>
       <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
       </billToAddress> 
    </domain>

**Error Response**

Please refer to error response body for additional details.


**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI or request body   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The Domain for domainId does not exist    |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

When provided domainId is not found in the system

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=FFE0355EF1D55E4EC60754298955D53C; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 148
    Date: Tue, 30 Oct 2012 23:32:45 GMT
    
    {
      "itemNotFound" : {
        "code" : 404,
        "details" : "Domain does not exist",
        "message" : "Not found",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196

**Additional Notes**


#### 3.4.1.5 Get All Domains#### {#get_all_domains}
#### GET /HP-IDM/v1.0/domains
*Privilege Level: System Adminstrator (SA)*

Allows reading a list of all domains. This API supports pagination through 'limit' and 'marker' usage. The returned list may be filtered to allow only those domains which the caller has access to. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.


**URL Parameters**


* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list
* *name* (Optional)} - string - filter by domain name

**Data Parameters**

This call does not require a request body

JSON

With limit parameter provided

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains?limit=2 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
    
    

XML

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)
    

Optional:

JSON

With marker and parameter both set


    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains?limit=2&marker=23213441623236 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)


**Success Response**

Returns list of domains for given input with http status code 200.

**Status Code**

200 - OK

**Response Data**



JSON

Listing all domains response

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=9CE7501B1B4C569F720C15B6692C7DD2; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 2353
    Date: Tue, 30 Oct 2012 23:53:11 GMT
    
    {
      "domains" : {
        "domain" : [ {
          "owners" : {
            "owner" : [ {
              "otherAttributes" : {
              },
              "userId" : "00000000003001"
            } ]
          },
          "domainId" : "00000000001001",
          "name" : "HP Cloud System Domain",
          "otherAttributes" : {
          },
          "status" : "enabled"
        }, {
          "domainId" : "23213441623236",
          "name" : "Sees Candies 6",
          "otherAttributes" : {
          },
          "status" : "enabled"
        }, {
          "description" : "See's Candies Domain",
          "addressLine1" : "128, Market Blvd",
          "city" : "San Francisco",
          "country" : "USA",
          "domainId" : "25279093386747",
          "emailAddress" : "owner@sees.com",
          "name" : "Sees Candies",
          "otherAttributes" : {
          },
          "phone" : "1-800-555-1212",
          "state" : "CA",
          "status" : "enabled",
          "website" : "www.sees.com",
          "zip" : "90210"
        }, {
          "domainId" : "45548920306336",
          "name" : "Sees Candies 5",
          "otherAttributes" : {
          },
          "status" : "enabled"
        }, {
          "description" : "See's Candies Domain",
          "addressLine1" : "128, Market Blvd",
          "city" : "San Francisco",
          "country" : "USA",
          "domainId" : "53584481318159",
          "emailAddress" : "owner@sees.com",
          "name" : "Sees Candies 2",
          "otherAttributes" : {
          },
          "phone" : "1-800-555-1212",
          "state" : "CA",
          "status" : "enabled",
          "website" : "www.sees.com",
          "zip" : "90210"
        }, {
          "owners" : {
            "owner" : [ {
              "otherAttributes" : {
              },
              "userId" : "77641675774128"
            } ]
          },
          "domainId" : "69985299710130",
          "emailAddress" : "test@test.com",
          "name" : "69985299710130-DOMAIN",
          "otherAttributes" : {
          },
          "status" : "enabled"
        }, {
          "domainId" : "82997401317216",
          "name" : "Sees Candies 4",
          "otherAttributes" : {
          },
          "status" : "enabled"
        }, {
          "owners" : {
            "owner" : [ {
              "otherAttributes" : {
              },
              "userId" : "74110440977688"
            } ]
          },
          "domainId" : "95403455987464",
          "emailAddress" : "test@test.com",
          "name" : "95403455987464-DOMAIN",
          "otherAttributes" : {
          },
          "status" : "enabled"
        } ],
        "otherAttributes" : {
        }
      }
    }

Listing response with marker and parameter both set
    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=587724ABE90EFF995115B4C07680F1F5; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 658
    Date: Tue, 30 Oct 2012 23:51:42 GMT
    
    {
      "domains" : {
        "domain" : [ {
          "description" : "See's Candies Domain",
          "addressLine1" : "128, Market Blvd",
          "city" : "San Francisco",
          "country" : "USA",
          "domainId" : "25279093386747",
          "emailAddress" : "owner@sees.com",
          "name" : "Sees Candies",
          "otherAttributes" : {
          },
          "phone" : "1-800-555-1212",
          "state" : "CA",
          "status" : "enabled",
          "website" : "www.sees.com",
          "zip" : "90210"
        }, {
          "domainId" : "45548920306336",
          "name" : "Sees Candies 5",
          "otherAttributes" : {
          },
          "status" : "enabled"
        } ],
        "otherAttributes" : {
        }
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=68E1E45A984F2747A98E2DF07E95B3E5; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 1625
    Date: Tue, 30 Oct 2012 23:54:44 GMT
    
    <domains xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
       <domain domainId="00000000001001" name="HP Cloud System Domain" status="enabled">
          <owners>
             <owner userId="00000000003001"/>
          </owners>
       </domain>
       <domain domainId="23213441623236" name="Sees Candies 6" status="enabled"/>
       <domain domainId="25279093386747" name="Sees Candies" emailAddress="owner@sees.com" addressLine1="128, Market Blvd" city="San Francisco" state="CA" zip="90210" country="USA" website="www.sees.com" phone="1-800-555-1212" status="enabled">
          <description>See's Candies Domain</description>
          <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
          </billToAddress> 
       </domain>
       <domain domainId="45548920306336" name="Sees Candies 5" status="enabled"/>
       <domain domainId="53584481318159" name="Sees Candies 2" emailAddress="owner@sees.com" addressLine1="128, Market Blvd" city="San Francisco" state="CA" zip="90210" country="USA" website="www.sees.com" phone="1-800-555-1212" status="enabled">
          <description>See's Candies Domain</description>
       </domain>
       <domain domainId="69985299710130" name="69985299710130-DOMAIN" emailAddress="test@test.com" status="enabled">
          <owners>
             <owner userId="77641675774128"/>
          </owners>
       </domain>
       <domain domainId="82997401317216" name="Sees Candies 4" status="enabled"/>
       <domain domainId="95403455987464" name="95403455987464-DOMAIN" emailAddress="test@test.com" status="enabled">
          <owners>
             <owner userId="74110440977688"/>
          </owners>
       </domain>
    </domains>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | When invalid marker is provided    |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

When invalid marker is provided

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=D3AC697EC1B71E03C6250E8EFDE8996E; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 154
    Date: Tue, 30 Oct 2012 23:56:58 GMT
    
    {
      "itemNotFound" : {
        "code" : 404,
        "details" : "Marker in request not found",
        "message" : "Not found",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains

**Additional Notes**


#### 3.4.1.6 Get Groups For A Domain#### {#get_groups_for_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId}/groups
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API is used to get list of groups for a given domain. Api results can be filtered by using parameters. Query parameters "marker" and "limit" can be used for pagination


**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list

Following filters can be used to filter the response data.

*Inclusion Filters*

* *groupId (Optional)* - string - include results for given groupId. Filters groupId and groupName are mutually exclusive. You can filter either using groupId or using groupName.
* *groupName (Optional)* - string - include results for given groupName. Filters groupId and groupName are mutually exclusive. You can filter either using groupId or using groupName  
* *tenantId (Optional)* - string - include results for given tenantId. Filters tenantId and tenantName are mutually exclusive. You can filter either using tenantId or using tenantName
* *tenantName (Optional)* - string - include results for given tenantName. Filters tenantId and tenantName are mutually exclusive. You can filter either using tenantId or using tenantName    

*Exclusion Filters*

* *excludeRoles (Optional)* - string - comma separated roleId to exclude 
* *excludeUsers (Optional)* - string - comma separated userId to exclude

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body

JSON

Request without filters
    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/groups HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

Request with marker and groupName

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/groups?marker=20249143710988&groupName=Domain%20Administrators HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

Optional:

XML

Request with filters groupId and excludeRoles

    GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP_IDM/v1.0/domains/641564254582/groups/groupId=1234&excludeRoles=roleId1,roleId2 HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

Request with filters excludeUsers

    GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP_IDM/v1.0/domains/641564254582/groups?excludeUsers=userId1,userId2 HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

Request with filters tenantId and excludeRoles

    GET http://haneef-desktop.americas.hpqcorp.net:8080/v2.0/HP_IDM/v1.0/domains/641564254582/groups/tenantId=1234&excludeRoles=roleId1,roleId2 HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

**Success Response**

List groups for domain for given filter criteria and marker if there with http status code 200.

**Status Code**

200 - OK

**Response Data**


JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=8DD402CDD89EF3A61D73B915F4B8BE42; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 474
    Date: Wed, 31 Oct 2012 15:42:34 GMT
    
    {
      "groups" : {
        "group" : [ {
          "description" : "Sees Candies   3 Domain Administrators",
          "domainId" : "66751536630361",
          "id" : "20249143710988",
          "name" : "Domain Administrators",
          "otherAttributes" : {
          }
        }, {
          "description" : "Sees Candies   3 Users",
          "domainId" : "66751536630361",
          "id" : "80305392769921",
          "name" : "Users",
          "otherAttributes" : {
          }
        } ],
        "otherAttributes" : {
        }
      }
    }

XML

Request with marker and groupName

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=10C0D5531A322E76410588242947F78D; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 332
    Date: Wed, 31 Oct 2012 16:44:21 GMT
    
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><groups xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom"/>


**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or groupId within the marker was not found. Or both groupId and groupName is specified   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

    {
      "badRequest" : {
        "code" : 400,
        "details" : "Bad input request : Filters groupId and groupName are mutually exclusive.  You can't use both at the same time",
        "message" : "Bad request",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/groups

**Additional Notes**


#### 3.4.1.7 Get Subscribe Able Services For A Domain#### {#get_subscribe_able_services_for_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId}/subscribeableServices
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API returns all subscribe able services that are available for the given {domainId} . It can also filter the result based on service name or endpoint template id. In request, either 'serviceName' filter or 'serviceEndpointId' filter is to be used. If both of filter values are provided, then error is returned back. This is essentially endpoint template data with some additional subscription specific attributes.
Domain user can only list subcribeable services but cannot subscribe services so "canSubscribe" flag is returned as false. DA and SA both can list and subscribe services.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


* *serviceName (Optional)* - string - Use service name if need to get subscrible data for all endpoints within that service.

* *endpointTemplateId (Optional)* - string - User endpoint template Id to get specific endpoint subscrible able data

**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body.


JSON

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

    GET https://localhost:8443/v2.0/HP-IDM/v1.0/domains/64521341789596/subscribeableServices HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token: HPAuth_4f46a309b0bebb59e36f663f
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

Optional:

JSON

With serviceName filter
    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices?serviceName=Compute HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)


**Success Response**

The response is a list of subscribe able services for the domain. Results are filtered by serviceName if serviceName is provided. Result will include single subscribe able service as identified endpoint template id if its provided in query.

**Status Code**

200 - OK

**Response Data**


JSON

    {"subscribeableServices": {
       "otherAttributes": {},
       "subscribeableService":    [
                {
             "adminURL": "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "100",
             "name": "Compute",
             "otherAttributes": {},
             "publicURL": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
             "publicURL2": "https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
             "region": "az-1.region-a.geo-1",
             "releaseState": "public",
             "type": "compute",
             "version":          {
                "id": "1.1",
                "list": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "110",
             "name": "Compute",
             "otherAttributes": {},
             "publicURL": "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
             "publicURL2": "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
             "region": "az-2.region-a.geo-1",
             "releaseState": "public",
             "type": "compute",
             "version":          {
                "id": "1.1",
                "list": "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "111",
             "name": "Compute",
             "otherAttributes": {},
             "publicURL": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
             "publicURL2": "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
             "region": "az-3.region-a.geo-1",
             "releaseState": "public",
             "type": "compute",
             "version":          {
                "id": "1.1",
                "list": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "120",
             "name": "Object Storage",
             "otherAttributes": {},
             "publicURL": "https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%",
             "region": "region-a.geo-1",
             "releaseState": "public",
             "type": "object-store",
             "version":          {
                "id": "1.0",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": true,
             "id": "130",
             "internalURL": "https://region-a.geo-1.identity-internal.hpcloudsvc.com/v2.0/",
             "name": "Identity",
             "otherAttributes": {},
             "publicURL": "https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/",
             "region": "region-a.geo-1",
             "releaseState": "public",
             "type": "identity",
             "version":          {
                "id": "2.0",
                "list": "https://region-a.geo-1.identity.hpcloudsvc.com/extension",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "140",
             "name": "Block Storage",
             "otherAttributes": {},
             "publicURL": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
             "region": "az-1.region-a.geo-1",
             "releaseState": "public",
             "type": "volume",
             "version":          {
                "id": "1.1",
                "list": "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
                "otherAttributes": {}
             }
          },
     
                {
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "150",
             "name": "CDN",
             "otherAttributes": {},
             "publicURL": "https://region-a.geo-1.cdnmgmt.hpcloudsvc.com/v1.0/",
             "region": "region-a.geo-1",
             "releaseState": "public",
             "type": "hpext:cdn",
             "version":          {
                "id": "1.0",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://glance1.uswest.hpcloud.net:9292/v1.0",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "160",
             "name": "Image Management",
             "otherAttributes": {},
             "region": "az-1.region-a.geo-1",
             "releaseState": "public",
             "type": "image",
             "version":          {
                "id": "1.0",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://glance2.uswest.hpcloud.net:9292/v1.0",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "170",
             "name": "Image Management",
             "otherAttributes": {},
             "region": "az-2.region-a.geo-1",
             "releaseState": "public",
             "type": "image",
             "version":          {
                "id": "1.0",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "113",
             "name": "EC2",
             "otherAttributes": {},
             "publicURL": "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
             "region": "az-2.region-a.geo-1",
             "releaseState": "public",
             "type": "ec2",
             "version":          {
                "id": "1.1",
                "list": "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
                "otherAttributes": {}
             }
          },
                {
             "adminURL": "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
             "canSubscribe": true,
             "enabled": true,
             "endpointReleaseState": "public",
             "global": false,
             "id": "114",
             "name": "EC2",
             "otherAttributes": {},
             "publicURL": "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
             "region": "az-3.region-a.geo-1",
             "releaseState": "public",
             "type": "ec2",
             "version":          {
                "id": "1.1",
                "list": "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
                "otherAttributes": {}
             }
          }
       ]
    }}

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=4ADA3703B5E45F3C198E4E4F0CC9A4D8; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 5128
    Date: Thu, 23 Feb 2012 20:37:58 GMT
     
    <subscribeableServices xmlns="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="100" type="compute" name="Compute" region="az-1.region-a.geo-1" publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
          <version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
          <subscribedInfo subscribedOn="2011-10-21T22:04:11.000Z" tenantId="36733265821255" status="deleted"/>
          <subscribedInfo subscribedOn="2011-10-21T22:05:43.000Z" tenantId="79402136023481" status="enabled"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="110" type="compute" name="Compute" region="az-2.region-a.geo-1" publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
          <version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="111" type="compute" name="Compute" region="az-3.region-a.geo-1" publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" publicURL2="https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/" adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
          <version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" id="120" type="object-store" name="Object Storage" region="region-a.geo-1" publicURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/%tenant_id%" adminURL="https://region-a.geo-1.objects.hpcloudsvc.com/v1.0/" global="false" enabled="true">
          <version id="1.0"/>
          <subscribedInfo subscribedOn="2011-10-25T20:51:49.000Z" tenantId="72290583996765"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="130" type="identity" name="Identity" region="region-a.geo-1" publicURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" internalURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" adminURL="https://region-a.geo-1.identity.hpcloudsvc.com/v2.0/" global="true" enabled="true">
          <version id="2.0" list="https://region-a.geo-1.identity.hpcloudsvc.com/extension"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="140" type="hpext:block-store" name="Block Storage" region="az-1.region-a.geo-1" publicURL="https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
          <version id="1.1" list="https://az-1.region-a.geo-1.compute.hpcloudsvc.com"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="141" type="hpext:block-store" name="Block Storage" region="az-2.region-a.geo-1" publicURL="https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
          <version id="1.1" list="https://az-2.region-a.geo-1.compute.hpcloudsvc.com"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="142" type="hpext:block-store" name="Block Storage" region="az-3.region-a.geo-1" publicURL="https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/" adminURL="https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/" global="false" enabled="true">
          <version id="1.1" list="https://az-3.region-a.geo-1.compute.hpcloudsvc.com"/>
       </subscribeableService>
       <subscribeableService releaseState="preview" endpointReleaseState="public" canSubscribe="false" id="150" type="hpext:cdn" name="CDN" region="region-a.geo-1" publicURL="https://region-a.geo-1.cdnmgmt.hpcloudsvc.com/v1.0/" global="false" enabled="true">
          <version id="1.0"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="160" type="image" name="Image Management" region="az-1.region-a.geo-1" adminURL="https://glance1.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
          <version id="1.0"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="170" type="image" name="Image Management" region="az-2.region-a.geo-1" adminURL="https://glance2.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
          <version id="1.0"/>
       </subscribeableService>
       <subscribeableService releaseState="public" endpointReleaseState="public" canSubscribe="true" id="180" type="image" name="Image Management" region="az-3.region-a.geo-1" adminURL="https://glance3.uswest.hpcloud.net:9292/v1.0" global="false" enabled="true">
          <version id="1.0"/>
       </subscribeableService>
    </subscribeableServices>

Optional

JSON

With serviceName filter

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=57031777BBA23809F2B7B172E342A8F9; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 2265
    Date: Wed, 31 Oct 2012 18:13:14 GMT
    
    {
      "subscribeableServices" : {
        "otherAttributes" : {
        },
        "subscribeableService" : [ {
          "adminURL" : "https://nv-aw2az1-manage0009.uswest.hpcloud.net/v1.1/",
          "canSubscribe" : true,
          "enabled" : true,
          "endpointReleaseState" : "public",
          "global" : false,
          "id" : "100",
          "name" : "Compute",
          "otherAttributes" : {
          },
          "publicURL" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
          "publicURL2" : "https://az-1.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
          "region" : "az-1.region-a.geo-1",
          "releaseState" : "public",
          "type" : "compute",
          "version" : {
            "id" : "1.1",
            "list" : "https://az-1.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes" : {
            }
          }
        }, {
          "adminURL" : "https://nv-aw2az2-manage0009.uswest.hpcloud.net/v1.1/",
          "canSubscribe" : true,
          "enabled" : true,
          "endpointReleaseState" : "public",
          "global" : false,
          "id" : "110",
          "name" : "Compute",
          "otherAttributes" : {
          },
          "publicURL" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
          "publicURL2" : "https://az-2.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
          "region" : "az-2.region-a.geo-1",
          "releaseState" : "public",
          "type" : "compute",
          "version" : {
            "id" : "1.1",
            "list" : "https://az-2.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes" : {
            }
          }
        }, {
          "adminURL" : "https://nv-aw2az3-manage0009.uswest.hpcloud.net/v1.1/",
          "canSubscribe" : true,
          "enabled" : true,
          "endpointReleaseState" : "public",
          "global" : false,
          "id" : "111",
          "name" : "Compute",
          "otherAttributes" : {
          },
          "publicURL" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com/v1.1/",
          "publicURL2" : "https://az-3.region-a.geo-1.ec2-compute.hpcloudsvc.com/services/Cloud/",
          "region" : "az-3.region-a.geo-1",
          "releaseState" : "public",
          "type" : "compute",
          "version" : {
            "id" : "1.1",
            "list" : "https://az-3.region-a.geo-1.compute.hpcloudsvc.com",
            "otherAttributes" : {
            }
          }
        } ]
      }
    }


**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI; If present, non-numeric endpoint template id is provided; If present, invalid endpoint template id is provided.; If present, invalid service name is provided.; If both serviceName and endpointTemplateId values are provided. |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or tenantId filter is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

    HTTP/1.1 400 Bad Request
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=670399F2C2059BD56F33D988AE8A2712; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 181
    Date: Wed, 31 Oct 2012 18:16:24 GMT
    Connection: close
    
    {
      "badRequest" : {
        "code" : 400,
        "details" : "Invalid service name specified, serviceName = Computer",
        "message" : "BAD_REQUEST",
        "otherAttributes" : {
        }
      }
    }

    HTTP/1.1 404 Not Found
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=274CFEB4593E9BB8D00C8DED21E3E75B; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 193
    Date: Wed, 31 Oct 2012 18:15:44 GMT
    
    {
      "itemNotFound" : {
        "code" : 404,
        "details" : "Domain with domainId : 66751536630362 does not exist in the System",
        "message" : "NOT_FOUND",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/subscribeableServices?serviceName=Compute 

**Additional Notes**



#### 3.4.1.8 Get Service Activations For A Domain#### {#get_service_activations_for_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId}/services
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API returns all services that have been activated for the given {domainId} . It can also filter the result based on tenantId. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


* *tenantId (Optional)* - string - tenantId to list service activation for that tenant
* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list. 'id' value in 'activatedService' response

**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body.


JSON

Request with tenantId 

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/90681825319071/services?tenantId=24290042003272 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_a46a8b6ddef111f44d569089564e2ee6efbe11f91cc04e0f7f3d26048e04df2d
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

List all activated services

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/90681825319071/services HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_a46a8b6ddef111f44d569089564e2ee6efbe11f91cc04e0f7f3d26048e04df2d
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

Optional:

JSON

When limit is specified without any marker (4 total documents)

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/90681825319071/services?limit=4 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_a46a8b6ddef111f44d569089564e2ee6efbe11f91cc04e0f7f3d26048e04df2d
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

When limit is specified with marker (4 total documents)

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/90681825319071/services?limit=2&marker=50a2a2ee957c4415121a2417 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_a46a8b6ddef111f44d569089564e2ee6efbe11f91cc04e0f7f3d26048e04df2d
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML 

When no activated services are there for a domain

    GET https://localhost:35357/v2.0/HP-IDM/v1.0/domains/88812793023919/services HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_a46a8b6ddef111f44d569089564e2ee6efbe11f91cc04e0f7f3d26048e04df2d
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

**Success Response**

The response is a list of activated services for the domain (filtered by tenantId if tenantId is provided)

**Status Code**

200 - OK

**Response Data**


JSON

Response with tenantId filter

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=94C8007DACBD6F746B211CEF012F4E4A; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 472
    Date: Tue, 13 Nov 2012 22:16:51 GMT
    
    {
      "activatedServices" : {
        "activatedService" : [ {
          "endpointTemplateId" : "120",
          "id" : "50a2a2ee957c4415121a241c",
          "otherAttributes" : {
          },
          "region" : "region-a.geo-1",
          "serviceId" : "110",
          "serviceName" : "Object Storage",
          "serviceType" : "object-store",
          "status" : "enabled",
          "subscribedOn" : "2012-11-13T19:43:42.992Z",
          "tenantId" : "24290042003272"
        } ],
        "otherAttributes" : {
        }
      }
    }

XML

Response for all activated services

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=4C4529A54A66517449F10A8F083E5570; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 1402
    Date: Tue, 13 Nov 2012 22:24:47 GMT
    
    <ns1:activatedServices xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
       <ns1:activatedService id="50a2a2ee957c4415121a2412" serviceId="110" serviceName="Object Storage" serviceType="object-store" region="region-a.geo-1" subscribedOn="2012-11-13T19:43:42.283Z" tenantId="45289935905449" status="enabled" endpointTemplateId="120"/>
       <ns1:activatedService id="50a2a2ee957c4415121a2417" serviceId="110" serviceName="Object Storage" serviceType="object-store" region="region-a.geo-1" subscribedOn="2012-11-13T19:43:42.422Z" tenantId="28729687685789" status="enabled" endpointTemplateId="120"/>
       <ns1:activatedService id="50a2a2ee957c4415121a241c" serviceId="110" serviceName="Object Storage" serviceType="object-store" region="region-a.geo-1" subscribedOn="2012-11-13T19:43:42.992Z" tenantId="24290042003272" status="enabled" endpointTemplateId="120"/>
       <ns1:activatedService id="50a2a2ef957c4415121a2421" serviceId="110" serviceName="Object Storage" serviceType="object-store" region="region-a.geo-1" subscribedOn="2012-11-13T19:43:43.221Z" tenantId="35383765754307" status="enabled" endpointTemplateId="120"/>
    </ns1:activatedServices>

Optional



JSON

When limit is specified without any marker (4 total documents)

    {"activatedServices": {
       "activatedService":    [
                {
             "endpointTemplateId": "120",
             "id": "50a2a2ee957c4415121a2412",
             "otherAttributes": {},
             "region": "region-a.geo-1",
             "serviceId": "110",
             "serviceName": "Object Storage",
             "serviceType": "object-store",
             "status": "enabled",
             "subscribedOn": "2012-11-13T19:43:42.283Z",
             "tenantId": "45289935905449"
          },
                {
             "endpointTemplateId": "120",
             "id": "50a2a2ee957c4415121a2417",
             "otherAttributes": {},
             "region": "region-a.geo-1",
             "serviceId": "110",
             "serviceName": "Object Storage",
             "serviceType": "object-store",
             "status": "enabled",
             "subscribedOn": "2012-11-13T19:43:42.422Z",
             "tenantId": "28729687685789"
          },
                {
             "endpointTemplateId": "120",
             "id": "50a2a2ee957c4415121a241c",
             "otherAttributes": {},
             "region": "region-a.geo-1",
             "serviceId": "110",
             "serviceName": "Object Storage",
             "serviceType": "object-store",
             "status": "enabled",
             "subscribedOn": "2012-11-13T19:43:42.992Z",
             "tenantId": "24290042003272"
          },
                {
             "endpointTemplateId": "120",
             "id": "50a2a2ef957c4415121a2421",
             "otherAttributes": {},
             "region": "region-a.geo-1",
             "serviceId": "110",
             "serviceName": "Object Storage",
             "serviceType": "object-store",
             "status": "enabled",
             "subscribedOn": "2012-11-13T19:43:43.221Z",
             "tenantId": "35383765754307"
          }
       ],
       "otherAttributes": {}
    }}

XML

When limit is specified with marker (4 total documents)

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=6AE817EEDD2D62CF0217FD840AEC5393; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 888
    Date: Tue, 13 Nov 2012 22:13:36 GMT
    
    <ns1:activatedServices xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom">
       <ns1:activatedService id="50a2a2ee957c4415121a241c" serviceId="110" serviceName="Object Storage" serviceType="object-store" region="region-a.geo-1" subscribedOn="2012-11-13T19:43:42.992Z" tenantId="24290042003272" status="enabled" endpointTemplateId="120"/>
       <ns1:activatedService id="50a2a2ef957c4415121a2421" serviceId="110" serviceName="Object Storage" serviceType="object-store" region="region-a.geo-1" subscribedOn="2012-11-13T19:43:43.221Z" tenantId="35383765754307" status="enabled" endpointTemplateId="120"/>
    </ns1:activatedServices>

XML

When no activated services are there for a domain
    TTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=14E953B8EA880BC9A80AB77B9CE5F22B; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 351
    Date: Tue, 13 Nov 2012 22:30:03 GMT
    
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><ns1:activatedServices xmlns:ns1="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://docs.openstack.org/common/api/v1.0" xmlns:ns5="http://www.w3.org/2005/Atom"/>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId, tenantId filter or marker is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

    {
      "itemNotFound" : {
        "code" : 404,
        "details" : "Domain with domainId : 66751536630362 does not exist in the System",
        "message" : "NOT_FOUND",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

XML

Invalid marker error

    <itemNotFound code="404" xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom">
       <message>NOT_FOUND</message>
       <details>Marker in request not found</details>
    </itemNotFound>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361/services

**Additional Notes**



#### 3.4.1.9 Get Tenants For A Domain#### {#get_tenants_for_a_domain}
#### GET /HP-IDM/v1.0/domains/{domainId}/tenants
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This REST API returns all tenants of a {domainId} and takes a "marker" and "limit" parameter to limit the number of Tenants in the response. The Api results can be filtered using filters which are specified as query parameters.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list

Following filters can be used to filter the response data.

* *tenantId (Optional)* - string - include results for given tenantId. Filters tenantId and name are mutually exclusive. You can filter either using tenantId or using name.
* *name (Optional)* - string - include results for given tenant name. Filters tenantId and name are mutually exclusive. You can filter either using tenantId or using name.  

**Data Parameters**

See schema file for more details on the response data structure.  

This call does not require a request body

JSON

    GET /v2.0/HP-IDM/v1.0/domains/29649421790262/tenants HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /V2.0/HP-IDM/v1.0/domains/798477662343/tenants HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

Optional:

JSON

Request with tenantId filter

    GET /v2.0/HP-IDM/v1.0/domains/29649421790262/tenants?tenantId=12345 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
    Host: localhost:9999
    Connection: keep-alive

XML

Request with name filter

    GET /V2.0/HP-IDM/v1.0/domains/798477662343/tenants?name=TENANTNAME1 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

The response is a list of tenant resources for the domain. 

**Status Code**

200 - OK

**Response Data**


JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 367
    Date: Fri, 07 Oct 2011 22:45:44 GMT
     
    {
      "tenants": {
        "anies": null,
        "otherAttributes": {
     
        },
        "tenant": [
          {
            "description": "Tenant for hosting Time Warner Applications & services",
            "domainId": "29649421790262",
            "name": "Time Warner Tenant Services",
            "otherAttributes": {
     
            },
            "status": "enabled",
            "tenantId": "96488406679080"
          }
        ]
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 525
    Date: Tue, 16 Aug 2011 21:24:54 GMT
     
    <?xml version="1.0" encoding="utf-8" standalone="yes"?>
    <tenants xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0"
    xmlns:ns2="http://www.w3.org/2005/Atom"
    xmlns:ns3="http://docs.openstack.org/identity/api/v2.0">
      <tenant status="enabled" domainId="798477662343"
      tenantId="842515505915"
      description="Tenant for Sales service"
      name="Forecasting Tenant" />
      <tenant status="enabled" domainId="798477662343"
      tenantId="225260164476"
      description="Tenant for Forecasting service"
      name="Sales Tenant" />
    </tenants>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or marker is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

    {
      "itemNotFound" : {
        "code" : 404,
        "details" : "Domain does not exist",
        "message" : "Not found",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630362/tenants?tenantId=12345

**Additional Notes**


#### 3.4.1.10 Get Users For A Domain#### {#get_users_for_a_domain}
#### {HTTP Verb: GET, POST, DELETE, PUT} [HPKeystoneExtensionBaseURI]/domains/{domainId}/users?limit=pagesize&marker=userId&excludeGroups=groupid1,groupdid2&excludeRoles=roleId1,roleId2&userId=userId&userName=userName&tenantId=t1&groupId=12345&excludeTenantId=tenantid1,tenantId2
*Privilege Level: System Adminstrator (SA), Domain Admin (DA)*

This API returns all users of a {domainId} .  The Api results can be filtered using filters which are specified as query parameters.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list

Following filters can be used to filter the response data.

*Inclusion-Filters*
* *userId (Optional)* - string - include results for given userId. Filters userId and userName are mutually exclusive. You can filter either using userId or using userName.
* *userName (Optional)* - string - include results for given userName. Filters userId and userName are mutually exclusive. You can filter either using userId or using userName.  
* *tenantId (Optional)* - string - include results for given tenantId. 
* *groupId (Optional)* - string - include results for given groupId. 

*Exclusion Filters*
* *excludeRoles (Optional)* - string - comma separated roleId to exclude 
* *excludeGroups (Optional)* - string - comma separated groupId to exclude 
* *excludeTenantId (Optional)* - string - tenantId to exclude


**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body

JSON

    GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v2.0/HP-IDM/v1.0/domains/798477662343/users HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

Optional:

JSON

Request with excludeRoles
    GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users?excludeRoles=RoleId1,RoleId2 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
    Host: localhost:9999
    Connection: keep-alive

Request with excludeGroups
    GET /v2.0/HP-IDM/v1.0/domains/53615830984009/users?excludeGroups=GroupId1,GroupId22 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e8ccde52cdc999e9328f761
    Host: localhost:9999
    Connection: keep-alive

XML

Request with exclusion filter
    GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?excludeGroups=000002002,000002001 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive


Request with userId filter
    GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?userId=12345 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive


Request with tenantId and groupId filter
    GET /v2.0/HP-IDM/v1.0/domains/798477662343/users?tenantId=1234&groupId=123455 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

List of users returned for given input criteria with http status code 200.

**Status Code**

200 - OK

**Response Data**

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 716
    Date: Wed, 05 Oct 2011 21:37:04 GMT
     
    {
      "users" : {
        "anies" : null,
        "otherAttributes" : {
        },
        "user" : [ {
          "roles" : null,
          "addressLine1" : "128, Hollywood Blvd",
          "addressLine2" : null,
          "city" : "Los Angeles",
          "company" : null,
          "country" : "USA",
          "domainId" : "53615830984009",
          "emailAddress" : "larryking@timewarner.com",
          "firstName" : "Larry",
          "lastName" : "King",
          "otherAttributes" : {
          },
          "password" : null,
          "phone" : "1-800-555-1212",
          "state" : "CA",
          "status" : "enabled",
          "userId" : "27000063617046",
          "username" : "larryking@timewarner.com",
          "website" : "http://www.timewarner.com",
          "zip" : "90210"
        } ]
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 822
    Date: Wed, 10 Aug 2011 19:35:24 GMT
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <users xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://www.w3.org/2005/Atom">
      <user domainId="798477662343" status="enabled" isDomainOwner="true" emailAddress="johndoe@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="627893056455" username="johndoe@papsi.com" name="John Doe"/>
      <user domainId="798477662343" status="enabled" emailAddress="amymiller@papsi.com" website="http://www.pepsi.com" phone="1-800-555-1212" zip="89072" country="USA" state="GA" city="Atlanta" addressLine1="1, Pepsi Way" accountId="968754602297" username="amymiller@papsi.com" name="Amy Miller"/>
    </users>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or marker is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  


**Response Data**

JSON

    {
      "itemNotFound" : {
        "code" : 404,
        "details" : "Domain does not exist",
        "message" : "Not found",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/798477662343/users?userId=12345

**Additional Notes**



#### 3.4.1.11 List Role Definitions (Deprecated)#### {#list_role_definitions_(deprecated)}
#### GET /HP-IDM/v1.0/domains/{domainId}/roles
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API is used to list all the roles defined in the domain and takes a "marker" and "limit" parameter to limit the number of roles in the response.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *limit (Optional)* - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - the resource Id of the last item in the previous list

**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body

JSON

    GET /v2.0/HP-IDM/v1.0/domains/641564254582/roles HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

XML

    GET /v2.0/HP-IDM/v1.0/domains/641564254582/roles HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

Optional:



**Success Response**

List of roles with http status code 200.

**Status Code**

200 - OK

**Response Data**


JSON

    {"roles": {"role": [
          {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role01",
          "description": "role01- description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
          "tenantId": "12345678909876"
       }, {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role02",
          "description": "role02- description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
          "tenantId": "12345678909876"
       }, {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role03",
          "description": "role03- description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
          "tenantId": "12345678909876"
       },
    ]}

XML

    <roles xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role01</roleName>
          <description>role01- description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
          <tenantId>12345678909876</tenantId>
       </role>
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role02</roleName>
          <description>role02- description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
          <tenantId>12345678909876</tenantId>
       </role>
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role03</roleName>
          <description>role03- description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
          <tenantId>12345678909876</tenantId>
       </role>
    </roles>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or marker is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/roles

**Additional Notes**



#### 3.4.1.12 Transfer Ownership Of A Domain#### {#transfer_ownership_of_a_domain}
#### PUT /HP-IDM/v1.0/domains/{domainId}/owner/{userId}	
*Privilege Level: System Adminstrator (SA)*

A Domain has a owner, it is usually the first user of the Domain or the self registered user during the self registration process. This REST API transfers the domain ownership from one valid User of that Domain to another valid User of the Domain. 

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

* *domainId* - string - {domainId} of the Domain for which the ownership transfer should happen.
* *userId* - string - {userId} of the new owner of the Domain.

**URL Parameters**


**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body


JSON

    PUT /v2.0/HP-IDM/v1.0/domains/29649421790262/owner/60414337132139 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e8f7d182cdcb96406c8c61b
    Host: localhost:9999
    Connection: keep-alive

XML

    PUT /v2.0/HP-IDM/v1.0/domains/662648896689/owner/129024620458 HTTP/1.1
    Accept: application/xml
    account_id: 000000003001
    Content-Type: application/xml
    domain_id: 000000001001
    User-Agent: Wink Client v1.1.2
    Host: localhost:9999
    Connection: keep-alive

Optional:


**Success Response**

Transfer ownership of a Domain with http status code 200

**Status Code**

200 - OK

**Response Data**


JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 603
    Date: Fri, 07 Oct 2011 22:55:55 GMT
     
    {
      "user": {
        "roles": null,
        "addressLine1": "128, Hollywood Blvd",
        "addressLine2": null,
        "city": "Los Angeles",
        "company": null,
        "country": "USA",
        "domainId": "29649421790262",
        "emailAddress": "larryking3@timewarner.com",
        "firstName": "Larry",
        "lastName": "King III",
        "otherAttributes": {
     
        },
        "password": null,
        "phone": "1-800-555-1212",
        "state": "CA",
        "status": "enabled",
        "userId": "60414337132139",
        "username": "larryking3@timewarner.com",
        "website": "http://www.timewarner.com",
        "zip": "90210"
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 437
    Date: Tue, 30 Aug 2011 00:06:02 GMT
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <user xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" name="Tom Riddle" username="tomriddle@timewarner.com" userId="129024620458" addressLine1="128, Hollywood Blvd" city="Los Angeles" state="CA" country="USA" zip="90210" phone="1-800-555-1212" website="http://www.timewarner.com" emailAddress="tomriddle@timewarner.com" status="enabled" domainId="662648896689"/>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified domainId or userId is not found   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/662648896689/owner/129024620458 

**Additional Notes**


#### 3.4.1.13 Update A Domain#### {#update_a_domain}
#### PUT /HP-IDM/v1.0/domains/{domainId}
*Privilege Level: System Adminstrator (SA), Domain Admin (DA**)

Allows update of an existing domain using the {domainId} and request body. Does not allow update or change of domainID.

DA* indicates that only attributes returned on the list operation as defined by Domain-Tenant-User-Group Model can be edited


**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

The request requires the updated Domain resource.  
The response is the updated Domain resource.


JSON

    PUT /v2.0/HP-IDM/v1.0/domains/91177319722637 HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e83a4532cdcb4bf5faa76ce
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 40
     
    {
      "domain": {
        "phone": "1-800-NO-DISNEY"
      }
    }

XML

    PUT /v2.0/HP-IDM/v1.0/domains/26856794720485 HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4ef385b32cdc64f2eead137c
    Host: localhost:9999
    Connection: keep-alive
    Content-Length: 384
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/identity/api/v2.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://docs.openstack.org/common/api/v1.0" phone="1-800-NO-DISNEY" addressLine2="Studio Lanes"/>

Optional:


**Success Response**

Updated domain resource is returned with http status code 200

**Status Code**

200 - OK

**Response Data**



JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 461
    Date: Wed, 28 Sep 2011 22:49:56 GMT
     
     
    {
      "domain" : {
        "anies" : null,
        "addressLine1" : "128, Hollywood Blvd",
        "addressLine2" : null,
        "city" : "Los Angeles",
        "company" : null,
        "country" : "USA",
        "domainId" : "91177319722637",
        "emailAddress" : "owner@timewarner.com",
        "name" : "Time Warner Inc",
        "otherAttributes" : {
        },
        "phone" : "1-800-NO-DISNEY",
        "state" : "CA",
        "status" : "enabled",
        "website" : "Time Warner",
        "zip" : "90210"
      }
    }

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/xml
    Content-Length: 508
    Date: Thu, 22 Dec 2011 19:51:00 GMT
     
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <domain xmlns="http://docs.openstack.org/identity/api/ext/hp/v1.0" xmlns:ns2="http://docs.openstack.org/identity/api/v2.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" xmlns:ns5="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" domainId="26856794720485" name="action-king-DOMAIN" emailAddress="actionking@hp.com" addressLine2="Studio Lanes" company="action-king" phone="1-800-NO-DISNEY" status="enabled">
    <billToAddress addressLine1="123 Smoke Test Lane" city="The Smoky City" state="SmokyState" zip="90909" country="USA">
     </billToAddress> 
    </domain>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |  
| :-----------| :-----------| :-------|  
| 400 | Bad Request | Malformed request in URI   |  
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.    |  
| 403 | Forbidden | Disabled or suspended user making the request |  
| 404 | Not Found | The specified {domainId} in request URI is not found   |  
| 409 | Conflict | The updated domain name already exists in the system   |  
| 500 | Internal Server Error | The server encountered a problem while processing the request|  
| 503 | Service Unavailable | The server is unavailable to process the request |  

**Response Data**

JSON

    {
      "IdentityFault" : {
        "message" : "Conflict",
        "details" : "Domain already exists",
        "code" : 409,
        "otherAttributes" : {
        }
      }
    }

    {
      "itemNotFound" : {
        "code" : 404,
        "details" : "Domain does not exist",
        "message" : "Not found",
        "otherAttributes" : {
        }
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

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XPUT -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" -H "Content-type: application/json" -d '{  "domain" : {  "name" : "Sees Candies 61", "phone": "1-800-NO-DISNEY"} }' https://localhost:35357/v2.0/HP-IDM/v1.0/domains/66751536630361

**Additional Notes**


#### 3.4.1.14 List Role Definitions#### {#list_role_definitions}
#### GET /HP-IDM/v1.0/domains/{domainId}/roleDefs
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API is used to list all the roles defined in the specified {domainId} and takes several parameters including "marker", "limit", "serviceId", "tenantId", "roleId", and "public" to limit the number of role definitions in the response.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**URL Parameters**

* *domainId* - string - The domainId representing the domain to return role definitions for.
* *limit (Optional)* - integer - Represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - The resource Id of the last item in the previous list.
* *tenantId (Optional)* - string - Limit role definitions to the specified tenant id if provided.
* *serviceId (Optional)* - string - Limit role definitions to the specified service id if provided.
* *roleId (Optional)* - string - Limit role definitions to the specified role id if provided.
* *public (Optional)* - boolean - If true, return only public role definitions.  If false, return only domain specific role definitions.  If not provided, return both.

**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body

JSON

    GET /v2.0/HP-IDM/v1.0/domains/641564254582/roleDefs HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

XML

    GET /v2.0/HP-IDM/v1.0/domains/641564254582/roleDefs HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

Optional:


**Success Response**

List of roles with http status code 200.

**Status Code**

200 - OK

**Response Data**


JSON

    {"roles": {"role": [
          {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role01",
          "description": "role01 - description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
       }, {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role02",
          "description": "role02 - description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
       }, {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role03",
          "description": "role03 - description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
       },
    ]}

XML

    <roles xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role01</roleName>
          <description>role01 - description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
       </role>
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role02</roleName>
          <description>role02 - description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
       </role>
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role03</roleName>
          <description>role03 - description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
       </role>
    </roles>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified domainId, marker, serviceId or tenantId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/roleDefs

Curl Example (public role definitions only)

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/roleDefs?public=true

Curl Example (domain specific role definitions only)

    curl -k --cert dev_hpmiddleware.pem  -XGET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" https://localhost:35357/v2.0/HP-IDM/v1.0/domains/27999842874196/roleDefs?public=false

#### 3.4.1.15 Check For Existence Of Non Tenant Role For A Given User#### {#check_for_existence_of_non_tenant_role_for_a_given_user}
#### HEAD /HP-IDM/v1.0/domains/{domainId}/users/{userId}/roles/{roleId}
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API will check for the existence of the specified role for the specified user in the specified domain.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.  There is no response body returned in API response data. 

**URL Parameters**

* *domainId* - string - the id of the domain to look for the role/user in (required)
* *userId* - string - the id of the user to check for the role for (required)
* *roleId* - string - the id of the role to check for (required)

**Data Parameters**

This call does not require a request body.

JSON

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json

XML

    HEAD https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml

**Success Response**

There is no response body returned. Status code indicates the result where 200 indicates that specified role exists and 404 indicates when it does not exist.

**Status Code**

200 - OK , 404 - NOT FOUND

**Response Data**

This call does not return a response body and result is determined through returned http status code.  Response body is present only in case of errors.

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Tue, 21 Aug 2012 19:15:56 GMT

XML

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Length: 0
    Date: Tue, 21 Aug 2012 19:17:00 GMT

**Error Response**

Status code 204 is returned when the role does not exist for the domain/user.

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 204 | No Content | When the role does not exist for the domain/user |
| 400 | Bad Request | Malformed request in URI |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |


**Response Data**

JSON

When role does not exist for the domain/user.

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: \-1
    Date: Tue, 21 Aug 2012 19:18:23 GMT

Curl Example

    curl -k  --cert dev_hpmiddleware.pem  -I -H "Accept: application/json" "https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004"

**Additional Notes**


#### 3.4.1.16 Delete A Non Tenant Role Assignment In The Specified Domain For The Specified User#### {#delete_a_non_tenant_role_assignment_in_the_specified_domain_for_the_specified_user}
#### DELETE /HP-IDM/v1.0/domains/{domainId}/users/{userId}/roles/{roleId}
*Privilege Level: System Adminstrator (SA), Domain Admin (DA)*

Deletes the specified role association by its {roleID}, in the specfied {domainId} for the specfied {userId}.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header.  Otherwise, a 401 will be returned.

**URL Parameters**

* *domainId* - string - the id of the domain to delete the role from (required)
* *userId* - string - the id of the user to delete the role for (required)
* *roleId* - string - the id of the role to delete (required)

**Data Parameters**

This call does not require a request body.

JSON

    DELETE https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

    DELETE https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

**Success Response**

There is no response body and response code of 204 is returned after successful deletion of the role.

**Status Code**

204 - No Content

**Response Data**

This call does not have a response body other than in case of errors.

JSON

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=38FAFEF8E7816E6B717B1328FC6AFF49; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 30 Oct 2012 21:30:16 GMT

XML

    HTTP/1.1 204 No Content
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=38FAFEF8E7816E6B717B1328FC6AFF49; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 30 Oct 2012 21:30:16 GMT

**Error Response**

Refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body   |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation    |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified domainId, userId, or roleId does not exist |
| 500 | Internal Server Error | The server encountered a problem while processing the request|
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

This call does not have a response body other than in case of errors.

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -X DELETE -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" "https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004"

**Additional Notes**


#### 3.4.1.17 Assign A Non Tenant Role Assignment In The Specified Domain For The Specified User#### {#assign_a_non_tenant_role_assignment_in_the_specified_domain_for_the_specified_user}
#### PUT /HP-IDM/v1.0/domains/{domainId}/users/{userId}/roles/{roleId}
*Privilege Level: System Adminstrator (SA), Domain Admin (DA)*

Assigns the specified role association by its {roleID}, in the specfied {domainId} for the specfied {userId}.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header.  Otherwise, a 401 will be returned.

**URL Parameters**

* *domainId* - string - the id of the domain to assign the role from (required)
* *userId* - string - the id of the user to assign the role for (required)
* *roleId* - string - the id of the role to assign (required)

**Data Parameters**

This call does not require a request body.

JSON

    PUT https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

XML

    PUT https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3
    Host: localhost:35357
    Connection: Keep-Alive
    User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

**Success Response**

There is no response body and response code of 204 is returned after successful deletion of the role.

**Status Code**

201 - Created

**Response Data**

This call does not have a response body other than in case of errors.

JSON

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=38FAFEF8E7816E6B717B1328FC6AFF49; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 30 Oct 2012 21:30:16 GMT

XML

    HTTP/1.1 201 Created
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=38FAFEF8E7816E6B717B1328FC6AFF49; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Date: Tue, 30 Oct 2012 21:30:16 GMT

**Error Response**

Refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation |
| 403 | Forbidden | Disabled or suspended user making the request |
| 404 | Not Found | The specified domainId, userId, or roleId does not exist |
| 500 | Internal Server Error | The server encountered a problem while processing the request |
| 503 | Service Unavailable | The server is unavailable to process the request |

**Response Data**

This call does not have a response body other than in case of errors.

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -X PUT -H "X-Auth-Token: HPAuth_769bcc02e0bf775aee3c7c5bbc647087a29e3da7103e2dde0d95beabb61f07e3" -H "Content-type: application/json" "https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles/00000000004004"

**Additional Notes**

#### 3.4.1.18 List Role Definitions For A Domain And User#### {#list_role_definitions_for_a_domain_and_user}
#### GET /HP-IDM/v1.0/domains/{domainId}/users/{userId}/roles
*Privilege Level: System Adminstrator (SA), Domain Admin (DA), Domain User (DU)*

This API is used to list all the roles defined in the specified {domainId} for the specified {userId} and takes several parameters including "marker" and "limit" to limit the number of role definitions in the response.

**Request Data**

A valid token must be presented in the *X-Auth-Token* HTTP header.  Otherwise, a 401 will be returned.

**URL Parameters**

* *domainId* - string - The domainId representing the domain to return role definitions for.
* *userId* - string - The userId representing the user to return role definitions for.
* *limit (Optional)* - integer - Represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker (Optional)* - string - The resource Id of the last item in the previous list.

**Data Parameters**

See schema file for more details on the response data structure.

This call does not require a request body

JSON

    GET /v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles HTTP/1.1
    Connection: close
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

XML

    GET /v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles HTTP/1.1
    Connection: close
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: haneef-desktop.americas.hpqcorp.net:8080

Optional:


**Success Response**

List of roles with http status code 200.

**Status Code**

200 - OK

**Response Data**


JSON

    {"roles": {"role": [
          {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role01",
          "description": "role01 - description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
       }, {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role02",
          "description": "role02 - description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
       }, {
          "roleId": "xxxxxxxxxxxxxx",
          "roleName": "role03",
          "description": "role03 - description",
          "serviceId" : "xxxxxxxxxxxxxx",
          "domainId": "xxxxxxxxxxxxxx",
       },
    ]}

XML

    <roles xmlns="http://hpcloud.hp.com/identity/api/ext/hp/v1.0">
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role01</roleName>
          <description>role01 - description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
       </role>
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role02</roleName>
          <description>role02 - description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
       </role>
       <role>
          <roleId>xxxxxxxxxxxxxx</roleId>
          <roleName>role03</roleName>
          <description>role03 - description</description>
          <serviceId>xxxxxxxxxxxxxx</serviceId>
          <domainId>xxxxxxxxxxxxxx</domainId>
       </role>
    </roles>

**Error Response**

Please refer to error response body for additional details.

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 404 | Not Found | The specified domainId, marker or userId is not found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request. |

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cert dev_hpmiddleware.pem  -X GET -H "X-Auth-Token: HPAuth_b4d1cf88adb2b9eb97766444958a24ff2ee8b2f8e7d2e26500c5133f9e8ec776" -H "Accept: application/json" "https://localhost:35357/v2.0/HP-IDM/v1.1/domains/69784881406703/users/89309563001447/roles"

**Additional Notes**


### 3.4.2 Projects

Project is a collection of services, and associated with zero or more users who have access to these services via role references.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 3.4.2.1 List Projects#### {#list_projects}
#### GET /projects
*Privilege Level: SS*

This API returns a listing of all projects for which the holder of the provided token has a role assignment. If the user is not a valid, an error is returned.

**Request Data**

This API supports pagination. See Pagination for more details.

This API also supports an optional *name* filter for get-by-name. Pagination and *name* filter are mutually exclusive.

**URL Parameters**

* *limit* (Optional) - integer - represents the maximum number of elements which will be returned in the request. Default is 100.
* *marker* (Optional)} - string - the resource Id of the last item in the previous list
* *name* (Optional) - string - name of the project to be returned

**Data Parameters**

See schema file for more details on the request and response data structure.

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

This call does not require a request body.

JSON

    GET /v3/projects HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

    GET /v3/projects/ HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

Optional:

JSON

With *name* filter.

    GET /v3/projects?name=projectName HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

With *projectId* filter.

    GET /v3/projects/00000000005002 HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

With pagination.

    GET /v3/projects?limit=2 HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

With the authenticated user's domain that are enabled.

    GET /v3/projects?enabled=true HTTP/1.1
    Accept: application/json
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

XML

With pagination.

    GET /v3/projects?limit=100&marker=S4DFJ123SF HTTP/1.1
    Accept: application/xml
    Content-Type: application/xml
    User-Agent: Wink Client v1.1.2
    X-Auth-Token: HPAuth_4e56db8d2cdce58d662fb351
    Host: localhost:9999
    Connection: keep-alive

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

A list of projects in the specified format is returned.

JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "ArrayList" : [ {
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005001",
        "name" : "HP Cloud System Domain's-Tenant01",
        "otherAttributes" : {
        }
      }, {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      }, {
        "description" : "Test tenant 3 is a terminated tenant",
        "domain_id" : "00000000001001",
        "enabled" : false,
        "id" : "00000000005003",
        "name" : "Test tenant 3",
        "otherAttributes" : {
        }
      } ]
    }

With *name* filter.

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "ArrayList" : [ {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      } ]
    }

With Pagination

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "ArrayList" : [ {
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005001",
        "name" : "HP Cloud System Domain's-Tenant01",
        "otherAttributes" : {
        }
      }, {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      } ]
    }

With authenticated user's domain that are enabled

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "ArrayList" : [ {
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005001",
        "name" : "HP Cloud System Domain's-Tenant01",
        "otherAttributes" : {
        }
      }, {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      } ]
    }

With projectId filter

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 240
    Date: Tue, 29 Nov 2011 17:17:50 GMT
    
    {
      "project" : {
        "description" : "Test tenant 2 is an enabled tenant",
        "domain_id" : "00000000001001",
        "enabled" : true,
        "id" : "00000000005002",
        "name" : "Test tenant 2",
        "otherAttributes" : {
        }
      }
    }

XML

    

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

***List Projects***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/projects"

***Get Project By Name***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v2.0/projects?name=MyProject"

**Additional Notes**


### 3.4.3 Tokens

An unique identifier which is used to identify the privilege of the user.


1. Given a user name & password, get a token to represent the user.
2. Given a token, validate the token and return user, domain, project, roles and potential endpoints.
3. Given a valid token, request another token with a different domain/project (change domain/project being represented with the user).
4. Given a valid token, force it's immediate revocation.

//  Add stuff about uniqueness once it is done

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 3.4.3.1 Authenticate#### {#authenticate}
#### POST /v3/auth/tokens
*Privilege Level: Anon*

This API is used to authenticate a user to be able to use an OpenStack service. The result of a successful authentication is a token to be used with service requests. A credential is used to obtain a token. We currently support username/password and  access/secret key credentials. If authentication succeeds, the response will include an authentication token and service catalog ( list of available services for that user ). Tokens are valid for 12 hours. Issued tokens can become invalid in two cases:

1. the token has expired
2. the token has been revoked.

Besides using a username and password, another way to authenticate is using symmetric keys. Symmetric keys are user access key and secret key pairs provisioned for user account. In this type of credential data, request body is expected to contain an access key and a secret key information belonging to the user. Once those keys are verified, a new token is created. In this type of authentication, the only change is in expected request body data (please see related example below). There is no difference in response format/content whether authentication is done using password credential data or access key credential data.

##### Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

##### Scoped Tokens:

A token can be scoped either to a domain or to a project.  ProjectId or DomainId/DomainName can be used to socpe the token to project or domain respecively. ProjectName can also be used, in that case caller need to qualify the project using domain informationm, since project name is not globally unique. Project name is unqiue only in its domain

A project scoped token will also return service endpoints for other services associated with the project in question. An unscoped token will likely not contain service endpoints except for those for the Identity Service. Note that if prjoect information is unknown, an unscoped token can be obtained and then a list of projects obtained. Project information can also be found in the Management Console.

**Request Data**

See examples below.

**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

Authenticate using userid/password credential for an unscoped token.

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "21243386194835",
                    "password": "secrete"
                }
            }
        }
    }


Authenticate using username/password credential for an unscoped token.  User is qualified using domain name

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "21243386194835",
                    "password": "secrete",
                    "domain" : {
                       "name" : "HPCSDemoDomain"
                     }
                }
            }
        }
    }


Authenticate using username/password credential for an unscoped token.  User is qualified using domain id

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "name": "HPCSDemoDomain_User1",
                    "password": "secrete",
      	       "domain" : {
    		  "id" : "94710780204290"
    	        }
                }
            }
        }
    }


Authenticate using password credential,scoped to a project using prject id.

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "453453453545",
                    "password": "secrete"
                }
            }
        },
        "scope": {
            "project": {
                "id": "94710780204290"
            }
        }
       }
    }

Authenticate using password credential,scoped to a project using prject name.  Project name is qualified using domain Id

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "453453453545",
                    "password": "secrete"
                }
            }
        },
        "scope": {
            "project": {
                "name": "HPCSDemoDomain_dev_project",
                "domain" : {
    		  "id" : "94710780204290"
    	     }
            }
        }
       }
    }

Authenticate using password credential, scoped to a doamin using domain name. 

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "453453453545",
                    "password": "secrete"
                }
            }
        },
        "scope": {
            "domain" : {
    	  "name" : "HPCSDemoDomain"
             }
         }
        }
       }
    }


Authenticate using password credential, scoped to a doamin using domain id. 

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 171
    
    {
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "id": "453453453545",
                    "password": "secrete"
                }
            }
        },
        "scope": {
            "domain" : {
    	  "id" : "94710780204290"
             }
         }
        }
       }
    }


Authenticate using access key credential.

    {
       "auth":{
          "identity":{
             "methods":[
                "accessKey"
             ],
             "accessKey":{
                "accessKey":"VCAVE3Y6RL9K8ADVKMY5",
                "secretKey":"quyNVz7gMtpG9QsLz0DUrqGocYbr5X+KGbkJsqzs"
             }
          }
       }
    }


Rescope token.

    {
       "auth":{
          "identity":{
             "methods":[
                "tokens"
             ],
             "token":{
                "id":"HPAuth_a6f32cefceb798cedd3183c71c07a3d169c8ad613e0c951ae5f426c015dd3210"
             }
          }
       }
    }
    

XML

Authenticate using password credential for a unscoped token.

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <auth xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
        <identity>
             <methods>password</methods>
            <password>
                <user name="haneeftest" password="haneeftest"/>
            </password>
        </identity>    
    </auth>
    
    


Authenticate using password credential for a Project unscoped token.

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <auth xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
        <identity>
             <methods>password</methods>
            <password>
                <user name="haneeftest" password="haneeftest"/>
            </password>
        </identity>    
        <scope>
            <project name="HPCSDeomonDomain_DevProject">
                <domain name="HPCSDemonDomain"/>
            </project>
        </scope>
    </auth>
    
    

Authenticate using access key credential Domain scoped

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <auth xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
        <identity>
             <methods>password</methods>
            <password>
                 <accessKey accessKey="quyNVz7gMtpG9QsLz0DUrqGocYbr5X+KGbkJsqzs" secretKey="VCAVE3Y6RL9K8ADVKMY5"/>
            </password>
        </identity>    
        <scope>
            <domain name="HPCSDeomonDomain">
            </domain>
        </scope>
    </auth>

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

Unscoped token response

    HTTP/1.1 200 OK
    X-Auth-Token: a32b28f56a874de3a22abfb2312b7199
    Content-Type: application/json
    Date: Tue, 12 Feb 2013 01:21:54 GMT
    Transfer-Encoding: chunked
     
     
    {
       "token":{
          "methods":[
             "password"
          ],
          "domain":{
             "otherAttributes":{
    
             }
          },
          "project":{
             "otherAttributes":{
    
             }
          },
          "roles":[
             {
                "id":"00000000004003",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004003",
                      "rel":"self"
                   }
                ],
                "name":"domainadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004004",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004004",
                      "rel":"self"
                   }
                ],
                "name":"domainuser",
                "otherAttributes":{
    
                }
             }
          ],
          "user":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"HPCSDemoDomain",
                "otherAttributes":{
    
                }
             },
             "id":"21243386194835",
             "link":[
                {
                   "href":"https://localhost:35357/v3/users/21243386194835",
                   "rel":"self"
                }
             ],
             "name":"HPCSDemoDomain_Admin",
             "otherAttributes":{
    
             }
          },
          "catalog":[
             {
                "endpoints":[
                   {
                      "id":"130_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/130_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"100",
                      "url":"https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"identity"
             },
             {
                "endpoints":[
                   {
                      "id":"190001_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/190001_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"190",
                      "url":"http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"metering"
             }
          ],
          "expires_at":"2013-03-13T10:10:29.161Z",
          "issued_at":"2013-03-12T17:56:59.469Z",
          "otherAttributes":{
    
          }
       }
    }


Project scoped tokens response


    HTTP/1.1 200 OK
    X-Auth-Token: a32b28f56a874de3a22abfb2312b7199
    Content-Type: application/json
    Date: Tue, 12 Feb 2013 01:21:54 GMT
    Transfer-Encoding: chunked
     
    {
       "token":{
          "methods":[
             "password"
          ],
          "domain":{
             "otherAttributes":{
    
             }
          },
          "project":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"haneeftest",
                "otherAttributes":{
    
                }
             },
             "id":"56524744656491",
             "link":[
                {
                   "href":"https://localhost:35357/v3/projects/56524744656491",
                   "rel":"self"
                }
             ],
             "name":"haneeftest_project",
             "otherAttributes":{
    
             }
          },
          "roles":[
             {
                "id":"00000000004024",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004024",
                      "rel":"self"
                   }
                ],
                "name":"user",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004013",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004013",
                      "rel":"self"
                   }
                ],
                "name":"block-admin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004016",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004016",
                      "rel":"self"
                   }
                ],
                "name":"netadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004003",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004003",
                      "rel":"self"
                   }
                ],
                "name":"domainadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004025",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004025",
                      "rel":"self"
                   }
                ],
                "name":"sysadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004004",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004004",
                      "rel":"self"
                   }
                ],
                "name":"domainuser",
                "otherAttributes":{
    
                }
             }
          ],
          "user":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"haneeftest",
                "otherAttributes":{
    
                }
             },
             "id":"21243386194835",
             "link":[
                {
                   "href":"https://localhost:35357/v3/users/21243386194835",
                   "rel":"self"
                }
             ],
             "name":"haneeftest",
             "otherAttributes":{
    
             }
          },
          "catalog":[
             {
                "endpoints":[
                   {
                      "id":"130_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/130_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"100",
                      "url":"https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"identity"
             },
             {
                "endpoints":[
                   {
                      "id":"160_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/160_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"140",
                      "url":"https://glance.rndd.aw1.hpcloud.net:9292/v1.0"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"image"
             },
             {
                "endpoints":[
                   {
                      "id":"140_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/140_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"130",
                      "url":"https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"volume"
             },
             {
                "endpoints":[
                   {
                      "id":"190001_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/190001_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"190",
                      "url":"http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"metering"
             },
             {
                "endpoints":[
                   {
                      "id":"100_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/100_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"120",
                      "url":"http://az1-nv-schedule-0000.rndd.aw1.hpcloud.net:8774/v1.1/56524744656491"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"compute"
             }
          ],
          "expires_at":"2013-03-13T10:22:37.047Z",
          "issued_at":"2013-03-12T22:22:37.047Z",
          "otherAttributes":{
    
          }
       }
    }
    

XML

XML response unscoped token

    
    <?xml version="1.0" encoding="UTF-8"?>
    <token xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
       <expires_at>2013-03-13T10:30:43.137Z</expires_at>
       <issued_at>2013-03-12T17:56:59.469Z</issued_at>
       <methods>password</methods>
       <domain />
       <project />
       <catalog type="identity">
          <endpoints id="130_P" interface="public" region="region-a.geo-1" url="https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/" service_id="100">
             <ns2:link rel="self" href="https://localhost:35357/v3/endpoints/130_P" />
          </endpoints>
       </catalog>
       <catalog type="metering">
          <endpoints id="190001_P" interface="public" region="region-a.geo-1" url="http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/" service_id="190">
             <ns2:link rel="self" href="https://localhost:35357/v3/endpoints/190001_P" />
          </endpoints>
       </catalog>
       <roles id="00000000004003" name="domainadmin">
          <ns2:link rel="self" href="https://localhost:35357/v3/roles/00000000004003" />
       </roles>
       <roles id="00000000004004" name="domainuser">
          <ns2:link rel="self" href="https://localhost:35357/v3/roles/00000000004004" />
       </roles>
       <user id="21243386194835" name="haneeftest">
          <domain id="94710780204290" name="haneeftest">
             <ns2:link rel="self" href="https://localhost:35357/v3/domains/94710780204290" />
          </domain>
          <ns2:link rel="self" href="https://localhost:35357/v3/users/21243386194835" />
       </user>
    </token>
    
    

XML response project scoped  token

    
    <?xml version="1.0" encoding="UTF-8"?>
    <token xmlns="http://docs.openstack.org/identity/api/v3.0" xmlns:ns2="http://www.w3.org/2005/Atom" xmlns:ns3="http://docs.openstack.org/common/api/v1.0">
       <expires_at>2013-03-13T10:33:25.133Z</expires_at>
       <issued_at>2013-03-12T17:56:59.469Z</issued_at>
       <methods>password</methods>
       <domain />
       <project />
       <catalog type="identity">
          <endpoints id="130_P" interface="public" region="region-a.geo-1" url="https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/" service_id="100">
             <ns2:link rel="self" href="https://localhost:35357/v3/endpoints/130_P" />
          </endpoints>
       </catalog>
       <catalog type="metering">
          <endpoints id="190001_P" interface="public" region="region-a.geo-1" url="http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/" service_id="190">
             <ns2:link rel="self" href="https://localhost:35357/v3/endpoints/190001_P" />
          </endpoints>
       </catalog>
       <roles id="00000000004003" name="domainadmin">
          <ns2:link rel="self" href="https://localhost:35357/v3/roles/00000000004003" />
       </roles>
       <user id="21243386194835" name="haneeftest">
          <domain id="94710780204290" name="haneeftest">
             <ns2:link rel="self" href="https://localhost:35357/v3/domains/94710780204290" />
          </domain>
          <ns2:link rel="self" href="https://localhost:35357/v3/users/21243386194835" />
       </user>
    </token>
    


**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Response Data**

JSON

    {
      "identityFault": {
        "message": "Fault",
        "details": "Error Details...",
        "code": 500
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8"?>
    <identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
              code="500">
            <message>Fault</message>
            <details>Error Details...</details>
    </identityFault>

Curl Example

***Authenticate with Username/Password and Tenant ID***

    curl -X POST -H "Content-Type: application/json"
         https://region-a.geo-1.identity.hpcloudsvc.com:35357/v3/auth/tokens
         -d '{"auth": {"identity": {	"methods": ["password"],"password": {"user": {"id": "342343232432", "password": "Super secret"	}}},"scope": {  "project": {"id": "453454354"} }} }'
    

***Authenticate with Access Keys and Tenant ID***

    

**Additional Notes**


#### 3.4.3.2 Rescope Token#### {#rescope_token}
#### POST /v3/auth/tokens
*Privilege Level: SS*

This API provides the ability to re-scope a valid token with another tenant. An existing unexpired token, regardless of its currently scoped or not, can be scoped to another tenant as long as the user has valid association with that tenant.

Re-scoping of token can be done from 1) unscoped token to a scoped token for specific tenant 2) scoped token from one tenant to another tenant 3) scoped token to unscoped token (with no tenantId and tenantName specified in request). Re-scoping of token does not alter the token expiration time and same token id is returned in response.

##### Service Catalog:

In case of un-scoped token request, the service catalog is going to include global active endpoint templates as endpoints in its data. In case of scoped token request, the service catalog is going to include tenant specific endpoints as well as global active endpoint templates as endpoints.

**Request Data**


**URL Parameters**

None

**Data Parameters**

See schema file for more details on the request and response data structure.

JSON

Domain Scoping

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 154
    
    {
        "auth": {
            "identity": {
                "methods": ["token"],
                "token": {
                    "id": "HPAuth_332fa874565d61c87f50cf37af955cf5e95f1e174c95776855780f584b3386e3"
                }
            },
            "scope": {
                "domain": {
                    "id": "345435435435435"               
                }
            }
        }
    }

Project Scoping

    Accept-Encoding: gzip,deflate
    Accept: application/json
    Content-Type: application/json
    Content-Length: 154
    
    {
        "auth": {
            "identity": {
                "methods": ["token"],
                "token": {
                    "id": "--token-id--"
                }
            },
            "scope": {
                "project": {          
                    "name": "HPCSDemoDomain_dev_Project",
    	       "domain": {
             	       "id": "345435435435435"               
    	        }
                }
            }
        }
    }

XML

    Accept-Encoding: gzip,deflate
    Accept: application/xml
    Content-Type: application/xml
    Content-Length: 195
    
    

**Success Response**


**Status Code**

200 - OK

**Response Data**


JSON

    HTTP/1.1 200 OK
    X-Auth-Token: a32b28f56a874de3a22abfb2312b7199
    Content-Type: application/json
    Date: Tue, 12 Feb 2013 01:21:54 GMT
    Transfer-Encoding: chunked
     
    {
       "token":{
          "methods":[
             "password"
          ],
          "domain":{
             "otherAttributes":{
    
             }
          },
          "project":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"haneeftest",
                "otherAttributes":{
    
                }
             },
             "id":"56524744656491",
             "link":[
                {
                   "href":"https://localhost:35357/v3/projects/56524744656491",
                   "rel":"self"
                }
             ],
             "name":"haneeftest_project",
             "otherAttributes":{
    
             }
          },
          "roles":[
             {
                "id":"00000000004024",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004024",
                      "rel":"self"
                   }
                ],
                "name":"user",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004013",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004013",
                      "rel":"self"
                   }
                ],
                "name":"block-admin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004016",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004016",
                      "rel":"self"
                   }
                ],
                "name":"netadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004003",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004003",
                      "rel":"self"
                   }
                ],
                "name":"domainadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004025",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004025",
                      "rel":"self"
                   }
                ],
                "name":"sysadmin",
                "otherAttributes":{
    
                }
             },
             {
                "id":"00000000004004",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/roles/00000000004004",
                      "rel":"self"
                   }
                ],
                "name":"domainuser",
                "otherAttributes":{
    
                }
             }
          ],
          "user":{
             "domain":{
                "id":"94710780204290",
                "link":[
                   {
                      "href":"https://localhost:35357/v3/domains/94710780204290",
                      "rel":"self"
                   }
                ],
                "name":"haneeftest",
                "otherAttributes":{
    
                }
             },
             "id":"21243386194835",
             "link":[
                {
                   "href":"https://localhost:35357/v3/users/21243386194835",
                   "rel":"self"
                }
             ],
             "name":"haneeftest",
             "otherAttributes":{
    
             }
          },
          "catalog":[
             {
                "endpoints":[
                   {
                      "id":"130_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/130_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"100",
                      "url":"https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"identity"
             },
             {
                "endpoints":[
                   {
                      "id":"160_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/160_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"140",
                      "url":"https://glance.rndd.aw1.hpcloud.net:9292/v1.0"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"image"
             },
             {
                "endpoints":[
                   {
                      "id":"140_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/140_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"130",
                      "url":"https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"volume"
             },
             {
                "endpoints":[
                   {
                      "id":"190001_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/190001_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"190",
                      "url":"http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"metering"
             },
             {
                "endpoints":[
                   {
                      "id":"100_P",
                      "interface":"public",
                      "link":[
                         {
                            "href":"https://localhost:35357/v3/endpoints/100_P",
                            "rel":"self"
                         }
                      ],
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"120",
                      "url":"http://az1-nv-schedule-0000.rndd.aw1.hpcloud.net:8774/v1.1/56524744656491"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"compute"
             }
          ],
          "expires_at":"2013-03-13T10:22:37.047Z",
          "issued_at":"2013-03-12T22:22:37.047Z",
          "otherAttributes":{
    
          }
       }
    }
     
    

XML

    

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

**Response Data**

JSON

    {
      "identityFault": {
        "message": "Fault",
        "details": "Error Details...",
        "code": 500
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8"?>
    <identityFault xmlns="http://docs.openstack.org/identity/api/v2.0"
              code="500">
            <message>Fault</message>
            <details>Error Details...</details>
    </identityFault>

Curl Example

    curl -k -H "Content-Type: application/json" -d '{"auth": {"identity": {"methods": ["tokens"],"token": {	"id": "HPAuth_a6f32cefceb798cedd3183c71c07a3d169c8ad613e0c951ae5f426c015dd3210"}}}}' -X POST https://region-a.geo-1.identity.hpcloudsvc.com:35357/v3/auth/tokens

**Additional Notes**


#### 3.4.3.3 Revoke Token#### {#revoke_token}
#### DELETE /v3/auth/tokens/
*Privilege Level: SA,DA,SS*

This API is used to revoke an authentication token. This operation does not require a request body. Once a token has been revoked, attempts to validate the token via GET /tokens/ will fail with a 404 (item not found) as the token no longer exists. Trying revoke a non existing token, including one which has expired will also return a 404 (item not found).


**HTTP Headers**

| Header Name | Description | Required | Comments |
| :-----------| :-----------| :------- | :--------| 
| X_Auth-Token       | Callers authorization token |  Y  | |
| X-Subject-Token    | Token to be deleted         |  Y  | |
| Accept		   | Content Type of response    |  N  |Defaults to Json |

**Request Data**


**URL Parameters**

None

**Data Parameters**

This call does not require a request body.

**Success Response**


**Status Code**

200 - OK

**Response Data**


**Error Response**


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |


**Response Data**

JSON

    {"forbidden":{"message":"Full authentication is required to access this resource","code":403}}

XML

    <?xml version="1.0" encoding="UTF-8"?><forbidden xmlns="http://docs.openstack.org/identity/api/v2.0" code="403"><message>Full authentication is required to access this resource</message></forbidden>

Curl Example

    curl -k -X DELETE -H "X-Auth-Token:HPAuth_23423423424234" -H "X-Subject-Token: HPAuth_45345345345454534"   https://region-a.geo-1.identity-internal.hpcloudsvc.com/v3/auth/tokens

**Additional Notes**

Keystone doesn't require X-Auth-Token headers. HPCS requires X-Auth-Token header

#### 3.4.3.4 Validate Token#### {#validate_token}
#### GET /v3/auth/tokens/HP-IDM-serviceId=110,global,130&HP-IDM-endpointTemplateId=110,111
*Privilege Level: Anon*
*Client cert Required : Yes*

This API is used to validate a token. Validation includes checking that
the token belongs to a particular user and it has not expired.  On
successful validation, the response contains permissions relevant to a
particular client. 
Unscoped token is not scoped to any tenant and is primarily used for interacting with some of 
CS APIs. In the event a token is not valid, a 404 (item not found) will be returned.

Filter Roles:

For scoped token validation, optional query parameter **HP-IDM-serviceId
and/or **HP-IDM-endpointTemplateId** can be used to include only
specific subset of roles in response. If the parameter values are
provided and there are no specific roles found, then 401 (unauthorized)
error is generated. Both HP-IDM-serviceId and HP-IDM-endpointTemplateId
parameter can be used in a validate token request.
 In HP-IDM-serviceId and HP-IDM-endpointTemplateId  parameter
values, multiple ids can be specified as comma separated values. To
request global roles to be included in response, global identifier
(which is currently configured as **global**) must be used in either
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

**HTTP Headers**

| Header Name | Description | Required | Comments |
| :-----------| :-----------| :------- | :--------| 
| X-Subject-Token    | Token to be validated       |  Y  | |
| Accept		   | Content Type of response    |  N  |Defaults to Json |

**Request Data**

See examples below.

**URL Parameters**

* *HP-IDM-serviceId* (Optional) - list of IDs (strings) - filter service specific roles
* *HP-IDM-endpointTemplateId* (Optional) - list of IDs (strings) - filter endpoint template specific roles

**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

JSON

    GET https://localhost:8443/v3/auth/tokens HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Subject-Token : HPAuth_4f5a7fe06a25ab00f896bee4
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    GET https://localhost:8443/v3/auth/tokens HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Subject-Token : HPAuth_4f5a7fe06a25ab00f896bee4
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

Optional:

JSON

ValidateToken  Request for JSON (unscoped token where HP-IDM-serviceId parameter value is ignored)

    GET https://localhost:8443/v3/auth/tokens?HP-IDM-serviceId=110 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Subject-Token : HPAuth_4f5a7fe06a25ab00f896bee4
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

ValidateToken JSON Request ( HP-IDM-serviceId parameter with 120 service id value)

    GET https://localhost:8443/v3/auth/tokens?HP-IDM-serviceId=120 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/json
    X-Subject-Token : HPAuth_4f5a7fe06a25ab00f896bee4
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

ValidateToken XML Request  (HP-IDM-serviceId parameter with 110 (Object Storage service) value and HP-IDM-endpointTemplateId parameter with 110 (Compute - AZ2) value)

    GET https://localhost:8443/v3/auth/tokens?HP-IDM-serviceId=110&HP-IDM-endpointTemplateId=110 HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Subject-Token : HPAuth_4f5a7fe06a25ab00f896bee4
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

ValidateToken  XML Request ( HP-IDM-serviceId parameter with 'global' only)

    GET https://localhost:8443/v3/auth/tokens?HP-IDM-serviceId=global HTTP/1.1
    Accept-Encoding: gzip,deflate
    Accept: application/xml
    X-Subject-Token : HPAuth_4f5a7fe06a25ab00f896bee4
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

**Success Response**

**Status Code**

200 - OK

**Response Data**


JSON

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    Set-Cookie: JSESSIONID=D63D9FAC8FA835321F36E51CE07F2485; Path=/; Secure
    Cache-Control: no-cache
    Pragma: no-cache
    Expires: -1
    Content-Type: application/json
    Content-Length: 454
    Date: Fri, 09 Mar 2012 22:16:50 GMT
    
    {
       "token":{
          "methods":[
             "tokens"
          ],
          "extras":{
          },
          "domain":{
             "otherAttributes":{
             }
          },
          "project":{
             "domain":{
                "id":"94710780204290",
                "name":"HPCSDemoDomain",
                "otherAttributes":{
    
                }
             },
             "id":"56524744656491",
             "name":"HPCSDemoDomain_DevProject",
             "otherAttributes":{
    
             }
          },
          "user":{
             "roles":{
                "otherAttributes":{
    
                },
                "role":[
                   {
                      "id":"00000000004016",
                      "name":"netadmin",
                      "otherAttributes":{
    
                      }
                   },
                   {
                      "id":"00000000004025",
                      "name":"sysadmin",
                      "otherAttributes":{
    
                      }
                   },
                   {
                      "id":"00000000004003",
                      "name":"domainadmin",
                      "otherAttributes":{
    
                      }
                   },
                   {
                      "id":"00000000004004",
                      "name":"domainuser",
                      "otherAttributes":{
    
                      }
                   }
                ]
             },
             "domain_id":"94710780204290",
             "id":"21243386194835",
             "name":"HPCSDemoDomain_Admin",
             "otherAttributes":{
    
             }
          },
          "catalog":[
             {
                "endpoints":[
                   {
                      "id":"130_P",
                      "interface":"public",
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"100",
                      "url":"https://csnode.rndd.aw1.hpcloud.net:35357/v2.0/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"identity"
             },
             {
                "endpoints":[
                   {
                      "id":"160_P",
                      "interface":"public",
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"140",
                      "url":"https://glance.rndd.aw1.hpcloud.net:9292/v1.0"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"image"
             },
             {
                "endpoints":[
                   {
                      "id":"140_P",
                      "interface":"public",
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"130",
                      "url":"https://az-1.region-a.geo-1.compute.hpcloudsvc.com/v1.1/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"volume"
             },
             {
                "endpoints":[
                   {
                      "id":"190001_P",
                      "interface":"public",
                      "otherAttributes":{
    
                      },
                      "region":"region-a.geo-1",
                      "service_id":"190",
                      "url":"http://mb-aw1rdd1-meterweb0000.rndd.aw1.hpcloud.net:8080/reportingService/"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"metering"
             },
             {
                "endpoints":[
                   {
                      "id":"100_P",
                      "interface":"public",
                      "otherAttributes":{
    
                      },
                      "region":"az-1.region-a.geo-1",
                      "service_id":"120",
                      "url":"http://az1-nv-schedule-0000.rndd.aw1.hpcloud.net:8774/v1.1/56524744656491"
                   }
                ],
                "otherAttributes":{
    
                },
                "type":"compute"
             }
          ],
          "expires_at":"2013-03-05T11:13:12.770Z",
          "issued_at":"2013-03-04T23:13:12.770Z",
          "otherAttributes":{
    
          }
       }
    
    }
    

XML

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
     

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem --key hpmiddleware.pem -H "Accept: application/json" -H "X-Subject-Token : HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v3/auth/tokens"

**Additional Notes**


This call is not exposed to public. This call requires a valid Client Cert


#### 3.4.3.5 Quick Token Validation#### {#quick_token_validation}
#### HEAD /v3/auth/tokens
*Privilege Level: Anon*

This API is used to do a quick token validation. Validation includes checking that the token belongs to a particular user and it has not expired. If there is no tenantId then it is globally scoped. In the event a token is not valid, a 404 (item not found) will be returned.  This call won't return any roles associated with the token.
In case of scoped token validation, if that tenant has swift account hash available in CS system, then its value is returned as a response header with name 'X-HP-IDM-swift-account-hash'.
Note: This request does not expect X-Auth-Token header but if its provided, then it needs to be have a valid token value otherwise forbidden (403) error is returned.

**HTTP Headers**

| Header Name | Description | Required | Comments |
| :-----------| :-----------| :------- | :--------| 
| X-Subject-Token    | Token to be validated       |  Y  | |


**Request Data**

See examples below.

**URL Parameters**


**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

JSON

    HEAD https://localhost:8443/v3/auth/tokens HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token:/HPAuth_4f5a7fe06a25ab00f896bee4 
    Accept: application/json
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

XML

    HEAD https://localhost:8443/v3/auth/tokens HTTP/1.1
    Accept-Encoding: gzip,deflate
    X-Auth-Token:/HPAuth_4f5a7fe06a25ab00f896bee4 
    Accept: application/xml
    User-Agent: Jakarta Commons-HttpClient/3.1
    Host: localhost:8443

Optional:


**Success Response**

**Status Code**

204 - OK

**Response Data**

This call does not return a response body.

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Item Not Found

**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

    curl -k --cacert ca.pem --cert hpmiddleware.pem -H "X-Subject-Token:HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -X HEAD "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v3/auth/tokens"

**Additional Notes**

Keystone requires X-Auth-Token whereas in HPCS case, it is optional

### 3.4.4 Versions



**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 3.4.4.1 GET Versions#### {#get_versions}
#### GET /
*Privilege Level: *



**Request Data**


**URL Parameters**



**Data Parameters**

See schema file for more details on the request and response data structure.

This call does not require a request body.

JSON

    

XML

    

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

A list of tenants in the specified format is returned.

JSON

    

XML

    

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


**Response Data**

JSON

    {
      "unauthorized" : {
        "code" : 401,
        "details" : "Invalid credentials",
        "message" : "UNAUTHORIZED",
        "otherAttributes" : {
        }
      }
    }

XML

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?><unauthorized xmlns="http://docs.openstack.org/identity/api/v2.0" xmlns:ns2="http://www.hp.com/identity/api/ext/HP-IDM/v1.0" xmlns:ns3="http://docs.openstack.org/common/api/v1.0" xmlns:ns4="http://www.w3.org/2005/Atom" code="401"><message>UNAUTHORIZED</message><details>Invalid credentials</details></unauthorized>

Curl Example

***Get Versions***

 

**Additional Notes**

---

# Appendix A: Available Actions <a id="available_action">

| Actions |
| :------ |




---
