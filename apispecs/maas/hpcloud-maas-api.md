---layout: page
permalink: /api/monitoring/
title: HP Cloud Monitoring API
description: "HP Cloud Monitoring API Specifications"
keywords: "monitoring, maas"
product: monitoring---# HP Cloud Monitoring API Specifications
**Date:**  January 17, 2013
**Document Version:** 1.0
## 1. Overview # {#Section1_}This document describes the HP Cloud Monitoring API, which allows you to monitor resources in HP's Cloud.### 1.1 API Maturity Level ## {#Section1_1}**Maturity Level**: HP Cloud Monitoring API is currently in Exploratory level.**Version API Status**: The HP Cloud Monitoring API is currently in BETA.## 2. Architecture View # {#Section2_}Monitoring as a Service provides APIs for managing metric consumption endpoints, metric subscriptions, alarms, and contact methods.### 2.1 Overview ## {#ArchitectureOverview}The Monitoring API provides a RESTful JSON interface for interacting with Monitoring as a Service and managing monitoring related resources.
The API supports a number of operations. These include:
+ [Version Operations](#ServiceVersionOps) - Provides information about the supported Monitoring API versions.
+ [Version Operations Details](#ServiceDetailsVersion)+ [Endpoint Operations](#ServiceEndpointOps) - The endpoint resource represents an endpoint from which metrics can be consumed.
+ [Endpoint Operations Details](#ServiceDetailsEndpoint)+ [Subscription Operations](#ServiceSubscriptionOps) - The subscription resource represents a subscription to consume metrics.
+ [Subscription Operations Details](#ServiceDetailsSubscription)+ [Notification Operations](#ServiceNotificationOps) - The notification method resource represents a method through which notifications can be sent.
+ [Notification Operations Details](#ServiceDetailsNotification)+ [Alarm Operations](#ServiceAlarmOps) - The alarm resource identifies a particular metric scoped by namespace, type and dimensions, which should trigger a set of actions when the value of the metric exceeds a threshold.
+ [Alarm Operations Details](#ServiceDetailsAlarm)#### 2.1.1 High Level ### {#HighLevel}
There are 4 major operations (besides Version information):
+ Endpoints specify the connection for consuming metric data to the AMQP message queue. (Endpoints can only be created one per tenant. At least one Dimension must be specified.)
+ Subscriptions specify what monitoring data is to be streamed. (You must create an Endpoint to use with the subscription.)
+ Notifications specify the method(s) in which a user is contacted by alarms.+ Alarms specify user defined exceptional conditions that the user feels the need to be notified about. (You must create a Notification method to use with the Alarm. At least one Dimension must be specified.
#### 2.1.2 Namespaces, Dimensions, and Metrics ### {#Metrics}
The Monitoring API makes use of several metric related pre-defined constants throughout.

##### 2.1.2.1 Namespaces #### {#Namespaces}

Defines the high level logical partition to monitor.  This restricts what metrics will be used.
*Supported Namespaces*

+ compute

##### 2.1.2.2 Dimensions #### {#Dimensions}

Places restrictions on the namespace to further narrow what is monitored.

*Note: each Dimension type can only be used once per call.*

*Supported Compute Dimensions*

+ instance_id

##### 2.1.2.3 Metrics #### {#Metrics}

Each namespace represents a service that has its own metric types. These are described below:

*Compute Metric Types*

|Metric Type|Type|Unit|Subject|Description|
|:----------|:---|:---|:------|:----------|
|cpu_total_time|Counter|Nanoseconds||Total CPU time used in nanoseconds|
|disk_read_ops|Counter|Operations|Disk Name|Number of read requests from a disk|
|disk_write_ops|Counter|Operations|Disk Name|Number of write requests from a disk|
|disk_read_bytes|Counter|Bytes|Disk Name|Number of bytes read from a disk|
|disk_write_bytes|Counter|Bytes|Disk Name|Number of bytes written to a disk|
|net_in_bytes|Counter|Bytes|Interface Name|Number of receive bytes on a network interface |
|net_out_bytes|Counter|Bytes|Interface Name|Number of transfer bytes on a network interface |
|net_in_packets|Counter|Packets|Interface Name|Number of receive packets on a network interface|
|net_out_packets|Counter|Packets|Interface Name|Number of transfer packets on a network interface |
|net_in_dropped|Counter|Packets|Interface Name|Number of receive packets dropped on a network interface|
|net_out_dropped|Counter|Packets|Interface Name|Number of transfer packets dropped on a network interface|
|net_in_errors|Counter|Errors|Interface Name|Number of receive packet errors on a network interface|
|net_out_errors|Counter|Errors|Interface Name|Number of transfer packet errors on a network interface|

### 2.2 Faults ## {#Faults}

When an fault occurs at request time, the system will return an HTTP error response code denoting the type of fault. The system will also return additional information about the fault in the body of the response.

*Fault Response*

JSON	{  
		"fault_element" : {
			"code" : HTTP error code (integer),
			"message" : "Fault information...",
			"details" : "Fault Details…",
			"internal_code" : "Internal error log code"
    	}
	}The error code is returned in the body of the response for convenience. The message section returns a human-readable message that is appropriate for display to the end user. The details section is optional and may contain extra information. The internal_code section is optional internal to monitoring information to further identify the cause of the fault.

The root element of the fault (the fault_element value) may change depending on the type of fault. The following is a list of possible elements along with their associated HTTP error codes.|Fault Element|HTTP Error Code|
|:------------|:--------------|
|server_error|500|
|bad_request|400|
|unauthorized|401|
|forbidden|403|
|not_found|404|
|conflict|409|
|unprocessable_entity|422|
## 3. Account-level View # {#Section3_}Requests to the Monitoring API are required to present a valid token which must be obtained from Keystone prior to making a Monitoring API request.### 3.1 Accounts ## {#Accounts}**Requesting a Token**
***Request URL***
	curl -i https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/tokens -X POST -H "Content-Type: application/json" -H "User-Agent: python-novaclient"
***Request Body***
	{"auth": {"tenantName": "tenant@domain.com", "passwordCredentials": {"username": "tenant@domain.com", "password": "changeit"}}}
***Response Body***
	{
		"access": {
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
	
***Accessing Monitoring***

The endpoint for accessing the Monitoring API can be obtained from the service catalog returned in your Keystone authentication request.

	https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/
	
A request can then be made against resources at that endpoint by supplying the access/token/id from your Keystone authentication request as in your Monitoring API request header as an X-Auth-Token:

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
| Version | Get a specific version | GET | {Host}/*version_id* | Y/N ||### Endpoint Operations ## {#ServiceEndpointOps}

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
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
	Accept: application/json**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{  
	  "versions": [
	    {
	      "id": "v1.0",
	      "links" : [
	        {
	          "rel": "self",
	          "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0"
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
| 500 | Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X GET https://region-a.geo-1.monitoring.hpcloudsvc.com ##### 4.4.1.2 Get a Specific Version #### {#ServiceDetailsSpecificVersion}###### GET /{version_id}Gets the details of a specific version identified by {version_id}.**Request Data**	GET /v1.0 HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**200 - OK**Response Data**JSON	{  
	  "version": {
	    "id": "v1.0",
	    "links" : [
	      {
	        "rel": "self",
	        "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0"
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
| 500 | Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/#### 4.4.2 Endpoint ### {#ServiceDetailsEndpoint}
The endpoint resource represents an endpoint from which metrics can be consumed.
*Note: The amqp_password is not retrievable after endpoint creation. If the password is lost, then the password reset operation must be performed.*
*Note: Endpoints can only be created once per tenant.*##### 4.4.2.1 Create a New Endpoint #### {#ServiceDetailsCreateEndpoint}###### POST /endpointsCreates a new endpoint for metric consumption. AMQP and URI information needs to be retained for accessing the message queue.**Request Data**	POST /v1.0/endpoints HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	    "uri": "amqp://region-a.geo-1.amqp-monitoring.hpcloudsvc.com:5672/385937540",
	    "meta" : {
	      "amqp_username": "385937540",
	      "amqp_password": "mEfOy34qJV",
	      "amqp_exchange": "metrics"
	    }
	  }
	}
	**Error Response****Status Code**| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 409 | Conflict | An endpoint for this tenant already exists. |
| 500 | Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints 
	  
*Extended Curl Example*

	$ curl -i https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints \
	  -X POST -H "Content-Type:application/json" -H "Accept:application/json" \
	  -H "X-Tenant-Id:21908171893702" -H "X-Auth-Token: HPAuth_4f7c6456e4b01a25ab011e74"##### 4.4.2.2 List All Endpoints #### {#ServiceDetailsListEndpoint}###### GET /endpointsLists all endpoints. Password information is not present.**Request Data**	GET /v1.0/endpoints HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	      "uri": "amqp://region-a.geo-1.amqp-monitoring.hpcloudsvc.com:5672/385937540"
	    },
	    {
	      "id": "abce9e32-6ce0-4a36-9750-df415606babc",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://az-1.region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints/abce9e32-6ce0-4a36-9750-df415606babc"
	        }
	      ]
	      "uri": "amqp://region-a.geo-1.amqp-monitoring.hpcloudsvc.com:5672/473077483"
	    }
	  ]
	}**Error Response**
**Status Code**| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 500 | Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints ##### 4.4.2.3 Get a Specific Endpoint #### {#ServiceDetailsSpecificEndpoint}###### GET /endpoints/{endpoint_id}Gets the details of a specific endpoint identified by {endpoint_id}. Password information is not present.**Request Data**	GET /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	    "uri": "amqp://region-a.geo-1.amqp-monitoring.hpcloudsvc.com:5672/385937540",
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
| 500 | Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c##### 4.4.2.4 Delete a Specific Endpoint #### {#ServiceDetailsDeleteEndpoint}###### DELETE /endpoints/{endpoint_id}Deletes a specific endpoint identified by {endpoint_id}.**Request Data**	DELETE /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
	Accept: application/json
	X-Auth-Token: {Auth_Token}**Data Parameters**This call does not require a request body.**Success Response****Status Code**204 - No Content**Response Data**This call does not provide a response body.**Error Response**
**Status Code**| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 404 | Not Found | Requested resource cannot be found. |
| 500 | Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c##### 4.4.2.4 Reset the Password for a Specific Endpoint #### {#ServiceDetailsResetPasswordEndpoint}###### POST /endpoints/{endpoint_id}/reset-passwordResets the password for a specific endpoint identified by {endpoint_id}.**Request Data**	POST /v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c/reset-password HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
| 500 | Server Error | The server encountered a problem while processing the request. |**Curl Example**	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/endpoints/eabe9e32-6ce0-4a36-9750-df415606b44c/reset-password#### 4.4.3 Subscription ### {#ServiceDetailsSubscription}

The subscription resource represents a subscription to consume metrics.

##### 4.4.3.1 Create a New Subscription #### {#ServiceDetailsCreateSubscription}
###### POST /subscriptions

Creates a new subscription to consume metrics.

**Request Data**

	POST /v1.0/subscriptions HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
	Content-Type: application/json
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

* *endpoint_id* - string - The id of the endpoint to subscribe to* *namespace* - string - The namespace of metrics to receive* *dimensions* - dictionary - The dimensions of metrics to receive (each dimension type can only be used once in this call)

JSON

	{
	  "subscription": {
	    "endpoint_id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "namespace": "compute",
	    "dimensions": {
	      "instance_id": "392633"
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
	        "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions/cdace7b4-8bea-404c-848c-860754a76fb7"
	      }
	    ]
	    "endpoint_id": "eabe9e32-6ce0-4a36-9750-df415606b44c",
	    "namespace": "compute",
	    "dimensions": {
	      "instance_id": "392633"
	    }
	    "meta": {}
	  }
	}

**Error Response**

**Status Code**

| Status Code | Description | Reasons |
| :-----------| :-----------| :-------|
| 400 | Bad Request | Malformed request in URI or request body. |
| 401 | Unauthorized | The caller does not have the privilege required to perform the operation.      |
| 403 | Forbidden | Disabled or suspended user making the request or requested operation is forbidden. |
| 409 | Conflict | A Subscription for this combination of endpoint_id, namespace, and dimension already exists for this tenant. |
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions 

*Extended Curl Example*

	$ curl -i https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions \
	  -X POST -H "Content-Type:application/json" -H "Accept:application/json" \
	  -H "X-Tenant-Id:21908171893702" -H "X-Auth-Token: HPAuth_4f7c6456e4b01a25ab011e74" \
	  -d '{"subscription": 	{"endpoint_id": "4d159ef6-0b6a-439b-a5bf-07459e1005b8", "namespace": "compute", "dimensions": {"instance_id": "392633"}}}'
##### 4.4.3.2 List All Subscriptions #### {#ServiceDetailsListSubscription}
###### GET /subscriptions

Lists all subscriptions.

**Request Data**

	GET /v1.0/subscriptions HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	          "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions/cdace7b4-8bea-404c-848c-860754a76fb7"
	        }
	      ]
	      "endpoint_id": "36351ef0-3ff3-11e2-a25f-0800200c9a66",
	      "namespace": "compute",
	      "dimensions": {
	        "instance_id": "392633"
	      }
	    },
	    {
	      "id": "abce9e32-6ce0-4a36-9750-df415606babc",
	      "links": [
	        {
	          "rel": "self",
	          "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions/abce9e32-6ce0-4a36-9750-df415606babc"
	        }
	      ]
	      "endpoint_id": "3d713b90-3ff3-11e2-a25f-0800200c9a66",
	      "namespace": "compute",
	      "dimensions": {
	        "instance_id": "392633"
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions 

##### 4.4.3.3 Get a Specific Subscription #### {#ServiceDetailsSpecificSubscription}
###### GET /subscriptions/{subscription_id}

Gets the details of a specific subscription identified by {subscription_id}.

**Request Data**

	GET /v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	        "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c"
	      }
	    ]
	    "endpoint_id": "36351ef0-3ff3-11e2-a25f-0800200c9a66",
	    "namespace": "compute",
	    "dimensions": {
	      "instance_id": "392633"
	    },
	    "meta": {}
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.3.4 Delete a Specific Subscription #### {#ServiceDetailsDeleteSubscription}
###### DELETE /subscriptions/{subscription_id}

Deletes a specific subscription identified by {subscription_id}.

**Request Data**

	DELETE /v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/subscriptions/eabe9e32-6ce0-4a36-9750-df415606b44c#### 4.4.4 Notification Method ### {#ServiceDetailsNotification}
The notification method resource represents a method through which notifications can be sent.

##### 4.4.4.1 Create a New Notification Method #### {#ServiceDetailsCreateNotification}
###### POST /notification-methods

Creates a new notification method through which notifications can be sent when an alarm is triggered.

**Request Data**

	POST /v1.0/notification-methods HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
	Content-Type: application/json
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

* *name* - string - A descriptive name for the notification
* *type* - string - The type of notification method (SMS, EMAIL)* *address* - string - The address/number to notify 

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
	        "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods/acb8ad2b-6ce0-4a36-9750-a78bc7da87a2"
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods 

*Extended Curl Example*

	$ curl -i https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods \
	  -X POST -H "Content-Type:application/json" -H "Accept:application/json" \
	  -H "X-Tenant-Id:21908171893702" -H "X-Auth-Token: HPAuth_4f7c6456e4b01a25ab011e74" \
	  -d '{"notification_method": {"name": "Joe'\''s Email", "type": "EMAIL", "address": "joe@mail.com"}}'##### 4.4.4.2 List All Notification Methods #### {#ServiceDetailsListNotification}
###### GET /notification-methods

Lists all notification methods.

**Request Data**

	GET /v1.0/notification-methods HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	          "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c"
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
	          "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods/acb8ad2b-6ce0-4a36-9750-a78bc7da87a2"
	        }
	      ],
	      "name": "Joe's Phone",
	      "type": "SMS",
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods 

##### 4.4.4.3 Get a Specific Notification Methods #### {#ServiceDetailsSpecificNotification}
###### GET /notification-methods/{notification_method_id}

Gets the details of a specific notification method identified by {notification_method_id}.

**Request Data**

	GET /v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	        "href": "https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c"
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.4.4 Delete a Specific Notification Method #### {#ServiceDetailsDeleteNotification}
###### DELETE /notification-methods /{notification_method_id}

Deletes a specific notification method identified by {notification_method_id}.

**Request Data**

	DELETE /v1.0/notification-methods /eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/notification-methods/eabe9e32-6ce0-4a36-9750-df415606b44c#### 4.4.5 Alarm ### {#ServiceDetailsAlarm}
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
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
	Content-Type: application/json
	Accept: application/json
	X-Auth-Token: {Auth_Token}

**Data Parameters**

* *name* - string - A descriptive name for the alarm* *namespace* - string - Namespace of metric to alarm on
* *metric_type* - string - Type of metric to alarm on
* *metric_subject* - string - (Optional) Descriptive subject name of metric to alarm on* *dimensions* - dictionary - Dimensions of metrics to alarm on (each dimension type can only be used once in this call)* *operator* - string - Comparison operator for which threshold and metric values are compared (LT, LTE, GT, GTE) corresponding to less than, less than or equal, greater than, and greater than or equal* *threshold* - long - Threshold which triggers an alarm when exceeded (see metric descriptions)* *alarm_actions* - array - Methods through which notifications (notification id) should be sent when transitioning to an ALARM state

JSON

	{
	  "alarm": {
	    "name": "Disk Exceeds 1k Operations",
	    "namespace": "compute",
	    "metric_type": "disk_read_ops",
	    "metric_subject": "VDA",
	    "dimensions": {
	      "instance_id": "392633"
	    },
	    "operator": "GTE",
	    "threshold": 1000,
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
	    "name": "Disk Exceeds 1k Operations",
	    "namespace": "compute",
	    "metric_type": "disk_read_ops",
	    "dimensions": {
	      "instance_id": "392633"
	    },
	    "operator": "GTE",
	    "threshold": 1000,
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
| 409 | Conflict | An Alarm for this combination of values already exists for this tenant. |
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X POST \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/alarms 

*Extended Curl Example*

	$ curl -i https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/alarms \
	  -X POST -H "Content-Type:application/json" -H "Accept:application/json" \
	  -H "X-Tenant-Id:21908171893702" -H "X-Auth-Token: HPAuth_4f7c6456e4b01a25ab011e74" \
	  -d '{"alarm": {"name": "Disk Exceeds 1k Operations", "namespace": "compute", "metric_type": "disk_read_ops", "metric_subject": "VDA", "dimensions": {"instance_id": "392633"}, "operator": "GTE", "threshold": 1000, "alarm_actions": ["036609b0-3d6b-11e2-a25f-0800200c9a66", "1221dba0-3d6b-11e2-a25f-0800200c9a66"]}}'##### 4.4.5.2 List All Alarms #### {#ServiceDetailsListAlarm}
###### GET /alarms

Lists all alarms.

**Request Data**

	GET /v1.0/alarms HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	      "name": "Disk Exceeds 1k Operations",
	      "namespace": "compute",
	      "metric_type": "disk_read_ops",
	      "dimensions": {
	        "instance_id": "392633"
	      },
	      "operator": "GTE",
	      "threshold": 1000,
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/alarms 

##### 4.4.5.3 Get a Specific Alarm #### {#ServiceDetailsSpecificAlarm}
###### GET /alarms/{alarm_id}

Gets the details of a specific alarms identified by {alarm_id}.

**Request Data**

	GET /v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
	    "name": "Disk Exceeds 1k Operations",
	    "namespace": "compute",
	    "metric_type": "disk_read_ops",
	    "dimensions": {
	      "instance_id": "392633"
	    },
	    "operator": "GTE",
	    "threshold": 1000,
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X GET \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c

##### 4.4.5.4 Delete a Specific Alarm #### {#ServiceDetailsDeleteAlarm}
###### DELETE /alarms/{alarm_id}

Deletes a specific alarm identified by {alarm_id}.

**Request Data**

	DELETE /v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c HTTP/1.1
	Host: https://region-a.geo-1.monitoring.hpcloudsvc.com
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
| 500 | Server Error | The server encountered a problem while processing the request. |

**Curl Example**

	$ curl -X DELETE \
	  -H "X-Auth-Token: {Auth_Token}" \
	  https://region-a.geo-1.monitoring.hpcloudsvc.com/v1.0/alarms/eabe9e32-6ce0-4a36-9750-df415606b44c## 5. Glossary # {#Section5_}* Namespace - A required classification for a metric.* Dimension - An optional classification for a metric. A metric may be classified by multiple dimensions.
* Tenant - The cloud name/id of the customer.