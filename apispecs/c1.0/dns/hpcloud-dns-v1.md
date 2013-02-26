---
layout: page
permalink: /api/dns/
title: HP Cloud DNS API
description: "HP Cloud DNS API Specification"
version: v1
keywords: "dns"
product: HP Cloud DNS

---

# HP Cloud DNS API

# 1. Overview

This guide is intended for software developers who wish to create applications using the HP Cloud DNS set of APIs. It assumes the reader has a general understanding of cloud APIs, DNS concepts, RESTful web services, HTTP/1.1 conventions and JSON serialization formats. The HP Cloud DNS set of APIs utilize and take advantage of a variety of Openstack cloud API patterns which are described in detail.




## 1.1 API Maturity Level

**Maturity Level**: *Exploratory* (HP Cloud DNS is currently in Private Beta)

**Version API Status**: *BETA*

---


# 2. Architecture View


### 2.1 Overview
HP Cloud DNS is a service includes a set of restful APIs for the display, creation, modification and deletion of DNS records. This service offers users the ability to manage their domains and have DNS servers to serve DNS queries worldwide using graphically distributed DNS servers.

### 2.2 Conceptual/Logical Architecture View
To use the HP Cloud DNS API effectively, you should understand several key concepts.

### 2.2.1 DNS
DNS, or Domain Name Service, is a service that provides a telephone book-like lookup of the actual internet address (IP address) of a domains. This is called name resolution. For instance, if a user wants to be able to access mytestdomain.com in their browser, DNS provides the mechanism for the browswer to know that the server is 1.2.3.4 (or whatever IP address it may be)

### 2.2.2 Domain Name
A domain name is an identification string that defines a realm of administrative autonomy, authority, or control on the Internet. An example of this is mytestdomain.com

### 2.3 Infrastructure Architecture View
HP Cloud DNS fits into the HP Cloud ecosystem of APIs by utilizing the common authentication mechanisms as other HP cloud services. In order to use HP Cloud DNS, a user account must be 'activated' all API calls will require a valid HP Cloud authentication token.

## 3. Account-level View
Once the account is activated, the HP Cloud DNS service will show up in the service catelog returned during user login. In addition, the HP Cloud DNS endpoint to be used will also be presented.



### 3.1 Accounts
Once logged into the HP Cloud, a service catalog will list the availability of HP Cloud DNS, roles and endpoints for the region logged into and for which the user is activated for.

*The following is an example of the HP Cloud DNS information within the service catalog including roles and endpoints*

    "user": {
        "id": "1234567890",
        "name": "user@somename.com",
        "roles": [
          {
            "id": "00000000004024",
            "serviceId": "140",
            "name": "user",
            "tenantId": "9876543210"
          },
          {
            "id": "00000000004004",
            "serviceId": "100",
            "name": "domainuser"
          },
          {
            "id": "91643347410087",
            "serviceId": "240",
            "name": "dns-admin",
            "tenantId": "9876543210"
          },
          {
            "id": "00000000004003",
            "serviceId": "100",
            "name": "domainadmin"
          }
        ]
      },
      "serviceCatalog": [
        ...
        {
          "name": "DNS",
          "type": "hpext:dns",
          "endpoints": [{
            "tenantId": "74562296981260",
            "publicURL": "https:\/\/region-a.geo-1.dns.hpcloudsvc.com\/v1\/",
            "publicURL2": "",
            "region": "region-a.geo-1",
            "versionId": "1",
            "versionInfo": "https:\/\/region-a.geo-1.dns.hpcloudsvc.com\/v1\/",
            "versionList": "https:\/\/region-a.geo-1.dns.hpcloudsvc.com\/"
          }]
        },
      ]
    }}
    
### 3.2 Regions and Availability Zones
HP Cloud DNS does not have AZ-specific endpoints but utilizes all AZs internally. It is available in region A

**Region(s)**: region-a

**Availability Zone(s)**: az-1, az-2, az-3 

**Future Expansion**: region-b


### 3.3 Service Catalog
The HP Cloud DNS service is exposed in the service catalog, as shown in the following fragment:

    {
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

## 4. REST API Specifications
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*

## 3.1 Service API Operations

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
The common request headers are
X-Auth-Token: Keystone/Control services authentication token
Content-Type: application/json


## 3.3 Common Response Headers
Content-Type: application/json
Content-Length: size of response body
Content-Type: application/json

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

N/A

**URL Parameters**

None

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json

    {
        "name": "domain1.com.",
        "ttl": 7200,
        "email": "nsadmin@example.org"
    }


**Response Data**

The newly created Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domain1.com.",
        "ttl": 7200,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

JSON

    {"errors": [{"path": "<form parameter>", "message": "<an error message>", "validator": "required"}]}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


**Curl Example**

***Create Domain***

    curl -X POST -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains" -d '{ "name": "domain1.com.", "ttl": 7200, "email": "nsadmin@example.org" }'

#### 3.4.1.2 Get a Domain #### {#get_domain}
#### GET /domains/{domainId}

**Request Data**

None

**URL Parameters**

None

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
**Status Code**

200 - OK

**Response Data**

Json response returned is data for a domain.

JSON

     HTTP/1.1 200 OK
     Vary: Accept
     Content-Type: application/json

    {
      "name": "domain1.com.",
      "created_at": "2012-11-01T20:11:08.000000",
      "email": "nsadmin@example.org",
      "ttl": 3600,
      "serial": 1351800668,
      "id": "09494b72-b65b-4297-9efb-187f65a0553e"
    }

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


Curl Example

***Get a Domain***

    curl -X GET -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains/09494b72-b65b-4297-9efb-187f65a0553e"



#### 3.4.1.3 Update Domain #### {#update_domain}
#### PUT /domains/{domainId}

**Request Data**

JSON

    PUT /domains/{domainId} HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json
    
    {
      "name": "domainnamex.com",
      "ttl": 7200,
      "email": "nsadmin@example.org"
    }

**URL Parameters**

None

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
**Status Code**

200 - OK

**Response Data**

The updated Domain is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
        "id": "89acac79-38e7-497d-807c-a011e1310438",
        "name": "domainnamex.com.",
        "ttl": 3600,
        "serial": 1351800588,
        "email": "nsadmin@example.org"
        "created_at": "2012-11-01T20:09:48.094457"
    }

**Error Response**

JSON

    {"errors": [{"path": "<form parameter>", "message": "<an error message>", "validator": "required"}]}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


Curl Example

***Get Domain***

    curl -X PUT -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains" -d '{ "name": "domain1.com.", "ttl": 3600, "email": "nsadmin@example.org" }'


**Additional Notes**

#### 3.4.1.4 Delete Domain #### {#delete_domain}
#### DELETE /domains/{domainId}

**Request Data**

N/A

**URL Parameters**

None

**Data Parameters**

None

**Status Code**

200 - OK

**Response Data**

None


**Error Response**

None

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


Curl Example

***Delete Domain***

    curl -X DELETE -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains/{domainId}"


**Additional Notes**

#### 3.4.1.5 Get Authoritative Nameservers for a Domain #### {#get_servers_hosting_domain}
#### GET /domains/{domainId}/servers

**Request Data**

none

**URL Parameters**

none

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.

**Status Code**

200 - OK

**Response Data**

List of nameservers for a domain

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json
    
    [
      {
        "id": "384a9b20-239c-11e2-81c1-0800200c9a66",
        "name": "ns1.provider.com.",
        "created_at": "2011-01-21T11:33:21Z",
        "updated_at": null
      },
      {
        "id": "cf661142-e577-40b5-b3eb-75795cdc0cd7",
        "name": "ns2.provider.com.",
        "created_at": "2011-01-21T11:33:21Z",
        "updated_at": "2011-01-21T11:33:21Z"
      }
    ]

**Error Response**

HTML

    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
    <title>404 Not Found</title>
    <h1>Not Found</h1>
    <p>The requested URL was not found on the server.</p><p>If you entered the URL manually please check your spelling and try again.</p>


**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


Curl Example

***Get Domain Nameservers***

    curl -X GET -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains/{domainId}/servers"


#### 3.4.1.6 Get a List of Domains for tenant #### {#list_domains}
#### GET /domains

**Request Data**

None

**URL Parameters**

None

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
**Status Code**

200 - OK

**Response Data**

Json response is returned containing a list of domains.

JSON

HTTP/1.1 200 OK
Vary: Accept
Content-Type: application/json

{
  "domains": [
    {
      "name": "domain1.com.",
      "created_at": "2012-11-01T20:11:08.000000",
      "email": "nsadmin@example.org",
      "ttl": 3600,
      "serial": 1351800668,
      "id": "09494b72-b65b-4297-9efb-187f65a0553e"
    },
    {
      "name": "domain2.com.",
      "created_at": "2012-11-01T20:09:48.000000",
      "email": "nsadmin@example.org",
      "ttl": 3600,
      "serial": 1351800588,
      "id": "89acac79-38e7-497d-807c-a011e1310438"
    }
  ]
}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


Curl Example

***List Domains***

    curl -X GET -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains"


### 3.4.2 Records

#### 3.4.2.1 Create Record #### {#create_record}
#### POST /domains/{domainId}/records

**Request Data**

None

**URL Parameters**

None

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    POST /domains/{domainId}/records HTTP/1.1
    Host: example.com
    Accept: application/json
    Content-Type: application/json
    
    {
      "name": "www.example.com.",
      "type": "A",
      "data": "15.185.172.152"
    }

**Status Code**

200 - OK

**Response Data**

The newly created domain record is returned.

JSON

    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 399
    Location: http://localhost:9001/v1/domains/89acac79-38e7-497d-807c-a011e1310438/records/2e32e609-3a4f-45ba-bdef-e50eacd345ad
    Date: Fri, 02 Nov 2012 19:56:26 GMT
    
    {
      "id": "2e32e609-3a4f-45ba-bdef-e50eacd345ad",
      "name": "www.example.com.",
      "type": "A",
      "created_at": "2012-11-02T19:56:26.366792",
      "updated_at": null,
      "domain_id": "89acac79-38e7-497d-807c-a011e1310438",
      "ttl": 3600,
      "data": "15.185.172.152",
    }

**Error Response**

JSON

    {"errors": [{"path": "<form parameter>", "message": "<an error message>", "validator": "required"}]}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


Curl Example

***Create Domain Record***

    curl -X POST -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains/09494b72-b65b-4297-9efb-187f65a0553e/records -d '{ "name": "www.example.com.", "type": "A", "data": "15.185.172.152" }'


**Additional Notes**

If one is creating an MX record, they must first have an A record to map to. Also, in creating an MX record, one needs to specify the "priority" form attribute.

#### 3.4.2.2 Get Record #### {#get_record}
#### GET /domains/{domainId}/records/{recordId}

**Request Data**

None

**URL Parameters**

None

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
**Status Code**

200 - OK

**Response Data**

The requested domain record is returned.

JSON

    HTTP/1.1 200 OK
    Vary: Accept
    Content-Type: application/json

    {
      "id": "2e32e609-3a4f-45ba-bdef-e50eacd345ad",
      "name": "www.example.com.",
      "type": "A",
      "created_at": "2012-11-02T19:56:26.366792",
      "updated_at": "2012-11-04T13:22:36.859786",
      "priority": null,
      "ttl": 3600,
      "data": "15.185.172.153",
      "domain_id": "89acac79-38e7-497d-807c-a011e1310438"
    }

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

Curl Example

***Get Domain Record***

    curl -X GET -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains/{domainId}/records/{recordId}"


#### 3.4.2.3 Update Record #### {#update_record}
#### PUT /domains/{domainId}/records/{recordId}

**Request Data**

N/A

**URL Parameters**

None

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
JSON

    PUT /domains/89acac79-38e7-497d-807c-a011e1310438/records/2e32e609-3a4f-45ba-bdef-e50eacd345ad
    Host: example.com
    Accept: application/json
    Content-Type: application/json
    {
      "name": "www.example.com.",
      "type": "A",
      "data": "15.185.172.153"
    }

**Status Code**

200 - OK

**Response Data**

The modified domain record is returned.

JSON

    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 446
    Date: Sun, 04 Nov 2012 13:22:36 GMT
    
    {
      "id": "2e32e609-3a4f-45ba-bdef-e50eacd345ad",
      "name": "www.example.com.",
      "type": "A",
      "created_at": "2012-11-02T19:56:26.366792",
      "updated_at": "2012-11-04T13:22:36.859786",
      "priority": null,
      "ttl": 3600,
      "data": "15.185.172.153",
      "domain_id": "89acac79-38e7-497d-807c-a011e1310438"
    }

**Error Response**

JSON

    {"errors": [{"path": "<form parameter>", "message": "<an error message>", "validator": "required"}]}

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


Curl Example

***Update Domain Record***

    curl -X PUT -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains/89acac79-38e7-497d-807c-a011e1310438/records/2e32e609-3a4f-45ba-bdef-e50eacd345ad" -d '{ "name": "www.example.com.", "type": "A", "data": "15.185.172.153" }'


**Additional Notes**

#### 3.4.2.4 Delete Record #### {#delete_record}
#### DELETE /domains/{domainId}/records/{recordId}

**Request Data**

None

**URL Parameters**

None

**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
**Status Code**

200 - OK

**Response Data**

None

**Error Response**

None

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |

Curl Example

***Delete Domain Record***

    curl -X DELETE -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Content-Type: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains/89acac79-38e7-497d-807c-a011e1310438/records/2e32e609-3a4f-45ba-bdef-e50eacd345ad"


#### 3.4.2.5 List Records in a Domain #### {#list_records_in_domain}
#### GET /domains/{domainId}/records

**Request Data**


**URL Parameters**


**Data Parameters**

A valid token must be presented in the *X-Auth-Token* HTTP header. Otherwise, a 401 will be returned.
   
**Status Code**

200 - OK

**Response Data**

List of domain records is returned

JSON

     Content-Type: application/json
     Content-Length: 1209
     Date: Sun, 04 Nov 2012 13:58:21 GMT
     
     {
       "records": [
         {
           "id": "2e32e609-3a4f-45ba-bdef-e50eacd345ad"
           "name": "www.example.com.",
           "type": "A",
           "ttl": 3600,
           "created_at": "2012-11-02T19:56:26.000000",
           "updated_at": "2012-11-04T13:22:36.000000",
           "data": "15.185.172.153",
           "domain_id": "89acac79-38e7-497d-807c-a011e1310438",
           "tenant_id": null,
           "priority": null,
           "version": 1,
         },
         {
           "id": "8e9ecf3e-fb92-4a3a-a8ae-7596f167bea3"
           "name": "host1.example.com.",
           "type": "A",
           "ttl": 3600,
           "created_at": "2012-11-04T13:57:50.000000",
           "updated_at": null,
           "data": "15.185.172.154",
           "domain_id": "89acac79-38e7-497d-807c-a011e1310438",
           "tenant_id": null,
           "priority": null,
           "version": 1,
         },
         {
           "id": "4ad19089-3e62-40f8-9482-17cc8ccb92cb"
           "name": "web.example.com.",
           "type": "CNAME",
           "ttl": 3600,
           "created_at": "2012-11-04T13:58:16.393735",
           "updated_at": null,
           "data": "www.example.com.",
           "domain_id": "89acac79-38e7-497d-807c-a011e1310438",
           "tenant_id": null,
           "priority": null,
           "version": 1,
         }
       ]
     }

**Error Response**

None

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation. |
| 403 | Forbidden | Disabled or suspended user making the request. |
| 409 | Conflict | Duplicate Domain present. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |
| 503 | Service Unavailable | The server is unavailable to process the request.   |


Curl Example

***List Domain Records***

    curl -X GET -k -H "X-Auth-Token: HPAuth_fd6f4f19c0bbf7bb0d500aac3bfe21b621073f22b8a92959cabfdc5c4b3f234c" -H "Accept: application/json" "https://region-a.geo-1.dns.hpcloudsvc.com/v1/domains/89acac79-38e7-497d-807c-a011e1310438/records"
