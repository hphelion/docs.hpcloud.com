---layout: page
permalink: /api/maas/
title: HP Monitoring API
description: "Monitoring API Documentation."
keywords: "Monitoring, Maas"
product: maas---# HP Cloud Monitoring API Specifications## 1. OverviewThis document describes the HP Cloud Monitoring API, which allows you to monitor resources in HP's Cloud.### 1.1 API Maturity Level**Maturity Level**: *Exploratory***Version API Status**: *BETA*## 2. Architecture View### 2.1 Overview*References to architectural details of the service.*### 2.2 Conceptual/Logical Architecture View*Describe the logical components of the system and their responsibilities*### 2.3 Infrastructure Architecture View*Describe how the API fits into the overall HPCS Infrastructure*### 2.4 Entity Relationship Diagram*Describe the relationships between the various entities (resources) involved in the API*## 3. Account-level View*Describe the relationship of the API with respect to the accounts, groups, tenants, regions, availability zones etc.*### 3.1 Accounts*Describe the structure of the user accounts, groups and tenants. Currently this might be described separately in context of Control Services, but in future each service API needs to state their usage. In future CS might support complex group hierarchies, enterprise account structures while there maybe a phased adoption by individual service APIs*### 3.2 Regions and Availability Zones*Describe the availability of the service API in different regions and availability zones. State plans for future expansion as well.***Region(s)**: region-a**Availability Zone(s)**: az-1, az-2, az-3 **Future Expansion**: region-b### 3.3 Service Catalog*Describe if the service API is exposed via the service catalog. Reference the fragment of the service catalog showing the structure.*The service is exposed in the service catalog, as shown in the following fragment:	{	   service catalog fragment here	}## 4. REST API SpecificationsThe HP Cloud Monitoring API is implemented using a RESTful web service interface. All requests to authenticate and operate against the Monitoring API should be performed using SSL over HTTP (HTTPS) on TCP port 443.### 4.1 Service API Operations**Host**: https://az-1.region-a.geo-1.maas.hpcloudsvc.com**BaseUri**: {Host}/v1.0### Version Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Version | List all versions | GET | {Host}/ | Y/N ||
| Version | Get a specific version | GET | {Host}]/*version_id* | Y/N ||### Endpoint Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Endpoint | Create a new endpoint | POST | {BaseUri}/endpoints | Y/N ||
| Endpoint | List all endpoints | GET | {BaseUri}/endpoints | Y/N ||
| Endpoint | Get a specific endpoint | GET | {BaseUri}/endpoints/*endpoint_id* | Y/N ||
| Endpoint | Delete a specific endpoint | DELETE | {BaseUri}/endpoints/*endpoint_id* | Y/N ||
| Endpoint | Reset the password for a specific endpoint | POST | {BaseUri}/endpoints/*endpoint_id*/reset-password | Y/N ||

### Subscription Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Subscription | Create a new subscription | POST | {BaseUri}/subscriptions | Y/N ||
| Subscription | List all subscriptions | GET | {BaseUri}/subscriptions | Y/N ||
| Subscription | Get a specific subscription | GET | {BaseUri}/subscriptions/*subscription_id* | Y/N ||
| Subscription | Delete a specific subscription | DELETE | {BaseUri}/subscriptions/*subscription_id* | Y/N ||

### Notification Method Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Notification Method | Create a new notification method | POST | {BaseUri}/notification-methods | Y/N ||
| Notification Method | List all notification methods | GET | {BaseUri}/notification-methods | Y/N ||
| Notification Method | Get a specific notification method | GET | {BaseUri}/notification-methods/*notification_method_id* | Y/N ||
| Notification Method | Delete a specific notification method | DELETE | {BaseUri}/notification-methods/*notification_method_id* | Y/N ||

### Alarm Operations

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Alarm | Create a new alarm | POST | {BaseUri}/alarms | Y/N ||
| Alarm | List all alarms | GET | {BaseUri}/alarms | Y/N ||
| Alarm | Get a specific alarm | GET | {BaseUri}/alarms/*alarm_id* | Y/N ||
| Alarm | Delete a specific alarm | DELETE | {BaseUri}/alarms/*alarm_id* | Y/N ||  
### 4.2 Common Request Headers*Http standard request headers*

**Accept** - Internet media types that are acceptable in the response. HP Cloud Monitoring supports the media types application/xml and application/json.

**Content-Length** - The length of the request body in octets (8-bit bytes).

**Content-Type** - The Internet media type of the request body. Used with POST and PUT requests. Must be either application/xml or application/json.

**Host** - The domain name of the server hosting HP Cloud Monitoring.

*Non-standard request headers*

**X-Auth-Token** - HP Cloud authorization token.

*Example*

	POST /v1.0/subscriptions HTTP/1.1
	Host: az-1.region-a.geo-1.maas.hpcloudsvc.com
	Content-Type: application/json
	Accept: application/json
	X-Auth-Token: HPAuth_2895c13b1118e23d977f6a21aa176fd2bd8a10e04b74bd8e353216072968832a
	Content-Length: 85### 4.3 Common Response Headers
*Http standard response headers*

**Content-Length** - The length of the response body in octets (8-bit bytes).

**Content-Type** - Internet media type of the response body.

**Date** - The date and time that the response was sent.

*Example*

	HTTP/1.1 200 OK
	Content-Length: 1135
	Content-Type: application/json; charset=UTF-8
	Date: Tue, 30 Oct 2012 16:22:35 GMT### 4.4 Service API Operation Details*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*

#### 4.4.1 Versions

Provides information about the supported Monitoring API versions.

##### 4.4.1.1 List All Versions###### GET /Lists all versions. **Request Data**	GET / HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{  
	  "versions": [
	    {
	      "id": "v1.0",
	      "links" : [
	        {
	          "rel": "self"
	          "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0",
	        }
	      ],
	      "status": "CURRENT",
	      "updated": "2012-09-25T00:00:00Z"
	    }
	  ]
	}**Error Response**
**Status Code*** 400 - Bad Request* 500 - Internal Server Error**Curl Example**	$ curl -X GET https://region-a.geo-1.maas.hpcloudsvc.com ##### 4.4.1.2 Get a Specific Version###### GET /{version_id}Gets the details of a specific version identified by {version_id}.**Request Data**	GET /v1.0 HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{  
	  "versions": {
	    "id": "v1.0",
	    "links" : [
	      {
	        "rel": "self"
	        "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0",
	      }
	    ],
	    "status": "CURRENT",
	    "updated": "2012-09-25T00:00:00Z"
	  }
	}**Error Response**
**Status Code*** 400 - Bad Request* 401 - Unauthorized* 403 - Forbidden* 404 - Not Found* 500 - Internal Server Error**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/#### 4.4.2 Endpoint
The endpoint resource represents an endpoint from which metrics can be consumed.**Status Lifecycle**N/A**Rate Limits**N/A**Quota Limits**N/A**Business Rules**None.##### 4.4.2.1 Create a New Endpoint###### POST /endpointsCreates a new endpoint for metric consumption. **Request Data**	POST /v1.0/endpoints HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**201 - Created**Response Data**JSON	{
	  "endpoint" : {
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "links": [
	      {
	        "rel": "self",
	        "href": "https://az-2.region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ]
	    "uri": "amqp://host:5672/385937540",
	    "meta" : {
	      "amqp_username": "385937540",
	      "amqp_password": "mEfOy34qJV",
	      "amqp_exchange": "metrics"
	    }
	  }
	}**Error Response****Status Code*** 400 - Bad Request* 401 - Unauthorized* 403 - Forbidden* 409 - Conflict* 500 - Internal Server Error**Curl Example**	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints ##### 4.4.2.2 List All Endpoints###### GET /endpointsLists all endpoints. Password information is not present.**Request Data**	GET /v1.0/endpoints HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{
	  "endpoints": [
	    {
	      "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://az-2.region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c"
	        }
	      ],
	      "uri": "amqp://host:5672/385937540",
	      "meta" : {
	        "amqp_username": "385937540",
	        "amqp_exchange": "metrics"
	      }
	    },
	    {
	      "id": "abce9e32-6ce0-4a36-9750-df415606babc",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://az-2.region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/abce9e32-6ce0-4a36-9750-df415606babc"
	        }
	      ]
	      "uri": "amqp://host:5672/473077483",
	      "meta" : {
	        "amqp_username": "473077483",
	        "amqp_exchange": "metrics"
	      }
	    }
	  ]
	}**Error Response**
**Status Code*** 400 - Bad Request* 401 - Unauthorized* 403 - Forbidden* 500 - Internal Server Error**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints ##### 4.4.2.3 Get a Specific Endpoint###### GET /endpoints/{endpoint_id}Gets the details of a specific endpoint identified by {endpoint_id}. Password information is not present.**Request Data**	GET /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{
	  "endpoint": {
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "links": [
	      {
	        "rel": "self",
	        "href": "https://az-2.region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ],
	    "uri": "amqp://host:5672/385937540",
	    "meta" : {
	      "amqp_username": "385937540",
	      "amqp_exchange": "metrics"
	    }
	  }
	}**Error Response**
**Status Code*** 400 - Bad Request* 401 - Unauthorized* 403 - Forbidden* 404 - Not Found* 500 - Internal Server Error**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c##### 4.4.2.4 Delete a Specific Endpoint###### DELETE /endpoints/{endpoint_id}Deletes a specific endpoint identified by {endpoint_id}.**Request Data**	DELETE /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**204 - No Content**Response Data**This call does not provide a response body.**Error Response**
**Status Code*** 400 - Bad Request* 401 - Unauthorized* 403 - Forbidden* 404 - Not Found* 500 - Internal Server Error**Curl Example**	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c##### 4.4.2.4 Reset the Password for a Specific Endpoint###### POST /endpoints/{endpoint_id}/reset-passwordResets the password for a specific endpoint identified by {endpoint_id}.**Request Data**	POST /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c/reset-password HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**	{
	  "password": "mEfOy34qJV"
	}**Error Response**
**Status Code*** 400 - Bad Request* 401 - Unauthorized* 403 - Forbidden* 404 - Not Found* 500 - Internal Server Error**Curl Example**	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c/reset-password#### 4.4.3 Subscription

The subscription resource represents a subscription to consume metrics.

##### 4.4.3.1 Create a New Subscription
###### POST /subscriptions

Creates a new subscription to consume metrics.

**Request Data**

	POST /v1.0/subscriptions HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Content-Type: application/json
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

* *endpoint_id* - string - The id of the endpoint to subscribe to* *namespace* - string - The namespace of metrics to receive* *dimensions* - dictionary - The dimensions of metrics to receive

JSON

	{
	  "subscription": {
	    "endpoint_id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "namespace": "nova",
	    "dimensions": {
	      "instance_id": "ca7251f7-8220-42f8-abef-af43739249ad"
	    }
	  }
	}

**Success Response**

**Status Code**

201 - Created

**Response Data**

JSON

	{
	  "subscription": {
	    "id": "cdace7b4-8bea-404c-848c-860754a76fb7",
	    "links": [
	      {
	        "rel": "self",
	        "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions/cdace7b4-8bea-404c-848c-860754a76fb7"
	      }
	    ]
	    "endpoint_id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "namespace": "nova",
	    "dimensions": {
	      "instance_id": "ca7251f7-8220-42f8-abef-af43739249ad"
	    }
	    "meta": {
	      "amqp_routing_key": "nova.server-1234363615-az-2-region-a-geo-1"
	    }
	  }
	}

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions 

##### 4.4.3.2 List All Subscriptions
###### GET /subscriptions

Lists all subscriptions.

**Request Data**

	GET /v1.0/subscriptions HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

	{
	  "subscriptions": [
	    {
	      "id": "cdace7b4-8bea-404c-848c-860754a76fb7",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions/cdace7b4-8bea-404c-848c-860754a76fb7"
	        }
	      ]
	      "endpoint_id": "36351ef0-3ff3-11e2-a25f-0800200c9a66",
	      "namespace": "nova",
	      "dimensions": {
	        "instance_id": "ca7251f7-8220-42f8-abef-af43739249ad"
	    }
	      "meta": {
	        "amqp_routing_key": "nova.server-1234363615-az-2-region-a-geo-1"
	      }
	    },
	    {
	      "id": "abce9e32-6ce0-4a36-9750-df415606babc",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions/abce9e32-6ce0-4a36-9750-df415606babc"
	        }
	      ]
	      "endpoint_id": "3d713b90-3ff3-11e2-a25f-0800200c9a66",
	      "namespace": "nova",
	      "dimensions": {
	        "instance_id": "490dcc20-3ff3-11e2-a25f-0800200c9a66"
	    }
	      "meta": {
	        "amqp_routing_key": "nova.server-1234363615-az-2-region-a-geo-1"
	      }
	    }
	  ]
	}

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions 

##### 4.4.3.3 Get a Specific Subscription
###### GET /subscriptions/{subscription_id}

Gets the details of a specific subscription identified by {subscription_id}.

**Request Data**

	GET /v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

	{
	  "subscription": {
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "links": [
	      {
	        "rel": "self",
	        "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ]
	    "endpoint_id": "36351ef0-3ff3-11e2-a25f-0800200c9a66",
	    "namespace": "nova",
	    "dimensions": {
	      "instance_id": "ca7251f7-8220-42f8-abef-af43739249ad"
	  }
	    "meta": {
	      "amqp_routing_key": "nova.server-1234363615-az-2-region-a-geo-1"
	    }
	  }
	}

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 500 - Internal Server Error

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.3.4 Delete a Specific Subscription
###### DELETE /subscriptions/{subscription_id}

Deletes a specific subscription identified by {subscription_id}.

**Request Data**

	DELETE /v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

204 - No Content

**Response Data**

This call does not provide a response body.

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 500 - Internal Server Error

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c#### 4.4.4 Notification Method
The notification method resource represents a method through which notifications can be sent.

##### 4.4.4.1 Create a New Notification Method
###### POST /notification-methods

Creates a new notification method through which notifications can be sent when an alarm is triggered.

**Request Data**

	POST /v1.0/notification-methods HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Content-Type: application/json
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

* *type* - string - The type of notification method (PHONE, EMAIL)* *address* - string - The address to notify

JSON

	{
	  "notification_method": {
	    "type": "EMAIL",
	    "address": "joe@mail.com"
	  }
	}

**Success Response**

**Status Code**

201 - Created

**Response Data**

JSON

	{
	  "notification_method": {
	    "id": "acb8ad2b-6ce0-4a36-9750-a78bc7da87a2",
	    "links": {
	      "self": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/acb8ad2b-6ce0-4a36-9750-a78bc7da87a2"
	    },
	    "type": "EMAIL",
	    "address": "joe@mail.com"
	  }
	}

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods 

##### 4.4.4.2 List All Notification Methods
###### GET /notification-methods

Lists all notification methods.

**Request Data**

	GET /v1.0/notification-methods HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

	{
	  "notification_methods": [
	    {
	      "id": "eabe9e32-6ce0-4a36-9750-df415606b44c"
	      "links": {
	        "self": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      },
	      "type": "EMAIL",
	      "address": "joe@mail.com"
	    },
	    {
	      "id": "acb8ad2b-6ce0-4a36-9750-a78bc7da87a2",
	      "links": {
	        "self": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/acb8ad2b-6ce0-4a36-9750-a78bc7da87a2"
	      },
	      "type": "PHONE",
	      "address": "12063823454"
	    }
	  ]
	}

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods 

##### 4.4.4.3 Get a Specific Notification Methods
###### GET /notification-methods/{notification_method_id}

Gets the details of a specific notification method identified by {notification_method_id}.

**Request Data**

	GET /v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

	{
	  "notification_method": {
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c"
	    "links": {
	      "self": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c"
	    },
	    "type": "EMAIL",
	    "address": "joe@mail.com"
	  }
	}

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 500 - Internal Server Error

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.4.4 Delete a Specific Notification Method
###### DELETE /notification-methods /{notification_method_id}

Deletes a specific notification method identified by {notification_method_id}.

**Request Data**

	DELETE /v1.0/notification-methods /eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

204 - No Content

**Response Data**

This call does not provide a response body.

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 500 - Internal Server Error

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c#### 4.4.5 Alarm
The alarm resource identifies a particular metric scoped by namespace, type and dimensions, which should trigger a set of actions when the value of the metric exceeds a threshold.

**State Lifecycle**

UNDETERMINED => OK | ALARM

##### 4.4.5.1 Create a New Alarm
###### POST /alarms

Creates a new alarm.

**Request Data**

	POST /v1.0/alarms HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Content-Type: application/json
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

* *name* - string - A descriptive name for the alarm* *namespace* - string - Namespace of metric to alarm on
* *metric_type* - string - Type of metric to alarm on* *dimensions* - dictionary - Dimensions of metrics to alarm on* *operator* - string - Comparison operator for which threshold and metric values are compared* *threshold* - long - Threshold which triggers an alarm when exceeded* *alarm_actions* - array - Methods through which notifications should be sent when transitioning to an ALARM state

JSON

	{
	  "alarm": {
	    "name": "My service CPU exceeds 90%",
	    "namespace": "nova",
	    "metric_type": "CPU",
	    "dimensions": {
	      "instance_id": "cdace7b4-8bea-404c-848c-860754a76fb7"
	    },
	    "operator": "GTE",
	    "threshold": "90",
	    "alarm_actions": [
	      "036609b0-3d6b-11e2-a25f-0800200c9a66",
	      "1221dba0-3d6b-11e2-a25f-0800200c9a66"
	    ]
	  }
	}

**Success Response**

**Status Code**

201 - Created

**Response Data**

JSON

	{
	  "alarm" {
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "links": [
	      {
	        "rel": "self",
	        "href": "https://az-2.region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ],
	    "name": "My service CPU exceeds 90%",
	    "namespace": "nova",
	    "metric_type": "CPU",
	    "dimensions": {
	      "instance_id": "cdace7b4-8bea-404c-848c-860754a76fb7"
	    },
	    "operator": "GTE",
	    "threshold": "90",
	    "state": "UNDETERMINED",
	    "alarm_actions": [
	      "036609b0-3d6b-11e2-a25f-0800200c9a66",
	      "1221dba0-3d6b-11e2-a25f-0800200c9a66"
	    ]
	  }
	}

**Error Response**

**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms 

##### 4.4.5.2 List All Alarms
###### GET /alarms

Lists all alarms.

**Request Data**

	GET /v1.0/alarms HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

	{
	  "alarms": [
	    {
	      "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://az-2.region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c"
	        }
	      ],
	      "name": "My service CPU exceeds 90%",
	      "namespace": "nova",
	      "metric_type": "CPU",
	      "dimensions": {
	        "instance_id": "cdace7b4-8bea-404c-848c-860754a76fb7"
	      },
	      "operator": "GTE",
	      "threshold": "90",
	      "state": "OK",
	      "alarm_actions": [
	        "036609b0-3d6b-11e2-a25f-0800200c9a66",
	        "1221dba0-3d6b-11e2-a25f-0800200c9a66"
	      ]
	    }
	  ]
	}

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 500 - Internal Server Error

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms 

##### 4.4.5.3 Get a Specific Alarm
###### GET /alarms/{alarm_id}

Gets the details of a specific alarms identified by {alarm_id}.

**Request Data**

	GET /v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

200 - OK

**Response Data**

JSON

	{
	  "alarm": {
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "links": [
	      {
	        "rel": "self",
	        "href": "https://az-2.region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ],
	    "name": "My service cpu exceeds 90%",
	    "namespace": "nova",
	    "metric_type": "cpu",
	    "dimensions": {
	      "instance_id": "cdace7b4-8bea-404c-848c-860754a76fb7"
	    },
	    "operator": "GTE",
	    "threshold": "90",
	    "state": "OK",
	    "alarm_actions": [
	      "036609b0-3d6b-11e2-a25f-0800200c9a66",
	      "1221dba0-3d6b-11e2-a25f-0800200c9a66"
	    ]
	  }
	}

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 500 - Internal Server Error

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.5.4 Delete a Specific Alarm
###### DELETE /alarms/{alarm_id}

Deletes a specific alarm identified by {alarm_id}.

**Request Data**

	DELETE /v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

This call does not require a request body.

**Success Response**

**Status Code**

204 - No Content

**Response Data**

This call does not provide a response body.

**Error Response**
**Status Code**

* 400 - Bad Request
* 401 - Unauthorized
* 403 - Forbidden
* 404 - Not Found
* 500 - Internal Server Error

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c## 5. Glossary* Namespace - A required classification for a metric.* Dimension - An optional classification for a metric. A metric may be classified by multiple dimensions.