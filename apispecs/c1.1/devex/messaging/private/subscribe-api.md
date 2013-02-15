---
layout: page
permalink: /api/devex/messaging/
title: Message Subscribe API
description: "Management Console Message Subscribe API documentation."
keywords: "Messaging, MessageHub"
product: devex_messaging
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

**Maturity Level**: *Experimental*

**Version API Status**: *ALPHA*


---


# 2. Architecture View

Documentation for MessageHub is available on the [MessageHub](https://wiki.hpcloud.net/display/iaas/MessageHub+-+Message+Subscriptions) Wiki page.


---

# 3. Account-level View


## 3.1 Regions and Availability Zones

**Region(s)**: region-a

**Availability Zone(s)**: az-1

**Future Expansion**: region-b

---


# 4. REST API Specifications


## 4.1 Service API Operations

**Host**: https://sp.uswest.hpcloud.net

**BaseUri**: /

| Resource | Operation                 | HTTP Method           | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------------ | :----------           | :--------------------- | :---------------- | :-------------: |
| Private Platform | [Retrieve all Private Platform messages](#get_private_platform) | GET | {BaseURI}/api/private/platform | Y/N | HP Cloud Domain |
| Private Platform Alert | [Retrieve all Private Platform Alert messages](#get_private_platform_alert) | GET | {BaseURI}/api/private/platform/alert | Y/N | HP Cloud Domain |
| Private Platform Status | [Retrieve all Private Platform Status messages](#get_private_platform_status) | GET | {BaseURI}/api/private/platform/status | Y/N | HP Cloud Domain |
| Public Platform | [Retrieve all Public Platform messages](#get_public_platform) | GET | {BaseURI}/api/public/platform | Y/N | None |
| Public Platform Alert | [Retrieve all Public Platform Alert messages](#get_public_platform_alert) | GET | {BaseURI}/api/public/platform/alert | Y/N | None |
| Public Platform Status | [Retrieve all Public Platform Status messages](#get_public_platform_status) | GET | {BaseURI}/api/public/platform/status | Y/N | None |


## 4.2 Common Request Headers

    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX


## 4.3 Common Response Headers

    Content-Type: application/json
    Content-Length: 2940
    Connection: keep-alive
    Server: thin 1.5.0 codename Knife


## 4.4 Service API Operation Details


### 4.4.1 Public Platform

Public Platform messages represents raw message data for messages targeted towards public/external users of the Management Console.


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.1.1 Get Public Platform {#get_public_platform}
#### GET /api/public/platform

Returns all the public platform alert and status messages.

**Request Data**

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

**URL Parameters**

None.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header

    HTTP/1.1 200 OK
    Content-Type: application/json
    Content-Length: 2940
    Connection: keep-alive
    Server: thin 1.5.0 codename Knife

JSON Body

    [
        {
        "_id":"5112ac8834ce3857d500000c", 
        "created_at":"2013-02-06T19:18:32+00:00", 
        "message":"Platform alert test message.", 
        "scope":"public", 
        "title":"Alert Message", 
        "type":"platform_alert"
        }, 
        {
        "_id":"51155e0b34ce3857d500000d", 
        "created_at":"2013-02-08T20:20:27+00:00", 
        "message":"Platform status test message.", 
        "scope":"public", 
        "title":"Status Message", 
        "type":"platform_status"
        }
    ]

**Error Response**
<!---
*Enumerate all the possible error status codes and any content that is returned.*
-->

**Status Code**

500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 500 Exception example

    {"message": "Server Error of an unknown nature.", "code": 500}

**Curl Example**

Here's an example in the RDD environment:

    curl -v -H "Accept=application/vnd.messagehub-v1+json" 
            -H X-Auth-Token:<HPAuthToken> 
            https://sp.rndd.aw1.hpcloud.net/api/public/platform


**Additional Notes**
<!---
*Specify any inconsistencies, ambiguities, issues, commentary or discussion relevant to the call.*
-->

None.


#### 4.4.1.2 Get Public Platform Alert
#### GET /api/public/platform/alert {#get_public_platform_alert}

Returns all the public platform alert messages.

**Request Data**

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

**URL Parameters**

None.

**Data Parameters**

None.

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

JSON Body

    [
        {
        "_id":"5112ac8834ce3857d500000c", 
        "created_at":"2013-02-06T19:18:32+00:00", 
        "message":"Platform alert test message.", 
        "scope":"public", 
        "title":"Alert Message", 
        "type":"platform_alert"
        }
    ]

**Error Response**

**Status Code**

500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 500 Exception example


    {"message": "Server Error of an unknown nature.", "code": 500}


**Curl Example**

Here's an example in the RDD environment:

    curl -v -H "Accept=application/vnd.messagehub-v1+json"
            -H X-Auth-Token:<HPAuthToken>
            https://sp.rndd.aw1.hpcloud.net/api/public/platform/alert


**Additional Notes**

None.


#### 4.4.1.3 Get Public Platform Status {#get_public_platform_status}
#### GET /api/public/platform/status

Returns all the public platform status messages.

**Request Data**

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

**URL Parameters**

None.

**Data Parameters**

None.

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

JSON Body

    [
        {
        "_id":"51155e0b34ce3857d500000d", 
        "created_at":"2013-02-08T20:20:27+00:00", 
        "message":"Platform status test message.", 
        "scope":"public", 
        "title":"Status Message", 
        "type":"platform_status"
        }
    ]

**Error Response**

**Status Code**

500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 500 Exception example

    {"message": "Server Error of an unknown nature.", "code": 500}

**Curl Example**

Here's an example in the RDD environment:

    curl -v -H "Accept=application/vnd.messagehub-v1+json"
            -H "X-Auth-Token:<HPAuthToken>"
            https://sp.rndd.aw1.hpcloud.net/api/public/platform/status

**Additional Notes**

None.


### 4.4.2 Private Platform

Public Platform messages represents raw message data for messages targeted towards public/internal users of the Cloud Admin Console.

**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.4.1.1 Get Private Platform {#get_private_platform}
#### GET /api/private/platform

Returns all the private platform alert and status messages.

**Request Data**

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

**URL Parameters**

None.

**Data Parameters**

None.

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

JSON Body

    [
        {
        "_id":"5112ac8834ce3857d500000c", 
        "created_at":"2013-02-06T19:18:32+00:00", 
        "message":"Platform alert test message.", 
        "scope":"private", 
        "title":"Alert Message", 
        "type":"platform_alert"
        }, 
        {
        "_id":"51155e0b34ce3857d500000d", 
        "created_at":"2013-02-08T20:20:27+00:00", 
        "message":"Platform status test message.", 
        "scope":"private", 
        "title":"Status Message", 
        "type":"platform_status"
        }
    ]

**Error Response**

**Status Code**

500 - Internal Server Error of an unspecified nature.  
401 - Unauthorized access has been attempted.

**Response Data**

JSON - 401 Exception example

    {"message": "Unauthorized Request - invalid CS token.", "code": 401}

JSON - 500 Exception example

    {"message": "Server Error of an unknown nature.", "code": 500}

**Curl Example**

Here's an example in the RDD environment:

    curl -v -H "Accept=application/vnd.messagehub-v1+json"
            -H "X-Auth-Token:<HPAuthToken>"
            https://sp.rndd.aw1.hpcloud.net/api/private/platform

**Additional Notes**

None.


#### 4.4.1.2 Get Private Platform Alert {#get_private_platform_alert}
#### GET /api/private/platform/alert

Returns all the private platform alert messages.

**Request Data**

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

**URL Parameters**

None.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

JSON Body

    [
        {
        "_id":"5112ac8834ce3857d500000c", 
        "created_at":"2013-02-06T19:18:32+00:00", 
        "message":"Platform alert test message.", 
        "scope":"private", 
        "title":"Alert Message", 
        "type":"platform_alert"
        }
    ]

**Error Response**

**Status Code**

500 - Internal Server Error of an unspecified nature.  
401 - Unauthorized access has been attempted.

**Response Data**

JSON - 401 Exception example

    {"message": "Unauthorized Request - invalid CS token.", "code": 401}

JSON - 500 Exception example

    {"message": "Server Error of an unknown nature.", "code": 500}

**Curl Example**

Here's an example in the RDD environment:

    curl -v -H "Accept=application/vnd.messagehub-v1+json"
            -H "X-Auth-Token:<HPAuthToken>"
            https://sp.rndd.aw1.hpcloud.net/api/private/platform/alert

**Additional Notes**

None.


#### 4.4.2.3 Get Private Platform Status {#get_private_platform_status}
#### GET /api/private/platform/status

Returns all the private platform status messages.

**Request Data**

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

**URL Parameters**

None.

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

Header

    GET /api/public/platform HTTP/1.1
    Accept: application/json
    Content-Type: application/json
    X-Auth-Token:HPAuth_XXXXX

JSON Body

    [ 
        {
        "_id":"51155e0b34ce3857d500000d", 
        "created_at":"2013-02-08T20:20:27+00:00", 
        "message":"Platform status test message.", 
        "scope":"private", 
        "title":"Status Message", 
        "type":"platform_status"
        }
    ]

**Error Response**

**Status Code**

500 - Internal Server Error of an unspecified nature.  
401 - Unauthorized access has been attempted.

**Response Data**

JSON - 401 Exception example

    {"message": "Unauthorized Request - invalid CS token.", "code": 401}

JSON - 500 Exception example

    {"message": "Server Error of an unknown nature.", "code": 500}

**Curl Example**

Here's an example in the RDD environment:

    curl -v -H "Accept=application/vnd.messagehub-v1+json"
            -H "X-Auth-Token:<HPAuthToken>"
            https://sp.rndd.aw1.hpcloud.net/api/private/platform/status

**Additional Notes**

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
