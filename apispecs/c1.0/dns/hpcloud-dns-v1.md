---
layout: page
permalink: /api/dns
title: HP Cloud DNS API
description: "HP Cloud DNS API Specification"
version: v1
keywords: "dns"
product: HP Cloud DNS

---

# HP Cloud DNS API

# 1. Overview

*Brief introduction and overview of the service and its intended use.*
## 1.1 API Maturity Level

**Maturity Level**: *Exploratory* (HP Cloud Block Storage is currently in Private Beta)

**Version API Status**: *BETA*

---


# 2. Architecture View
### 2.1 Overview*References to architectural details of the service.*### 2.2 Conceptual/Logical Architecture View*Describe the logical components of the system and their responsibilities*### 2.3 Infrastructure Architecture View*Describe how the API fits into the overall HPCS Infrastructure*### 2.4 Entity Relationship Diagram*Describe the relationships between the various entities (resources) involved in the API*## 3. Account-level View*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*### 3.1 Accounts*Describe the structure of the user accounts, groups and tenants. Currently this might be described separately in context of Control Services, but in future each service API needs to state their usage. In future CS might support complex group hierarchies, enterprise account structures while there maybe a phased adoption by individual service APIs*### 3.2 Regions and Availability Zones*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.***Region(s)**: region-a**Availability Zone(s)**: az-1, az-2, az-3 **Future Expansion**: region-b### 3.3 Service Catalog*Describe if the service API is exposed via the service catalog. Reference the fragment of the service catalog showing the structure.*The service is exposed in the service catalog, as shown in the following fragment:    {
        "name": "DNS",
        "type": "hpext:dns",
        "endpoints": [
            {
                "tenantId": "{tenantId}",
                "publicURL": "https://region-a.geo-1.dns.hpcloudsvc.com/v1/",
                "publicURL2": "",
                "region": "region-a.geo-1",
                "versionId": "1",
                "versionInfo": "https://region-a.geo-1.dns.hpcloudsvc.com/v1/",
                "versionList": "https://region-a.geo-1.dns.hpcloudsvc.com/"
            }
        ]
    }

## 4. REST API Specifications*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*## 3.1 Service API Operations

**Host**: https://region-a.geo-1.dns.hpcloudsvc.com

**BaseUri**: {Host}/v1

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- |
| **Domains** | [Create Domain](#create_domain) | POST | /domains | Y/N |
| | [Get Domain](#get_domain) | GET | /domains/{domainId} | Y/N |
| | [Update Domain](#update_domain) | PUT | /domains/{domainId} | Y/N |
| | [Delete Domain ](#delete_domain) | DELETE | /domains/{domainId} | Y/N |
| | [Get Servers Hosting a Domain](#get_servers_hosting_domain) | GET | /domains/{domainId}/servers | Y/N |
| | [List Domains](#list_domains) | GET | /domains | Y/N |
| **Records** | [Create Record](#create_record) | POST | /domains/{domainId}/records | Y/N |
| | [Get Record](#get_record) | GET | /domains/{domainId}/records/{recordId}  | Y/N |
| | [Update Record](#update_record) | PUT | /domains/{domainId}/records/{recordId} | Y/N |
| | [Delete Record](#delete_record) | DELETE | /domains/{domainId}/records/{recordId} | Y/N |
| | [List Records in a Domain](#list_records_in_domain) | GET | /domains/{domainId}/records | Y/N |


## 3.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*


## 3.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *


## 3.4 Service API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*


### 3.4.1 Domains

Domain entries are used to generate zones containing RR  
*Need additional details*

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 3.4.1.1 Create Domain #### {#create_domain}
#### POST /domains

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**

#### 3.4.1.2 Get Domain #### {#get_domain}
#### GET /domains

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**


#### 3.4.1.3 Update Domain #### {#update_domain}
#### PUT /domains

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**

#### 3.4.1.4 Delete Domain #### {#delete_domain}
#### DELETE /domains

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**

#### 3.4.1.5 Get Servers Hosting a Domain #### {#get_servers_hosting_domain}
#### GET /domains/{domainId}/servers

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**


### 3.4.2 Records

#### 3.4.2.1 Create Record #### {#create_record}
#### POST /domains/{domainId}/records

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**

#### 3.4.2.2 Get Record #### {#get_record}
#### GET /domains/{domainId}/records/{recordId}

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**

#### 3.4.2.3 Update Record #### {#update_record}
#### PUT /domains/{domainId}/records/{recordId}

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**

#### 3.4.2.4 Delete Record #### {#delete_record}
#### DELETE /domains/{domainId}/records/{recordId}

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**

#### 3.4.2.5 List Records in a Domain #### {#list_records_in_domain}
#### GET /domains/{domainId}/records

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 3600,
        "email": "nsadmin@example.org"
    }

**Success Response**

*Specify the status code and any content that is returned.*

**Status Code**

200 - OK

**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
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


Curl Example

***Create Domain***

    curl -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


**Additional Notes**

## 5. Changes from Cloud 1.0 API to Cloud 1.1 API*Put down a list of things that has changed from the 1.0 specs to 1.1 specs. If your service did not have a 1.0 version, please remove this section.*## 6. Glossary*Put down definitions of terms and items that need explanation.*
