---
layout: page
permalink: /api
title: Message Subscribe API
description: "Management Console Message Subscribe API documenation."
keywords: "Messaging, MessageHub"
product: identity
private: true
---


# 1. Overview

The HP Cloud Message Hub is a lightweight message subscription platform that allows the Network Operations Center (NOC) and the Support group to retrieve archived messaging data.

The first iteration is essentially a prototype that supports archive retrieval for the following message types:

- Private Platform Alerts
- Public Platform Alerts
- Private Platform Status
- Public Platform Status


## 1.1 API Maturity Level
<!---
*State the maturity level in which the API is in currently, based on the pre-defined stages i.e. Experimental (early Alpha, available internally only), Exploratory (Private-beta ready), Public (Public-beta ready), GA (Release to General Availability, SLAs defined.*
*The versions schema, status field, supports an enumeration of ALPHA, BETA, CURRENT and DEPRECATED. The versions->status field should correspond to the Maturity Level for the API, i.e. ALPHA for Experimental, BETA for Exploratory, CURRENT for Public and GA, DEPRECATED for all other versions of the API that are not supported anymore.*
-->

**Maturity Level**: *Experimental*

**Version API Status**: *ALPHA*


---


# 2. Architecture View

Documentation for MessageHub is available on the [MessageHub](https://wiki.hpcloud.net/display/iaas/MessageHub+-+Message+Subscriptions) Wiki page.

## 2.1 Overview
<!---
*References to architectural details of the service.*
-->

## 2.2 Conceptual/Logical Architecture View
<!---
*Describe the logical components of the system and their responsibilities*
-->

## 2.3 Infrastructure Architecture View
<!---
*Describe how the API fits into the overall HPCS Infrastructure*
-->

## 2.4 Entity Relationship Diagram
<!---
*Describe the relationships between the various entities (resources) involved in the API*
-->

---

# 3. Account-level View
<!---
*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*
-->

## 3.1 Accounts
<!---
*Describe the structure of the user accounts, groups and tenants. Currently this might be described separately in context of Control Services, but in future each service API needs to state their usage. In future CS might support complex group hierarchies, enterprise account structures while there maybe a phased adoption by individual service APIs*
-->

## 3.2 Regions and Availability Zones
<!---
*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.*
-->

**Region(s)**: region-a

**Availability Zone(s)**: az-1

**Future Expansion**: region-b


## 3.3 Service Catalog
<!---
*Describe if the service API is exposed via the service catalog. Reference the fragment of the service catalog showing the structure.*
-->

N/A

---

# 4. REST API Specifications
<!---
*Describe the API specifications, namely the API operations, and its details, documenting the naming conventions, request and response formats, media type support, status codes, error conditions, rate limits, quota limits, and specific business rules.*
-->

## 4.1 Service API Operations

**Host**: https://sp.uswest.hpcloud.net

**BaseUri**: /

**Admin URI**: N/A

| Resource | Operation                 | HTTP Method           | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------------ | :----------           | :--------------------- | :---------------- | :-------------: |
| Private Platform Alert | Get all private Platform Alert messages | GET | {BaseURI}/api/private/platform/alert | Y/N | HP Cloud Domain |
| Public Platform Alert | Get all public Platform Alert messages | GET | {BaseURI}/api/public/platform/alert | Y/N | None |
| Private Platform Status | Get all private Platform Status messages | GET | {BaseURI}/api/private/platform/status | Y/N | HP Cloud Domain |
| Public Platform Status | Get all public Platform Status messages | GET | {BaseURI}/api/public/platform/status | Y/N | None |
| Private Platform | Get all private Platform messages | GET | {BaseURI}/api/private/platform | Y/N | HP Cloud Domain |
| Public Platform | Get all public Platform messages | GET | {BaseURI}/api/public/platform | Y/N | None |


## 4.2 Common Request Headers
<!---
*List the common request headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*
-->

Accept: application/vnd.messagehub-v1+json   
Content-Type: application/json   

For all private messages, you need to have a valid Auth Token.  
X-Auth-Token: <Auth_Token>

## 4.3 Common Response Headers
<!---
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc.*
-->


## 4.4 Service API Operation Details
<!---
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*
-->

### 4.4.1 Public Platform
<!---
*Describe the resource and what information they provide. Then enumerate all the API method calls below.*
-->

Public Platform messages represents raw message data for messages targeted towards public/external users of the Management Console.


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.1.1 Get Public Platform
#### HTTP Verb: GET /api/public/platform
<!---
*Description about the method call*
-->
Returns all the public platform alert and status messages.

**Request Data**
<!---
*Specify all the required/optional url and data parameters for the given method call.*
-->

**URL Parameters**
<!---
*Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.*
-->

None.

**Data Parameters**
<!---
*List all the attributes that comprise the data structure*
-->

None.

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

This call does not require a request body.

**Success Response**
<!---
*Specify the status code and any content that is returned.*
-->

**Status Code**

200 - OK

**Response Data**
<!---
*Either put 'This call does not require a response body' or include JSON/XML response data structure*
-->

A successful response does not require a response body.

**Error Response**
<!---
*Enumerate all the possible error status codes and any content that is returned.*
-->

**Status Code**

500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 500 Exception example

```
{"message": "Server Error of an unknown nature.", "code": 500}
```

**Curl Example**

Here's an example in the RDD environment:

```
curl -v -H "Accept=application/vnd.messagehub-v1+json" \
https://sp.rndd.aw1.hpcloud.net/api/public/platform
```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

None.


#### 4.4.1.2 Get Public Platform Alert
#### HTTP Verb: GET /api/public/platform/alert
<!---
*Description about the method call*
-->
Returns all the public platform alert messages.

**Request Data**
<!---
*Specify all the required/optional url and data parameters for the given method call.*
-->

**URL Parameters**
<!---
*Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.*
-->

None.

**Data Parameters**
<!---
*List all the attributes that comprise the data structure*
-->

None.

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

This call does not require a request body.

**Success Response**
<!---
*Specify the status code and any content that is returned.*
-->

**Status Code**

200 - OK

**Response Data**
<!---
*Either put 'This call does not require a response body' or include JSON/XML response data structure*
-->

A successful response does not require a response body.

**Error Response**
<!---
*Enumerate all the possible error status codes and any content that is returned.*
-->

**Status Code**

500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 500 Exception example

```
{"Error": {"message": "Server Error of an unknown nature.", "code": 500}}
```

**Curl Example**

Here's an example in the RDD environment:

```
curl -v -H "Accept=application/vnd.messagehub-v1+json" \
https://sp.rndd.aw1.hpcloud.net/api/public/platform/alert
```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

None.


#### 4.4.1.3 Get Public Platform Status
#### HTTP Verb: GET /api/public/platform/status
<!---
*Description about the method call*
-->
Returns all the public platform status messages.

**Request Data**
<!---
*Specify all the required/optional url and data parameters for the given method call.*
-->

**URL Parameters**
<!---
*Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.*
-->

None.

**Data Parameters**
<!---
*List all the attributes that comprise the data structure*
-->

None.

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

This call does not require a request body.

**Success Response**
<!---
*Specify the status code and any content that is returned.*
-->

**Status Code**

200 - OK

**Response Data**
<!---
*Either put 'This call does not require a response body' or include JSON/XML response data structure*
-->

A successful response does not require a response body.

**Error Response**
<!---
*Enumerate all the possible error status codes and any content that is returned.*
-->

**Status Code**

500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 500 Exception example

```
{"message": "Server Error of an unknown nature.", "code": 500}
```

**Curl Example**

Here's an example in the RDD environment:

```
curl -v -H "Accept=application/vnd.messagehub-v1+json" \
https://sp.rndd.aw1.hpcloud.net/api/public/platform/status
```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

None.


### 4.4.2 Private Platform
<!---
*Describe the resource and what information they provide. Then enumerate all the API method calls below.*
-->

Public Platform messages represents raw message data for messages targeted towards public/internal users of the Cloud Admin Console.


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.1.1 Get Private Platform
#### HTTP Verb: GET /api/private/platform
<!---
*Description about the method call*
-->
Returns all the private platform alert and status messages.

**Request Data**
<!---
*Specify all the required/optional url and data parameters for the given method call.*
-->

**URL Parameters**
<!---
*Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.*
-->

None.

**Data Parameters**
<!---
*List all the attributes that comprise the data structure*
-->

None.

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

This call does not require a request body.

**Success Response**
<!---
*Specify the status code and any content that is returned.*
-->

**Status Code**

200 - OK

**Response Data**
<!---
*Either put 'This call does not require a response body' or include JSON/XML response data structure*
-->

A successful response does not require a response body.

**Error Response**
<!---
*Enumerate all the possible error status codes and any content that is returned.*
-->

**Status Code**

500 - Internal Server Error of an unspecified nature.  
401 - Unauthorized access has been attempted.

**Response Data**

JSON - 401 Exception example

```
{"message": "Unauthorized Request - invalid CS token.", "code": 401}
```

JSON - 500 Exception example

```
{"message": "Server Error of an unknown nature.", "code": 500}
```

**Curl Example**

Here's an example in the RDD environment:

```
curl -v -H "Accept=application/vnd.messagehub-v1+json" \
https://sp.rndd.aw1.hpcloud.net/api/private/platform
```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

None.


#### 4.4.1.2 Get Private Platform Alert
#### HTTP Verb: GET /api/private/platform/alert
<!---
*Description about the method call*
-->
Returns all the private platform alert messages.

**Request Data**
<!---
*Specify all the required/optional url and data parameters for the given method call.*
-->

**URL Parameters**
<!---
*Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.*
-->

None.

**Data Parameters**
<!---
*List all the attributes that comprise the data structure*
-->

None.

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

This call does not require a request body.

**Success Response**
<!---
*Specify the status code and any content that is returned.*
-->

**Status Code**

200 - OK

**Response Data**
<!---
*Either put 'This call does not require a response body' or include JSON/XML response data structure*
-->

A successful response does not require a response body.

**Error Response**
<!---
*Enumerate all the possible error status codes and any content that is returned.*
-->

**Status Code**

500 - Internal Server Error of an unspecified nature.  
401 - Unauthorized access has been attempted.

**Response Data**

JSON - 401 Exception example

```
{"message": "Unauthorized Request - invalid CS token.", "code": 401}
```

JSON - 500 Exception example

```
{"message": "Server Error of an unknown nature.", "code": 500}
```

**Curl Example**

Here's an example in the RDD environment:

```
curl -v -H "Accept=application/vnd.messagehub-v1+json" \
https://sp.rndd.aw1.hpcloud.net/api/private/platform/alert
```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

None.


#### 4.4.2.3 Get Private Platform Status
#### HTTP Verb: GET /api/private/platform/status
<!---
*Description about the method call*
-->
Returns all the private platform status messages.

**Request Data**
<!---
*Specify all the required/optional url and data parameters for the given method call.*
-->

**URL Parameters**
<!---
*Pagination concepts can be described here, i.e. marker, limit, count etc. Filtering concepts can be described as well i.e. prefix, delimiter etc.*
-->

None.

**Data Parameters**
<!---
*List all the attributes that comprise the data structure*
-->

None.

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

This call does not require a request body.

**Success Response**
<!---
*Specify the status code and any content that is returned.*
-->

**Status Code**

200 - OK

**Response Data**
<!---
*Either put 'This call does not require a response body' or include JSON/XML response data structure*
-->

A successful response does not require a response body.

**Error Response**
<!---
*Enumerate all the possible error status codes and any content that is returned.*
-->

**Status Code**

500 - Internal Server Error of an unspecified nature.  
401 - Unauthorized access has been attempted.

**Response Data**

JSON - 401 Exception example

```
{"message": "Unauthorized Request - invalid CS token.", "code": 401}
```

JSON - 500 Exception example

```
{"message": "Server Error of an unknown nature.", "code": 500}
```

**Curl Example**

Here's an example in the RDD environment:

```
curl -v -H "Accept=application/vnd.messagehub-v1+json" \
https://sp.rndd.aw1.hpcloud.net/api/private/platform/status
```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

None.

---

# 5. Additional References

## 5.1 Resources

**Wiki Page**:

https://wiki.hpcloud.net/display/iaas/MessageHub+-+Message+Subscriptions
https://wiki.hpcloud.net/display/iaas/Implementation+Phases+and+Scope
https://wiki.hpcloud.net/display/iaas/Messaging+Characteristics

**Code Repo**:

https://git.hpcloud.net/ManagementConsole/message_hub.git

**API Lead Contacts**:

Chris Johnson (wchrisjohnson@hp.com)
Travis Longoris (travis.longoria@hp.com)

---

# 6. Glossary
<!---
{Put down definitions of terms and items that need explanation.}
-->

---
