---
layout: page
title:
title_section:
description:
group: apispec

---
{% include JB/setup %}


# 1. Overview

*Brief introduction and overview of the service and its intended use.*



## 1.1 API Maturity Level


**Maturity Level**: GA

**Version API Status**: CURRENT


---


# 2. Architecture View


## 2.1 Overview
*References to architectural details of the service.*

## 2.2 Conceptual/Logical Architecture View
*Describe the logical components of the system and their responsibilities*

## 2.3 Infrastructure Architecture View
*Describe how the API fits into the overall HPCS Infrastructure*

## 2.4 Entity Relationship Diagram
*Describe the relationships between the various entities (resources) involved in the API*


---

# 3. Account-level View
*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*


## 3.1 Accounts
*Describe the structure of the user accounts, groups and tenants. Currently this might be described separately in context of Control Services, but in future each service API needs to state their usage. In future CS might support complex group hierarchies, enterprise account structures while there maybe a phased adoption by individual service APIs*

## 3.2 Regions and Availability Zones
*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.*

**Region(s)**: region-a, region-b

**Availability Zone(s)**: az-1, az-2, az-3

**Future Expansion**:


## 3.3 Service Catalog

The service is exposed in the service catalog, as shown in the following fragment:

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
}
```

---


# 4. REST API Specifications
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*

## 4.1 Service API Operations


**Host**: https://az-1.region-a.geo-1.compute.hpcloudsvc.com

**BaseUri**: {Host}/v2.0

**Admin URI**: N/A

| Resource | Operation            | HTTP Method | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------- | :---------- | :--------------------- | :---------------- | :-------------: |
| Token      | Authenticate | POST | {BaseURI}/tokens | Y/Y    |                 |
| Token      | Rescope Token | POST | {BaseURI}/tokens | Y/Y    |                 |
| Tenant     | List Tenants | GET | {BaseURI}/tenants | Y/Y    |                 |
| Token      | Revoke | DELETE | {BaseURI}/HP-IDM/v1.0/tokens/<tokenId> | Y/Y    |                 |


## 4.2 Common Request Headers
*List the common response headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*

## 4.3 Common Response Headers
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc. *

## 4.4 Service API Operation Details
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*


### 4.4.1 Action

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.1.1 {deleteerrorcategory}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.2 {deletejob}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.3 {errorcount}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.4 {geterrorcategory}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.5 {geterrorjobs}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.6 {getjob}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.7 {getjobs}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.8 {jobbystatus}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.9 {jobcountbystatus}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.10 {postaction}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.1.11 {restartjob}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.2 Authorization

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.2.1 {addtrust}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.2.2 {authorizationresult}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.2.3 {gettrusts}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.2.4 {removetrust}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.3 Domain

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.3.1 {checkdomainnameexistence}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.2 {createadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.3 {deleteadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.4 {getadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.5 {getalldomains}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.6 {getgroupsfordomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.7 {getservicesforadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.8 {gettenantsforadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.9 {getusersforadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.10 {listroles}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.11 {transferownershipofadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.3.12 {updateadomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.4 Endpoint Template

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.4.1 {addendpointtemplate}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.4.2 {deleteendpointtemplate}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.4.3 {getenabledendpointtemplates}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.4.4 {getendpointtemplatebyid}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.4.5 {getendpointtemplates}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.4.6 {updateendpointtemplate}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.5 Group

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.5.1 {addusertospecificgroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.5.2 {creategroups}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.5.3 {deletegroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.5.4 {getspecificgroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.5.5 {listusersforgroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.5.6 {removeuserfromgroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.5.7 {updategroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.6 Management Console

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.6.1 {userdetails}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.6.2 {userpreferences}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.7 Role Assignment

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.7.1 {checktenantroleassignmentforuser}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.2 {creategroupsglobalroleassignment}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.3 {createtenantroleassignmentforgroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.4 {createtenantroleassignmentforuser}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.5 {createusersglobalroleassignment}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.6 {deletegroupsglobalroleassignment}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.7 {deletetenantroleassignmentforgroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.8 {deletetenantroleassignmentforuser}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.9 {deleteusersglobalroleassignment}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.10 {getnontenantrasdomain}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.11 {getusersglobalrole}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.12 {listgroupsglobalroles}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.13 {listtenantroleassignment}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.14 {listtenantroleassignmentforgroup}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.15 {listtenantroleassignmentforuser}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.7.16 {listusersglobalroles}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.8 Role Defs

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.8.1 {createroledef}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.2 {deleteroledef}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.3 {getdomainsroledefs}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.4 {getroleadef}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.5 {listroledefs}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.6 {updateroledef}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.8.7 {updateroledefscope}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.9 Service

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.9.1 {getservicebyid}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.9.2 {listregisteredservices}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.9.3 {registernewservice}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.9.4 {updateservice}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.10 Signature

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.10.1 {ec2signature}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.10.2 {genericsignature}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.11 Tenant

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.11.1 {addendpointtotenant}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.2 {checktenantnameexistence}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.3 {createatenant}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.4 {deleteatenant}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.5 {getalltenants}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.6 {getatenant}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.7 {getendpointsfortenant}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.8 {gettenantsforuser}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.9 {getusersforatenant}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.10 {removeendpointfromtenant}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.11.11 {updateatenant}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.12 Token

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.12.1 {getauthtoken}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.12.2 {getauthtokenv1}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.12.3 {quickvalidateauthtoken}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.12.4 {refreshauthtoken}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.12.5 {rescopeauthtoken}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.12.6 {revokeauthtoken}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.12.7 {validateauthtoken}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.13 User

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.13.1 {checkusernameexistence}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.2 {createanuserextension}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.3 {deleteanuserextension}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.4 {getallgroupsforanuserextension}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.5 {getallusersextension}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.6 {getsecurityquestions}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.7 {passwordreset}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.8 {returnanuserextension}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.9 {updateanuserextension}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.10 {updatepassword}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.11 {validatnonce}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.13.12 {validatsecret}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.14 User Access Key

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.14.1 {createaccesskey}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.14.2 {deleteaccesskey}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.14.3 {getaccesskey}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.14.4 {importaccesskey}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.14.5 {updateaccesskey}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.15 User Certificate

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.15.1 {createcertificate}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.15.2 {deletecertificate}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.15.3 {getcertificate}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.15.4 {getcertificates}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.15.5 {importcertificate}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.15.6 {updatecertificate}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


### 4.4.16 User Key Pair

{Describe the resource and what information they provide. Then enumerate all the API method calls below.}

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.


#### 4.4.16.1 {createkeypair}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.2 {deletekeypair}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.3 {getkeypair}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.4 {getkeypairs}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.5 {importkeypair}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


#### 4.4.16.6 {updatekeypair}
#### {HTTP Verb: GET, POST, DELETE, PUT} {path only, no root path}
*Privilege Level: {Privilege Level}*

{Description about the method call}

**Request Data**

{Specify all the required/optional url and data parameters for the given method call.}

**URL Parameters**

{Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional)} - {data type} - {description of the attribute}

**Data Parameters**

See schema file for more details on the request and response data structure.

{List all the attributes that comprises the data structure}

* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* - {data type} - {description of the attribute}
* *{name_of_attribute}* (Optional) - {data type} - {description of the attribute}

{Either put 'This call does not require a request body' or include JSON/XML request data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

Optional:

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Success Response**

{Specify the status code and any content that is returned.}

**Status Code**

200 - OK

**Response Data**

{Either put 'This call does not require a request body' or include JSON/XML response data structure}

JSON

```
{json data structure here}
```

XML

```
{xml data structure here}
```

**Error Response**

{Enumerate all the possible error status codes and any content that is returned.}

**Status Code**

400 - Bad Request
401 - Unauthorized
403 - Forbidden
500 - Internal Server Error
503 - Service Unavailable

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
{curl -i -H "X-Auth-Token: <Auth_Token>" [BaseUri][path]}
```

**Additional Notes**

{Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.}


# 5. Additional References

## 5.1 Resources

**Wiki Page**: {Link to Wiki page}

**Code Repo**:  {Link to the internal Github repo}

**API Lead Contact**: {Name of contact}

---

# 6. Glossary

{Put down definitions of terms and items that need explanation.}

---

