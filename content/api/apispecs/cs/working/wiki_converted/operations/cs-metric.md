---  
title : CS Metric Operations

---  

### Get All Services

Verb

URI

Description

**GET**

**[csbu:HPKeystoneExtensionBaseURI]/metric**

Returns all services with their status

#### **Detailed Description**

Returns all services with their status in the response.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

No

gzip

 No

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/metric HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml


<serviceMetricsList>
  <serviceMetrics>
    <serviceName>EndpointRef Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Authorization Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Keystone Domain Manangement Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Endpoint Template Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Keystone Group Manangement Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Registered Service Object Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Control Services Node</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Keystone Authentication Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Openstack IdentityService</serviceName>
    <serviceStatus>0</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Keystone Signature Authentication Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Keystone Password Manangement Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Peristence Service</serviceName>
    <serviceStatus>0</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>User Management Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Keystone Tenant Manangement Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Keystone User Manangement Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Openstack Domains Resource</serviceName>
    <serviceStatus>0</serviceStatus>
  </serviceMetrics>
  <serviceMetrics>
    <serviceName>Persistence Service</serviceName>
    <serviceStatus>2</serviceStatus>
  </serviceMetrics>
</serviceMetricsList>
~~~

### Get Metrics for Service

Verb

URI

Description

**GET**

**[csbu:HPKeystoneExtensionBaseURI]/metric/{serviceName}**

Returns Metric for a given service name

#### **Detailed Description**

Returns metric for a given service. Optionally if the *reset* query
parameter is set to *true* it clears all the metrics for the service
after returning the values.

#### **Normal Response Codes**

**200** (OK)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

*reset - if set to "true" clears the metric from the memory, defaults to
false.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

No

gzip

 No

#### **Example(s)**

##### XML Request

~~~
GET /v2.0/HP-IDM/v1.0/metric/Keystone Authentication Service HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml


<opMetricsList><opMetricsList>
  <opMetrics>
    <opName>get EC2 auth token Service Call</opName>
    <opCount>7</opCount>
    <errorCount>0</errorCount>
    <latency>
      <minLatency>24741</minLatency>
      <avgLatency>40108</avgLatency>
      <maxLatency>79186</maxLatency>
      <lastLatency>25054</lastLatency>
    </latency>
  </opMetrics>
  <opMetrics>
    <opName>get auth token Service Call</opName>
    <opCount>8</opCount>
    <errorCount>0</errorCount>
    <latency>
      <minLatency>24735</minLatency>
      <avgLatency>39506</avgLatency>
      <maxLatency>79179</maxLatency>
      <lastLatency>35336</lastLatency>
    </latency>
  </opMetrics>
  <opMetrics>
    <opName>AuthN Query User By Username Service Call</opName>
    <opCount>13</opCount>
    <errorCount>0</errorCount>
    <latency>
      <minLatency>77</minLatency>
      <avgLatency>80</avgLatency>
      <maxLatency>91</maxLatency>
      <lastLatency>81</lastLatency>
    </latency>
  </opMetrics>
</opMetricsList>
~~~

### Delete Metrics for Service

Verb

URI

Description

**DELETE**

**[csbu:HPKeystoneExtensionBaseURI]/metric/{serviceName}**

Deletes Metric for a given service name

#### **Detailed Description**

Delete metric for a given service.

#### **Normal Response Codes**

**204 **(No Content)

#### ***Error Response Codes***

HTTP Status Code

Reason(s)

***401**** *(Unauthorized)

The caller does not have the privilege required to perform the operation.

***403*** *(Forbidden) *

Disabled or suspended user making the request

**500** (Internal Server Error)

The server encountered a problem while processing the request.

***503**** *(Service Unavailable)

The server is unavailable to process the request.

Please refer to error response body for additional details.

#### **Header Values**

No additional header values required.

#### **Query String Values**

*reset - if set to "true" clears the metric from the memory, defaults to
false.*

#### **Request and Response Resource Representations**

Content Type

Supported

XSD

No

XML

Yes

JSON

No

gzip

 No

#### **Example(s)**

##### XML Request

~~~
DELETE /v2.0/HP-IDM/v1.0/metric/Keystone Authentication Service HTTP/1.1
Accept: application/xml
Content-Type: application/xml
User-Agent: Wink Client v1.1.2
Host: localhost:9999
Connection: keep-alive
~~~

##### XML Response

~~~
HTTP/1.1 204 No Content
Server: Apache-Coyote/1.1
Cache-Control: no-cache
Pragma: no-cache
Expires: -1
Content-Type: application/xml
~~~
