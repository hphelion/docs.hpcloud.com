---
layout: page
title: Message Publish API
title_section: DevEx
description: 
group: apispec

---
{% include JB/setup %}


# 1. Overview

The HP Cloud Message Pub is a lightweight message publishing platform that allows the Network Operations Center (NOC) and the Support group to initiate messages to HPCS clients. These messages will target Management Console users via the web UI.

The first iteration is essentially a prototype and will implement the following types of messages:

- Platform Alert



## 1.1 API Maturity Level
<!---
*State the maturity level in which the API is in currently, based on the pre-defined stages i.e. Experimental (early Alpha, available internally only), Exploratory (Private-beta ready), Public (Public-beta ready), GA (Release to General Availability, SLAs defined.*  
*The versions schema, status field, supports an enumeration of ALPHA, BETA, CURRENT and DEPRECATED. The versions->status field should correspond to the Maturity Level for the API, i.e. ALPHA for Experimental, BETA for Exploratory, CURRENT for Public and GA, DEPRECATED for all other versions of the API that are not supported anymore.*
-->

**Maturity Level**: *Experimental*

**Version API Status**: *ALPHA*


---


# 2. Architecture View

Documentation for MessagePub is available on the [MessagePub](https://wiki.hpcloud.net/display/iaas/MessagePub+-+Message+Publishing) Wiki page.

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

**Host**: https://mp.uswest.hpcloud.net

**BaseUri**: /

**Admin URI**: N/A

| Resource | Operation                 | HTTP Method           | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------------ | :----------           | :--------------------- | :---------------- | :-------------: |
| Platform Alert | Create a new Platform Alert | POST | {BaseURI}/external_platform_alert | JSON only | mgmtconsole-admin |
| Public Platform Status | Create a new public Platform Status | POST | {BaseURI}/public_platform_status | JSON only | mgmtconsole-admin |
| Private Platform Status | Create a new public Platform Status | POST | {BaseURI}/private_platform_status | JSON only | mgmtconsole-admin |


Note: The "mgmtconsole-admin" role is a temporary role created to allow initial development of this API to progress without hindrance. This initial role will be assigned both to Management Console, NOC and Support personnel as needed to enable publishing of messages across environments (RDD, ST1/ST2/PRO). Later, one or more specific roles will be created to allow sending of specific kinds of messages.


## 4.2 Common Request Headers
<!---
*List the common request headers i.e. X-Auth-Token, Content-Type, Content-Length, Date etc.*
-->

Content-Type: application/json
X-Auth-Token: <Auth_Token>


## 4.3 Common Response Headers
<!---
*List the common response headers i.e. Content-Type, Content-Length, Connection, Date, ETag, Server, etc.*
-->


## 4.4 Service API Operation Details
<!---
*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*
-->

### 4.4.1 Platform Alert
<!---
*Describe the resource and what information they provide. Then enumerate all the API method calls below.*
-->

The Platform Alert provides critical platform feedback to both internal and external users of the Management Console. 
More information is on the wiki - [Messaging Characteristics](https://wiki.hpcloud.net/display/iaas/Messaging+Characteristics)


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.1.1 Create a Platform Alert
#### HTTP Verb: POST /external_platform_alert
<!---
*Description about the method call*
-->

The creation of a Platform Alert will post a message containing a title and message content to this Publish API. The API will drop the message onto the RabbitMQ messaging cluster where it will be consumed by connected Management Console clients and saved to a database for archival purposes.

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

* title - string - brief title of the message to convey significance
* message - string - message to be sent

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

JSON

```
{ :title => 'Test Message', 
  :message => 'This is a <strong>test</strong> message'
}
```

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

400 - Malformed request, normally because of missing required data.
401 - Unauthorized access has been attempted.
500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 400 Exception example

```
{"PlatformAlertException": {"message": "Malformed Request - missing message title.", "code": 400}}
```

JSON - 401 Exception example

```
{"PlatformAlertException": {"message": "Unauthorized Request - invalid CS token.", "code": 401}}
```

JSON - 500 Exception example

```
{"PlatformAlertException": {"message": "Server Error of an unknown nature.", "code": 500}}
```

**Curl Example**

Here's an example in the RDD environment: 

```
curl -v -H "Content-Type: application/json" \
  -H "X-Auth-Token: <Auth_Token>" \
  -X POST \
  -d '{"title":"test message","message":"test message"}' \
  https://mp.rndd.aw1.hpcloud.net/external_platform_alert
```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

The 'message' attribute can include a number of HTML markup tags. A whitelist of allowed tags are noted on the [HPCS Wiki](https://wiki.hpcloud.net/display/iaas/Messaging+-+Markup+Tags+Whitelist).

A 400 exception will be thrown if the content length of the request exceeds 4096 characters.



### 4.4.2 Public Platform Status
<!---
*Describe the resource and what information they provide. Then enumerate all the API method calls below.*
-->

The Public Platform Status provides platform status information to all users of the Management Console. 
More information is on the wiki - [Messaging Characteristics](https://wiki.hpcloud.net/display/iaas/Messaging+Characteristics)


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.2.1 Create a Public Platform status
#### HTTP Verb: POST /public_platform_status
<!---
*Description about the method call*
-->

The creation of a Public Platform Status message will post a message containing a title and message content to this API. The API will drop the message onto the RabbitMQ messaging cluster where it will be consumed by connected Management Console clients and saved to a database for archival purposes.

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

* title - string - brief title of the message to convey significance
* message - string - message to be sent

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

JSON

```
{ :title => 'Test Message', 
  :message => 'This is a <strong>test</strong> message'
}
```

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

400 - Malformed request, normally because of missing required data.
401 - Unauthorized access has been attempted.
500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 400 Exception example

```
{"PlatformStatusException": {"message": "Malformed Request - missing message title.", "code": 400}}
```

JSON - 401 Exception example

```
{"PlatformStatusException": {"message": "Unauthorized Request - invalid CS token.", "code": 401}}
```

JSON - 500 Exception example

```
{"PlatformStatusException": {"message": "Server Error of an unknown nature.", "code": 500}}
```

**Curl Example**

Here's an example in the RDD environment: 

```
curl -v -H "Content-Type: application/json" \
  -H "X-Auth-Token: <Auth_Token>" \
  -X POST \
  -d '{"title":"test message","message":"test message"}' \
  https://mp.rndd.aw1.hpcloud.net/public_platform_status
```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

The 'message' attribute can include a number of HTML markup tags. A whitelist of allowed tags are noted on the [HPCS Wiki](https://wiki.hpcloud.net/display/iaas/Messaging+-+Markup+Tags+Whitelist).

A 400 exception will be thrown if the content length of the request exceeds 4096 characters.



### 4.4.3 Private Platform Status
<!---
*Describe the resource and what information they provide. Then enumerate all the API method calls below.*
-->

The Private Platform Status provides platform status information to all HPCS users of the Management Console.
More information is on the wiki - [Messaging Characteristics](https://wiki.hpcloud.net/display/iaas/Messaging+Characteristics)


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.3.1 Create a Private Platform Status
#### HTTP Verb: POST /private_platform_status
<!---
*Description about the method call*
-->

The creation of a Private Platform Status message will post a message containing a title and message content to this API. The API will drop the message onto the RabbitMQ messaging cluster where it will be consumed by connected Management Console clients and saved to a database for archival purposes.

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

* title - string - brief title of the message to convey significance
* message - string - message to be sent

<!---
*Either put 'This call does not require a request body' or include JSON/XML request data structure*
-->

JSON

```
{ :title => 'Test Message', 
  :message => 'This is a <strong>test</strong> message'
}
```

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

400 - Malformed request, normally because of missing required data.
401 - Unauthorized access has been attempted.
500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 400 Exception example

```
{"PlatformStatusException": {"message": "Malformed Request - missing message title.", "code": 400}}
```

JSON - 401 Exception example

```
{"PlatformStatusException": {"message": "Unauthorized Request - invalid CS token.", "code": 401}}
```

JSON - 500 Exception example

```
{"PlatformStatusException": {"message": "Server Error of an unknown nature.", "code": 500}}
```

**Curl Example**

Here's an example in the RDD environment: 

```
curl -v -H "Content-Type: application/json" \
  -H "X-Auth-Token: <Auth_Token>" \
  -X POST \
  -d '{"title":"test message","message":"private test message"}' \
  https://mp.rndd.aw1.hpcloud.net/private_platform_status

```

**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

The 'message' attribute can include a number of HTML markup tags. A whitelist of allowed tags are noted on the [HPCS Wiki](https://wiki.hpcloud.net/display/iaas/Messaging+-+Markup+Tags+Whitelist).

A 400 exception will be thrown if the content length of the request exceeds 4096 characters.


---

# 5. Additional References

## 5.1 Resources

**Wiki Page**: 

https://wiki.hpcloud.net/display/iaas/MessagePub+-+Message+Publishing
https://wiki.hpcloud.net/display/iaas/Implementation+Phases+and+Scope
https://wiki.hpcloud.net/display/iaas/Messaging+Characteristics
https://wiki.hpcloud.net/display/iaas/Messaging+-+Markup+Tags+Whitelist

**Code Repo**: 

https://git.hpcloud.net/ManagementConsole/message_pub.git

**API Lead Contacts**: 

Chris Johnson (wchrisjohnson@hp.com)
Travis Longoris (travis.longoria@hp.com)

---

# 6. Glossary
<!---
{Put down definitions of terms and items that need explanation.}
-->

---
