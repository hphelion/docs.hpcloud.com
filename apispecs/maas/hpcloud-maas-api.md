---layout: page
permalink: /api/maas/
title: HP Monitoring API
description: "Monitoring API Documentation."
keywords: "Monitoring, Maas"
product: maas---# HP Cloud Monitoring API Specifications
**Date:**  January 17, 2013
**Document Version:** 1.0
## 1. Overview # {#Section1_}This document describes the HP Cloud Monitoring API, which allows you to monitor resources in HP's Cloud.### 1.1 API Maturity Level ## {#Section1_1}**Maturity Level**: HP Cloud Monitoring API is currently in Exploratory level.**Version API Status**: The HP Cloud Monitoring API is currently in BETA.## 2. Architecture View # {#Section2_}Monitoring as a Service provides APIs for managing metric consumption endpoints, metric subscriptions, alarms, and contact methods.### 2.1 Overview ## {#ArchitectureOverview}The MaaS API provides a RESTful JSON interface for interacting with Monitoring as a Service and managing monitoring related resources.
The API supports a number of operations. These include:
+ [Version Operations](#ServiceVersionOps) - Provides information about the supported Monitoring API versions.
+ [Version Operations Details](#ServiceDetailsVersion)+ [Endpoint Operations](#ServiceEndpointOps) - The endpoint resource represents an endpoint from which metrics can be consumed.
+ [Endpoint Operations Details](#ServiceDetailsEndpoint)+ [Subscription Operations](#ServiceSubscriptionOps) - The subscription resource represents a subscription to consume metrics.
+ [Subscription Operations Details](#ServiceDetailsSubscription)+ [Notification Operations](#ServiceNotificationOps) - The notification method resource represents a method through which notifications can be sent.
+ [Notification Operations Details](#ServiceDetailsNotification)+ [Alarm Operations](#ServiceAlarmOps) - The alarm resource identifies a particular metric scoped by namespace, type and dimensions, which should trigger a set of actions when the value of the metric exceeds a threshold.
+ [Alarm Operations Details](#ServiceDetailsAlarm)#### 2.1.1 High Level Usage ### {#HighLevelUsage}

#### 2.1.2 Metric Constants ### {#Constants}
The MaaS API makes use of several metric related pre-defined constants throughout. Foremost is the namespace constant. Support namespaces are:

+ Compute
+ Volume

Each namespace represents a service that has its own constants. These are described below:

*Compute Metric Types*

|Metric Type|Unit|Description|
|:----------|:---|:----------|
|cpu_total_time|nanoseconds|Total CPU time used in nanoseconds|
|disk_read_ops|count|Number of read requests from a disk|
|disk_write_ops|count|Number of write requests from a disk|
|disk_read_bytes|bytes|Number of bytes read from a disk|
|disk_write_bytes|bytes|Number of bytes written to a disk|
|net_in_bytes|bytes|Number of receive bytes on a network interface |
|net_out_bytes|bytes|Number of transfer bytes on a network interface |
|net_in_packets|packets|Number of receive packets on a network interface|
|net_out_packets|packets|Number of transfer packets on a network interface |
|net_in_dropped|packets|Number of receive packets dropped on a network interface|
|net_out_dropped|packets|Number of transfer packets dropped on a network interface|
|net_in_errors|count|Number of receive packet errors on a network interface|
|net_out_errors|count|Number of transfer packet errors on a network interface|

*Compute Dimensions*

+ instance_id

#### 2.1.3 Faults ### {#Faults}

When an error occurs at request time, the system will return an HTTP error response code denoting the type of error. The system will also return additional information about the fault in the body of the response.

*Fault Response*

JSON	{  
		"messaging_fault" : {
			"code" : 500,
			"message" : "Fault information...",
			"details" : "Error Details…",
			"internal_code" : "Internal error log code"
    	}
	}The error code is returned in the body of the response for convenience. The message section returns a human-readable message that is appropriate for display to the end user. The details section is optional and may contain extra information. The internal_code is optional to further identify the internal cause of an error.
## 3. Account-level View # {#Section3_}Requests to the MaaS API are required to present a valid token which must be obtained from Keystone prior to making a MaaS API request.### 3.1 Accounts ## {#Accounts}**Requesting a Token**
***Request URL***
	curl -i https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens -X POST -H "Content-Type: application/json" -H "User-Agent: python-novaclient"
***Request Body***
	{"auth": {"tenantName": "tenant@domain.com", "passwordCredentials": {"username": "tenant@domain.com", "password": "changeit"}}}
***Response Body***
	{"access": {
	  "token": {
	    "expires": "2012-04-05T04:28:29.405Z",
	    "id": "HPAuth_4f7c6456e4b01a25ab011e74",
	    "tenant": {
	    	"id": "123456789",
			"name": "tenant@domain.com"
			}
		},
	"user": {
	"id": "987654321",
	"name": "tenant@hp.com",
	"roles": [
		{
			...
		},
	},
	"serviceCatalog": [
			...
		{
		"name": "MaaS",
		"type": "maas",
		"endpoints": [
			{
			"tenantId": "12345678901234",
			"publicURL": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/",
			"region": "az-1.region-a.geo-1",
			"versionId": "1.0",
			}
		]
		}
	]
	}}
	
***Accessing MaaS***

The endpoint for accessing the MaaS API can be obtained from the service catalog returned in your Keystone authentication request.

	https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/
	
A request can then be made against resources at that endpoint by supplying the access/token/id from your Keystone authentication request as in your MaaS API request header as an X-Auth-Token:

*Sample Request*

	> GET /v1.0/ HTTP/1.1
	> Host: 15.185.167.67:8779
	> Accept: application/json
	> Content-Type: application/json
	> X-Auth-Token: HPAuth_4f7c6456e4b01a25ab011e74
	
### 3.2 Regions and Availability Zones ## {#AccountsRegions}**Region(s)**: region-a**Future Expansion**: region-b## 4. REST API Specifications # {#Section4_}The HP Cloud Monitoring API is implemented using a RESTful web service interface. All requests to authenticate and operate against the Monitoring API should be performed using SSL over HTTP (HTTPS) on TCP port 443.### 4.1 Service API Operations ## {#Service}**Host**: https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com**BaseUri**: {Host}/v1.0### Version Operations ## {#ServiceVersionOps}

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Version | List all versions | GET | {Host}/ | Y/N ||
| Version | Get a specific version | GET | {Host}]/*version_id* | Y/N ||### Endpoint Operations ## {#ServiceEndpointOps}

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Endpoint | Create a new endpoint | POST | {BaseUri}/endpoints | Y/N ||
| Endpoint | List all endpoints | GET | {BaseUri}/endpoints | Y/N ||
| Endpoint | Get a specific endpoint | GET | {BaseUri}/endpoints/*endpoint_id* | Y/N ||
| Endpoint | Delete a specific endpoint | DELETE | {BaseUri}/endpoints/*endpoint_id* | Y/N ||
| Endpoint | Reset the password for a specific endpoint | POST | {BaseUri}/endpoints/*endpoint_id*/reset-password | Y/N ||

### Subscription Operations ## {#ServiceSubscriptionOps}

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Subscription | Create a new subscription | POST | {BaseUri}/subscriptions | Y/N ||
| Subscription | List all subscriptions | GET | {BaseUri}/subscriptions | Y/N ||
| Subscription | Get a specific subscription | GET | {BaseUri}/subscriptions/*subscription_id* | Y/N ||
| Subscription | Delete a specific subscription | DELETE | {BaseUri}/subscriptions/*subscription_id* | Y/N ||

### Notification Method Operations ## {#ServiceNotificationOps}

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Notification Method | Create a new notification method | POST | {BaseUri}/notification-methods | Y/N ||
| Notification Method | List all notification methods | GET | {BaseUri}/notification-methods | Y/N ||
| Notification Method | Get a specific notification method | GET | {BaseUri}/notification-methods/*notification_method_id* | Y/N ||
| Notification Method | Delete a specific notification method | DELETE | {BaseUri}/notification-methods/*notification_method_id* | Y/N ||

### Alarm Operations ## {#ServiceAlarmOps}

| Resource | Operation                                          | HTTP Method | Path                            | JSON/XML Support? | Privilege Level |
| :------- | :------------------------------------------------- | :---------- | :------------------------------ | :---------------- | :-------------- |
| Alarm | Create a new alarm | POST | {BaseUri}/alarms | Y/N ||
| Alarm | List all alarms | GET | {BaseUri}/alarms | Y/N ||
| Alarm | Get a specific alarm | GET | {BaseUri}/alarms/*alarm_id* | Y/N ||
| Alarm | Delete a specific alarm | DELETE | {BaseUri}/alarms/*alarm_id* | Y/N ||  
### 4.2 Common Request Headers ## {#CommonRequestHeaders}*Http standard request headers*

**Accept** - Internet media types that are acceptable in the response. HP Cloud Monitoring supports the media types application/xml and application/json.

**Content-Length** - The length of the request body in octets (8-bit bytes).

**Content-Type** - The Internet media type of the request body. Used with POST and PUT requests. Must be either application/xml or application/json.

**Host** - The domain name of the server hosting HP Cloud Monitoring.

*Non-standard request headers*

**X-Auth-Token** - HP Cloud authorization token.

*Example*

	POST /v1.0/subscriptions HTTP/1.1
	Host: az-1.region-a.geo-1.monitoring.hpcloudsvc.com
	Content-Type: application/json
	Accept: application/json
	X-Auth-Token: HPAuth_2895c13b1118e23d977f6a21aa176fd2bd8a10e04b74bd8e353216072968832a
	Content-Length: 85### 4.3 Common Response Headers ## {#CommonResponseHeaders}
*Http standard response headers*

**Content-Length** - The length of the response body in octets (8-bit bytes).

**Content-Type** - Internet media type of the response body.

**Date** - The date and time that the response was sent.

*Example*

	HTTP/1.1 200 OK
	Content-Length: 1135
	Content-Type: application/json; charset=UTF-8
	Date: Tue, 30 Oct 2012 16:22:35 GMT### 4.4 Service API Operation Details ## {#ServiceDetails}*The following section, enumerates each resource and describes each of its API calls as listed in the Service API Operations section, documenting the naming conventions, request and response formats, status codes, error conditions, rate limits, quota limits, and specific business rules.*

#### 4.4.1 Versions ### {#ServiceDetailsVersion}

Provides information about the supported Monitoring API versions.

##### 4.4.1.1 List All Versions #### {#ServiceDetailsListVersion}###### GET /Lists all versions. **Request Data**	GET / HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{  
	  "versions": [
	    {
	      "id": "v1.0",
	      "links" : [
	        {
	          "rel": "self",
	          "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0"
	        }
	      ],
	      "status": "CURRENT",
	      "updated": "2012-09-25T00:00:00Z"
	    }
	  ]
	}**Error Response**
**Status Code**
| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X GET https://region-a.geo-1.maas.hpcloudsvc.com ##### 4.4.1.2 Get a Specific Version #### {#ServiceDetailsSpecificVersion}###### GET /{version_id}Gets the details of a specific version identified by {version_id}.**Request Data**	GET /v1.0 HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{  
	  "version": {
	    "id": "v1.0",
	    "links" : [
	      {
	        "rel": "self",
	        "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0"
	      }
	    ],
	    "status": "CURRENT",
	    "updated": "2012-09-25T00:00:00Z"
	  }
	}**Error Response**
**Status Code**
| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/#### 4.4.2 Endpoint ### {#ServiceDetailsEndpoint}
The endpoint resource represents an endpoint from which metrics can be consumed.
*Note: The amqp_password is not retrievable after endpoint creation. If the password is lost, then the password reset operation must be performed.*##### 4.4.2.1 Create a New Endpoint #### {#ServiceDetailsCreateEndpoint}###### POST /endpointsCreates a new endpoint for metric consumption. **Request Data**	POST /v1.0/endpoints HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response**	HTTP/1.1 201 Created
	Content-Type: application/son
	Content-Length: 337
	Location: /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c**Status Code**201 - Created**Response Data**JSON	{
	  "endpoint" : {
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "links": [
	      {
	        "rel": "self",
	        "href": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ]
	    "uri": "amqp://host:5672/385937540",
	    "meta" : {
	      "amqp_username": "385937540",
	      "amqp_password": "mEfOy34qJV",
	      "amqp_exchange": "metrics"
	    }
	  }
	}**Error Response****Status Code**| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 409 | Conflict | An endpoint for this tenant already exists. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints ##### 4.4.2.2 List All Endpoints #### {#ServiceDetailsListEndpoint}###### GET /endpointsLists all endpoints. Password information is not present.**Request Data**	GET /v1.0/endpoints HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{
	  "endpoints": [
	    {
	      "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c"
	        }
	      ],
	      "uri": "amqp://host:5672/385937540"
	    },
	    {
	      "id": "abce9e32-6ce0-4a36-9750-df415606babc",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints/abce9e32-6ce0-4a36-9750-df415606babc"
	        }
	      ]
	      "uri": "amqp://host:5672/473077483"
	    }
	  ]
	}**Error Response**
**Status Code**| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints ##### 4.4.2.3 Get a Specific Endpoint #### {#ServiceDetailsSpecificEndpoint}###### GET /endpoints/{endpoint_id}Gets the details of a specific endpoint identified by {endpoint_id}. Password information is not present.**Request Data**	GET /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{
	  "endpoint": {
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "links": [
	      {
	        "rel": "self",
	        "href": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ],
	    "uri": "amqp://host:5672/385937540",
	    "meta" : {
	      "amqp_username": "385937540",
	      "amqp_exchange": "metrics"
	    }
	  }
	}**Error Response**
**Status Code**| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c##### 4.4.2.4 Delete a Specific Endpoint #### {#ServiceDetailsDeleteEndpoint}###### DELETE /endpoints/{endpoint_id}Deletes a specific endpoint identified by {endpoint_id}.**Request Data**	DELETE /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**204 - No Content**Response Data**This call does not provide a response body.**Error Response**
**Status Code**| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c##### 4.4.2.4 Reset the Password for a Specific Endpoint #### {#ServiceDetailsResetPasswordEndpoint}###### POST /endpoints/{endpoint_id}/reset-passwordResets the password for a specific endpoint identified by {endpoint_id}.**Request Data**	POST /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c/reset-password HTTP/1.1
	Host: https://region-a.geo-1.maas.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**	{
	  "password": "mEfOy34qJV"
	}**Error Response**
**Status Code**| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c/reset-password#### 4.4.3 Subscription ### {#ServiceDetailsSubscription}

The subscription resource represents a subscription to consume metrics.

##### 4.4.3.1 Create a New Subscription #### {#ServiceDetailsCreateSubscription}
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

	HTTP/1.1 201 Created
	Content-Type: application/son
	Content-Length: 337
	Location: /v1.0/subscriptions/cdace7b4-8bea-404c-848c-860754a76fb7

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
	      "amqp_routing_key": "nova.server-1234363615-az-1-region-a-geo-1"
	    }
	  }
	}

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions 

##### 4.4.3.2 List All Subscriptions #### {#ServiceDetailsListSubscription}
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
	    }
	  ]
	}

**Error Response**
**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions 

##### 4.4.3.3 Get a Specific Subscription #### {#ServiceDetailsSpecificSubscription}
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
	    },
	    "meta": {
	      "amqp_routing_key": "nova.server-1234363615-az-1-region-a-geo-1"
	    }
	  }
	}

**Error Response**
**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.3.4 Delete a Specific Subscription #### {#ServiceDetailsDeleteSubscription}
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

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c#### 4.4.4 Notification Method ### {#ServiceDetailsNotification}
The notification method resource represents a method through which notifications can be sent.

##### 4.4.4.1 Create a New Notification Method #### {#ServiceDetailsCreateNotification}
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
	    "name": "Joe's Email",
	    "type": "EMAIL",
	    "address": "joe@mail.com"
	  }
	}

**Success Response**

	HTTP/1.1 201 Created
	Content-Type: application/son
	Content-Length: 337
	Location: /v1.0/notification-methods/acb8ad2b-6ce0-4a36-9750-a78bc7da87a2

**Status Code**

201 - Created

**Response Data**

JSON

	{
	  "notification_method": {
	    "id": "acb8ad2b-6ce0-4a36-9750-a78bc7da87a2",
	    "links" : [
	      {
	        "rel": "self",
	        "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/acb8ad2b-6ce0-4a36-9750-a78bc7da87a2"
	      }
	    ],
	    "name": "Joe's Email",
	    "type": "EMAIL",
	    "address": "joe@mail.com"
	  }
	}

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods 

##### 4.4.4.2 List All Notification Methods #### {#ServiceDetailsListNotification}
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
	      "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	      "links" : [
	        {
	          "rel": "self",
	          "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c"
	        }
	      ],
	      "name": "Joe's Email",
	      "type": "EMAIL",
	      "address": "joe@mail.com"
	    },
	    {
	      "id": "acb8ad2b-6ce0-4a36-9750-a78bc7da87a2",
	      "links" : [
	        {
	          "rel": "self",
	          "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/acb8ad2b-6ce0-4a36-9750-a78bc7da87a2"
	        }
	      ],
	      "name": "Joe's Phone",
	      "type": "PHONE",
	      "address": "12063823454"
	    }
	  ]
	}

**Error Response**
**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods 

##### 4.4.4.3 Get a Specific Notification Methods #### {#ServiceDetailsSpecificNotification}
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
	    "id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "links" : [
	      {
	        "rel": "self",
	        "href": "https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ],
	    "name": "Joe's Email",
	    "type": "EMAIL",
	    "address": "joe@mail.com"
	  }
	}

**Error Response**
**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.4.4 Delete a Specific Notification Method #### {#ServiceDetailsDeleteNotification}
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

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c#### 4.4.5 Alarm ### {#ServiceDetailsAlarm}
The alarm resource identifies a particular metric scoped by namespace, type and dimensions, which should trigger a set of actions when the value of the metric exceeds a threshold.

**State Lifecycle**

* UNDETERMINED => OK | ALARM
* OK => UNDETERMINED | ALARM
* ALARM => OK | UNDETERMINED | FLAPPING
* FLAPPING => OK | UNDETERMINED | ALARM

##### 4.4.5.1 Create a New Alarm #### {#ServiceDetailsCreateAlarm}
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

	HTTP/1.1 201 Created
	Content-Type: application/son
	Content-Length: 337
	Location: /v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c

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
	        "href": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c"
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

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms 

##### 4.4.5.2 List All Alarms #### {#ServiceDetailsListAlarm}
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
	          "href": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c"
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
	      "state": "OK"	
	    }
	  ]
	}

**Error Response**
**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms 

##### 4.4.5.3 Get a Specific Alarm #### {#ServiceDetailsSpecificAlarm}
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
	        "href": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c"
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

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.5.4 Delete a Specific Alarm #### {#ServiceDetailsDeleteAlarm}
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

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Internal Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.maas.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c## 5. Glossary # {#Section5_}* Namespace - A required classification for a metric.* Dimension - An optional classification for a metric. A metric may be classified by multiple dimensions.* MaaSEndpoint - The base HTTP endpoint through which the MaaS API can be accessed. 
* MaaSBaseURI - The base URI through which a specific version of the MaaS API can be accessed.



