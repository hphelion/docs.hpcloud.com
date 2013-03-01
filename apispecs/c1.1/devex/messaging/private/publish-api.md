---
layout: page
permalink: /api/devex/messaging/publish/
title: Message Publish API
description: "Management Console Message Publish API documentation."
keywords: "Messaging, MessagePub"
product: devex-messaging
private: true
---


# 1. Overview

The HP Cloud Message Pub is a lightweight message publishing platform that allows the Network Operations Center (NOC) and the Support group to initiate messages to HPCS clients. These messages will target Management Console users via the web UI.

The first iteration is essentially a prototype and will implement the following types of messages:

- Platform Alert



## 1.1 API Maturity Level

**Maturity Level**: *Experimental*

**Version API Status**: *ALPHA*


---


# 2. Architecture View

Documentation for MessagePub is available on the [MessagePub](https://wiki.hpcloud.net/display/iaas/MessagePub+-+Message+Publishing) Wiki page.


---

# 3. Account-level View


## 3.1 Regions and Availability Zones

**Region(s)**: region-a

**Availability Zone(s)**: az-1

**Future Expansion**: region-b

---


# 4. REST API Specifications


## 4.1 Service API Operations

**Host**: https://mp.uswest.hpcloud.net

**BaseUri**: /

| Resource | Operation                 | HTTP Method           | Path                   | JSON/XML Support? | Privilege Level |
| :------- | :------------------------ | :----------           | :--------------------- | :---------------- | :-------------: |
| Public Platform Alert | [Create a new Platform Alert](#create_platform_alert) | POST | {BaseURI}/api/public_platform_alert | Y/N | L3 Support Role |
| Public Platform Status | [Create a new Public Platform Status](#create_public_platform_status) | POST | {BaseURI}/api/public_platform_status | Y/N | L3 Support Role |
| Private Platform Status | [Create a new Private Platform Status](#create_private_platform_status) | POST | {BaseURI}/api/private_platform_status | Y/N | L3 Support Role |


## 4.2 Common Request Headers

Content-Type: application/json  
X-Auth-Token: <Auth_Token>


## 4.3 Service API Operation Details


### 4.3.1 Public Platform Alert

The Public Platform Alert provides critical platform feedback to both internal and external users of the Management Console.
More information is on the wiki - [Messaging Characteristics](https://wiki.hpcloud.net/display/iaas/Messaging+Characteristics)


**Status Lifecycle**

N/A

**Rate Limits**

N/A

**Quota Limits**

N/A

**Business Rules**

None.

#### 4.3.1.1 Create a Platform Alert {#create_platform_alert}
#### POST /api/public_platform_alert

The creation of a Platform Alert will post a message containing a title and message content to this Publish API. The API will drop the message onto the RabbitMQ messaging cluster where it will be consumed by connected Management Console clients and saved to a database for archival purposes.

**Data Parameters**

* title - string - brief title of the message to convey significance
* message - string - message to be sent

JSON

```
{ :title => 'Test Message',
  :message => 'This is a <strong>test</strong> message'
}
```

**Success Response**

**Status Code**

200 - OK

**Response Data**

A successful response does not require a response body.

**Error Response**

**Status Code**

400 - Malformed request, normally because of missing required data.  
401 - Unauthorized access has been attempted.  
500 - Internal Server Error of an unspecified nature.  

**Response Data**

JSON - 400 Exception example

    {"PlatformAlertException": {"message": "Malformed Request - missing message title.", "code": 400}}

JSON - 401 Exception example

    {"PlatformAlertException": {"message": "Unauthorized Request - invalid CS token.", "code": 401}}
    {"PlatformAlertException": {"message": "Unauthorized Request - user doesn't have sufficient access to perform this operation.", "code": 401}}

JSON - 500 Exception example

    {"PlatformAlertException": {"message": "Server Error of an unknown nature.", "code": 500}}

**Curl Example**

Here's an example in the RDD environment:

    curl -v -H "Accept=application/vnd.messagepub-v1+json" \
         -H "Content-Type: application/json" \
         -H "X-Auth-Token: <HPAuthToken>" \
         -X POST \
         -d '{"title":"public_platform_alert test message","message":"public_platform_alert test message"}' \
         https://mp.rndd.aw1.hpcloud.net/api/public_platform_alert

**Additional Notes**

The 'message' attribute can include a number of HTML markup tags. A whitelist of allowed tags are noted on the [HPCS Wiki](https://wiki.hpcloud.net/display/iaas/Messaging+-+Markup+Tags+Whitelist).

A 400 exception will be thrown if the content length of the request exceeds 4096 characters.


### 4.3.2 Public Platform Status

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

#### 4.3.2.1 Create a Public Platform status {#create_public_platform_status}
#### POST /api/public_platform_status


The creation of a Public Platform Status message will post a message containing a title and message content to this API. The API will drop the message onto the RabbitMQ messaging cluster where it will be consumed by connected Management Console clients and saved to a database for archival purposes.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

* title - string - brief title of the message to convey significance
* message - string - message to be sent

JSON

    { :title => 'Test Message',
      :message => 'This is a <strong>test</strong> message'
    }

**Success Response**

**Status Code**

200 - OK

**Response Data**

A successful response does not require a response body.

**Error Response**

**Status Code**

400 - Malformed request, normally because of missing required data.  
401 - Unauthorized access has been attempted.  
500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 400 Exception example

    {"PlatformStatusException": {"message": "Malformed Request - missing message title.", "code": 400}}

JSON - 401 Exception example

    {"PlatformStatusException": {"message": "Unauthorized Request - invalid CS token.", "code": 401}}
    {"PlatformStatusException": {"message": "Unauthorized Request - user doesn't have sufficient access to perform this operation.", "code": 401}}

JSON - 500 Exception example

    {"PlatformStatusException": {"message": "Server Error of an unknown nature.", "code": 500}}

**Curl Example**

Here's an example in the RDD environment:

    curl -v -H "Accept=application/vnd.messagepub-v1+json" \
         -H "Content-Type: application/json" \
         -H "X-Auth-Token: <HPAuthToken>" \
         -X POST \
         -d '{"title":"public_platform_status test message","message":"public_platform_status test message"}' \
         https://mp.rndd.aw1.hpcloud.net/public_platform_status

**Additional Notes**

The 'message' attribute can include a number of HTML markup tags. A whitelist of allowed tags are noted on the [HPCS Wiki](https://wiki.hpcloud.net/display/iaas/Messaging+-+Markup+Tags+Whitelist).

A 400 exception will be thrown if the content length of the request exceeds 4096 characters.

### 4.3.3 Private Platform Status

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

#### 4.3.3.1 Create a Private Platform Status {#create_private_platform_status}
#### POST /api/private_platform_status

The creation of a Private Platform Status message will post a message containing a title and message content to this API. The API will drop the message onto the RabbitMQ messaging cluster where it will be consumed by connected Management Console clients and saved to a database for archival purposes.

**Request Data**

**URL Parameters**

None.

**Data Parameters**

* title - string - brief title of the message to convey significance
* message - string - message to be sent

JSON

    { :title => 'Test Message',
      :message => 'This is a <strong>test</strong> message'
    }

**Success Response**

**Status Code**

200 - OK

**Response Data**

A successful response does not require a response body.

**Error Response**

**Status Code**

400 - Malformed request, normally because of missing required data.  
401 - Unauthorized access has been attempted.  
500 - Internal Server Error of an unspecified nature.

**Response Data**

JSON - 400 Exception example

    {"PlatformStatusException": {"message": "Malformed Request - missing message title.", "code": 400}}

JSON - 401 Exception example

    {"PlatformStatusException": {"message": "Unauthorized Request - invalid CS token.", "code": 401}}
    {"PlatformStatusException": {"message": "Unauthorized Request - user doesn't have sufficient access to perform this operation.", "code": 401}}

JSON - 500 Exception example

    {"PlatformStatusException": {"message": "Server Error of an unknown nature.", "code": 500}}

**Curl Example**

Here's an example in the RDD environment:


    curl -v -H "Accept=application/vnd.messagepub-v1+json" \
         -H "Content-Type: application/json" \
         -H "X-Auth-Token: <HPAuthToken>" \
         -X POST \
         -d '{"title":"private_platform_status test message","message":"private_platform_status private test message"}' \
         https://mp.rndd.aw1.hpcloud.net/private_platform_status

**Additional Notes**

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
